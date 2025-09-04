page 53036 APISalesOrderHeader//T12370-Full Comment//T50051 Code Uncommented
{
    ApplicationArea = All;
    Caption = 'LP - API Sales Order Header';
    PageType = API;
    SourceTable = "Sales Header";
    Permissions = tabledata "Sales Header" = R;
    DataCaptionFields = "No.";
    UsageCategory = History;
    DeleteAllowed = false;
    ModifyAllowed = false;
    InsertAllowed = false;

    // Powerautomate Category
    EntityName = 'SalesOrderHeader';
    EntitySetName = 'SalesOrderheaders';
    EntityCaption = 'SalesOrderHeader';
    EntitySetCaption = 'SalesOrderHeaders';
    // ODataKeyFields = SystemId;
    Extensible = false;

    APIPublisher = 'Kemipex';
    APIGroup = 'LabelPrinting';
    APIVersion = 'v2.0';


    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Document_Type"; Rec."Document Type")
                {
                    ApplicationArea = All;
                }
                field("No"; Rec."No.")
                {
                    ApplicationArea = all;
                }
                field("Bill_to_Customer_No"; rec."Bill-to Customer No.")
                {
                    ApplicationArea = All;
                }
                field("Bill_to_Name"; rec."Bill-to Name")
                {
                    ApplicationArea = all;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = all;
                }
                field("Order_Date"; Rec."Order Date")
                {
                    ApplicationArea = all;
                }
                field("Posting_Date"; rec."Posting Date")
                {
                    ApplicationArea = all;
                }
                field("Document_Date"; rec."Document Date")
                {
                    ApplicationArea = all;
                }
                field("External_Document_No"; rec."External Document No.")
                {
                    ApplicationArea = all;
                }
                field("Payment_Terms_Code"; rec."Payment Terms Code")
                {
                    ApplicationArea = all;
                }
                field("Salesperson_Code"; Rec."Salesperson Code")
                {
                    ApplicationArea = all;
                }
                field("Salesperson_Name"; rec."Salesperson Name")
                {
                    ApplicationArea = all;
                }
                field("Currency_Code"; rec."Currency Code")
                {
                    ApplicationArea = all;
                }
                field(Amount; rec.Amount)
                {
                    ApplicationArea = all;
                }
                field("Amount_Including_VAT"; rec."Amount Including VAT")
                {
                    ApplicationArea = all;
                }
                field("Incoterm"; rec."Transaction Specification")
                {
                    ApplicationArea = all;
                }
                field(POL; Rec."Exit Point")
                {
                    ApplicationArea = all;
                }
                field(POD; Rec."Area")
                {
                    ApplicationArea = all;
                }
                field("Transport_Method"; rec."Transport Method")
                {
                    ApplicationArea = all;
                }

            }

        }
    }
}
