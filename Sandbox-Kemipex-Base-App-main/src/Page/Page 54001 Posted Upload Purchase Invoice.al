/// <summary>//T12370-Full Comment
/// Page Staging Purchase Invoice (ID 50100).
/// </summary>
page 54001 "Posted Upload Purchase Invoice"     //T13413
{
    Caption = 'Posted Upload Purchase Invoice';
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Staging Purchase Invoice";
    SourceTableView = sorting("Upload Batch No.", "Vendor Refrence", "Line No.") WHERE(Status = FILTER(Closed));
    Editable = false;
    InsertAllowed = false;
    DeleteAllowed = false;
    ModifyAllowed = false;
    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Upload Batch No."; Rec."Upload Batch No.")
                {
                    ApplicationArea = All;
                }
                field("Vendor Refrence"; Rec."Vendor Refrence")
                {
                    ApplicationArea = All;
                }
                field("Vendor No."; Rec."Vendor No.")
                {
                    ApplicationArea = All;
                }
                field("Purch. Invo. No."; Rec."Purch. Inv. No.")
                {
                    ApplicationArea = all;
                }
                field("Posted Purch. Inv. No."; Rec."Posted Purch. Inv. No.")
                {
                    ApplicationArea = all;

                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                }
                field("Document Date"; Rec."Document Date")
                {
                    ApplicationArea = All;
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    ApplicationArea = All;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = all;
                    Visible = false;
                }

                field("Header Description"; Rec."Header Description")
                {
                    Caption = 'Descriptions';
                    ApplicationArea = All;
                }
                field("Your Reference/PO Refernce"; Rec."Your Reference/PO Refernce")
                {
                    ApplicationArea = All;
                }
                field("Receipt No."; Rec."Receipt No.")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                }
                field("Item No."; Rec."Item No.")
                {
                    ApplicationArea = All;
                    Caption = 'No.';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                }
                field("Direct Unit Cost"; Rec."Direct Unit Cost")
                {
                    ApplicationArea = All;
                }
                field("Charge Item Types"; Rec."Charge Item Types")
                {
                    ApplicationArea = All;
                }
                field("Charge Item Doc1"; Rec."Charge Item Doc1")
                {
                    ApplicationArea = All;
                }
                field("Charge Item Doc2"; Rec."Charge Item Doc2")
                {
                    ApplicationArea = All;
                }
                field(Alloction; Rec.Alloction)
                {
                    ApplicationArea = All;
                }

                field(Status; Rec.Status)
                {
                    ApplicationArea = all;
                    Editable = NonEdiTablestatus;
                }
                field("Error Remarks"; Rec."Error Remarks")
                {
                    ApplicationArea = all;
                }
                field("Uploaded By"; Rec."Uploaded By")
                {
                    ApplicationArea = All;
                }
                field("Uploaded Date/Time"; Rec."Uploaded Date/Time")
                {
                    ApplicationArea = all;
                }
                field("Modify By"; Rec."Modify By")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Modify On"; Rec."Modify On")
                {
                    ApplicationArea = all;
                    Editable = false;
                }


            }
        }
        area(Factboxes)
        {

        }
    }

    actions
    {
        area(Processing)
        {

        }
    }
    trigger OnAfterGetRecord()
    begin
        NonEdiTablestatus := true;
        if rec.Status = rec.Status::Created then
            NonEdiTablestatus := false;


    end;

    var

        NonEdiTablestatus: Boolean;

}