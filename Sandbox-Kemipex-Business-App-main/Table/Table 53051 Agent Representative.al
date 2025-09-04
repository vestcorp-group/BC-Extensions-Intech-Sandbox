table 53051 "Agent Representative"//T12370-Full Comment  //T12724
{
    Caption = 'Agent Representative';
    DataCaptionFields = Name, "Code";
    //LookupPageID = "Agent Representative List";

    fields
    {
        field(2; "Code"; Code[10])
        {
            Caption = 'Code';
            NotBlank = true;
        }
        field(3; Name; Text[100])
        {
            Caption = 'Name';
        }
        field(5; Address; Text[100])
        {
            Caption = 'Address';
        }
        field(6; "Address 2"; Text[150])
        {
            Caption = 'Address 2';
        }
        field(7; City; Text[30])
        {
            Caption = 'City';
            TableRelation = IF ("Country/Region Code" = CONST('')) "Post Code".City
            ELSE
            IF ("Country/Region Code" = FILTER(<> '')) "Post Code".City WHERE("Country/Region Code" = FIELD("Country/Region Code"));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnLookup()
            begin
                PostCode.LookupPostCode(City, "Post Code", blankvar, "Country/Region Code");
            end;

            trigger OnValidate()
            begin

                PostCode.ValidateCity(City, "Post Code", blankvar, "Country/Region Code", (CurrFieldNo <> 0) and GuiAllowed);
            end;
        }
        field(9; "Phone No."; Text[30])
        {
            Caption = 'Phone No.';
            ExtendedDatatype = PhoneNo;
        }
        field(35; "Country/Region Code"; Code[10])
        {
            Caption = 'Country/Region Code';
            TableRelation = "Country/Region";

            trigger OnValidate()
            begin
                PostCode.CheckClearPostCodeCityCounty(City, "Post Code", blankvar, "Country/Region Code", xRec."Country/Region Code");
            end;
        }
        field(54; "Last Date Modified"; Date)
        {
            Caption = 'Last Date Modified';
            Editable = false;
        }
        field(84; "Fax No."; Text[30])
        {
            Caption = 'Fax No.';
        }
        field(91; "Post Code"; Code[20])
        {
            Caption = 'Post Code';
            TableRelation = IF ("Country/Region Code" = CONST('')) "Post Code"
            ELSE
            IF ("Country/Region Code" = FILTER(<> '')) "Post Code" WHERE("Country/Region Code" = FIELD("Country/Region Code"));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnLookup()
            begin
                PostCode.LookupPostCode(City, "Post Code", blankvar, "Country/Region Code");
            end;

            trigger OnValidate()
            begin
                PostCode.ValidatePostCode(City, "Post Code", blankvar, "Country/Region Code", (CurrFieldNo <> 0) and GuiAllowed);
            end;
        }
        field(102; "E-Mail"; Text[80])
        {
            Caption = 'Email';
            ExtendedDatatype = EMail;

            trigger OnValidate()
            begin
                ValidateEmail()
            end;
        }
    }

    keys
    {
        key(Key1; "Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Code", Name, Address, City, "Post Code", "Country/Region Code")
        {
        }
    }

    trigger OnInsert()
    begin
    end;

    trigger OnModify()
    begin
        "Last Date Modified" := Today;
    end;

    trigger OnRename()
    begin
        "Last Date Modified" := Today;
    end;

    var
        Text000: Label 'untitled';
        PostCode: Record "Post Code";
        Text001: Label 'Before you can use Online Map, you must fill in the Online Map Setup window.\See Setting Up Online Map in Help.';
        blankvar: Variant;




    local procedure ValidateEmail()
    var
        MailManagement: Codeunit "Mail Management";
        IsHandled: Boolean;
    begin
        IsHandled := false;
        if IsHandled then
            exit;

        MailManagement.ValidateEmailAddressField("E-Mail");
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterLookupPostCode(var ShipToAddress: Record "Ship-to Address"; var PostCodeRec: Record "Post Code");
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterLookupCity(var ShipToAddress: Record "Ship-to Address"; var PostCodeRec: Record "Post Code");
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeLookupCity(var ShipToAddress: Record "Ship-to Address"; var PostCodeRec: Record "Post Code");
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeLookupPostCode(var ShipToAddress: Record "Ship-to Address"; var PostCodeRec: Record "Post Code");
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeValidateCity(ShipToAddress: Record "Ship-to Address"; var PostCodeRec: Record "Post Code");
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeValidateEmail(var ShiptoAddress: Record "Ship-to Address"; xShiptoAddress: Record "Ship-to Address"; var IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeValidatePostCode(ShipToAddress: Record "Ship-to Address"; var PostCodeRec: Record "Post Code");
    begin
    end;
}

