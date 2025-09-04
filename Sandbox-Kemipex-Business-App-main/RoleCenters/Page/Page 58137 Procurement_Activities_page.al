page 58137 Procurement_Activities_page//T12370-Full Comment     //T13413-Full UnComment
{
    PageType = CardPart;
    ApplicationArea = All;
    UsageCategory = Administration;
    Caption = 'Procurement Activities';
    SourceTable = "Procurement Activities Cue";

    layout
    {
        area(Content)
        {
            cuegroup("Blanket Purchase Orders")
            {
                field("Open BPO"; rec."Open BPO")
                {
                    Caption = 'Open BPO';
                    ApplicationArea = All;
                    DrillDownPageId = "Blanket Purchase Orders";
                }
                field("Pending Approval BPO"; rec."Pending Approval BPO")
                {
                    Caption = 'Pending Approval BPO';
                    ApplicationArea = All;
                    DrillDownPageId = "Blanket Purchase Orders";
                }
                field("Approved BPO"; rec."Approved BPO")
                {
                    Caption = 'Approved BPO';
                    ApplicationArea = All;
                    DrillDownPageId = "Blanket Purchase Orders";
                }
            }
            cuegroup("Purhcase Orders")
            {
                field("Open PO"; rec."Open PO")
                {
                    Caption = 'Open PO';
                    ApplicationArea = All;
                    DrillDownPageId = "Purchase Order List";
                }
                field("Pending Approval PO"; rec."Pending Approval PO")
                {
                    Caption = 'Pending Approval PO';
                    ApplicationArea = All;
                    DrillDownPageId = "Purchase Order List";
                }
                field("Approved PO"; rec."Approved PO")
                {
                    Caption = 'Approved PO';
                    ApplicationArea = All;
                    DrillDownPageId = "Purchase Order List";
                }
            }
        }
    }
    trigger OnOpenPage()
    var
        myInt: Integer;
    begin
        rec.Reset();
        if not rec.get() then begin
            rec.Init();
            rec.Insert();
        end;
    end;

    var
        myInt: Integer;
}