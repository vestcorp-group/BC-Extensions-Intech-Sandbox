tableextension 50485 Teamsalespeopletableext extends "Team Salesperson"
{
    fields
    {
        field(50116; Manager; Boolean)
        {
            Caption = 'Manager';
            DataClassification = CustomerContent;
            trigger OnValidate()
            var
                TeamSalespeople: Record "Team Salesperson";
                Text001: Label 'One manager allowed per team';
            begin
                if Manager = true then begin  //T12370_MIG
                    TeamSalespeople.SetRange("Team Code", "Team Code");
                    TeamSalespeople.SetRange(Manager, true);
                    if TeamSalespeople.FindFirst() then
                        Error(Text001);
                end;

            end;
        }
    }

    var
        myInt: Integer;
}