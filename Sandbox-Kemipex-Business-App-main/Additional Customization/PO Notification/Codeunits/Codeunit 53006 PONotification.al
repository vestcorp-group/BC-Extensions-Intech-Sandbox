codeunit 53006 PONotification//T12370-Full Comment  HyperCare-Yaksh
{
    [EventSubscriber(ObjectType::Table, Database::"Purchase Line", 'OnAfterValidateEvent', 'CustomR_ETD', false, false)]
    local procedure OnRETDChangeNotification(var Rec: Record "Purchase Line"; var xRec: Record "Purchase Line"; CurrFieldNo: Integer)
    var
        RecHdr: Record "Purchase Header";
        SubjectLabel: Label 'ETD and ETA Update on - Purchase Order No. %1';
    begin
        if Rec."Document Type" <> Rec."Document Type"::Order then exit;
        Clear(RecHdr);
        RecHdr.SetRange("Document Type", Rec."Document Type");
        RecHdr.SetRange("No.", Rec."Document No.");
        If RecHdr.FindFirst() then;
        // if (xRec.CustomR_ETD <> 0D) AND (Rec.CustomR_ETD <> xRec.CustomR_ETD) then
        //     If RecHdr."Purchaser Code" <> '' then
        SendPONotificationToPurchaser(Rec, RecHdr, SubjectLabel, xRec.CustomR_ETD, 'ETD');
    end;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Line", 'OnAfterValidateEvent', 'CustomR_ETA', false, false)]
    local procedure OnRETAChangeNotification(var Rec: Record "Purchase Line"; var xRec: Record "Purchase Line"; CurrFieldNo: Integer)
    var
        RecHdr: Record "Purchase Header";
        SubjectLabel: Label 'ETD and ETA Update on - Purchase Order No. %1';
    begin
        if Rec."Document Type" <> Rec."Document Type"::Order then exit;
        Clear(RecHdr);
        RecHdr.SetRange("Document Type", Rec."Document Type");
        RecHdr.SetRange("No.", Rec."Document No.");
        If RecHdr.FindFirst() then;
        // if (xRec.CustomR_ETA <> 0D) AND (Rec.CustomR_ETA <> xRec.CustomR_ETA) then
        // If RecHdr."Purchaser Code" <> '' then
        SendPONotificationToPurchaser(Rec, RecHdr, SubjectLabel, xRec.CustomR_ETA, 'ETA');
    end;

    /*[EventSubscriber(ObjectType::Table, Database::"Purchase Line", 'OnValidateQtyToReceiveOnAfterInitQty', '', false, false)]
    local procedure OnValidateQtyToReceiveOnAfterInitQty(var PurchaseLine: Record "Purchase Line"; var xPurchaseLine: Record "Purchase Line"; CallingFieldNo: Integer; var IsHandled: Boolean);
    var
        RecHdr: Record "Purchase Header";
        SubjectLabel: Label 'GRN Completed for - Order No. %1';
    begin
        if PurchaseLine."Document Type" <> PurchaseLine."Document Type"::Order then exit;
        Clear(RecHdr);
        RecHdr.SetRange("Document Type", PurchaseLine."Document Type");
        RecHdr.SetRange("No.", PurchaseLine."Document No.");
        If RecHdr.FindFirst() then;

        if PurchaseLine.Quantity = PurchaseLine."Quantity Received" then begin
            SendPONotificationToPurchaser(PurchaseLine, RecHdr, SubjectLabel, xPurchaseLine.CustomR_ETD, '');
        end;
    end;*/

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnBeforePurchRcptLineInsert', '', false, false)]
    local procedure OnBeforePurchRcptLineInsert(var PurchRcptLine: Record "Purch. Rcpt. Line"; var PurchRcptHeader: Record "Purch. Rcpt. Header"; var PurchLine: Record "Purchase Line"; CommitIsSupressed: Boolean; PostedWhseRcptLine: Record "Posted Whse. Receipt Line"; var IsHandled: Boolean);
    var
        RecHdr: Record "Purchase Header";
        SubjectLabel: Label 'GRN Completed for - Purchase Order No. %1';
        RecLInes: Record "Purchase Line";
    begin
        //Hypercare
        if PurchRcptLine.IsTemporary then
            exit;
        //Hypercare

        if PurchLine."Document Type" <> PurchLine."Document Type"::Order then exit;
        Clear(RecHdr);
        RecHdr.SetRange("Document Type", PurchLine."Document Type");
        RecHdr.SetRange("No.", PurchLine."Document No.");
        If RecHdr.FindFirst() then;
        if PurchLine."Qty. to Receive" = 0 then exit;
        Clear(RecLInes);
        RecLInes.SetRange("Document Type", PurchLine."Document Type");
        RecLInes.SetRange("Document No.", PurchLine."Document No.");
        RecLInes.SetRange("Salesperson Code", PurchLine."Salesperson Code");
        RecLInes.SetFilter("Line No.", '>%1', PurchLine."Line No.");
        RecLInes.SetFilter("Qty. to Receive", '<>%1', 0);
        if RecLInes.FindFirst() then exit;
        //if PurchLine.Quantity = PurchRcptLine.Quantity + PurchLine."Quantity Received" then begin
        SendPONotificationToPurchaser(PurchLine, RecHdr, SubjectLabel, PurchLine.CustomR_ETD, '');
        //end;
    end;


    //To Get Salesperson from SO Header to PO Line in case of Drop Shipment
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Get Drop Shpt.", 'OnBeforePurchaseLineInsert', '', false, false)]
    local procedure OnBeforePurchaseLineInsert(var PurchaseLine: Record "Purchase Line"; SalesLine: Record "Sales Line");
    var
        SHeader: Record "Sales Header";
    begin
        //Hypercare
        if PurchaseLine.IsTemporary then
            exit;
        //Hypercare
        Clear(SHeader);
        SHeader.SetRange("Document Type", SalesLine."Document Type");
        SHeader.SetRange("No.", SalesLine."Document No.");
        if SHeader.FindFirst() then;
        PurchaseLine."Salesperson Code" := SHeader."Salesperson Code";
    end;


    local procedure SendPONotificationToPurchaser(var RecPOLine: Record "Purchase Line"; Var RecPoHdr: Record "Purchase Header"; SubjectLabel: Text; PrevDate: Date; ETDORETA: Text)
    var
        EmailMessage: Codeunit "Email Message";
        Email: Codeunit Email;
        Recipients: List of [Text];
        Subject: Text;
        Body: Text;
        ReceiverSetup: Record "User Setup";
        PageId: Integer;
        ReceiverUser: Record User;
        PnPsetup: Record "Purchases & Payables Setup";
        RecSp: Record "Salesperson/Purchaser";
        SnRsetup: Record "Sales & Receivables Setup";
    begin

        /* PnPsetup.GET; //Hypercare-Email Setup Error Skip Yaksh-Anoop
        SnRsetup.get();
        // Clear(ReceiverSetup);
        // ReceiverSetup.SetRange("Salespers./Purch. Code", RecPoHdr."Purchaser Code");
        // ReceiverSetup.SetFilter("E-Mail", '<>%1', '');
        // if ReceiverSetup.FindFirst() then begin

        Clear(RecSp);
        RecSp.SetRange(Code, RecPOLine."Salesperson Code");
        RecSp.SetFilter("E-Mail", '<>%1', '');
        if NOT RecSp.FindSet() then begin
            Clear(RecSp);
            RecSp.SetRange(Code, RecPoHdr."Purchaser Code");
            RecSp.SetFilter("E-Mail", '<>%1', '');
            if RecSp.FindSet() then;
        end;

        Recipients.Add(RecSp."E-Mail");
        if PnPsetup."Procurement E-Mail" <> '' then
            Recipients.Add(PnPsetup."Procurement E-Mail");
        if SnRsetup."Sales Support Email" <> '' then
            Recipients.Add(SnRsetup."Sales Support Email");
        ReceiverUser.Reset();
        ReceiverUser.SetRange("User Name", ReceiverSetup."User ID");
        if ReceiverUser.FindFirst() then;
        Subject := StrSubstNo(SubjectLabel, RecPOLine."Document No.");
        if SubjectLabel.Contains('GRN') then
            Body := CreateEmailBody(RecPoHdr, ReceiverUser, RecPOLine, true, '', PrevDate)
        else
            Body := CreateEmailBody(RecPoHdr, ReceiverUser, RecPOLine, false, ETDORETA, PrevDate);
        EmailMessage.Create(Recipients, Subject, Body, true);
        Email.Enqueue(EmailMessage, Enum::"Email Scenario"::Default);//27-06-2022 */
    end;




    local procedure CreateEmailBody(Var RecPoHdr: Record "Purchase Header"; Var Receiver: Record User; var RecPoLine: Record "Purchase Line"; IsGRN: Boolean; ETDORETA: Text; PrevDate: Date): Text
    var
        BodyText: TextBuilder;
        RecVendor: Record Vendor;
        PageId, J : Integer;
        GLSetup: Record "General Ledger Setup";
        RecPaymentTerms: Record "Payment Terms";
        Recteams: Record Team;
        RecteamSalesPerson: Record "Team Salesperson";
        RecSalesperson: Record "Salesperson/Purchaser";
        RecItem: Record Item;
        TotalQty, AvailableLimit, UsedLimit, OverDueHistory : Decimal;
        ShortName: Record "Company Short Name";
        PaymentTermsText, ColorText : Text;
        UOMCheck: List of [Text];
        RecLines: Record "Purchase Line";
        RecLines2: Record "Purchase Line";
        TestText: Text;
    begin
        RecPoLine.Modify();
        ShortName.GET(CompanyName);
        Clear(RecVendor);
        RecVendor.GET(RecPoHdr."Buy-from Vendor No.");
        Clear(BodyText);
        BodyText.Append('<style>table { border-collapse: collapse; border: 1px solid black;} table.a { table-layout: auto;  width: 500px; } table.b { table-layout: auto;  width: 730px; } </style>');

        BodyText.Append('Hello ' + Receiver."User Name" + '<br><br>You are registered to receive notifications related to Purchase Order.');

        if IsGRN then
            BodyText.Append('<br><br>GRN update notification.')
        else begin
            if ETDORETA = 'ETA' then
                BodyText.Append('<br><br>This is a message to notify you that:<br><br> R-' + ETDORETA + ' : ' + Format(PrevDate) + ' in Purchase Order No. ' + RecPoHdr."No." + ' is changed to ' + FORMAT(RecPoLine.CustomR_ETA) + '.')
            else
                BodyText.Append('<br><br>This is a message to notify you that:<br><br> R-' + ETDORETA + ' : ' + Format(PrevDate) + ' in Purchase Order No. ' + RecPoHdr."No." + ' is changed to ' + FORMAT(RecPoLine.CustomR_ETD) + '.');
        end;


        BodyText.Append('<br><br>');

        TestText := RecPoHdr."No." + ' - ' + ShortName."Short Name";
        BodyText.Append('<table class="a">');
        BodyText.Append('<tr>');
        BodyText.Append('<td align="left" Style="padding-left:5px"> <font> Purchase Order No. </font></td>');
        BodyText.Append('<td align="left"> <font> ' + TestText + '</font></td>');
        BodyText.Append('</tr>');


        if RecPoHdr."Purchaser Code" <> '' then begin
            RecSalesperson.GET(RecPoHdr."Purchaser Code");
            BodyText.Append('<tr>');
            BodyText.Append('<td align="left" Style="padding-left:5px"> <font> Purchaser Name: </font></td>');
            Clear(RecteamSalesPerson);
            RecteamSalesPerson.SetRange("Salesperson Code", RecPoHdr."Purchaser Code");
            if RecteamSalesPerson.FindFirst() then begin
                Clear(Recteams);
                if Recteams.GET(RecteamSalesPerson."Team Code") then
                    BodyText.Append('<td align="left" > <font> ' + RecSalesperson."Name" + ' / ' + Recteams.Name + ' </font></td>')
                else
                    BodyText.Append('<td align="left"> <font> ' + RecSalesperson."Name" + ' </font></td>');
            end else
                BodyText.Append('<td align="left"> <font> ' + RecSalesperson."Name" + ' </font></td>');
            BodyText.Append('</tr>');
        end;
        BodyText.Append('</table>');
        BodyText.Append('<br>');



        Clear(RecLines);
        RecLines.SetCurrentKey("Line No.");
        RecLines.SetAscending("Line No.", true);
        RecLines.SetRange("Document Type", RecPoHdr."Document Type");
        RecLines.SetRange("Document No.", RecPoHdr."No.");
        RecLines.SetRange(Type, RecLines.Type::Item);
        if RecLines.FindSet() then begin
            BodyText.Append('<table class="b">');
            Clear(TotalQty);
            BodyText.Append('<tr>');
            BodyText.Append('<td align="left" Style="width:180px;padding-left:5px"> <font> Product Name </font></td>');
            BodyText.Append('<td align="right" Style="width:110px"> <font> Quantity </font></td>');
            BodyText.Append('<td align="left" Style="width:110px;padding-left:10px"> <font> R-ETD </font></td>');
            BodyText.Append('<td align="left" Style="width:110px"> <font> R-ETA </font></td>');
            BodyText.Append('<td align="right" Style="width:110px"> <font> Qty. Received </font></td>');
            BodyText.Append('<td align="left" Style="width:110px; padding-left:10px"> <font> Warehouse </font></td>');
            BodyText.Append('</tr>');
            repeat
                BodyText.Append('<tr>');
                RecItem.GET(RecLines."No.");
                BodyText.Append('<td align="left" Style="padding-left:5px"> <font> ' + RecItem.Description + ' </font></td>');//, 0, '<Precision,2:2><Standard Format,0>'
                if RecLines."Line No." = RecPoLine."Line No." then begin
                    BodyText.Append('<td align="right"> <font> ' + RecPoLine."Base UOM" + ' ' + FORMAT(RecPoLine."Quantity (Base)", 0, '<Precision,3:3><Standard Format,0>') + ' </font></td>');
                    BodyText.Append('<td align="left" Style="padding-left:10px"> <font> ' + FORMAT(RecPoLine.CustomR_ETD) + ' </font></td>');
                    BodyText.Append('<td align="left"> <font> ' + FORMAT(RecPoLine.CustomR_ETA) + ' </font></td>');
                    if IsGRN then
                        BodyText.Append('<td align="right"> <font> ' + RecLines."Base UOM" + ' ' + FORMAT(RecLines."Qty. to Receive (Base)" + RecLines."Qty. Received (Base)", 0, '<Precision,3:3><Standard Format,0>') + ' </font></td>')
                    else
                        BodyText.Append('<td align="right"> <font> ' + RecLines."Base UOM" + ' ' + FORMAT(RecLines."Qty. Received (Base)", 0, '<Precision,3:3><Standard Format,0>') + ' </font></td>')

                end else begin
                    BodyText.Append('<td align="right"> <font> ' + RecLines."Base UOM" + ' ' + FORMAT(RecLines."Quantity (Base)", 0, '<Precision,3:3><Standard Format,0>') + ' </font></td>');
                    BodyText.Append('<td align="left" Style="padding-left:10px"> <font> ' + FORMAT(RecLines.CustomR_ETD) + ' </font></td>');
                    BodyText.Append('<td align="left"> <font> ' + FORMAT(RecLines.CustomR_ETA) + ' </font></td>');
                    BodyText.Append('<td align="right"> <font> ' + RecLines."Base UOM" + ' ' + FORMAT(RecLines."Qty. Received (Base)", 0, '<Precision,3:3><Standard Format,0>') + ' </font></td>');
                end;

                TotalQty += RecLines."Quantity (Base)";
                BodyText.Append('<td align="left" Style="padding-left:10px"> <font>   ' + RecLines."Location Code" + ' </font></td>');
                BodyText.Append('</tr>');
            until RecLines.Next() = 0;


            //added to show total for each UOM -start
            J := 1;
            Clear(UOMCheck);
            Clear(RecLines);
            RecLines.SetCurrentKey("Line No.");
            RecLines.SetAscending("Line No.", true);
            RecLines.SetRange("Document Type", RecPoHdr."Document Type");
            RecLines.SetRange("Document No.", RecPoHdr."No.");
            RecLines.SetRange(Type, RecLines.Type::Item);
            if RecLines.FindSet() then begin
                repeat
                    if not UOMCheck.Contains(RecLines."Base UOM") then begin
                        UOMCheck.Add(RecLines."Base UOM");

                        Clear(RecLines2);
                        RecLines2.SetCurrentKey("Line No.");
                        RecLines2.SetAscending("Line No.", true);
                        RecLines2.SetRange("Document Type", RecPoHdr."Document Type");
                        RecLines2.SetRange("Document No.", RecPoHdr."No.");
                        RecLines2.SetRange(Type, RecLines2.Type::Item);
                        RecLines2.SetRange("Base UOM", RecLines."Base UOM");
                        if RecLines2.FindSet() then begin
                            RecLines2.CalcSums("Quantity (Base)", "Qty. Received (Base)");
                            BodyText.Append('<tr>');
                            if J = 1 then
                                BodyText.Append('<td align="left" Style="padding-left:5px"> <font> <b>TOTAL</b> </font></td>')
                            else
                                BodyText.Append('<td align="left"></td>');

                            BodyText.Append('<td align="right"> <font> <b>' + RecLines."Base UOM" + ' ' + FORMAT(RecLines2."Quantity (Base)", 0, '<Precision,3:3><Standard Format,0>') + '</b> </font></td>');

                            BodyText.Append('<td align="left"></td>');
                            BodyText.Append('<td align="left"></td>');
                            if not IsGRN then
                                BodyText.Append('<td align="right"> <font> <b>' + RecLines."Base UOM" + ' ' + FORMAT(RecLines2."Qty. Received (Base)", 0, '<Precision,3:3><Standard Format,0>') + '</b> </font></td>')
                            else begin
                                BodyText.Append('<td align="right"> <font> <b>' + RecLines."Base UOM" + ' ' + FORMAT(RecLines2."Qty. Received (Base)" + RecPoLine."Qty. to Receive (Base)", 0, '<Precision,3:3><Standard Format,0>') + '</b> </font></td>')
                            end;
                            BodyText.Append('<td align="left"></td>');
                            J += 1;
                        end;
                    end;
                Until RecLines.Next() = 0;
            end;
            //-end
            BodyText.Append('</table>');
            BodyText.Append('<br>');
        end;

        if RecPoHdr."Document Type" = RecPoHdr."Document Type"::Order then
            PageId := Page::"Purchase Order"
        else
            if RecPoHdr."Document Type" = RecPoHdr."Document Type"::"Blanket Order" then
                PageId := Page::"Blanket Purchase Order";


        BodyText.Append('<br>');
        BodyText.Append(StrSubstNo('<p> <a href="%1">Open document in Business Central</a> </p>', GetUrl(ClientType::Web, CompanyName, ObjectType::Page, PageId, RecPoHdr, False)));

        exit(BodyText.ToText());
    end;
}
