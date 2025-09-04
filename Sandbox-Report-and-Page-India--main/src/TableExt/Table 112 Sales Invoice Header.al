tableextension 50124 "ExtSalesInvHeader" extends "Sales Invoice Header"//T12370-N //T12574-MIG USING ISPL E-Invoice Ext.
{
    fields
    {

        field(50588; "Billing"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50589; "Shipping"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        //         //E-Invoicing
        //         field(60010; "E-Invoice API Status"; Option)
        //         {
        //             Caption = 'E-Invoice API Status';
        //             DataClassification = ToBeClassified;
        //             OptionMembers = " ","Success","Failed","Cancelled";
        //         }
        //         field(60011; "E-Invoice Message"; Text[250])
        //         {
        //             Caption = 'E-Invoice Message';
        //             DataClassification = ToBeClassified;
        //         }
        //         field(60012; "E-Invoice No."; Text[80])
        //         {
        //             Caption = 'E-Invoice No.';
        //             DataClassification = ToBeClassified;
        //         }
        //         field(60013; "E-Invoice Id"; Text[80])
        //         {
        //             Caption = 'E-Invoice Id';
        //             DataClassification = ToBeClassified;
        //         }
        //         field(60014; "E-Invoice GenBy"; Text[100])
        //         {
        //             Caption = 'E-Invoice GenBy';
        //             DataClassification = ToBeClassified;
        //         }
        //         field(60015; "E-Invoice GenBy Name"; Text[100])
        //         {
        //             Caption = 'E-Invoice GenBy Name';
        //             DataClassification = ToBeClassified;
        //         }

        //          field(60016; "E-Invoice Status"; Code[20])
        //         {
        //             Caption = 'E-Invoice Status';
        //             DataClassification = ToBeClassified;
        //         }
        //         field(60017; "E-Invoice ACK No."; Text[100])
        //         {
        //             Caption = 'E-Invoice ACK No.';
        //             DataClassification = ToBeClassified;
        //         }
        //         field(60018; "E-Invoice Ack Date"; DateTime)
        //         {
        //             Caption = 'E-Invoice Ack Date';
        //             DataClassification = ToBeClassified;
        //         }
        //         field(60019; "E-Invoice IRN"; Text[250])
        //         {
        //             Caption = 'E-Invoice IRN';
        //             DataClassification = ToBeClassified;
        //         }
        //         field(60020; "E-Invoice EWB No."; Text[80])
        //         {
        //             Caption = 'E-Invoice EWB No.';
        //             DataClassification = ToBeClassified;
        //         }
        //         field(60021; "E-Invoice EWB Date"; DateTime)
        //         {
        //             Caption = 'E-Invoice EWB Date';
        //             DataClassification = ToBeClassified;
        //         }
        //         field(60022; "E-Invoice EWB Valid Till"; DateTime)
        //         {
        //             Caption = 'E-Invoice EWB Valid Till';
        //             DataClassification = ToBeClassified;
        //         }
                field(60023; "E-Invoice QR Code"; Blob)
                {
                    DataClassification = ToBeClassified;
                    Subtype = Bitmap;
                }

        //         field(60024; "E-Invoice Signed Invoice"; Blob)
        //         {
        //             DataClassification = ToBeClassified;
        //             Subtype = Bitmap;
        //         }
        //         field(60025; "E-Invoice signedQrCode"; Blob)
        //         {
        //             DataClassification = ToBeClassified;
        //             Subtype = Bitmap;
        //         }
        //         field(60026; "E-Invoice Generated At"; DateTime)
        //         {
        //             DataClassification = ToBeClassified;
        //         }
        //         field(60027; "E-Invoice API Response"; Text[500])
        //         {
        //             DataClassification = ToBeClassified;
        //         }
        //         field(60028; "Transport Doc No."; Code[15])
        //         {
        //             DataClassification = ToBeClassified;
        //             trigger OnValidate()
        //             var
        //                 Vehicleformat: Label '^([a-zA-Z0-9\/-]{1,15})$';
        //                 CheckvehicleNumber: Codeunit Regex;
        //             begin
        //                 if Rec."Transport Doc No." <> '' then begin
        //                     if not CheckvehicleNumber.IsMatch(Rec."Transport Doc No.", Vehicleformat, 0) then
        //                         Error('Transport Doc No. is not valid. It must be in %1 format.', 'TA120');
        //                 end
        //             end;
        //         }
        //         field(60029; "Transport Doc Date"; Date)
        //         {
        //             DataClassification = ToBeClassified;
        //         }
        //         //07-07-2022-start
        //         field(60030; "Transporter ID"; Text[15])
        //         {
        //             DataClassification = ToBeClassified;
        //         }
        //         field(60031; "Transporter Name"; Text[100])
        //         {
        //             DataClassification = ToBeClassified;
        //             trigger OnValidate()
        //             begin
        //                 if Rec."Transporter Name" <> '' then begin
        //                     if StrLen("Transporter Name") < 3 then
        //                         Error('Transporter Name must have atleast 3 characters');
        //                 end
        //             end;
        //         }
        //         field(60040; "Transaction Mode"; Option)
        //         {
        //             DataClassification = ToBeClassified;
        //             OptionMembers = REG,SHP,DIS,CMB;
        //         }
        //         field(60041; "Dispatch From GSTIN"; Code[20])
        //         {
        //             DataClassification = ToBeClassified;
        //         }
        //         field(60042; "Dispatch From Trade Name"; Text[100])
        //         {
        //             DataClassification = ToBeClassified;
        //         }
        //         field(60043; "Dispatch From Legal Name"; Text[100])
        //         {
        //             DataClassification = ToBeClassified;
        //         }
        //         field(60044; "Dispatch From Address 1"; Text[100])
        //         {
        //             DataClassification = ToBeClassified;
        //         }
        //         field(60045; "Dispatch From Address 2"; Text[100])
        //         {
        //             DataClassification = ToBeClassified;
        //         }
        //         field(60046; "Dispatch From Location"; Text[50])
        //         {
        //             DataClassification = ToBeClassified;
        //         }
        //         field(60047; "Dispatch From State Code"; code[20])
        //         {
        //             DataClassification = ToBeClassified;
        //         }
        //         field(60048; "Dispatch From Pincode"; Code[10])
        //         {
        //             DataClassification = ToBeClassified;
        //         }
        //         //07-07-2022-end
        //         modify("Vehicle No.")
        //         {
        //             trigger OnAfterValidate()
        //             var
        //                 //Vehicleformat: Label '^[A-Z]{2}[0-9]{2}[A-Z]{2}[0-9]{4}$';
        //                 Vehicleformat: Label '^[A-Z]{2}[0-9]{2}$';
        //                 CheckvehicleNumber: Codeunit Regex;
        //             begin
        //                 // if Rec."Vehicle No." <> '' then begin
        //                 //     if not CheckvehicleNumber.IsMatch(CopyStr(Rec."Vehicle No.", 1, 4), Vehicleformat, 0) then
        //                 //         Error('Vehicle No. is not valid. It must be in %1 format.', 'KA12KA1234');
        //                 // end
        //             end;
        //         }

    }

    //     var
    //         myInt: Integer;
}