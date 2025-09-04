page 50501 "Item Testing Parameters"//T12370-N
{
    PageType = List;
    SourceTable = "Item Testing Parameter";
    Caption = 'Item Testing Parameters';
    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Item No."; rec."Item No.")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field(Code; rec.Code)
                {
                    ApplicationArea = all;
                    trigger OnValidate()
                    begin
                        SetControls();
                    end;
                }
                //T45727-NS
                field("Testing Parameter Code"; Rec."Testing Parameter Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                //T45727-NE
                field("Testing Parameter"; rec."Testing Parameter")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Data Type"; rec."Data Type")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field(Minimum; rec.Minimum)
                {
                    ApplicationArea = all;
                    Editable = MinMaxEditableG;
                }
                field(Maximum; rec.Maximum)
                {
                    ApplicationArea = all;
                    Editable = MinMaxEditableG;
                }
                field(Symbol; rec.Symbol)
                {
                    ApplicationArea = All;
                    Editable = MinMaxEditableG;
                    Visible = false;//5-06-2022
                }
                field(Value; rec.Value2)
                {
                    ApplicationArea = all;
                    Editable = ValueEditableG;
                }
                field(Priority; rec.Priority)
                {
                    ApplicationArea = all;
                    ///Editable = ValueEditableG;
                }
                field("Show in COA"; rec."Show in COA")
                {
                    ApplicationArea = all;
                    //Editable = ValueEditableG;
                }
                field("Default Value"; Rec."Default Value")
                {
                    ApplicationArea = All;
                    //Editable = ValueEditableG;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Copy Parameters")
            {
                ApplicationArea = All;
                Caption = 'Copy Parameters';
                Image = CopyWorksheet;
                Visible = false;
                trigger OnAction()
                var
                    LotTestingParameterL: Record "Lot Testing Parameter";
                    LotTestingParameter2L: Record "Lot Testing Parameter";
                    ItemTestingParameter: Page "Item Testing Parameters";
                    ItemTestingParameterTabal: Record "Item Testing Parameter";
                    TextValue: Text[250];
                begin
                    ItemTestingParameterTabal.FilterGroup(2);
                    ItemTestingParameterTabal.SetFilter("Item No.", '<>%1', '');
                    ItemTestingParameterTabal.SetFilter(Code, '<>%1', '');
                    if Page.RunModal(Page::"Item Testing Parameters", ItemTestingParameterTabal) = Action::LookupOK then
                        TextValue := ItemTestingParameterTabal.Code;
                end;
            }
        }
    }

    var
        //[InDataSet]
        MinMaxEditableG: Boolean;
        //[InDataSet]
        ValueEditableG: Boolean;

    trigger OnAfterGetRecord()
    var
        myInt: Integer;
    begin
        SetControls();
    end;

    local procedure SetControls()
    var
        TestingParameterL: Record "Testing Parameter";
    begin
        MinMaxEditableG := false;
        ValueEditableG := false;
        if TestingParameterL.Get(rec.Code) then begin
            MinMaxEditableG := (TestingParameterL."Data Type" = TestingParameterL."Data Type"::Decimal) or
                (TestingParameterL."Data Type" = TestingParameterL."Data Type"::Integer);
            ValueEditableG := TestingParameterL."Data Type" = TestingParameterL."Data Type"::Alphanumeric;
        end;
    end;
}
