page 53050 "Custom User Setup"//T12370-Full Comment
{
    ApplicationArea = Basic, Suite;
    Caption = 'Custom User Setup';
    PageType = List;
    SourceTable = "Custom User Setup";
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = Basic, Suite;
                    LookupPageID = "User Lookup";
                    ToolTip = 'Specifies the ID of the user who posted the entry, to be used, for example, in the change log.';
                }
                field("Undo Purchase Receipt"; Rec."Undo Purchase Receipt")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies permission to undo purchase receipt before invoicing.';
                }
                field("Undo Sales Shipment"; Rec."Undo Sales Shipment")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies permission to undo sales shipment return before invoicing.';
                }
                field("Allow this Comp. COO selection"; Rec."Allow this Comp. COO selection")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies permission to allow this company COO selection on SO Line.';
                }
                field("Allow PO Modification"; Rec."Allow PO Modification")
                {
                    ApplicationArea = All;
                    Caption = 'Allow PO Modification after released.';
                    ToolTip = 'Allow PO modification after released.';

                }
                field("Allow Salesperson Modification"; Rec."Allow Salesperson Modification")
                {
                    ApplicationArea = all;
                    Caption = 'Allow Salesperson Modification on BSO/SO';
                    ToolTip = 'Allow Salesperson Modification on Blanket/Sales Order Header';
                }
            }
        }
    }
    actions
    {
        area(Creation)
        {
            // action(Release)
            // {
            //     Caption = 'Release to Companies';
            //     ApplicationArea = all;
            //     Promoted = true;
            //     PromotedCategory = Process;
            //     PromotedIsBig = true;
            //     trigger OnAction()
            //     var
            //         myInt: Integer;
            //     begin
            //         rec.companytransfer(xRec);
            //     end;
            // }

        }
    }
}