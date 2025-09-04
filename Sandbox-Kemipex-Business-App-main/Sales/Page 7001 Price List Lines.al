pageextension 58002 SalesPriceLine_58002 extends "Price List Lines"
{
    layout
    {
        addafter("Minimum Quantity")
        {
            field("Minimum Selling Price"; Rec."Minimum Selling Price")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Minimum Selling Price field.', Comment = '%';
                Visible = Visible_gBol;//T13852-N
            }
            field("Base UOM"; Rec."Base UOM")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Base UOM field.', Comment = '%';
            }

            field("Item Commercial Name"; Rec."Item Commercial Name")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Item Commercial Name field.', Comment = '%';
            }
            field("Incentive Point"; Rec."Incentive Point")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Incentive Point field.', Comment = '%';
            }
        }
        addafter(EndingDate)//31-12-2024-Sales Price   //T13852
        {
            field("Currency 2"; rec."Currency 2")
            {
                ApplicationArea = all;

            }
            field("Unit Price 2"; rec."Unit Price 2")
            {
                ApplicationArea = all;
                Visible = Visible_gBol;//T13852-N

            }
        }
    }
    //T13852-NS
    trigger OnOpenPage()
    var
        myInt: Integer;
    begin
        Visible_lFnc();
    end;

    trigger OnAfterGetRecord()
    var
        myInt: Integer;
    begin
        Visible_lFnc();

    end;

    local procedure Visible_lFnc()

    begin
        clear(Usersetup_gRec);
        if Usersetup_gRec.get(UserId) then begin
            if not Usersetup_gRec."Allow to view Sales Price" then
                Visible_gBol := false
            else
                Visible_gBol := true;
        end;
    end;


    var
        Visible_gBol: Boolean;
        Usersetup_gRec: Record "User Setup";
    //T13852-NE
}



