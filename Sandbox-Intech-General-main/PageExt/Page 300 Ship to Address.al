PageExtension 75056 Ship_to_Address_50059 extends "Ship-to Address"
{
    layout
    {
        //T32682-NS
        modify("GST Registration No.")
        {
            Visible = false;
        }
        addafter("GST Registration No.")
        {
            field(GSTRegNo_gCod; GSTRegNo_gCod)
            {
                Caption = 'GST Registration No.';
                ApplicationArea = Basic;

                trigger OnValidate()
                begin

                    Rec."GST Registration No." := GSTRegNo_gCod;
                    Rec.Modify();

                    IF GSTRegNo_gCod <> '' then
                        ShipValidate_gCdu.ValidateShipToAdd_gFnc(Rec);
                end;
            }
        }
        //T32682-NE

    }

    //T32682-NS
    trigger OnAfterGetRecord()
    begin
        GSTRegNo_gCod := Rec."GST Registration No.";
    end;
    //T32682-NE

    var
        ShipValidate_gCdu: Codeunit ShipToAdd_Validation;
        GSTRegNo_gCod: Code[15];
}

