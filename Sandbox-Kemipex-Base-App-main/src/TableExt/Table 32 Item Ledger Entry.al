tableextension 50110 "KMP_TblItemLedgerEntry" extends "Item Ledger Entry"
{
    fields
    {
        // Add changes to table fields here
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
            DataClassification = CustomerContent;
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
        field(50112; "Production Warehouse"; Boolean)
        {
            FieldClass = FlowField;
            CalcFormula = lookup(Location."Production Warehouse" where(Code = field("Location Code")));
        }

        field(50600; "Profit % IC"; Decimal)
        {
            Caption = 'Profit %';
        }
    }
}