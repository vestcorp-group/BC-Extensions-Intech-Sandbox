pageextension 51201 KMP_PageExtSalesLine extends "Sales Order Subform"//T12370-Full Comment
{
    layout
    {
        addbefore(Description)
        {
            field("IMCO Code"; rec."IMCO Class")
            {
                ApplicationArea = all;
            }
        }
        //T12724 NS 6/11/2024
        addafter(Quantity)
        {
            field("Quantity (Base)"; Rec."Quantity (Base)")
            {
                ApplicationArea = all;
                Editable = false;
            }
            field("Base UOM 2"; rec."Base UOM 2")
            {
                ApplicationArea = all;
                Editable = false;
                Caption = 'Base UOM';
            }
            field("Unit Price Base UOM 2"; rec."Unit Price Base UOM 2")
            {
                ApplicationArea = All;
                Caption = 'Unit Price Base UOM';
            }
        }
        //T12724 NE 6/11/2024
        //         // Add changes to page layout here
        addafter("No.")
        {
            field(HSNCode; rec.HSNCode)
            {
                Caption = 'Item HSN Code';
                ApplicationArea = All;
                Editable = false; //T-12855
            }
            field(CountryOfOrigin; rec.CountryOfOrigin)
            {
                Caption = 'Item Country Of Origin';
                ApplicationArea = All;
                Editable = false;
            }
            field(LineHSNCode; rec.LineHSNCode)
            {
                Caption = 'Line HSN Code';
                ApplicationArea = All;
            }
            field(LineCountryOfOrigin; rec.LineCountryOfOrigin)
            {
                Caption = 'Line Country Of Origin';
                ApplicationArea = All;
            }
            field(BillOfExit; rec.BillOfExit)
            {
                Caption = 'Bill Of Exit';
                ApplicationArea = All;
                Editable = false;
            }
        }
        //         }
        addafter("Unit of Measure Code")
        {
            field("Allow Loose Qty."; rec."Allow Loose Qty.")
            {
                ApplicationArea = all;
            }
            field("Net Weight1"; rec."Net Weight")
            {
                ApplicationArea = all;
            }
            field("Gross Weight1"; rec."Gross Weight")
            {
                ApplicationArea = all;
            }
            field("Container No. 2"; rec."Container No. 2")
            {
                ApplicationArea = all;
                Caption = 'Container No.';
            }
        }
        addafter("Quantity Invoiced")
        {
            field("Profit % IC"; rec."Profit % IC")
            {
                ApplicationArea = all;
            }
        }
        // addfirst(factboxes)
        // {
        //     part(ConsolInv; "Item Company Wise Inventory")
        //     {
        //         ApplicationArea = all;
        //         SubPageLink = "Item No." = field("No.");
        //         Visible = false;
        //     }
        // }

        /* Hide by B addafter("Gross Weight")
        {
            field("Container No. 2"; rec."Container No. 2")
            {
                ApplicationArea = all;
                Caption = 'Container No.';
            }
        } Hide by B*/
    }
    actions
    {
        addafter("Insert Ext. Texts")
        {
            action("Copy IC Sales Lines")
            {
                ApplicationArea = all;
                Image = Copy;
                trigger OnAction()
                var
                    ItemL: Record Item;
                    SalesHeaderL: Record "Sales Header";
                    SalesLineL: Record "Sales Line";
                    PageSalesOrderListL: Page KMP_ICSalesOrderList;
                    ICPartnerL: Record "IC Partner";
                    ICProfitMarginL: Record "Intercompany Profit Margin";
                    CurrExchRateL: Record "Currency Exchange Rate";
                    GLSetupL: Record "General Ledger Setup";
                    GLSetup2L: Record "General Ledger Setup";
                    Itemvariant: Record "Item Variant";
                    UnitCostLCY: Decimal;
                    CostDifferenceL: Decimal;
                    CostZeroMsg: Label 'The cost for the Item %1 is 0.';
                    ItemVariantErr: Label 'Copied item %1 variant code %2 is not available in item variant table';
                    profit: Decimal;
                    IC_SalespriceLCY: Decimal;
                    CustomerPriceLCY: Decimal;

                begin
                    GLSetupL.Get();
                    SalesHeaderL.Get(rec."Document Type", rec."Document No.");
                    SalesHeaderL.TestField(Status, SalesHeaderL.Status::Open);
                    SalesHeaderL.TestField("Sell-to IC Partner Code");
                    ICPartnerL.Get(SalesHeaderL."Sell-to IC Partner Code");
                    ICPartnerL.TestField("Inbox Type", ICPartnerL."Inbox Type"::Database);
                    PageSalesOrderListL.InitTempTable(SalesHeaderL."Sell-to IC Partner Code");
                    PageSalesOrderListL.LookupMode(true);
                    if PageSalesOrderListL.RunModal() = Action::LookupOK then begin
                        PageSalesOrderListL.GetRecord(SalesHeaderL);
                        if not Confirm(StrSubstNo(CopyICLinesQst, SalesHeaderL."No.", SalesHeaderL."Posting Description"), false) then
                            exit;
                        SalesLineL.SetRange("Document Type", rec."Document Type");
                        SalesLineL.SetRange("Document No.", rec."Document No.");
                        if not SalesLineL.IsEmpty then
                            if Confirm(StrSubstNo(OverrideLinesQst, Rec."Document No."), false) then
                                SalesLineL.DeleteAll()
                            else
                                exit;
                        Clear(SalesLineL);
                        if ICProfitMarginL.Get(CompanyName, ICPartnerL."Inbox Details") then;
                        SalesLineL.ChangeCompany(SalesHeaderL."Posting Description");
                        GLSetup2L.ChangeCompany(SalesHeaderL."Posting Description");
                        GLSetup2L.Get();
                        SalesLineL.SetRange("Document Type", SalesHeaderL."Document Type");
                        SalesLineL.SetRange("Document No.", SalesHeaderL."No.");
                        SalesLineL.SetRange(Type, rec.Type::Item);
                        if SalesLineL.IsEmpty then
                            Error(NoLinesToCopyErr, SalesHeaderL."No.");
                        SalesLineL.FindSet();
                        repeat
                            UnitCostLCY := 0;
                            CostDifferenceL := 0;
                            Rec.Init();
                            Rec."Line No." := SalesLineL."Line No.";
                            Rec.Validate(Type, SalesLineL.Type);
                            Rec.Validate("No.", SalesLineL."No.");
                            Rec.Insert(true);
                            Rec."IC Copy" := true;
                            Rec.validate("Unit of Measure Code", SalesLineL."Unit of Measure Code");
                            Rec."IC Copy" := false;
                            Rec.Validate(Quantity, SalesLineL.Quantity);

                            if ItemL.Get(SalesLineL."No.") then begin
                                UnitCostLCY := ItemL."Unit Cost";
                                IC_SalespriceLCY := ((UnitCostLCY / 100) * ICProfitMarginL."Profit Margin %") + UnitCostLCY;

                                CustomerPriceLCY := CurrExchRateL.ExchangeAmtFCYToFCY(Today, SalesLineL."Currency Code", '', SalesLineL."Unit Price Base UOM 2"); //PackingListExtChange
                            end;

                            if UnitCostLCY = 0 then
                                Message(StrSubstNo(CostZeroMsg, SalesLineL."No."))
                            else
                                //if ICProfitMarginL."Profit Margin %" > 0 then
                                if CustomerPriceLCY > IC_SalespriceLCY then begin
                                    if rec."Currency Code" = '' then
                                        rec.Validate("Unit Price Base UOM 2", Round(IC_SalespriceLCY, 5, '=')) //PackingListExtChange
                                    else
                                        rec.Validate("Unit Price Base UOM 2", Round(CurrExchRateL.ExchangeAmtFCYToFCY(Today, '', rec."Currency Code", IC_SalespriceLCY), 5, '=')); //PackingListExtChange
                                end
                                else
                                    if rec."Currency Code" <> '' then
                                        rec.Validate("Unit Price Base UOM 2", Round(CurrExchRateL.ExchangeAmtFCYToFCY(Today, '', rec."Currency Code", UnitCostLCY), 5, '=')) //PackingListExtChange
                                    else
                                        rec.Validate("Unit Price Base UOM 2", Round(UnitCostLCY, 5, '=')); //PackingListExtChange

                            // if UnitCostL < CustomerPriceLCY then
                            //     Validate("Unit Price Base UOM", Round(IC_Salesprice, 5, '='))
                            // else
                            // Validate("Unit Price Base UOM", Round(UnitCostL, 5, '='));

                            rec."Location Code" := SalesLineL."Location Code";
                            rec."IC Customer" := SalesHeaderL."Sell-to Customer Name";
                            rec."IC Related SO" := SalesHeaderL."No.";
                            if SalesLineL."Variant Code" <> '' then begin
                                If not Itemvariant.Get(SalesLineL."No.", SalesLineL."Variant Code") then
                                    Error(ItemVariantErr, SalesLineL."No.", SalesLineL."Variant Code")
                                else begin
                                    Rec."Variant Code" := SalesLineL."Variant Code";
                                end;

                            end;

                            rec.Modify(true);
                        until SalesLineL.Next() = 0;
                    end;
                end;
            }
        }
    }

    procedure CheckCustomerSaleslineCurrency(salesLine: Record "Sales Line") Currencycode: Code[20];
    var
        GLS: Record "General Ledger Setup";
    begin
        if GLS.Get() then;

        exit(Currencycode)
    end;

    var
        CopyICLinesQst: Label 'Do you want to copy the lines from Sales Order %1 and Company %2?';
        NoLinesToCopyErr: Label 'There are no lines in Sales Order %1 to copy!!';
        OverrideLinesQst: Label 'There are lines exist in Sales Order %1. Do you want to override the existing lines?';

    trigger OnModifyRecord(): Boolean
    var
        SalesHeader: Record "Sales Header";
        HandledICInboxSalesLine: Record "Handled IC Inbox Sales Line";
        Text0001: Label 'You cannot modify because this is Inter Commpany Transaction.';
        HandledICInboxSalesHeader: Record "Handled IC Inbox Sales Header";
    begin
        if Rec."Document Type" <> Rec."Document Type"::Order then
            exit;

        SalesHeader.Reset();
        SalesHeader.Get(Rec."Document Type", Rec."Document No.");
        if SalesHeader."IC Transaction No." = 0 then
            exit;

        if Rec."IC Partner Ref. Type" = Rec."IC Partner Ref. Type"::"Cross Reference" then begin //Hypercare-09-04-2025-N
            HandledICInboxSalesHeader.reset;
            HandledICInboxSalesHeader.SetRange("IC Transaction No.", SalesHeader."IC Transaction No.");
            HandledICInboxSalesHeader.SetRange("Document Type", HandledICInboxSalesHeader."Document Type"::Order);
            HandledICInboxSalesHeader.SetRange("IC Partner Code", SalesHeader."Sell-to IC Partner Code");
            HandledICInboxSalesHeader.SetRange("No.", SalesHeader."IC Reference Document No.");
            if HandledICInboxSalesHeader.FindFirst() then begin

                HandledICInboxSalesLine.Reset();
                HandledICInboxSalesLine.SetRange("IC Transaction No.", HandledICInboxSalesHeader."IC Transaction No.");
                HandledICInboxSalesLine.SetRange("IC Partner Code", HandledICInboxSalesHeader."IC Partner Code");
                HandledICInboxSalesLine.SetRange("Line No.", Rec."Line No.");
                HandledICInboxSalesLine.SetRange("Transaction Source", HandledICInboxSalesHeader."Transaction Source");
                HandledICInboxSalesLine.SetFilter("IC Partner Reference", '<>%1', '');
                if HandledICInboxSalesLine.FindFirst() then begin

                    if Rec.Quantity <> HandledICInboxSalesLine.Quantity then
                        Error(Text0001);
                    if Rec."Unit of Measure Code" <> HandledICInboxSalesLine."Unit of Measure Code" then
                        Error(Text0001);
                    if HandledICInboxSalesLine."IC Partner Ref. Type" = HandledICInboxSalesLine."IC Partner Ref. Type"::"Cross Reference" then
                        if Rec."IC Item Reference No." <> HandledICInboxSalesLine."IC Item Reference No." then
                            Error(Text0001);
                end;
            end;

            if Rec."No." <> xRec."No." then
                Error(Text0001);
            if Rec."Variant Code" <> xRec."Variant Code" then
                Error(Text0001);
            if Rec."Line Amount" <> xRec."Line Amount" then
                Error(Text0001);
            if Rec."Unit Price" <> xRec."Unit Price" then
                Error(Text0001);
            if Rec."Line Discount Amount" <> xRec."Line Discount Amount" then
                Error(Text0001);
            if Rec."Inv. Discount Amount" <> xRec."Inv. Discount Amount" then
                Error(Text0001);
            if Rec."Line Discount %" <> xRec."Line Discount %" then
                Error(Text0001);
        end;//Hypercare-09-04-2025-N
    End;


}


// // if ("Currency Code" = SalesLineL."Currency Code") and ("Currency Code" > '') then
// //     CostDifferenceL := SalesLineL."Unit Price Base UOM" - UnitCostL
// // else begin
// //     if ("Currency Code" = '') and (SalesLineL."Currency Code" = '') then begin
// //         if GLSetupL."LCY Code" = GLSetup2L."LCY Code" then
// //             CostDifferenceL := SalesLineL."Unit Price Base UOM" - UnitCostL
// //         else
// //             CostDifferenceL := CurrExchRateL.ExchangeAmtFCYToFCY(Today, GLSetup2L."LCY Code", GLSetupL."LCY Code", SalesLineL."Unit Price Base UOM") - UnitCostL;
// //     end else begin
// //         if SalesLineL."Currency Code" > '' then
// //             CostDifferenceL := CurrExchRateL.ExchangeAmtFCYToFCY(Today, SalesLineL."Currency Code", "Currency Code", SalesLineL."Unit Price Base UOM") - UnitCostL
// //         else
// //             CostDifferenceL := CurrExchRateL.ExchangeAmtFCYToFCY(Today, GLSetup2L."LCY Code", "Currency Code", SalesLineL."Unit Price Base UOM") - UnitCostL
// //     end;
// // end;

// // Validate("Unit Price Base UOM", Round(UnitCostL + (CostDifferenceL * (100 - ICProfitMarginL."Profit Margin %") / 100), 5, '='));

// // "Unit Price Base UOM" := Round("Unit Price Base UOM", 5, '=');

// // if "Currency Code" = '' then
// //     if ("Currency Code" = SalesLineL."Currency Code") and ("Currency Code" > '') then begin
// //         profit := (UnitCostL / 100) * ICProfitMarginL."Profit Margin %";
// //         Message('this is 1');
// //     end
// //     else begin
// //         if ("Currency Code" = '') and (SalesLineL."Currency Code" = '') then begin
// //             if GLSetupL."LCY Code" = GLSetup2L."LCY Code" then begin
// //                 profit := (UnitCostL / 100) * ICProfitMarginL."Profit Margin %";
// //                 Message('this is 2');
// //             end
// //             else begin
// //                 profit := (UnitCostL / 100) * ICProfitMarginL."Profit Margin %";
// //                 Message('This is 3');
// //             end;
// //         end else begin
// //             if SalesLineL."Currency Code" > '' then begin
// //                 profit := (UnitCostL / 100) * ICProfitMarginL."Profit Margin %";
// //                 Message('This is 4');
// //             end
// //             else begin
// //                 profit := (UnitCostL / 100) * ICProfitMarginL."Profit Margin %";
// //                 Message('This is 5');
// //             end;
// //         end;
// //     end;