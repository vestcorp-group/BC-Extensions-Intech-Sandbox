pageextension 79657 P79657RegisteredPickSubform extends "Registered Pick Subform"
{


    actions
    {
        addlast("&Line")
        {
            action("Undo Pick")
            {
                ApplicationArea = All;
                Image = ReverseLines;
                trigger OnAction()
                var
                    ShortCloseFun: Codeunit "Short Close Functionality";
                begin
                    ShortCloseFun.UndoPickLine(Rec);
                end;
            }
        }
    }
}