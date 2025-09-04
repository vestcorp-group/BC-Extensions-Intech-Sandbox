PageExtension 75062 Order_Address_75062 extends "Order Address"
{
    //GST_PAN_ERROR_SKIP
    layout
    {
        modify("GST Registration No.")
        {
            Visible = false;
        }

        addafter("GST Registration No.")
        {
            field("GST Registration No. INT"; GSTRegNo_gCod)
            {
                Caption = 'GST Registration No.';
                ApplicationArea = All;

                trigger OnValidate()
                var
                    PANVendErr: Label 'PAN No. must be entered in Vendor.';
                    GSTRegNoErr: Label 'You cannot select GST Reg. No. for selected Vendor Type.';
                begin
                    IF GSTRegNo_gCod <> '' Then begin

                        Rec."GST Registration No." := GSTRegNo_gCod;

                        Rec.TestField(State);
                        Rec.TestField(Address);

                        Vendor.Get(Rec."Vendor No.");
                        if Vendor."P.A.N. No." <> '' then
                            CheckGSTRegistrationNo(Rec.State, Rec."GST Registration No.", Vendor."P.A.N. No.")
                        else
                            if Rec."GST Registration No." <> '' then
                                Error(PANvendErr);

                        if (Rec."GST Registration No." <> '') or (Rec."ARN No." <> '') then
                            if Vendor."GST Vendor Type" in [Vendor."GST Vendor Type"::Unregistered, Vendor."GST Vendor Type"::Import] then
                                Error(GSTRegNoErr);

                        if (not IsImportUnregisteredVendor(Vendor)) and (Rec."ARN No." = '') then
                            Rec.TestField("GST Registration No.");


                        Rec.Modify(TRUE);

                    End Else begin
                        Rec.Validate("GST Registration No.", '');
                        Rec.Modify(TRUE);
                    End;
                end;
            }
        }
    }

    var
        Vendor: Record Vendor;

    trigger OnOpenPage()
    begin
        GSTRegNo_gCod := Rec."GST Registration No.";
    end;

    local procedure IsImportUnregisteredVendor(Vendor: Record Vendor): Boolean
    begin
        if (Vendor."GST Vendor Type" in [Vendor."GST Vendor Type"::Import, Vendor."GST Vendor Type"::Unregistered]) then
            exit(true);
    end;

    procedure CheckGSTRegistrationNo(StateCode: Code[10]; RegistrationNo: Code[20]; PANNo: Code[20])
    var
        State: Record State;
        Position: Integer;
        LengthErr: Label 'The Length of the GST Registration Nos. must be 15.';
        StateCodeErr: Label 'The GST Registration No. for the state %1 should start with %2.', Comment = '%1 = StateCode ; %2 = GST Reg. No';
    begin
        if RegistrationNo = '' then
            exit;

        if StrLen(RegistrationNo) <> 15 then
            Error(LengthErr);

        State.Get(StateCode);
        if State."State Code (GST Reg. No.)" <> CopyStr(RegistrationNo, 1, 2) then
            Error(StateCodeErr, StateCode, State."State Code (GST Reg. No.)");

        //SKIP PAN ERROR
        // if PANNo <> '' then
        //     if PANNo <> CopyStr(RegistrationNo, 3, 10) then
        //         Error(SamePanErr, PANNo);

        for Position := 3 to 15 do
            case Position of
                3 .. 7, 12:
                    CheckIsAlphabet(RegistrationNo, Position);
                8 .. 11:
                    CheckIsNumeric(RegistrationNo, Position);
                13:
                    CheckIsAlphaNumeric(RegistrationNo, Position);
                15:
                    CheckIsAlphaNumeric(RegistrationNo, Position)
            end;
    end;


    local procedure CheckIsAlphabet(RegistrationNo: Code[20]; Position: Integer)
    var
        OnlyAlphabetErr: Label 'Only Alphabet is allowed in the position %1.', Comment = '%1 = Position';
    begin
        if not (CopyStr(RegistrationNo, Position, 1) in ['A' .. 'Z']) then
            Error(OnlyAlphabetErr, Position);
    end;

    local procedure CheckIsNumeric(RegistrationNo: Code[20]; Position: Integer)
    var
        OnlyNumericErr: Label 'Only Numeric is allowed in the position %1.', Comment = '%1 = Position';
    begin
        if not (CopyStr(RegistrationNo, Position, 1) in ['0' .. '9']) then
            Error(OnlyNumericErr, Position);
    end;

    local procedure CheckIsAlphaNumeric(RegistrationNo: Code[20]; Position: Integer)
    var
        OnlyAlphaNumericErr: Label 'Only AlphaNumeric is allowed in the position %1.', Comment = '%1 = Position';
    begin
        if not ((CopyStr(RegistrationNo, Position, 1) in ['0' .. '9']) or (CopyStr(RegistrationNo, Position, 1) in ['A' .. 'Z'])) then
            Error(OnlyAlphaNumericErr, Position);
    end;

    var
        GSTRegNo_gCod: Code[20];

}

