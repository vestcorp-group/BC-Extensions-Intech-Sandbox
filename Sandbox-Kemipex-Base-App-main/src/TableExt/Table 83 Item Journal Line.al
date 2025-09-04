tableextension 50113 KMP_TblExtItemJournalLine extends "Item Journal Line"
{
    fields
    {
        field(50100; CustomBOENumber; Text[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Custom BOE No.';
        }
        field(50101; CustomBOENumber2; Text[250])
        {
            DataClassification = ToBeClassified;
            Caption = 'Custom BOE No. 2';
        }
        field(50102; CustomLotNumber; Code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Lot No.';
        }
        field(50103; BillOfExit; Text[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Bill Of Exit';
        }
        field(50104; "Of Spec"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Off-Spec';
            Description = 'Created for COA Process';
        }
        field(50105; "Analysis Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Analysis Date';
            Description = 'Created for COA Process';
        }

        //Moved from PDCnOthers Extension
        field(50107; "Supplier Batch No. 2"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50108; "Manufacturing Date 2"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50109; "Expiry Period 2"; DateFormula)
        {
            DataClassification = ToBeClassified;
        }
        field(50110; "Gross Weight 2"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50111; "Net Weight 2"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        //Merged from Inventory Counting Module developed by SA Global Singapore
        field(50150; "Lot No. KMP"; Code[50])
        {
            Caption = 'Lot No. KMP';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                if (StrPos("Lot No. KMP", '@') > 0) then begin
                    CustomLotNumber := CopyStr("Lot No. KMP", 1, StrPos("Lot No. KMP", '@') - 1);
                    CustomBOENumber := CopyStr("Lot No. KMP", StrPos("Lot No. KMP", '@') + 1, MaxStrLen(CustomBOENumber));
                end else
                    CustomLotNumber := "Lot No. KMP";
            end;
        }
        field(50151; "FromCountingSheet"; Boolean)
        {
            Caption = 'System use. From Counting Sheet';
            DataClassification = ToBeClassified;
        }
        field(50152; "Expiration Period"; DateFormula) { }

        field(50600; "Profit % IC"; Decimal)
        {
            Caption = 'Profit % (IC)';
        }
    }
}