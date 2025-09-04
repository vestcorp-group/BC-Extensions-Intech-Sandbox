//T36936-NS
Page 74989 "Vendor TDS Files Subform"
{
    Caption = 'Vendor Form16 TDS File Subform';
    PageType = ListPart;
    SourceTable = "Vendor TDS Files Lines";
    InsertAllowed = false;
    ModifyAllowed = false;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("File Name"; Rec."File Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the File Name field.';
                }
                field("Vendor No."; Rec."Vendor No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Vendor No. field.';
                }
                field("Vendor Name"; Rec."Vendor Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Vendor Name field.';
                }
                field("Email Sent"; Rec."Email Sent")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Email Sent field.';
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            group("Send Mail")
            {
                action(SendMail)
                {
                    Caption = 'Send E-Mail';
                    ApplicationArea = All;
                    // Promoted = true;
                    // PromotedCategory = Process;
                    // PromotedIsBig = true;
                    Image = SendEmailPDF;
                    ToolTip = 'Send E-Mail with Attachments';

                    trigger OnAction()
                    var
                    begin
                        Rec.SetRecFilter();
                        Rec.SendVendorTDSFile(Rec);
                    end;
                }
            }
        }
    }
}

//T36936-NE