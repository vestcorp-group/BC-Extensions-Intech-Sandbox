tableextension 75001 Workflow_75001 extends Workflow
{
    fields
    {
        field(50000; "Send CC"; Text[250])
        {
            DataClassification = ToBeClassified;
            Description = 'T11244';
            CaptionML = ENU = 'Send CC', ENN = 'Send CC';
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                IF "Send CC" <> '' THEN
                    CorrectAndValidateEmailList("Send CC");
            end;
        }
        field(50001; "Send BCC"; Text[250])
        {
            DataClassification = ToBeClassified;
            Description = 'T11244';
            CaptionML = ENU = 'Send BCC', ENN = 'Send BCC';
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                IF "Send BCC" <> '' THEN
                    CorrectAndValidateEmailList("Send BCC");
            end;
        }
    }


    local procedure CorrectAndValidateEmailList(VAR EmailAddresses: Text[250])
    var
        MailManagement: Codeunit "Mail Management";
    begin
        //T11244-NS
        EmailAddresses := CONVERTSTR(EmailAddresses, ',', ';');
        EmailAddresses := DELCHR(EmailAddresses, '<>');
        MailManagement.CheckValidEmailAddresses(EmailAddresses);
        //T11244-NE
    end;



    var
        myInt: Integer;
}