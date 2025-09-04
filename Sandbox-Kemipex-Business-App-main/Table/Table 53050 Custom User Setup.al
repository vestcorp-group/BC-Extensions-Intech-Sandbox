table 53050 "Custom User Setup"//T12370-Full Comment
{
    Caption = 'User Setup';
    DrillDownPageID = "User Setup";
    LookupPageID = "Custom User Setup";
    ReplicateData = true;

    fields
    {
        field(1; "User ID"; Code[50])
        {
            Caption = 'User ID';
            DataClassification = EndUserIdentifiableInformation;
            NotBlank = true;
            TableRelation = User."User Name";
            ValidateTableRelation = false;

            trigger OnValidate()
            var
                UserSelection: Codeunit "User Selection";
            begin
                UserSelection.ValidateUserName("User ID");
            end;
        }
        field(6; "Undo Sales Shipment"; Boolean)
        {
            Caption = 'Undo Sales Shipment';
        }
        field(7; "Undo Purchase Receipt"; Boolean)
        {
            Caption = 'Undo Purchase Receipt';
        }
        field(8; "Allow this Comp. COO selection"; Boolean)
        {
            Caption = 'Allow this company COO selection on SO Line';

        }
        field(53206; "Allow PO Modification"; Boolean)
        {
            Caption = 'Allow PO Modification after released';
            DataClassification = CustomerContent;
        }
        field(53207; "Allow Salesperson Modification"; Boolean)
        {
            Caption = 'Allow Salesperson Modification on BSO/SO';
        }
    }

    keys
    {
        key(Key1; "User ID")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
    end;

    trigger OnInsert()
    var
        User: Record User;
    begin
    end;

    procedure companytransfer(CustomUserSetup_from: Record "Custom User Setup")
    var
        masterconfig: Record "Release to Company Setup";
        CustomUserSetup_to: Record "Custom User Setup";
        Text001: Label 'Custom User Setup %1 transfered to %2 Company';
        Text002: Label 'Custom User Setup %1 modified in %2 Company';
    begin
        masterconfig.reset();
        masterconfig.SetRange(masterconfig."Transfer Customer", true);
        masterconfig.SetFilter(masterconfig."Company Name", '<>%1', CompanyName);
        if masterconfig.FindSet() then
            repeat
                CustomUserSetup_to.ChangeCompany(masterconfig."Company Name");
                CustomUserSetup_to.Reset();
                if not CustomUserSetup_to.Get(CustomUserSetup_from."User ID") then begin
                    CustomUserSetup_to.Init();
                    CustomUserSetup_to := CustomUserSetup_from;
                    if CustomUserSetup_to.Insert() then;
                    Message(Text001, CustomUserSetup_to."User ID", masterconfig."Company Name");
                end
                else begin
                    CustomUserSetup_to.TransferFields(CustomUserSetup_from, false);
                    if CustomUserSetup_to.Modify() then;
                    Message(Text002, CustomUserSetup_to."User ID", masterconfig."Company Name");
                end;
            until masterconfig.Next() = 0;
    end;

    var
        UserSetupManagement: Codeunit "User Setup Management";
}

