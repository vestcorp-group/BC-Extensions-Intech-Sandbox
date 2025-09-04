pageextension 64104 PostedSalesCrediInv extends "Posted Sales Credit Memo"//T12370-N //T12574-MIG USING ISPL E-Invoice Ext.
{
    layout
    {
        /* addlast(General)
        {
            field("Transport Doc No."; Rec."Transport Doc No.")
            {
                ApplicationArea = All;
                Enabled = false;
            }
            field("Transport Doc Date"; Rec."Transport Doc Date")
            {
                ApplicationArea = All;
                Enabled = false;
            }
            field("Transporter ID"; Rec."Transporter ID")
            {
                ApplicationArea = All;
            }
            field("Transporter Name"; Rec."Transporter Name")
            {
                ApplicationArea = All;
            }
        }
        addlast(content)
        {
            group("E-Invoicing_")
            {
                Caption = 'E-Invoicing';
                field("E-Invoice API Status"; Rec."E-Invoice API Status")
                {
                    ToolTip = 'Specifies the value of the E-Invoice API Status field.';
                    ApplicationArea = All;
                    Enabled = false;
                }
                field("E-Invoice API Response"; Rec."E-Invoice API Response")
                {
                    ApplicationArea = All;
                    Enabled = false;
                }
                field("E-Invoice Message"; Rec."E-Invoice Message")
                {
                    ToolTip = 'Specifies the value of the E-Invoice Message field.';
                    ApplicationArea = All;
                    Enabled = false;
                }
                field("E-Invoice No."; Rec."E-Invoice No.")
                {
                    ToolTip = 'Specifies the value of the E-Invoice No. field.';
                    ApplicationArea = All;
                    Enabled = false;
                }
                field("E-Invoice Id"; Rec."E-Invoice Id")
                {
                    ToolTip = 'Specifies the value of the E-Invoice Id field.';
                    ApplicationArea = All;
                    Enabled = false;
                }
                field("E-Invoice IRN"; Rec."E-Invoice IRN")
                {
                    ToolTip = 'Specifies the value of the E-Invoice IRN field.';
                    ApplicationArea = All;
                    Enabled = false;
                }
                field("E-Invoice GenBy"; Rec."E-Invoice GenBy")
                {
                    ToolTip = 'Specifies the value of the E-Invoice GenBy field.';
                    ApplicationArea = All;
                    Enabled = false;
                }
                field("E-Invoice GenBy Name"; Rec."E-Invoice GenBy Name") 
                {
                    ToolTip = 'Specifies the value of the E-Invoice GenBy Name field.';
                    ApplicationArea = All;
                    Enabled = false;
                }
                field("E-Invoice Status"; Rec."E-Invoice Status")
                {
                    ToolTip = 'Specifies the value of the E-Invoice Status field.';
                    ApplicationArea = All;
                    Enabled = false;
                }
                field("E-Invoice ACK No."; Rec."E-Invoice ACK No.")
                {
                    ToolTip = 'Specifies the value of the E-Invoice ACK No. field.';
                    ApplicationArea = All;
                    Enabled = false;
                }
                field("E-Invoice EWB No."; Rec."E-Invoice EWB No.")
                {
                    ToolTip = 'Specifies the value of the E-Invoice EWB No. field.';
                    ApplicationArea = All;
                    Enabled = false;
                }
                field("E-Invoice Ack Date"; Rec."E-Invoice Ack Date")
                {
                    ToolTip = 'Specifies the value of the E-Invoice Ack Date field.';
                    ApplicationArea = All;
                    Enabled = false;
                }
                field("E-Invoice EWB Date"; Rec."E-Invoice EWB Date")
                {
                    ToolTip = 'Specifies the value of the E-Invoice EWB Date field.';
                    ApplicationArea = All;
                    Enabled = false;
                }
                field("E-Invoice EWB Valid Till"; Rec."E-Invoice EWB Valid Till")
                {
                    ToolTip = 'Specifies the value of the E-Invoice EWB Valid Till field.';
                    ApplicationArea = All;
                    Enabled = false;
                }
                field("E-Invoice QR Code"; Rec."E-Invoice QR Code")
                {
                    ApplicationArea = All;
                    Enabled = false;
                }
                field("E-Invoice Signed Invoice"; Rec."E-Invoice Signed Invoice")
                {
                    ApplicationArea = All;
                    Enabled = false;
                }
                field("E-Invoice signedQrCode"; Rec."E-Invoice signedQrCode")
                {
                    ApplicationArea = All;
                    Enabled = false;
                    Caption = 'Signed QR Code';
                }
                field("E-Invoice Generated At"; Rec."E-Invoice Generated At")
                {
                    ApplicationArea = All;
                    Enabled = false;
                    Visible = false;
                }
                field("Cancel EWB Date"; Rec."Cancel EWB Date")
                {
                    ApplicationArea = All;
                    Enabled = false;
                }
                field("Cancel EWB No."; Rec."Cancel EWB No.")
                {
                    ApplicationArea = All;
                    Enabled = false;
                }
                field("Cancel IRN"; Rec."Cancel IRN")
                {
                    ApplicationArea = All;
                    Enabled = false;
                }
            }
        } */

        /* addlast("Tax Info")
        {
            field("Transaction Mode"; Rec."Transaction Mode")
            {
                ApplicationArea = All;
            }
            field("Dispatch From GSTIN"; Rec."Dispatch From GSTIN")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Dispatch From GSTIN field.';
            }
            field("Dispatch From Trade Name"; Rec."Dispatch From Trade Name")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Dispatch From Trade Name field.';
            }
            field("Dispatch From Legal Name"; Rec."Dispatch From Legal Name")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Dispatch From Legal Name field.';
            }
            field("Dispatch From Address 1"; Rec."Dispatch From Address 1")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Dispatch From Address 1 field.';
            }
            field("Dispatch From Address 2"; Rec."Dispatch From Address 2")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Dispatch From Address 2 field.';
            }
            field("Dispatch From Location"; Rec."Dispatch From Location")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Dispatch From Location field.';
            }
            field("Dispatch From State Code"; Rec."Dispatch From State Code")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Dispatch From State Code field.';
            }
            field("Dispatch From Pincode"; Rec."Dispatch From Pincode")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Dispatch From Pincode field.';
            }
        } */
    }

    actions
    {
        /* addafter("&Cr. Memo")
        {
            group("E-Invoicing")
            {
                action("Cancel E-Invoice")
                {
                    ApplicationArea = All;
                    Image = PostSendTo;
                    Promoted = true;
                    PromotedOnly = true;
                    trigger OnAction()
                    var
                        Dt: Date;
                        TM: Time;
                    begin
                        Rec.TestField("E-Invoice Ack Date");
                        Dt := DT2Date(Rec."E-Invoice Ack Date");
                        TM := DT2Time(Rec."E-Invoice Ack Date");

                        Rec.TestField("E-Invoice IRN");
                        Rec.TestField("E-Invoice EWB No.");
                        if (CurrentDateTime < CreateDateTime(CalcDate('1D', Dt), TM)) then begin
                            if Rec."E-Way Bill No." <> '' then
                                Codeunit.Run(Codeunit::"Cancel EWB", Rec);
                            if Rec."IRN Hash" <> '' then
                                Codeunit.Run(Codeunit::"Cancel IRN", Rec);
                            if (Rec."IRN Hash" = '') AND (Rec."E-Way Bill No." = '') then
                                Error('IRN or EWB No. must have a value');
                            Message('E-Invoice has been cancelled successfully.');


                        end
                        else begin
                            Codeunit.Run(Codeunit::"Cancel EWB And IRN", Rec);
                        end;
                    end;
                }
            }
        } */

        addafter(Print)
        {
            group(Report)
            {
                action("Tax Invoice Report")
                {
                    ApplicationArea = all;
                    Promoted = true;
                    trigger OnAction()
                    var
                        SalesInvHeader: Record "Sales Cr.Memo Header";
                    begin


                        SalesInvHeader.Reset();
                        SalesInvHeader.SetRange("No.", Rec."No.");

                        if SalesInvHeader.FindFirst() then
                            Report.RunModal(54786, true, false, SalesInvHeader);
                    end;



                }
            }
        }

        /* addlast("&Cr. Memo")
        {
            action("Download EWB JSON")
            {
                ApplicationArea = All;
                Image = Download;
                trigger OnAction()
                var
                    GenEInv: Codeunit "Cancel EWB";
                    Jsntext: Text;
                    Instr: InStream;
                    OutStr: OutStream;
                    TempBlob: Codeunit "Temp Blob";
                    FileName: Text;
                begin
                    Jsntext := GenEInv.CreateJSONForIRIS(Rec, false);
                    Clear(TempBlob);
                    TempBlob.CreateOutStream(OutStr);
                    OutStr.WriteText(Jsntext);
                    TempBlob.CreateInStream(Instr);
                    FileName := DelChr(Rec."No." + '_' + FORMAT(CurrentDateTime), '=', ' \/-:AMPM') + '.json';
                    DownloadFromStream(Instr, '', '', '', FileName);
                end;
            }

            action("Download IRN JSON")
            {
                ApplicationArea = All;
                Image = Download;
                trigger OnAction()
                var
                    GenEInv: Codeunit "Cancel IRN";
                    Jsntext: Text;
                    Instr: InStream;
                    OutStr: OutStream;
                    TempBlob: Codeunit "Temp Blob";
                    FileName: Text;
                begin
                    Jsntext := GenEInv.CreateJSONForIRIS(Rec, false);
                    Clear(TempBlob);
                    TempBlob.CreateOutStream(OutStr);
                    OutStr.WriteText(Jsntext);
                    TempBlob.CreateInStream(Instr);
                    FileName := DelChr(Rec."No." + '_' + FORMAT(CurrentDateTime), '=', ' \/-:AMPM') + '.json';
                    DownloadFromStream(Instr, '', '', '', FileName);
                end;
            }

            action("Download E-Invoice JSON")
            {
                ApplicationArea = All;
                Image = Download;
                trigger OnAction()
                var
                    GenEInv: Codeunit "Cancel EWB And IRN";
                    Jsntext: Text;
                    Instr: InStream;
                    OutStr: OutStream;
                    TempBlob: Codeunit "Temp Blob";
                    FileName: Text;
                begin
                    Jsntext := GenEInv.CreateJSONForIRIS(Rec, false);
                    Clear(TempBlob);
                    TempBlob.CreateOutStream(OutStr);
                    OutStr.WriteText(Jsntext);
                    TempBlob.CreateInStream(Instr);
                    FileName := DelChr(Rec."No." + '_' + FORMAT(CurrentDateTime), '=', ' \/-:AMPM') + '.json';
                    DownloadFromStream(Instr, '', '', '', FileName);
                end;
            }
        } */
    }


    var
        myInt: Integer;
}