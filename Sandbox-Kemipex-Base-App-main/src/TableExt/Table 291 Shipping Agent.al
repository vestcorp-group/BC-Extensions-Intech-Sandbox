tableextension 50371 ShipAgent extends "Shipping Agent"//T12370-Full Comment //Code Uncommented 24-12-24
{
    fields
    {
        modify(Code)
        {
            Caption = 'Agent Short Code';
            trigger OnAfterValidate()
            var
                myInt: Integer;
            begin

            end;
        }
        field(50100; "Address"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50101; "Address2"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50102; "City"; Text[30])
        {
            Caption = ' City';
            TableRelation = "Post Code".City;
            ValidateTableRelation = false;
        }
        field(50103; "Country"; Code[10])
        {
            TableRelation = "Country/Region";
        }
        field(50104; "Phone No"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50105; "E-Mail"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50106; "Contact Code"; Code[20])
        {
            DataClassification = ToBeClassified;

            trigger OnLookup()
            var
                Contact2: Record Contact;
                Contact1: Record Contact;
                ContactList: Page "Contact List";
            begin
                Contact1.SetRange("Company No.", "Agent Code2");
                if not Contact1.FindSet() then begin
                    Contact2.Init();
                    Contact2.Type := Contact2.Type::Company;
                    Contact2."No." := "Agent Code2";
                    Contact2."Company No." := Rec."Agent Code2";
                    Contact2.Name := Rec.Name;
                    Contact2.Address := Rec.Address;
                    Contact2."Address 2" := Rec.Address2;
                    Contact2.City := Rec.City;
                    Contact2."Country/Region Code" := Rec.Country;
                    Contact2."Phone No." := Rec."Phone No";
                    Contact2."E-Mail" := Rec."E-Mail";
                    Contact2.Insert();

                    // ContactList.SetTableView(Contact2);
                    // ContactList.LookupMode := true;
                    // if ContactList.RunModal() = action::LookupOK then
                    //     Message('Message 1');
                    // // Validate("Contact Code", ContactList.GetSelectionFilter());

                end else begin
                    ContactList.SetTableView(Contact1);
                    ContactList.LookupMode := true;
                    if ContactList.RunModal() = action::LookupOK then
                        Validate("Contact Code", ContactList.GetSelectionFilter());
                end;
            end;

            trigger OnValidate()
            var
                contact: Record Contact;
            begin
                if contact.get("Contact Code") then
                    "Contact Name" := contact.Name else
                    "Contact Name" := '';
            end;
        }
        field(50107; "Contact Name"; Text[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = Contact.Name;
            ValidateTableRelation = false;
            Editable = false;
        }
        field(50108; "Agent Code2"; Code[10])
        {
            Caption = 'Agent Code';
            DataClassification = ToBeClassified;
            Editable = false;
        }
    }
    trigger OnAfterInsert()
    var
        AgentRec: Record "Shipping Agent";
    begin


    end;

    var
        myInt: Integer;
}