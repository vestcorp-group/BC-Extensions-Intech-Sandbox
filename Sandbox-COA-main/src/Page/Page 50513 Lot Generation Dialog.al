page 50513 "Lot Generation Dialog"//T12370-Full Comment
{
    PageType = StandardDialog;

    Caption = 'Lot Generator';
    SaveValues = true;

    layout
    {
        area(Content)
        {
            group(GroupName)
            {
                field(pageLotNo; pageLotNo)
                {
                    Caption = 'Lot Starting No.';
                    ApplicationArea = All;
                }
                field(Copyparamater; Copyparamater)
                {
                    ApplicationArea = all;
                    Caption = 'Copy Parameters';
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                ApplicationArea = All;

                trigger OnAction()
                begin

                end;
            }
        }
    }

    trigger OnOpenPage()
    var
        myInt: Integer;
    begin
        Copyparamater := true;
    end;

    procedure GetFields(var LotNo: Code[50]; var CopyTP: Boolean)
    var
    begin
        LotNo := pageLotNo;
        CopyTP := Copyparamater;
    end;

    var
        pageLotNo: Code[50];
        Copyparamater: Boolean;
}