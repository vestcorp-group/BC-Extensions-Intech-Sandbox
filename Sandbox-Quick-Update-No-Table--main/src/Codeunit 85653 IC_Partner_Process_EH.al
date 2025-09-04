codeunit 85653 IC_Partner_Process_EH //13919
{
    //T13919NG-N 010325 IC Partner Code Auto Process
    TableNo = "IC Inbox Transaction";
    trigger OnRun()
    var
        ModICInvTran_lRec: Record "IC Inbox Transaction";
        HandledICOutboxTrans: Record "Handled IC Inbox Trans.";
    begin
        IF rec."Source Type" IN [Rec."Source Type"::"Purchase Document", Rec."Source Type"::"Sales Document"] Then begin
            HandledICOutboxTrans.SetRange("IC Partner Code", Rec."IC Partner Code");
            HandledICOutboxTrans.SetRange("Source Type", Rec."Source Type");
            HandledICOutboxTrans.SetRange("Document Type", Rec."Document Type");
            HandledICOutboxTrans.SetRange("Document No.", Rec."Document No.");
            IF HandledICOutboxTrans.FindFirst() then
                Error('');
        end;
        ModICInvTran_lRec.RESET;
        ModICInvTran_lRec.SetRange("Transaction No.", Rec."Transaction No.");
        ModICInvTran_lRec.SetRange("IC Partner Code", Rec."IC Partner Code");
        ModICInvTran_lRec.SetRange("Transaction Source", Rec."Transaction Source");
        ModICInvTran_lRec.SetRange("Document Type", Rec."Document Type");
        ModICInvTran_lRec.FindFirst();

        ModICInvTran_lRec.TestField("Transaction Source", Rec."Transaction Source"::"Created by Partner");
        ModICInvTran_lRec.Validate("Line Action", Rec."Line Action"::Accept);
        ModICInvTran_lRec.Modify();


        REPORT.RunModal(REPORT::"Complete IC Inbox Action", False, false, ModICInvTran_lRec);
    end;

    //NG-NS 090425
    [EventSubscriber(ObjectType::Codeunit, Codeunit::ICInboxOutboxMgt, OnBeforeUpdatePurchLineICPartnerReference, '', false, false)]
    local procedure ICInboxOutboxMgt_OnBeforeUpdatePurchLineICPartnerReference(var PurchaseLine: Record "Purchase Line"; PurchaseHeader: Record "Purchase Header"; ICInboxPurchLine: Record "IC Inbox Purchase Line"; var IsHandled: Boolean)
    var
        ICPartner: Record "IC Partner";
        ItemReference: Record "Item Reference";
        GLAccount: Record "G/L Account";
        ToDate: Date;
    begin
        IsHandled := true;

        if (ICInboxPurchLine."IC Partner Ref. Type" <> ICInboxPurchLine."IC Partner Ref. Type"::"G/L Account") and
                       (ICInboxPurchLine."IC Partner Ref. Type" <> ICInboxPurchLine."IC Partner Ref. Type"::" ") and
                       (ICInboxPurchLine."IC Partner Ref. Type" <> ICInboxPurchLine."IC Partner Ref. Type"::"Charge (Item)") and
                       (ICInboxPurchLine."IC Partner Ref. Type" <> ICInboxPurchLine."IC Partner Ref. Type"::"Cross Reference")
                then begin
            ICPartner.Get(PurchaseHeader."Buy-from IC Partner Code");
            case ICPartner."Outbound Purch. Item No. Type" of
                ICPartner."Outbound Purch. Item No. Type"::"Common Item No.":
                    PurchaseLine.Validate("IC Partner Ref. Type", ICInboxPurchLine."IC Partner Ref. Type"::"Common Item No.");
                ICPartner."Outbound Purch. Item No. Type"::"Internal No.":
                    begin
                        PurchaseLine."IC Partner Ref. Type" := ICInboxPurchLine."IC Partner Ref. Type"::Item;
                        PurchaseLine."IC Partner Reference" := ICInboxPurchLine."IC Partner Reference";
                    end;
                ICPartner."Outbound Purch. Item No. Type"::"Cross Reference":
                    begin
                        PurchaseLine.Validate("IC Partner Ref. Type", ICInboxPurchLine."IC Partner Ref. Type"::"Cross reference");
                        ItemReference.SetRange("Reference Type", "Item Reference Type"::Vendor);
                        ItemReference.SetRange("Reference Type No.", PurchaseHeader."Buy-from Vendor No.");
                        //ItemReference.SetRange("Item No.", ICInboxPurchLine."IC Item Reference No.");  //NG-O Standard BC Line In Correct we have update with Old NAV Logic
                        ItemReference.SETRANGE("Item No.", ICInboxPurchLine."IC Partner Reference");  //NG-U Standard BC Line In Correct we have update with Old NAV Logic
                        ToDate := PurchaseLine.GetDateForCalculations();
                        if ToDate <> 0D then begin
                            ItemReference.SetFilter("Starting Date", '<=%1', ToDate);
                            ItemReference.SetFilter("Ending Date", '>=%1|%2', ToDate, 0D);
                        end;
                        if ItemReference.FindFirst() then
                            PurchaseLine."IC Item Reference No." := ItemReference."Reference No.";
                    end;
                ICPartner."Outbound Purch. Item No. Type"::"Vendor Item No.":
                    begin
                        PurchaseLine."IC Partner Ref. Type" := ICInboxPurchLine."IC Partner Ref. Type"::"Vendor Item No.";
                        PurchaseLine."IC Item Reference No." := PurchaseLine."Vendor Item No.";
                        // TODO
                    end;
            end;
        end else begin
            PurchaseLine."IC Partner Ref. Type" := ICInboxPurchLine."IC Partner Ref. Type";
            if ICInboxPurchLine."IC Partner Ref. Type" <> ICInboxPurchLine."IC Partner Ref. Type"::"G/L Account" then begin
                PurchaseLine."IC Partner Reference" := ICInboxPurchLine."IC Partner Reference";
                PurchaseLine."IC Item Reference No." := ICInboxPurchLine."IC Item Reference No.";
            end else
                if GLAccount.Get(TranslateICGLAccount(ICInboxPurchLine."IC Partner Reference")) then
                    PurchaseLine."IC Partner Reference" := GLAccount."Default IC Partner G/L Acc. No";
        end;
    end;

    procedure TranslateICGLAccount(ICAccNo: Code[30]): Code[20]
    var
        ICGLAcc: Record "IC G/L Account";
    begin
        ICGLAcc.Get(ICAccNo);
        exit(ICGLAcc."Map-to G/L Acc. No.");
    end;
    //NG-NE 090425

    var
        myInt: Integer;
}