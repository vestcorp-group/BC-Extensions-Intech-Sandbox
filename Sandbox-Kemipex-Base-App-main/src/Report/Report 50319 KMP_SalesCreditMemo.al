//Replace the existing report 50107 to 50319...posted sales credit note.
report 50319 KMP_SalesCreditMemo//T12370-N
{
    UsageCategory = Administration;
    ApplicationArea = All;
    RDLCLayout = './Layouts/KMP_SalesCreditMemo.rdl';
    Caption = 'Tax Credit Note';

    dataset
    {
        dataitem("Sales Cr.Memo Header"; "Sales Cr.Memo Header")
        {
            DataItemTableView = SORTING("No.");
            RequestFilterFields = "No.";
            column(No_; "No.")
            { }
            column(Posting_Date; "Posting Date")
            { }
            column(ComanyName; CompanyInfoG.Name)
            { }
            column(CompanyAddr1Value; CompanyAddrG[1])
            { }
            column(CompanyAddr2Value; CompanyAddrG[2])
            { }
            column(CompanyAddr3Value; CompanyAddrG[3])
            { }
            column(CompanyPicture; CompanyInfoG.Picture)
            { }
            column(CompanyVatRegNo; CompanyInfoG."VAT Registration No.")
            { }
            column(Sell_to_Customer_Name; "Sell-to Customer Name")
            { }
            column(Sell_to_Address; "Sell-to Address")
            { }
            column(Sell_to_Address_2; "Sell-to Address 2")
            { }
            column(CustomerRegNo; CustomerG."VAT Registration No.")
            { }
            column(Applies_to_Doc__No_; "Applies-to Doc. No.")
            { }
            column(Work_Description; WorkDescG)
            { }
            column(InvoiceAmount; PostedSalesInvG."Amount Including VAT")
            { }
            column(InvoiceVat; PostedSalesInvG."Amount Including VAT" - PostedSalesInvG.Amount)
            { }
            column(SalesCreditMemoAmount; "Sales Cr.Memo Header"."Amount Including VAT")
            { }
            column(SalesCreditMemoVat; "Amount Including VAT" - Amount)
            { }

            trigger OnAfterGetRecord()
            var
                myInt: Integer;
            begin
                CalcFields(Amount, "Amount Including VAT");

                CustomerG.Get("Sales Cr.Memo Header"."Sell-to Customer No.");
                PostedSalesInvG.Get("Sales Cr.Memo Header"."Applies-to Doc. No.");
                PostedSalesInvG.CalcFields(Amount, "Amount Including VAT");
                WorkDescG := GetWorkDescription();
            end;

        }
    }

    // requestpage
    // {
    //     layout
    //     {
    //         area(Content)
    //         {
    //             group(GroupName)
    //             {
    //                 field(Name; SourceExpression)
    //                 {
    //                     ApplicationArea = All;

    //                 }
    //             }
    //         }
    //     }


    // }

    trigger OnPreReport()
    begin
        CompanyInfoG.Get();
        FormatAddrG.Company(CompanyAddrG, CompanyInfoG);

    end;

    var
        CompanyInfoG: Record "Company Information";
        FormatAddrG: Codeunit "Format Address";
        CompanyAddrG: array[8] of Text[100];
        CustomerG: Record Customer;

        PostedSalesInvG: Record "Sales Invoice Header";

        WorkDescG: Text;
}