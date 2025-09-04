query 53020 PurchInvoicePostedWebAPI//T12370-Full Comment //T50051 Code Uncommented
{
    QueryType = Normal;

    Caption = 'BI Purchase Invoice Header';

    elements
    {
        dataitem(Purch__Inv__Header; "Purch. Inv. Header")
        {
            column(No_; "No.")
            {

            }
            column(Buy_from_Vendor_No_; "Buy-from Vendor No.") { }
            column(Buy_from_Vendor_Name; "Buy-from Vendor Name") { }
            //            column(Buy_from_Address; "Buy-from Address") { }
            //           column(Buy_from_Address_2; "Buy-from Address 2") { }
            //         column(Buy_from_City; "Buy-from City") { }
            column(Buy_from_Country_Region_Code; "Buy-from Country/Region Code") { }
            column(Buy_from_Post_Code; "Buy-from Post Code") { }
            column(Order_Date; "Order Date") { }
            column(Posting_Date; "Posting Date") { }
            column(Due_Date; "Due Date") { }

            column(Payment_Terms_Code; "Payment Terms Code") { }
            column(Payment_Method_Code; "Payment Method Code") { }
            column(Ship_to_Code; "Ship-to Code") { }
            //       column(Ship_to_Name; "Ship-to Name") { }
            //      column(Ship_to_Address; "Ship-to Address") { }
            //     column(Ship_to_Address_2; "Ship-to Address 2") { }
            //   column(Ship_to_City; "Ship-to City") { }
            column(Ship_to_Country_Region_Code; "Ship-to Country/Region Code") { }
            column(Ship_to_Post_Code; "Ship-to Post Code") { }
            column(Location_Code; "Location Code") { }
            column(Currency_Code; "Currency Code") { }
            column(Currency_Factor; "Currency Factor") { }
            column(Purchaser_Code; "Purchaser Code") { }
            column(Order_No_; "Order No.") { }
            //column(Prices_Including_VAT; "Prices Including VAT") { }
            // column(Gen__Bus__Posting_Group; "Gen. Bus. Posting Group") { }
            // column(VAT_Bus__Posting_Group; "VAT Bus. Posting Group") { }
            column(Transport_Method; "Transport Method") { }
            // column(Amount; Amount) { }
            //column(Amount_Including_VAT; "Amount Including VAT") { }

            // added by bayas
            column(Document_Date; "Document Date") { } //Vendor Invoice Date
            column(Vendor_Invoice_No_; "Vendor Invoice No.") { }
            column(Prepayment_Invoice; "Prepayment Invoice") { }
            column(Prepayment_Order_No_; "Prepayment Order No.") { }
            column(Remaining_Amount; "Remaining Amount") { }
            column(Sell_to_Customer_No_; "Sell-to Customer No.") { }
            column(Ship_to_Name; "Ship-to Name") { }



        }
    }

    var
        myInt: Integer;

    trigger OnBeforeOpen()
    begin

    end;
}