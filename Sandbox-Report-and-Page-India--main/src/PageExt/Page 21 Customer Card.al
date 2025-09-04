pageextension 60015 CustomerCar_d extends "Customer Card"//T12370-Full Comment
{
    actions
    {
        addlast("&Customer")
        {
            action("Update GSTIN")
            {
                ApplicationArea = All;
                Visible = false;
                trigger OnAction()
                begin
                    Rec."GST Registration No." := Rec."ARN No.";
                    Rec.Modify();
                end;
            }
        }
    }
}
