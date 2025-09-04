pageextension 64111 BlanketPurchOrderExt extends "Blanket Purchase Order"
{
    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        //T53930-NS
        // modify(Email)
        // {
        //     Visible = false;
        // }
        modify(AttachAsPDF)
        {
            Visible = false;
        }
        // modify("Print Preview")
        // {
        //     Visible = false;
        // }
        // modify(Send)
        // {
        //     Visible = false;
        // }
        //T53930-NE
    }

    var
        myInt: Integer;
}