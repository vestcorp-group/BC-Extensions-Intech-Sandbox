#pragma warning disable AL0432 // TODO: - Will removed once it will be removed from base app 30-04-2022
tableextension 58183 SalesPriceExt extends "Price List Line"//T12370-Full Comment  //T12574-N 31-12-2024-Sales Price
#pragma warning restore AL0432 // TODO: - Will removed once it will be removed from base app 30-04-2022
{
    fields
    {
        modify("Asset No.")//31-12-2024-Sales Price
        {
            trigger OnAfterValidate()
            var
                itemRec: Record Item;
            begin
                "Unit of Measure Code" := '';
                "Source Type" := "Source Type"::"All Customers";//31-12-2024-Sales Price
                if itemRec.Get("Asset No.") then begin
                    rec."Item Commercial Name" := itemRec.Description;
                    rec."Base UOM" := itemRec."Base Unit of Measure";
                    rec."Incentive Point" := itemRec."Item Incentive Ratio (IIR)";
                end;
            end;
        }
        field(58000; "Currency 2"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Currency;
            trigger OnValidate()
            var
            begin
                CalcPrice();
                TransferPrice(Rec);
            end;
        }
        field(58001; "Unit Price 2"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 2;

            trigger OnValidate()
            var
            begin
                CalcPrice();
                TransferPrice(Rec);
            end;
        }
        field(58002; "Item Commercial Name"; Text[100])
        {
            Editable = false;
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                myInt: Integer;
            begin

            end;
        }
        field(58003; "Base UOM"; Code[20])
        {
            Editable = false;
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                myInt: Integer;
            begin

            end;
        }
        //26-09-2022-start
        field(58004; "Minimum Selling Price"; Decimal)
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
            begin
                // TransferPrice(Rec); // AS-O 31-12-24
            end;
        }
        field(58005; "Incentive Point"; Option) //added by bayas
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ","1","2","3","4","5";

            trigger OnValidate()
            var
                itemRec: Record Item;
                company: Record Company;
            begin
                if itemRec.Get("Asset No.") then begin
                    //itemRec."Item Incentive Ratio (IIR)" := rec."Incentive Point";
                    //itemRec.Modify();

                    company.SetFilter(Name, '<>%1', CurrentCompany);
                    itemRec.SetRange("No.", Rec."Asset No.");
                    repeat
                        itemRec.ChangeCompany(company.Name);
                        if itemRec.FindSet() then begin
                            repeat
                                itemRec."Item Incentive Ratio (IIR)" := Rec."Incentive Point";
                                if itemRec.Modify() then;
                            until itemRec.Next() = 0;
                        end;
                    until company.Next() = 0;
                end;
                //T12574-N TransferPrice(Rec);
            end;
        }

    }

    local procedure CalcPrice()
    var
        FXRec: Record "Currency Exchange Rate";
    begin
        "Unit Price" := FXRec.ExchangeAmtFCYToLCY(WorkDate(), "Currency 2", "Unit Price 2", FXRec.GetCurrentCurrencyFactor("Currency 2"));
        // "Unit Price" := Round(FXRec.GetCurrentCurrencyFactor("Currency 2") * "Unit Price 2", 0.01);
    end;

    var
        myInt: Integer;

    procedure TransferPrice(ItemPrice_From: Record "Price List Line") //31-12-2024-Sales Price
    var
        masterconfig: Record "Release to Company Setup";
        ItemPrice_To: Record "Price List Line";//31-12-2024-Sales Price
        Text001: Label 'Price Update for %1 in following companies';
        Text002: Label 'Price Update for ##########1 modified in %2 Company';
        Transfered_companies: Text[200];
    begin
        masterconfig.reset();
        masterconfig.SetRange(masterconfig."Transfer Item", true);
        masterconfig.SetFilter(masterconfig."Company Name", '<>%1', CompanyName);
        if masterconfig.FindSet() then
            repeat
                ItemPrice_To.ChangeCompany(masterconfig."Company Name");
                ItemPrice_To.Reset();
                if not ItemPrice_To.Get(ItemPrice_From."Asset No.", ItemPrice_From."Source Type", ItemPrice_From."Source No.", ItemPrice_From."Starting Date", ItemPrice_From."Currency Code", ItemPrice_From."Variant Code", ItemPrice_From."Unit of Measure Code", ItemPrice_From."Minimum Quantity") then begin
                    ItemPrice_To.Init();
                    ItemPrice_To := ItemPrice_From;
                    ItemPrice_To."Currency 2" := ItemPrice_From."Currency 2";
                    ItemPrice_To."Minimum Selling Price" := ItemPrice_From."Minimum Selling Price";
                    ItemPrice_To."Incentive Point" := ItemPrice_From."Incentive Point";
                    if ItemPrice_To.Insert() then;
                    // Transfered_companies += masterconfig."Company Name";
                end
                else begin
                    ItemPrice_To.TransferFields(ItemPrice_From, false);
                    ItemPrice_To."Currency 2" := ItemPrice_From."Currency 2";
                    ItemPrice_To."Minimum Selling Price" := ItemPrice_From."Minimum Selling Price";
                    ItemPrice_To."Incentive Point" := ItemPrice_From."Incentive Point";
                    if ItemPrice_To.Modify() then;
                    // Transfered_companies += masterconfig."Company Name";
                end;
            until masterconfig.Next() = 0;
    end;
}

