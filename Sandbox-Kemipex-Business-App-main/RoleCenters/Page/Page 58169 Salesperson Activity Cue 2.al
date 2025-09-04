page 58169 "Salesperson Activity Cue 2"//T12370-Full Comment    //T13413-Full UnComment
{
    PageType = CardPart;
    ApplicationArea = All;
    RefreshOnActivate = true;
    UsageCategory = Administration;
    Caption = 'Sales Order Activities';
    SourceTable = SalespersonActivityCue;

    layout
    {
        area(Content)
        {
            cuegroup("Your Blanket Sales Orders")
            {
                field("Open BSO"; rec."Open BSO")
                {
                    Caption = 'Open BSO';
                    ApplicationArea = All;
                    DrillDownPageId = "Blanket Sales Orders";
                }
                field("Pending Approval BSO"; rec."Pending Approval BSO")
                {
                    Caption = 'Pending Approval BSO';
                    ApplicationArea = All;
                    DrillDownPageId = "Blanket Sales Orders";
                }
                field("Approved BSO"; rec."Approved BSO")
                {
                    Caption = 'Approved BSO';
                    ApplicationArea = All;
                    DrillDownPageId = "Blanket Sales Orders";
                }
            }
            cuegroup("Your Sales Orders")
            {
                field("Open SO"; rec."Open SO")
                {
                    Caption = 'Open SO';
                    ApplicationArea = All;
                    DrillDownPageId = "Sales Order List";
                }
                field("Pending Approval SO"; rec."Pending Approval SO")
                {
                    Caption = 'Pending Approval SO';
                    ApplicationArea = All;
                    DrillDownPageId = "Sales Order List";
                }
                field("Approved SO"; rec."Approved SO")
                {
                    Caption = 'Approved SO';

                    ApplicationArea = All;
                    DrillDownPageId = "Sales Order List";
                }
            }
            cuegroup("Team Blanket Sales Orders")
            {
                field("Team Open BSO"; rec."Team Open BSO")
                {
                    Caption = 'Open BSO';
                    ApplicationArea = All;
                    DrillDownPageId = "Blanket Sales Orders";
                }
                field("Team Pending Approval BSO"; rec."Team Pending Approval BSO")
                {
                    Caption = 'Pending Approval BSO';
                    ApplicationArea = All;
                    DrillDownPageId = "Blanket Sales Orders";
                }
                field("Team Approved BSO"; rec."Team Approved BSO")
                {
                    Caption = 'Approved BSO';
                    ApplicationArea = All;
                    DrillDownPageId = "Blanket Sales Orders";
                }
            }
            cuegroup("Team Sales Orders")
            {
                field("Team Open SO"; rec."Team Open SO")
                {
                    Caption = 'Open SO';
                    ApplicationArea = All;
                    DrillDownPageId = "Sales Order List";
                }
                field("Team Pending Approval SO"; rec."Team Pending Approval SO")
                {
                    Caption = 'Pending Approval SO';
                    ApplicationArea = All;
                    DrillDownPageId = "Sales Order List";
                }
                field("Team Approved SO"; rec."Team Approved SO")
                {
                    Caption = 'Approved SO';
                    ApplicationArea = All;
                    DrillDownPageId = "Sales Order List";
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                ApplicationArea = All;

                trigger OnAction()
                begin

                end;
            }
        }
    }
    trigger OnOpenPage()
    var
        SP_rec: Record "Salesperson/Purchaser";
        Usersetup_rec: Record "User Setup";
        teamsalestemp: Record "Team Salesperson";
        Salesteam: Record "Team Salesperson";
        TeamSPFilter: Code[2000];
        Temptext: Text[2000];

    begin
        rec.Reset();
        if not rec.get() then begin
            rec.Init();
            rec.Insert();
        end;

        Usersetup_rec.Get(UserId);
        teamsalestemp.SetRange("Salesperson Code", Usersetup_rec."Salespers./Purch. Code");
        if teamsalestemp.FindFirst() then
            Salesteam.SetRange("Team Code", teamsalestemp."Team Code");
        if Salesteam.FindSet() then begin
            Temptext := '';
            repeat
                TeamSPFilter += Temptext + Salesteam."Salesperson Code";
                Temptext := '|';
            until Salesteam.Next() = 0;
        end;

        rec.SetFilter("Sales Team Filter", TeamSPFilter);
        rec.SetFilter("Salesperson Code Filter", Usersetup_rec."Salespers./Purch. Code");
    end;

    var
        myInt: Integer;
}