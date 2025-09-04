report 58053 Purchase_Line_report//T12370-Full Comment  //T13413-Full UnComment
{
    UsageCategory = Administration;
    ApplicationArea = all;
    RDLCLayout = 'Reports/Open Purchase Order report.rdl';
    Caption = 'Open Purchase Order Report';

    dataset
    {

        dataitem(Company; Company)
        {
            column(Company_name; Company_short_Name."Short Name") { }
            dataitem("Purchase Line"; "Purchase Line")
            {
                RequestFilterFields = "Buy-from Vendor No.", "Currency Code", "Location Code";

                DataItemTableView = where("Document Type" = filter(Order));
                // column(comp; comp.Name) { }
                column(Order_Date; "Order Date") { }
                column(Document_No_; "Document No.") { }
                column(No_; "No.") { }
                column(Currency_Code; "Currency Code") { }
                column(Buy_from_Vendor_No_; "Buy-from Vendor No.") { }
                column(Vendor; Vendor.Name) { }
                column(Location_Code; "Location Code") { }
                column(Quantity__Base_; "Quantity (Base)") { DecimalPlaces = 0 : 3; }
                column(Qty__Received__Base_; "Qty. Received (Base)") { DecimalPlaces = 0 : 3; }
                column(Qty__Invoiced__Base_; "Qty. Invoiced (Base)") { DecimalPlaces = 0 : 3; }
                column(Unit_Price_Base_UOM; "Unit Price Base UOM") { }
                column(Amount; Amount) { }
                column(Line_Amount; "Line Amount") { }
                column(Quantity; Quantity) { }
                column(Base_UOM; "Base UOM") { }
                column(Unit_of_Measure; "Unit of Measure") { }
                column(itemName; Description) { }
                column(CustomETA; CustomETA) { }
                column(CustomETD; CustomETD) { }
                column(CustomR_ETD; CustomR_ETD) { }
                column(CustomR_ETA; CustomR_ETA) { }
                column(Quantity_Received; "Quantity Received") { }
                column(Quantity_Invoiced; "Quantity Invoiced") { }
                column(Outstanding_Amount; "Outstanding Amount") { }
                column(ReceivedAmount; ReceivedAmount) { }
                column(Blanket_Order_No_; "Blanket Order No.") { }
                column(Reserved_Qty___Base_; "Reserved Qty. (Base)") { }
                column(SystemCreatedAt; SystemCreatedAt) { }
                column(ApprovalEntry; ApprovalEntry."Last Date-Time Modified") { }
                column(Status; PurchaseHeader.Status) { }


                trigger OnAfterGetRecord()
                begin

                    if "Document No." = '' then CurrReport.Skip();
                    Clear(item);
                    Clear(ReceivedAmount);
                    Clear(ApprovalEntry);
                    Clear(PurchaseHeader);

                    Vendor.ChangeCompany(Company.Name);
                    item.ChangeCompany(Company.Name);
                    ApprovalEntry.ChangeCompany(Company.Name);
                    PurchaseHeader.ChangeCompany(Company.Name);

                    ApprovalEntry.SetRange("Document No.", "Purchase Line"."Document No.");
                    ApprovalEntry.SetFilter(Status, 'Approved');
                    if ApprovalEntry.FindLast() then;

                    PurchaseHeader.SetRange("No.", "Purchase Line"."Document No.");
                    if PurchaseHeader.FindFirst() then;


                    if item.Get("Purchase Line"."No.") then;
                    if "Currency Code" = '' then "Currency Code" := 'AED';
                    If Vendor.Get("Buy-from Vendor No.") and (Vendor."IC Partner Code" > '') and (not Showintercompa) then CurrReport.Skip();


                end;

                trigger OnPreDataItem()
                var
                    myInt: Integer;
                begin
                    ChangeCompany(Company.Name);

                    comp.Get();
                    if (FromDate <> 0D) and (ToDate <> 0D) then begin
                        SetFilter("Order Date", '%1..%2', FromDate, ToDate);
                    end;
                    if only_eta = true then begin
                        SetFilter(CustomR_ETD, '%1', 0D);
                        SetFilter(CustomETA, '<>%1&<%2', 0D, WorkDate());
                    end;
                    if Only_R_ETA = true then begin
                        SetFilter(CustomR_ETA, '<>%1', 0D);
                        SetFilter(CustomETA, '<%1', WorkDate());
                    end;
                    SetFilter("No.", ItemNo);
                end;

            }
            trigger OnAfterGetRecord()
            var
                myInt: Integer;
                PurchaseLine: Record "Purchase Line";
                RecShortName: Record "Company Short Name";//20MAY2022
            begin
                Company_short_Name.Get(Name);

                Clear(RecShortName);//20MAY2022
                RecShortName.SetRange(Name, Name);
                RecShortName.SetRange("Block in Reports", true);
                if RecShortName.FindFirst() then
                    CurrReport.Skip();

                PurchaseLine.SetRange("Document Type", PurchaseLine."Document Type"::Order);
                PurchaseLine.ChangeCompany(Name);
                if not PurchaseLine.FindSet() then CurrReport.skip;

            end;

            trigger OnPreDataItem()
            var

            begin
                SetFilter(Name, select_company);
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
                    ApplicationArea = all;
                    Caption = 'From Date';
                }
                field(ToDate; ToDate)
                {
                    Caption = 'To Date';
                    ApplicationArea = all;
                }
                field(ItemNo; ItemNo)
                {
                    ApplicationArea = all;
                    Caption = 'Item No.';
                    TableRelation = Item;
                }
                field(select_company; select_company)
                {
                    ApplicationArea = all;
                    Caption = 'Select Company';
                    TableRelation = Company;
                }
                field(only_eta; only_eta)
                {
                    Caption = 'Show Only Elapsed ETA';
                    ApplicationArea = all;
                    trigger OnValidate()
                    var
                    begin
                        Only_R_ETA := false;

                    end;
                }
                field(Only_R_ETA; Only_R_ETA)
                {
                    Caption = 'Show Only Elapsed R-ETA';
                    ApplicationArea = all;
                    trigger OnValidate()
                    var
                    begin
                        only_eta := false;
                    end;
                }
                field(Showintercompa; Showintercompa)
                {
                    Caption = 'Show Intercompany Purchase';
                    ApplicationArea = all;
                }
            }
        }
    }

    var
        Vendor: Record Vendor;
        item: Record 27;
        comp: Record "Company Information";
        only_eta: Boolean;
        Only_R_ETA: Boolean;
        datevar: Date;
        FromDate: Date;
        ToDate: date;
        Showintercompa: Boolean;
        Company_short_Name: Record "Company Short Name";
        ReceivedAmount: Decimal;
        ItemNo: Code[20];
        select_company: Text;
        ApprovalEntry: Record "Approval Entry";
        PurchaseHeader: Record "Purchase Header";

}