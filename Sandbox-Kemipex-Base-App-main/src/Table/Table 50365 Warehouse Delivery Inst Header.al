table 50365 "Warehouse Delivery Inst Header"//T12370-Full Comment  //T12724
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "WDI No"; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(2; "Sales Shipment No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(3; "Location Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(4; "Collection Date"; Date)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                myInt: Integer;
            begin
                if Revision <> 0 then begin
                    "Revised After Sending" := true;
                end;
            end;
        }
        field(5; "Bill-to Customer Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(9; "Bill-to Customer Name"; Text[200])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(24; "Customer Contact Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Contact;
            trigger OnValidate()
            var
                ContactRec: Record Contact;
            begin
                if ContactRec.Get("Customer Contact Code") then begin
                    "Customer Contact Name" := ContactRec.Name;
                    "Customer Contact Mob No" := ContactRec."Mobile Phone No.";
                    "Customer Contact E-Mail" := ContactRec."E-Mail";
                end;
            end;
        }
        field(25; "Customer Contact Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(26; "Customer Contact Mob No"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(27; "Customer Phone No"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        // field(6; "Customer Reference"; Code[20])
        // {
        //     DataClassification = ToBeClassified;
        //     Editable = false;
        // }
        field(7; "WDI Date"; Date)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(8; "Ship-to Customer Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(10; "Location Name"; Text[200])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(11; "Order No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(12; "Blanket Order No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(13; "Location E-Mail Address"; Text[100])
        {
            DataClassification = ToBeClassified;
            Editable = true;
        }
        field(14; "Revision"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(15; "Collection Time"; Option)
        {
            OptionCaption = ',Before 10 AM,10 AM - 12 PM,12 PM - 3 PM,After 3 PM';
            OptionMembers = "","Before 10 AM","10 AM - 12 PM","12PM - 3PM","After 3PM";
            DataClassification = ToBeClassified;
        }
        field(16; "Revised After Sending"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(17; "Shipping Agent"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Shipping Agent";
            trigger OnValidate()
            var
                ShippingAgent: Record "Shipping Agent";
                contact: Record Contact;
                CleareAgentName: Boolean;
            begin
                // CleareAgentName := true;//T12370-Full Comment
                // if "Shipping Agent" <> '' then begin
                //     if ShippingAgent.Get(Rec."Shipping Agent") then begin
                //         Rec."Shipping Agent Name" := ShippingAgent.Name;
                //         Rec."Ship Agent Phone No" := ShippingAgent."Phone No";
                //         Validate("Ship Agent Contact Code", ShippingAgent."Contact Code");
                //     end;
                // end
                // else
                //     ClearAgentDetails(CleareAgentName);
            end;
        }
        field(18; "Shipping Agent Name"; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(29; "Ship Agent Contact E-mail"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(28; "Ship Agent Contact Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            // TableRelation = Contact where("Company No." = field("Shipping Agent"));
            trigger OnLookup()
            var
                AgentRec: Record "Shipping Agent";
                contactListP: Page "Contact List";
                contactrec: Record Contact;
            begin
                //T12370-Full Comment
                // if AgentRec.Get("Shipping Agent") then;
                // contactrec.SetRange("Company No.", AgentRec."Agent Code2");
                // if contactrec.FindSet() then begin
                //     contactListP.SetTableView(contactrec);
                //     contactListP.LookupMode := true;
                //     if contactListP.RunModal() = Action::LookupOK then
                //         Validate("Ship Agent Contact Code", contactListP.GetSelectionFilter());
                // end;
            end;

            trigger OnValidate()
            var
                myInt: Integer;
            begin
                ValidateAgentContact("Ship Agent Contact Code");
            end;
        }
        field(19; "Ship Agent Contact Name"; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(20; "Ship Agent Mobile No."; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(21; "Ship Agent Phone No"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(22; "Ex-Works"; Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = false;
            trigger OnValidate()
            var

            begin
                if "Ex-Works" = true then begin
                    Validate("Shipping Agent", '');
                    "Agent Enabled" := false;
                end
                else
                    "Agent Enabled" := true;
            end;
        }
        field(23; "Agent Enabled"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(30; "Customer Contact E-Mail"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; "WDI No", "Sales Shipment No.", "Location Code")
        {
            Clustered = true;
        }
    }

    local procedure ValidateAgentContact(var ContactCode: Code[20])
    var
        ContactRec: Record Contact;
        ClearagentName: Boolean;
    begin
        ClearagentName := false;
        if ContactRec.get(ContactCode) then begin
            "Ship Agent Contact Name" := ContactRec.Name;
            "Ship Agent Mobile No." := ContactRec."Mobile Phone No.";
            "Ship Agent Contact E-mail" := ContactRec."E-Mail";
        end
        else
            ClearAgentDetails(ClearagentName);
    end;

    local procedure ClearAgentDetails(var ClearAgentName: Boolean)

    begin
        "Ship Agent Contact Name" := '';
        "Ship Agent Mobile No." := '';
        "Ship Agent Contact Code" := '';
        "Ship Agent Contact E-mail" := '';
        if ClearAgentName then begin
            "Shipping Agent Name" := '';
            "Ship Agent Phone No" := '';
        end;
    end;

    // local procedure ValidatedCustomerContact(var ContactCode: Code[20])
    // var
    //     ContactRec: Record Contact;
    // begin
    //     if ContactRec.get(ContactCode) then begin
    //         "Customer Contact Name" := ContactRec.Name;

    //     end;
    // end;

    trigger OnInsert()
    begin

    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;
}