table 58001 "Sales Approver User Setup"//T12370-Full  //T12574-N
{
    Caption = 'Sales Approver User Setup';
    DataClassification = ToBeClassified;
    Description = 'T50307';

    fields
    {
        field(1; "Document Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ","Sales Order","Blanket Sales Order","Sales Quote","Sales Return Order";  //T50307-Added Sales Return Order
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                if (Rec."Document Type" <> Rec."Document Type"::" ") AND (Rec.Type <> Rec.Type::" ") then begin
                    if (Rec."Document Type" = Rec."Document Type"::"Blanket Sales Order") AND (Rec.Type = Rec.Type::"Sales Credit Limit") then begin
                        // Rec.TestField("Document Type", Rec."Document Type"::"Sales Order");  ////06012025
                    end;
                end;
            end;
        }
        field(2; "Type"; Option)
        {
            Caption = 'Type';
            DataClassification = ToBeClassified;
            OptionMembers = " ","Sales Credit Limit","Price Limit","Payment Terms","Order Value","Overdue","Price Comparision","Short Close","1st Level","2nd Level","Advance Payment";  //T50307-N -Added Short Close Option

            trigger OnValidate()
            begin
                if (Rec."Document Type" = Rec."Document Type"::"Blanket Sales Order") AND (Rec.Type = Rec.Type::"Sales Credit Limit") then begin
                    // Rec.TestField("Document Type", Rec."Document Type"::"Sales Order");  //06012025
                end;

                if ("Calculation Type" <> "Calculation Type"::" ") AND (Type <> Type::" ") then begin
                    case Type of
                        Type::"Payment Terms", Type::Overdue:
                            TestField("Calculation Type", "Calculation Type"::Days);
                        Type::"Order Value":
                            TestField("Calculation Type", "Calculation Type"::Amount);
                    end;
                end;
            end;
        }
        field(3; "Sequence No."; Integer)
        {
            Caption = 'Sequence';
            DataClassification = ToBeClassified;
        }
        field(4; "From Value"; Decimal)
        {
            Caption = 'From Value';
            DataClassification = ToBeClassified;
        }
        field(5; "To Value"; Decimal)
        {
            Caption = 'To Value';
            DataClassification = ToBeClassified;
        }
        field(6; "Approver Type"; Option)
        {
            Caption = 'Approver Type';
            DataClassification = ToBeClassified;
            OptionMembers = " ","User","Manager","Salesperson";
            trigger OnValidate()
            begin
                if "Approver Type" <> "Approver Type"::User then
                    "User Id" := '';
            end;
        }
        field(7; "User Id"; Text[30])
        {
            Caption = 'User Id';
            DataClassification = ToBeClassified;
            TableRelation = "User Setup"."User ID";
            //ValidateTableRelation = false;
            // trigger OnValidate()
            // var
            //     UserSelection: Codeunit "User Selection";
            // begin
            //     UserSelection.ValidateUserName("User Id");
            // end;
        }
        field(8; "Calculation Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ",Percentage,Amount,Days;
            trigger OnValidate()
            begin
                if ("Calculation Type" <> "Calculation Type"::" ") AND (Type <> Type::" ") then begin
                    case Type of
                        Type::"Payment Terms", Type::Overdue:
                            TestField("Calculation Type", "Calculation Type"::Days);
                        Type::"Order Value":
                            TestField("Calculation Type", "Calculation Type"::Amount);
                    end;
                end;
            end;
        }
        field(9; "Workflow Priority"; Integer)
        {
            DataClassification = ToBeClassified;
            MinValue = 1;
            MaxValue = 100;
            trigger OnValidate()
            var
                SalesWorkflowCod: Codeunit "Sales Approval Events";
            begin
                //SalesWorkflowCod.UpdateWorkflowPriority(Rec, Rec."Workflow Priority");
                //CurrPage.Update(false);
            end;
        }
    }
    keys
    {
        key(PK; "Document Type", "Type", "Calculation Type", "From Value", "To Value", "Sequence No.")
        {
            Clustered = true;
        }
    }
}
