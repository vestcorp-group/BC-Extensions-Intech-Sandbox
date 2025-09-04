pageextension 75049 GL_Posting_Preview_75049 extends "G/L Posting Preview"

{
    //PreviewPost-NS
    actions
    {

        addafter(Show)
        {
            action(Verify)
            {
                ApplicationArea = All;
                Caption = 'Verify';
                Promoted = true;
                PromotedCategory = Process;
                ShortcutKey = 'F9';
                PromotedIsBig = true;
                trigger OnAction()
                begin
                    PreviewPostSingleInstance.ShowEntries();
                end;

            }
        }

    }
    var
        PreviewPostSingleInstance: Codeunit "Preview Posting SingleIns";
    //PreviewPost-NE
}
