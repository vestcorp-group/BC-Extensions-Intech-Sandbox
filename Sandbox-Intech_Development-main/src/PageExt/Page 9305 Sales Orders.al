pageextension 85205 SalesOrdersExtV extends "Sales Order List"
{
    Description = 'T51137';
    layout
    {
        addlast(Control1)
        {

            field(SystemCreatedBy; CreatedBy_gTxt)
            {
                ApplicationArea = All;
                Caption = 'Created By';
                ToolTip = 'Specifies the value of the SystemCreatedBy field.', Comment = '%';
            }
            field(SystemCreatedAt; Rec.SystemCreatedAt)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the SystemCreatedAt field.', Comment = '%';
            }
        }
    }
    trigger OnAfterGetRecord()
    var
        User_lRec: Record User;
    begin
        Clear(CreatedBy_gTxt);
        if User_lRec.Get(Rec.SystemCreatedBy) then
            CreatedBy_gTxt := User_lRec."User Name";
    end;

    var
        CreatedBy_gTxt: Text;
}