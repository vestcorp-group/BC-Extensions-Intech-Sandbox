PageExtension 75077 UsersPageExt_75077 extends Users
{
    layout
    {
        modify("User Name")
        {
            StyleExpr = StyleExt_gTxt;
        }

        modify("Full Name")
        {
            StyleExpr = StyleExt_gTxt;
        }

        modify(State)
        {
            StyleExpr = StyleExt_gTxt;
        }

        modify("Authentication Email")
        {
            StyleExpr = StyleExt_gTxt;
        }
    }

    var
        StyleExt_gTxt: Text;


    trigger OnAfterGetRecord()
    begin
        IF Rec.State = Rec.State::Enabled then
            StyleExt_gTxt := 'Favorable'
        Else
            StyleExt_gTxt := 'Unfavorable';
    end;
}

