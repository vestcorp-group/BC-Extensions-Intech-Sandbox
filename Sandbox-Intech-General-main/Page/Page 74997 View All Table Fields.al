page 74997 "View All Table Fields"
{
    ApplicationArea = All;
    Caption = 'View All Table Fields';
    PageType = List;
    SourceTable = "Field";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {


                field(Enabled; Rec.Enabled)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Enabled field.';
                }
                field("Field Caption"; Rec."Field Caption")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the caption of the field, that is, the name that will be shown in the user interface.';
                }
                field(FieldName; Rec.FieldName)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the GST Reconciliation Name Field No.';
                }

                field(Len; Rec.Len)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Len field.';
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the document number.';
                }
                field(ObsoleteReason; Rec.ObsoleteReason)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the ObsoleteReason field.';
                }
                field(ObsoleteState; Rec.ObsoleteState)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the ObsoleteState field.';
                }

                field(SQLDataType; Rec.SQLDataType)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the SQL data type.';
                }


                field(TableName; Rec.TableName)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the name of the table.';
                }
                field(TableNo; Rec.TableNo)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the GSTIN for which GST reconciliation is created.';
                }
                field("Type"; Rec."Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Datatype of the field.';
                }
                field("Type Name"; Rec."Type Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the type of data.';
                }
            }
        }
    }
}
