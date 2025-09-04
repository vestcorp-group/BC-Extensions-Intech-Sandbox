tableextension 50312 KMP_TabExtEntrySummary extends "Entry Summary"
{
    fields
    {
        field(50100; CustomBOENumber; Text[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Custom BOE No.';
        }
        field(50102; CustomLotNumber; Code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Lot No.';
        }
        field(50103; "New BOE No."; Text[20])
        {
            DataClassification = CustomerContent;
            Caption = 'New BOE No.';
        }
        field(50115; "Posting Date"; date)
        {
            DataClassification = SystemMetadata;
            Caption = 'Posting Date';
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
        field(50101; "Supplier Batch No. 2"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50106; "Manufacturing Date 2"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50107; "Expiry Period 2"; DateFormula)
        {
            DataClassification = ToBeClassified;
        }
        field(50108; "Gross Weight 2"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50109; "Net Weight 2"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        
    }
}