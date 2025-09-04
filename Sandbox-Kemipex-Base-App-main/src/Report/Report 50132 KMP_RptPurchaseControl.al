report 50132 KMP_RptPurchaseControl//T12370-N
{
    UsageCategory = Administration;
    ApplicationArea = All;
    RDLCLayout = './Layouts/KMP_RptPurchaseControl.rdl';
    Caption = 'Purchase Receipt Report';
    //Caption = 'Purchase Control Report';

    dataset
    {
        dataitem(DataItem1; "Purch. Inv. Header")
        {
            column(No_; "No.")
            {

            }

            column(Posting_Date; "Posting Date")
            {

            }

            column(Buy_from_Vendor_No_; "Buy-from Vendor No.")
            {

            }

            column(Buy_from_Vendor_Name; "Buy-from Vendor Name")
            {

            }
            column(VendorSearchName; VendorG."Search Name")
            { }
            column(Vendor_Invoice_No_; "Vendor Invoice No.")
            {

            }
            column(Currency_Code; "Currency Code")
            {

            }

            column(Currency_Factor; "Currency Factor")
            { }
            column(Vendor_Order_No_; "Vendor Order No.")
            { }
            dataitem(DataItem2; "Purch. Inv. Line")
            {
                DataItemLink = "Document No." = field("No.");

                column(Vendor_Item_No_; "Vendor Item No.")
                {

                }

                column(Description; Description)
                {

                }

                column(ItemSerachDesc; ItemG."Search Description")
                { }
                column(Quantity; Quantity)
                {

                }
                column(Unit_of_Measure_Code; "Unit of Measure Code")
                { }

                column(Amount; Amount)
                {

                }

                column(Direct_Unit_Cost; "Direct Unit Cost")
                {

                }

                column(ETD; CustomETD)
                {

                }
                column(ETA; CustomETA)
                {

                }

                column(R_ETD; CustomR_ETD)
                {

                }
                column(R_ETA; CustomR_ETA)
                { }

                trigger OnAfterGetRecord()
                begin
                    ItemG.Get("No.");
                end;
            }

            column(CompanyNameValue; CompanyNameValue)
            {

            }

            column(CompanyAddr1Value; CompanyAddr1Value)
            {

            }

            column(CompanyAddr2Value; CompanyAddr2Value)
            {

            }

            column(FromDateParameterValue; FromDateParameterValue)
            {

            }

            column(ToDateParameterValue; ToDateParameterValue)
            {

            }

            trigger OnAfterGetRecord()
            var
                myInt: Integer;
            begin
                VendorG.Get("Buy-from Vendor No.");

            end;
        }
    }

    requestpage
    {
        SaveValues = true;
        layout
        {
            area(Content)
            {
                field(FromDate; FromDate)
                {
                    ApplicationArea = All;
                    Caption = 'From Date';
                }
                field(ToDate; ToDate)
                {
                    ApplicationArea = All;
                    Caption = 'To Date';
                }

                field(VendorNo; VendorNo)
                {
                    ApplicationArea = All;
                    Caption = 'Vendor No.';
                    TableRelation = Vendor;
                    // trigger OnDrillDown()
                    // var
                    //     myInt: Integer;
                    //     selectedVendorNo: Record Vendor;
                    //     VendorList: Page KMP_VendorList;
                    // begin
                    //     //Message(Rec.TransactionNumber);
                    //     VendorList.LookupMode(true);
                    //     if VendorList.RUNMODAL = ACTION::LookupOK then begin
                    //         VendorList.GETRECORD(selectedVendorNo);
                    //         VendorNo := selectedVendorNo."No.";
                    //     end;
                    // end;
                }
            }
        }


    }

    var
        CompanyInfo: Record 79;
        CompanyNameValue: Text[50];
        CompanyAddr1Value: Text[50];
        CompanyAddr2Value: Text[50];
        FromDate: Date;
        ToDate: Date;
        FromDateParameterValue: Date;

        ToDateParameterValue: Date;
        VendorNo: Text[20];
        VendorG: Record Vendor;
        ItemG: Record Item;

    trigger OnPreReport()
    var
        myInt: Integer;

        RecordName: Record "Purch. Inv. Header";

        CompanyInfoRec: Record "Company Information";


    begin

        //RecordName.SetFilter("Posting Date", '<=' + Format(FromDate));
        RecordName.SetFilter("Posting Date", '%1..%2', FromDate, ToDate);
        RecordName.SetFilter("Buy-from Vendor No.", VendorNo);
        FromDateParameterValue := FromDate;
        ToDateParameterValue := ToDate;
        CurrReport.SetTableView(RecordName);

        CompanyInfoRec.SetFilter(Name, CompanyInfo.CurrentCompany);
        if CompanyInfoRec.FindFirst() then begin
            CompanyNameValue := CompanyInfoRec.Name;
            CompanyAddr1Value := CompanyInfoRec.Address;
            CompanyAddr2Value := CompanyInfoRec."Address 2";
        end;

    end;

}