Report 85656 "Group GRN Date Update 2Tenent" //T14049-N
{

    UsageCategory = ReportsAndAnalysis;
    Caption = 'Batch for Update the Group GRN Date on Item Ledger Entry';
    ProcessingOnly = true;
    ApplicationArea = All;
    Permissions = tabledata "Value Entry" = rm, tabledata "Item Ledger Entry" = rm;

    dataset
    {
        dataitem("Item Ledger Entry"; "Item Ledger Entry")
        {
            RequestFilterFields = "Entry Type", "Document Type";
            trigger OnAfterGetRecord()
            var
                ItemApplicationEntry_lRec: Record "Item Application Entry";
                SourceEntry_lRec: Record "Item Ledger Entry";
                ValueEntry_lRec: Record "Value Entry";
                PurchaseReceiptHeader: Record "Purch. Rcpt. Header";
                PurchaseHeader: Record "Purchase Header";
                ICPartner: Record "IC Partner";
                ICShipmentLine: Record "Sales Shipment Line";
                ICSalesOrderNumber: Code[30];
                ICILE: Record "Item Ledger Entry";
                StaggingGroupGRNDetails: Record "Stagging Group GRN Details";
            begin
                CurrentRec_gDec += 1;
                Windows_gDlg.Update(2, CurrentRec_gDec);
                if ("Item Ledger Entry"."Entry Type" =
                     "Item Ledger Entry"."Entry Type"::Purchase) and  //Purchase-Negative
                                    (not "Item Ledger Entry".Positive) and
                    "Item Ledger Entry"."Document Type" in
                    ["Item Ledger Entry"."Document Type"::" ",
                    "Item Ledger Entry"."Document Type"::"Purchase Receipt",
                    "Item Ledger Entry"."Document Type"::"Purchase Invoice",
                     "Item Ledger Entry"."Document Type"::"Purchase Credit Memo",
                    "Item Ledger Entry"."Document Type"::"Purchase Return Shipment"] then begin
                    //Find 
                    ItemApplicationEntry_lRec.reset;
                    ItemApplicationEntry_lRec.SetRange("Item Ledger Entry No.", "Item Ledger Entry"."Entry No.");
                    ItemApplicationEntry_lRec.SetRange("Outbound Item Entry No.", "Item Ledger Entry"."Entry No.");
                    if ItemApplicationEntry_lRec.FindFirst() then begin
                        SourceEntry_lRec.Reset();
                        SourceEntry_lRec.Get(ItemApplicationEntry_lRec."Inbound Item Entry No.");
                        "Item Ledger Entry"."Group GRN Date" := SourceEntry_lRec."Group GRN Date";
                        "Item Ledger Entry".Modify();
                        ValueEntry_lRec.Reset();
                        ValueEntry_lRec.SetRange("Item Ledger Entry No.", "Item Ledger Entry"."Entry No.");
                        if ValueEntry_lRec.FindSet() then begin
                            ValueEntry_lRec.ModifyAll("Group GRN Date", "Item Ledger Entry"."Group GRN Date");
                        end;
                    end;
                end else if ("Item Ledger Entry"."Entry Type" =                     //Sales-Negative
                     "Item Ledger Entry"."Entry Type"::Sale) and
                                    (not "Item Ledger Entry".Positive) and
                    "Item Ledger Entry"."Document Type" in
                    ["Item Ledger Entry"."Document Type"::" ",
                    "Item Ledger Entry"."Document Type"::"Sales Shipment",
                    "Item Ledger Entry"."Document Type"::"Sales Invoice"]
                      then begin
                    //Find 
                    ItemApplicationEntry_lRec.reset;
                    ItemApplicationEntry_lRec.SetRange("Item Ledger Entry No.", "Item Ledger Entry"."Entry No.");
                    ItemApplicationEntry_lRec.SetRange("outbound Item Entry No.", "Item Ledger Entry"."Entry No.");
                    if ItemApplicationEntry_lRec.FindFirst() then begin
                        SourceEntry_lRec.Reset();
                        SourceEntry_lRec.Get(ItemApplicationEntry_lRec."Inbound Item Entry No.");
                        "Item Ledger Entry"."Group GRN Date" := SourceEntry_lRec."Group GRN Date";
                        "Item Ledger Entry".Modify();
                        ValueEntry_lRec.Reset();
                        ValueEntry_lRec.SetRange("Item Ledger Entry No.", "Item Ledger Entry"."Entry No.");
                        if ValueEntry_lRec.FindSet() then begin
                            ValueEntry_lRec.ModifyAll("Group GRN Date", "Item Ledger Entry"."Group GRN Date");
                        end;
                    end;
                end else if ("Item Ledger Entry"."Entry Type" =                     //Transfer-Negative
                     "Item Ledger Entry"."Entry Type"::Transfer) and
                                    (not "Item Ledger Entry".Positive) and
                    "Item Ledger Entry"."Document Type" in
                    ["Item Ledger Entry"."Document Type"::"Transfer Shipment",
                    "Item Ledger Entry"."Document Type"::"Direct Transfer"]
                      then begin
                    //Find 
                    ItemApplicationEntry_lRec.reset;
                    ItemApplicationEntry_lRec.SetRange("Item Ledger Entry No.", "Item Ledger Entry"."Entry No.");
                    ItemApplicationEntry_lRec.SetRange("outbound Item Entry No.", "Item Ledger Entry"."Entry No.");
                    if ItemApplicationEntry_lRec.FindFirst() then begin
                        SourceEntry_lRec.Reset();
                        SourceEntry_lRec.Get(ItemApplicationEntry_lRec."Inbound Item Entry No.");
                        "Item Ledger Entry"."Group GRN Date" := SourceEntry_lRec."Group GRN Date";
                        "Item Ledger Entry".Modify();
                        ValueEntry_lRec.Reset();
                        ValueEntry_lRec.SetRange("Item Ledger Entry No.", "Item Ledger Entry"."Entry No.");
                        if ValueEntry_lRec.FindSet() then begin
                            ValueEntry_lRec.ModifyAll("Group GRN Date", "Item Ledger Entry"."Group GRN Date");
                        end;
                    end;
                end else if ("Item Ledger Entry"."Entry Type" =                     //Output-Negative
                     "Item Ledger Entry"."Entry Type"::Output) and
                                    (not "Item Ledger Entry".Positive) and
                    "Item Ledger Entry"."Document Type" in
                    ["Item Ledger Entry"."Document Type"::" "]
                      then begin
                    //Find 
                    ItemApplicationEntry_lRec.reset;
                    ItemApplicationEntry_lRec.SetRange("Item Ledger Entry No.", "Item Ledger Entry"."Entry No.");
                    ItemApplicationEntry_lRec.SetRange("outbound Item Entry No.", "Item Ledger Entry"."Entry No.");
                    if ItemApplicationEntry_lRec.FindFirst() then begin
                        SourceEntry_lRec.Reset();
                        SourceEntry_lRec.Get(ItemApplicationEntry_lRec."Inbound Item Entry No.");
                        "Item Ledger Entry"."Group GRN Date" := SourceEntry_lRec."Group GRN Date";
                        "Item Ledger Entry".Modify();
                        ValueEntry_lRec.Reset();
                        ValueEntry_lRec.SetRange("Item Ledger Entry No.", "Item Ledger Entry"."Entry No.");
                        if ValueEntry_lRec.FindSet() then begin
                            ValueEntry_lRec.ModifyAll("Group GRN Date", "Item Ledger Entry"."Group GRN Date");
                        end;
                    end;
                end else if ("Item Ledger Entry"."Entry Type" =                     //Negative-Negative
                     "Item Ledger Entry"."Entry Type"::"Negative Adjmt.") and
                                    (not "Item Ledger Entry".Positive) and
                    "Item Ledger Entry"."Document Type" in
                    ["Item Ledger Entry"."Document Type"::" ",
                    "Item Ledger Entry"."Document Type"::"Inventory Shipment"]
                      then begin
                    //Find 
                    ItemApplicationEntry_lRec.reset;
                    ItemApplicationEntry_lRec.SetRange("Item Ledger Entry No.", "Item Ledger Entry"."Entry No.");
                    ItemApplicationEntry_lRec.SetRange("outbound Item Entry No.", "Item Ledger Entry"."Entry No.");
                    if ItemApplicationEntry_lRec.FindFirst() then begin
                        SourceEntry_lRec.Reset();
                        SourceEntry_lRec.Get(ItemApplicationEntry_lRec."Inbound Item Entry No.");
                        "Item Ledger Entry"."Group GRN Date" := SourceEntry_lRec."Group GRN Date";
                        "Item Ledger Entry".Modify();
                        ValueEntry_lRec.Reset();
                        ValueEntry_lRec.SetRange("Item Ledger Entry No.", "Item Ledger Entry"."Entry No.");
                        if ValueEntry_lRec.FindSet() then begin
                            ValueEntry_lRec.ModifyAll("Group GRN Date", "Item Ledger Entry"."Group GRN Date");
                        end;
                    end;
                end else if ("Item Ledger Entry"."Entry Type" =                     //Consumption-Negative
                 "Item Ledger Entry"."Entry Type"::Consumption) and
                                (not "Item Ledger Entry".Positive) and
                "Item Ledger Entry"."Document Type" in
                ["Item Ledger Entry"."Document Type"::" "]
                  then begin
                    //Find 
                    ItemApplicationEntry_lRec.reset;
                    ItemApplicationEntry_lRec.SetRange("Item Ledger Entry No.", "Item Ledger Entry"."Entry No.");
                    ItemApplicationEntry_lRec.SetRange("outbound Item Entry No.", "Item Ledger Entry"."Entry No.");
                    if ItemApplicationEntry_lRec.FindFirst() then begin
                        SourceEntry_lRec.Reset();
                        SourceEntry_lRec.Get(ItemApplicationEntry_lRec."Inbound Item Entry No.");
                        "Item Ledger Entry"."Group GRN Date" := SourceEntry_lRec."Group GRN Date";
                        "Item Ledger Entry".Modify();
                        ValueEntry_lRec.Reset();
                        ValueEntry_lRec.SetRange("Item Ledger Entry No.", "Item Ledger Entry"."Entry No.");
                        if ValueEntry_lRec.FindSet() then begin
                            ValueEntry_lRec.ModifyAll("Group GRN Date", "Item Ledger Entry"."Group GRN Date");
                        end;
                    end;
                end else if ("Item Ledger Entry"."Entry Type" =                     //Assembly Output-Negative
                 "Item Ledger Entry"."Entry Type"::"Assembly Output") and
                                (not "Item Ledger Entry".Positive) and
                "Item Ledger Entry"."Document Type" in
                ["Item Ledger Entry"."Document Type"::"Posted Assembly"]
                  then begin
                    //Find 
                    ItemApplicationEntry_lRec.reset;
                    ItemApplicationEntry_lRec.SetRange("Item Ledger Entry No.", "Item Ledger Entry"."Entry No.");
                    ItemApplicationEntry_lRec.SetRange("outbound Item Entry No.", "Item Ledger Entry"."Entry No.");
                    if ItemApplicationEntry_lRec.FindFirst() then begin
                        SourceEntry_lRec.Reset();
                        SourceEntry_lRec.Get(ItemApplicationEntry_lRec."Inbound Item Entry No.");
                        "Item Ledger Entry"."Group GRN Date" := SourceEntry_lRec."Group GRN Date";
                        "Item Ledger Entry".Modify();
                        ValueEntry_lRec.Reset();
                        ValueEntry_lRec.SetRange("Item Ledger Entry No.", "Item Ledger Entry"."Entry No.");
                        if ValueEntry_lRec.FindSet() then begin
                            ValueEntry_lRec.ModifyAll("Group GRN Date", "Item Ledger Entry"."Group GRN Date");
                        end;
                    end;
                end else if ("Item Ledger Entry"."Entry Type" =                     //Assembly Consumption-Negative
                 "Item Ledger Entry"."Entry Type"::"Assembly Consumption") and
                                (not "Item Ledger Entry".Positive) and
                "Item Ledger Entry"."Document Type" in
                ["Item Ledger Entry"."Document Type"::"Posted Assembly"]
                  then begin
                    //Find 
                    ItemApplicationEntry_lRec.reset;
                    ItemApplicationEntry_lRec.SetRange("Item Ledger Entry No.", "Item Ledger Entry"."Entry No.");
                    ItemApplicationEntry_lRec.SetRange("outbound Item Entry No.", "Item Ledger Entry"."Entry No.");
                    if ItemApplicationEntry_lRec.FindFirst() then begin
                        SourceEntry_lRec.Reset();
                        SourceEntry_lRec.Get(ItemApplicationEntry_lRec."Inbound Item Entry No.");
                        "Item Ledger Entry"."Group GRN Date" := SourceEntry_lRec."Group GRN Date";
                        "Item Ledger Entry".Modify();
                        ValueEntry_lRec.Reset();
                        ValueEntry_lRec.SetRange("Item Ledger Entry No.", "Item Ledger Entry"."Entry No.");
                        if ValueEntry_lRec.FindSet() then begin
                            ValueEntry_lRec.ModifyAll("Group GRN Date", "Item Ledger Entry"."Group GRN Date");
                        end;
                    end;
                end;
                /////////////////////////////////////////////////////////////////////////////////////////////-below code for Positive
                if ("Item Ledger Entry"."Entry Type" =
                     "Item Ledger Entry"."Entry Type"::Purchase) and  //Purchase-Positive
                                    ("Item Ledger Entry".Positive) and
                    "Item Ledger Entry"."Document Type" in
                    ["Item Ledger Entry"."Document Type"::" ",
                    "Item Ledger Entry"."Document Type"::"Purchase Receipt",
                    "Item Ledger Entry"."Document Type"::"Purchase Invoice"
                    ] then begin
                    //Find 
                    PurchaseReceiptHeader.Reset();
                    PurchaseReceiptHeader.SetRange("No.", "Item Ledger Entry"."Document No.");
                    PurchaseReceiptHeader.SetFilter("Order No.", '<>%1', '');
                    if PurchaseReceiptHeader.FindLast() then begin
                        CLEAR(PurchaseHeader);
                        PurchaseHeader.RESET;
                        PurchaseHeader.SetRange("Document Type", PurchaseHeader."Document Type"::Order);
                        PurchaseHeader.SetRange("No.", PurchaseReceiptHeader."Order No.");
                        PurchaseHeader.SetFilter("Vendor Order No.", '<>%1', ''); // Finding PO with the help of GRN to get the Vendor Order no in the Selling company..
                        IF PurchaseHeader.FindLAST() THEN begin
                            Clear(ICPartner);
                            ICPartner.Reset();
                            ICPartner.SetRange("Vendor No.", PurchaseHeader."Buy-from Vendor No.");
                            if ICPartner.FindFirst() then begin
                                if (ICPartner."Inbox Details" <> '') and (ICPartner."Data Exchange Type" = ICPartner."Data Exchange Type"::Database) then begin
                                    ICShipmentLine.ChangeCompany(ICPartner."Inbox Details");
                                    ICShipmentLine.Reset();
                                    ICShipmentLine.SetRange("Order No.", PurchaseHeader."Vendor Order No.");
                                    ICShipmentLine.SetRange("No.", "Item Ledger Entry"."Item No.");
                                    ICShipmentLine.SetRange("Variant Code", "Item Ledger Entry"."Variant Code");
                                    if ICShipmentLine.FindLast() then begin
                                        Clear(ICILE);
                                        ICILE.ChangeCompany(ICPartner."Inbox Details");
                                        ICILE.Reset();
                                        ICILE.SetRange("Document No.", ICShipmentLine."Document No.");
                                        ICILE.SetRange("Document Line No.", ICShipmentLine."Line No.");
                                        ICILE.SetRange("Item No.", "Item Ledger Entry"."Item No.");
                                        ICILE.SetRange("Variant Code", "Item Ledger Entry"."Variant Code");
                                        if "Item Ledger Entry".CustomLotNumber <> '' then
                                            ICILE.SetRange(CustomLotNumber, "Item Ledger Entry".CustomLotNumber);
                                        if ICILE.FindFirst() then begin
                                            "Item Ledger Entry"."Group GRN Date" := ICILE."Group GRN Date";
                                            "Item Ledger Entry".Modify();
                                            ValueEntry_lRec.Reset();
                                            ValueEntry_lRec.SetRange("Item Ledger Entry No.", "Item Ledger Entry"."Entry No.");
                                            if ValueEntry_lRec.FindSet() then begin
                                                ValueEntry_lRec.ModifyAll("Group GRN Date", "Item Ledger Entry"."Group GRN Date");
                                            end;
                                        end;
                                    end;
                                    //end;
                                end else if (ICPartner."Inbox Details" <> '') and (ICPartner."Data Exchange Type" = ICPartner."Data Exchange Type"::API) then begin
                                    StaggingGroupGRNDetails.reset;
                                    StaggingGroupGRNDetails.SetRange("From Entry No.", "Item Ledger Entry"."Entry No.");
                                    if StaggingGroupGRNDetails.FindLast() then begin
                                        "Item Ledger Entry"."Group GRN Date" := StaggingGroupGRNDetails."To Group GRN Date";
                                        "Item Ledger Entry".Modify();
                                        ValueEntry_lRec.Reset();
                                        ValueEntry_lRec.SetRange("Item Ledger Entry No.", "Item Ledger Entry"."Entry No.");
                                        if ValueEntry_lRec.FindSet() then begin
                                            ValueEntry_lRec.ModifyAll("Group GRN Date", "Item Ledger Entry"."Group GRN Date");
                                        end;
                                    end;

                                end;
                            end
                            else
                                "Item Ledger Entry"."Group GRN Date" := "Item Ledger Entry"."Posting Date";
                        end;
                    end;
                end;
                if ("Item Ledger Entry"."Entry Type" =
                                     "Item Ledger Entry"."Entry Type"::Sale) and  //Sale-Postive
                                                    ("Item Ledger Entry".Positive) and
                                    "Item Ledger Entry"."Document Type" in
                                    ["Item Ledger Entry"."Document Type"::" ",
                                    "Item Ledger Entry"."Document Type"::"Sales Shipment",
                                    "Item Ledger Entry"."Document Type"::"Sales Invoice",
                                     "Item Ledger Entry"."Document Type"::"Sales Return Receipt",
                                    "Item Ledger Entry"."Document Type"::"Sales Credit Memo"] then begin
                    //Find 
                    ItemApplicationEntry_lRec.reset;
                    ItemApplicationEntry_lRec.SetRange("Item Ledger Entry No.", "Item Ledger Entry"."Entry No.");
                    ItemApplicationEntry_lRec.SetRange("Inbound Item Entry No.", "Item Ledger Entry"."Entry No.");
                    if ItemApplicationEntry_lRec.FindFirst() then begin
                        SourceEntry_lRec.Reset();
                        SourceEntry_lRec.Get(ItemApplicationEntry_lRec."Outbound Item Entry No.");
                        "Item Ledger Entry"."Group GRN Date" := SourceEntry_lRec."Group GRN Date";
                        "Item Ledger Entry".Modify();
                        ValueEntry_lRec.Reset();
                        ValueEntry_lRec.SetRange("Item Ledger Entry No.", "Item Ledger Entry"."Entry No.");
                        if ValueEntry_lRec.FindSet() then begin
                            ValueEntry_lRec.ModifyAll("Group GRN Date", "Item Ledger Entry"."Group GRN Date");
                        end;
                    end;
                end;
                if ("Item Ledger Entry"."Entry Type" =
                                     "Item Ledger Entry"."Entry Type"::Transfer) and  //Transfer-Postive
                                                    ("Item Ledger Entry".Positive) and
                                    "Item Ledger Entry"."Document Type" in
                                    ["Item Ledger Entry"."Document Type"::" ",
                                     "Item Ledger Entry"."Document Type"::"Transfer Receipt",
                                    "Item Ledger Entry"."Document Type"::"Direct Transfer"] then begin
                    //Find 
                    ItemApplicationEntry_lRec.reset;
                    ItemApplicationEntry_lRec.SetRange("Item Ledger Entry No.", "Item Ledger Entry"."Entry No.");
                    ItemApplicationEntry_lRec.SetRange("Inbound Item Entry No.", "Item Ledger Entry"."Entry No.");
                    if ItemApplicationEntry_lRec.FindFirst() then begin
                        SourceEntry_lRec.Reset();
                        SourceEntry_lRec.Get(ItemApplicationEntry_lRec."Transferred-from Entry No.");
                        "Item Ledger Entry"."Group GRN Date" := SourceEntry_lRec."Group GRN Date";
                        "Item Ledger Entry".Modify();
                        ValueEntry_lRec.Reset();
                        ValueEntry_lRec.SetRange("Item Ledger Entry No.", "Item Ledger Entry"."Entry No.");
                        if ValueEntry_lRec.FindSet() then begin
                            ValueEntry_lRec.ModifyAll("Group GRN Date", "Item Ledger Entry"."Group GRN Date");
                        end;
                    end;
                end;
                if (("Item Ledger Entry"."Entry Type" = "Item Ledger Entry"."Entry Type"::Output) or ("Item Ledger Entry"."Entry Type" =
                                     "Item Ledger Entry"."Entry Type"::"Assembly Output") and  //Output/Assembly Output-Postive
                                                    ("Item Ledger Entry".Positive) and
                                    "Item Ledger Entry"."Document Type" in
                                    ["Item Ledger Entry"."Document Type"::" ",
                                     "Item Ledger Entry"."Document Type"::"Posted Assembly"
                                    ]) then begin
                    //Find
                    "Item Ledger Entry"."Group GRN Date" := "Item Ledger Entry"."Posting Date";
                    "Item Ledger Entry".Modify();
                    ValueEntry_lRec.Reset();
                    ValueEntry_lRec.SetRange("Item Ledger Entry No.", "Item Ledger Entry"."Entry No.");
                    if ValueEntry_lRec.FindSet() then begin
                        ValueEntry_lRec.ModifyAll("Group GRN Date", "Item Ledger Entry"."Posting Date");
                    end;
                end;
                /////////////////////////////////////////////////////////////////////////////////////////////
            end;


            trigger OnPostDataItem()
            begin
                Windows_gDlg.Close;
            end;

            trigger OnPreDataItem()
            begin

                Windows_gDlg.Open('Total Record : #1#########\' + 'Current Record : #2##########\');
                Windows_gDlg.Update(1, Count);
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        Windows_gDlg: Dialog;
        CurrentRec_gDec: Decimal;
}