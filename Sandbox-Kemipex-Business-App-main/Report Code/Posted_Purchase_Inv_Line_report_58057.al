/*report 58057 Purch_inv_line_report
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;
    RDLCLayout = 'Reports/Purch_Inv_Line_report.rdl';
    Caption = 'Dummy';
    dataset
    {
        dataitem("Purch. Inv. Header"; "Purch. Inv. Header")
        {
            //UseTemporary = true;
            RequestFilterFields = "Buy-from Vendor No.", "Posting Date";
            DataItemTableView = where("Prepayment Invoice" = filter('No'));
            column(Posting_Date; "Posting Date") { }
            column(Invoice_No; "No.") { }

            column(Currency_Code; "Currency Code") { }
            column(Vendor_Invoice_No_; "Vendor Invoice No.") { }
            column(Document_Date; "Document Date") { }
            column(Buy_from_Vendor_No_; "Buy-from Vendor No.") { }
            column(Vendorname; ven_name.Name) { }
            dataitem("Purch. Inv. Line"; "Purch. Inv. Line")
            {
                DataItemLink = "Document No." = field("No.");
                RequestFilterFields = "Buy-from Vendor No.", "Location Code";
                DataItemTableView = where("Type" = filter(<> ''), "No." = filter(<> '110320'));

                column(No_; "No.") { }
                //  column(itemName; item.Description) { }
                column(Description; Description) { }
                column(Unit_of_Measure_Code; "Unit of Measure Code") { }
                column(Quantity; Quantity) { }
                column(Location_Code; "Location Code") { }
                column(GetCurrencyCode; GetCurrencyCode) { }
                column(Direct_Unit_Cost; "Direct Unit Cost") { }
                column(Amount; Amount) { }
                column(Transaction_Specification; "Transaction Specification") { }
                column(Entry_Point; "Entry Point") { }
                column(POL; pol.Description) { }
                column(POD; POD.Text) { }

                column(Amount_lcy; Amount_lcy) { }

                trigger OnPreDataItem()
                begin
                    "Purch. Inv. Header".ChangeCompany()
                end;

                trigger OnAfterGetRecord()
                begin
                    if ven_name.Get("Purch. Inv. Header"."Buy-from Vendor No.") then;
                    // if item.Get("Purch. Inv. Line"."No.") then;
                    if pol.Get("Purch. Inv. Line"."Entry Point") then;
                    if pod.Get("Purch. Inv. Line"."Area") then;

                    Amount_lcy := "Unit Cost (LCY)" * Quantity;
                    //  vatAmount := Amount_lcy * (100 / "VAT %")
                end;
            }
        }
    }
    var
        ven_name: Record Vendor;
        item: Record Item;
        POL: Record "Entry/Exit Point";
        POD: Record "Area";
        Amount_lcy: Decimal;
        vatAmount: Decimal;
    //purch_inv_header: Record "Purch. Inv. Header";

}
*/