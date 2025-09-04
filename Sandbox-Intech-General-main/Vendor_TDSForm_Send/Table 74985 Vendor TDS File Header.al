Table 74985 "Vendor TDS File Header"
{
    //VendorTDSFormEmail
    Caption = 'Vendor TDS File Header';
    DataClassification = ToBeClassified;
    Description = 'T36936';

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = ToBeClassified;
        }
        field(2; Description; Text[100])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    var
        myInt: Integer;
    begin
        if Rec."No." = '' then
            SetNewNumber();
    end;

    procedure AssistEdit(OldVendorTdsFiles_lRec: Record "Vendor TDS File Header") Result: Boolean
    var
    begin
        exit(SetNewNumber());
    end;

    procedure SetNewNumber() Result: Boolean
    var
        myInt: Integer;
    begin
        Purchases_PayableSetup_lRec.Reset();
        Purchases_PayableSetup_lRec.GET();
        Purchases_PayableSetup_lRec.TestField("Vendor TDS Files No. Series");
        NoseriesCOde := Purchases_PayableSetup_lRec."Vendor TDS Files No. Series";

        if NoSeriesMgt.SelectSeries(Purchases_PayableSetup_lRec."Vendor TDS Files No. Series", '', NoseriesCOde) then begin

            NoSeriesMgt.SetSeries("No.");
            if VednorTDSFiles_lRec.Get("No.") then
                Error(Text051, "No.");
            exit(true);
        end;
    end;

    Var
        Text051: Label 'The record %1 already exists.';
        VednorTDSFiles_lRec: Record "Vendor TDS Files Lines";
        IsHandled: Boolean;
        NoSeriesMgt: Codeunit NoSeriesManagement;
        Purchases_PayableSetup_lRec: Record "Purchases & Payables Setup";
        NoseriesCOde: code[20];

}
