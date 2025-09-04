pageextension 58018 "Team Salespeople" extends "Team Salespeople"//T12370-Full Comment
{
    layout
    {
        addlast(Control1)
        {
            field("E-Email"; Rec."E-Email")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("Manager Code"; Rec."Manager Code")
            {
                ApplicationArea = All;
                Editable = false;
            }
            //23-10-2022-start
            // field("Power BI Block"; Rec."Power BI Block")
            // {
            //     ApplicationArea = All;
            // }
            //23-10-2022-end
        }
        modify(Manager)
        {
            Editable = false;
        }
        // modify(Manager)
        // {
        //     trigger OnAfterValidate()
        //     var
        //         Utility: Codeunit Events;
        //         RecTeamSales: Record "Team Salesperson";
        //     begin
        //         Clear(RecTeamSales);
        //         RecTeamSales.SetRange("Team Code", Rec."Team Code");
        //         if RecTeamSales.FindSet() then begin
        //             repeat
        //                 If Rec.Manager then
        //                     RecTeamSales."Manager Code" := Rec."Manager Code"
        //                 else
        //                     RecTeamSales."Manager Code" := '';
        //             until RecTeamSales.Next() = 0;
        //         end;
        //         Rec := RecTeamSales;
        //         // CurrPage.Update();
        //     end;
        // }
    }

    actions
    {
        addfirst(Processing)
        {
            action("Manager_")
            {
                ApplicationArea = All;
                Image = Administration;
                Promoted = true;
                PromotedCategory = Process;
                caption = 'Make Manager';
                trigger OnAction()
                var
                    Utility: Codeunit Events;
                begin
                    if not confirm('Are you sure, you want to make manager?', false) then exit;
                    Utility.UpdateManagerCode(Rec."Team Code", Rec."Salesperson Code");
                end;
            }
        }
    }
}
