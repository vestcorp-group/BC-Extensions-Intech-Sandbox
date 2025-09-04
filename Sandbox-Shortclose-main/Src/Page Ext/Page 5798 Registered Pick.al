pageextension 79655 P79655_RegisteredPick extends "Registered Pick"
{

    actions
    {
        addlast(Processing)
        {
            action("Undo Pick")
            {
                ApplicationArea = All;
                Image = ReverseLines;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    ShortCloseFun: Codeunit "Short Close Functionality";
                begin
                    ShortCloseFun.UndoPick(Rec);
                end;
            }
        }
    }

}