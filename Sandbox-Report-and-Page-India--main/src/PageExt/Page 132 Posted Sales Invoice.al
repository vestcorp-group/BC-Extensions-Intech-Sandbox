pageextension 64100 PostedSalesInv extends "Posted Sales Invoice"//T12370-N , 07082024 //T12574-MIG USING ISPL E-Invoice Ext.
{
    layout
    {
        addlast(General)
        {

            //     field("Transport Doc No."; Rec."Transport Doc No.")
            //     {
            //         ApplicationArea = All;
            //         Enabled = false;
            //     }
            //     field("Transport Doc Date"; Rec."Transport Doc Date")
            //     {
            //         ApplicationArea = All;
            //         Enabled = false;
            //     }
            //     field("Transporter ID"; Rec."Transporter ID")
            //     {
            //         ApplicationArea = All;
            //     }
            //     field("Transporter Name"; Rec."Transporter Name")
            //     {
            //         ApplicationArea = All;
            //     }

            // 24-12-24 AS-NS
            field(Shipping; Rec.Shipping)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Shipping field.', Comment = '%';
            }

            // 24-12-24 AS-NE
        }
        addlast(content)
        {
            //     group("E-Invoicing_")
            //     {
            //         Caption = 'E-Invoicing';
            //         field("E-Invoice API Status"; Rec."E-Invoice API Status")
            //         {
            //             ToolTip = 'Specifies the value of the E-Invoice API Status field.';
            //             ApplicationArea = All;
            //             Enabled = false;
            //         }
            //         field("E-Invoice API Response"; Rec."E-Invoice API Response")
            //         {
            //             ApplicationArea = All;
            //             Enabled = false;
            //         }
            //         field("E-Invoice Message"; Rec."E-Invoice Message")
            //         {
            //             ToolTip = 'Specifies the value of the E-Invoice Message field.';
            //             ApplicationArea = All;
            //             Enabled = false;
            //         }
            //         field("E-Invoice No."; Rec."E-Invoice No.")
            //         {
            //             ToolTip = 'Specifies the value of the E-Invoice No. field.';
            //             ApplicationArea = All;
            //             Enabled = false;
            //         }
            //         field("E-Invoice Id"; Rec."E-Invoice Id")
            //         {
            //             ToolTip = 'Specifies the value of the E-Invoice Id field.';
            //             ApplicationArea = All;
            //             Enabled = false;
            //         }
            //         field("E-Invoice IRN"; Rec."E-Invoice IRN")
            //         {
            //             ToolTip = 'Specifies the value of the E-Invoice IRN field.';
            //             ApplicationArea = All;
            //             Enabled = false;
            //         }
            //         field("E-Invoice GenBy"; Rec."E-Invoice GenBy")
            //         {
            //             ToolTip = 'Specifies the value of the E-Invoice GenBy field.';
            //             ApplicationArea = All;
            //             Enabled = false;
            //         }
            //         field("E-Invoice GenBy Name"; Rec."E-Invoice GenBy Name")
            //         {
            //             ToolTip = 'Specifies the value of the E-Invoice GenBy Name field.';
            //             ApplicationArea = All;
            //             Enabled = false;
            //         }
            //          field("E-Invoice Status"; Rec."E-Invoice Status")
            //         {
            //             ToolTip = 'Specifies the value of the E-Invoice Status field.';
            //             ApplicationArea = All;
            //             Enabled = false;
            //         }
            //         field("E-Invoice ACK No."; Rec."E-Invoice ACK No.")
            //         {
            //             ToolTip = 'Specifies the value of the E-Invoice ACK No. field.';
            //             ApplicationArea = All;
            //             Enabled = false;
            //         }
            //         field("E-Invoice EWB No."; Rec."E-Invoice EWB No.")
            //         {
            //             ToolTip = 'Specifies the value of the E-Invoice EWB No. field.';
            //             ApplicationArea = All;
            //             Enabled = false;
            //         }
            //         field("E-Invoice Ack Date"; Rec."E-Invoice Ack Date")
            //         {
            //             ToolTip = 'Specifies the value of the E-Invoice Ack Date field.';
            //             ApplicationArea = All;
            //             Enabled = false;
            //         }
            //         field("E-Invoice EWB Date"; Rec."E-Invoice EWB Date")
            //         {
            //             ToolTip = 'Specifies the value of the E-Invoice EWB Date field.';
            //             ApplicationArea = All;
            //             Enabled = false;
            //         }
            //         field("E-Invoice EWB Valid Till"; Rec."E-Invoice EWB Valid Till")
            //         {
            //             ToolTip = 'Specifies the value of the E-Invoice EWB Valid Till field.';
            //             ApplicationArea = All;
            //             Enabled = false;
            //         }
            field("E-Invoice QR Code"; Rec."E-Invoice QR Code")
            {
                ApplicationArea = All;
                Enabled = false;
            }
            //         field("E-Invoice Signed Invoice"; Rec."E-Invoice Signed Invoice")
            //         {
            //             ApplicationArea = All;
            //             Enabled = false;
            //         }
            //         field("E-Invoice signedQrCode"; Rec."E-Invoice signedQrCode")
            //         {
            //             ApplicationArea = All;
            //             Enabled = false;
            //             Caption = 'Signed QR Code';
            //         }
            //         field("E-Invoice Generated At"; Rec."E-Invoice Generated At")
            //         {
            //             ApplicationArea = All;
            //             Enabled = false;
            //             Visible = false;
            //         }
            //     }
        }
        // addlast("Tax Info")
        // {
        //     field("Transaction Mode"; Rec."Transaction Mode")
        //     {
        //         ApplicationArea = All;
        //     }
        //     field("Dispatch From GSTIN"; Rec."Dispatch From GSTIN")
        //     {
        //         ApplicationArea = All;
        //         ToolTip = 'Specifies the value of the Dispatch From GSTIN field.';
        //     }
        //     field("Dispatch From Trade Name"; Rec."Dispatch From Trade Name")
        //     {
        //         ApplicationArea = All;
        //         ToolTip = 'Specifies the value of the Dispatch From Trade Name field.';
        //     }
        //     field("Dispatch From Legal Name"; Rec."Dispatch From Legal Name")
        //     {
        //         ApplicationArea = All;
        //         ToolTip = 'Specifies the value of the Dispatch From Legal Name field.';
        //     }
        //     field("Dispatch From Address 1"; Rec."Dispatch From Address 1")
        //     {
        //         ApplicationArea = All;
        //         ToolTip = 'Specifies the value of the Dispatch From Address 1 field.';
        //     }
        //     field("Dispatch From Address 2"; Rec."Dispatch From Address 2")
        //     {
        //         ApplicationArea = All;
        //         ToolTip = 'Specifies the value of the Dispatch From Address 2 field.';
        //     }
        //     field("Dispatch From Location"; Rec."Dispatch From Location")
        //     {
        //         ApplicationArea = All;
        //         ToolTip = 'Specifies the value of the Dispatch From Location field.';
        //     }
        //     field("Dispatch From State Code"; Rec."Dispatch From State Code")
        //     {
        //         ApplicationArea = All;
        //         ToolTip = 'Specifies the value of the Dispatch From State Code field.';
        //     }
        //     field("Dispatch From Pincode"; Rec."Dispatch From Pincode")
        //     {
        //         ApplicationArea = All;
        //         ToolTip = 'Specifies the value of the Dispatch From Pincode field.';
        //     }
        // }
    }
    actions
    {
        //     addafter("&Invoice")
        //     {
        //         group("E-Invoicing")
        //         {
        //             action("Send E-Invoice")
        //             {
        //                 ApplicationArea = All;
        //                 Image = PostSendTo;
        //                 Promoted = true;
        //                 PromotedOnly = true;
        //                 Caption = 'Generate IRN/EWB';
        //                 trigger OnAction()
        //                 begin
        //                     if (Rec."IRN Hash" = '') OR (Rec."E-Invoice EWB No." = '') then
        //                         Codeunit.Run(Codeunit::"Generate E-Invoice", Rec)
        //                     else begin
        //                         Rec.TestField("IRN Hash", '');
        //                         Rec.TestField("E-Invoice EWB No.", '');
        //                     end;
        //                 end;
        //             }
        //             action("Generate EWB")
        //             {
        //                 ApplicationArea = All;
        //                 Image = PostSendTo;
        //                 Promoted = true;
        //                 PromotedOnly = true;
        //                 trigger OnAction()
        //                 begin
        //                     if (Rec."E-Invoice EWB No." = '') then
        //                         Codeunit.Run(Codeunit::"Generate EWB", Rec)
        //                     else begin
        //                         Rec.TestField("E-Invoice EWB No.", '');
        //                     end;
        //                 end;
        //             }
        //             action("Download E-Invoice")
        //             {
        //                 ApplicationArea = All;
        //                 Image = Download;
        //                 Promoted = true;
        //                 PromotedOnly = true;
        //                 trigger OnAction()
        //                 var
        //                     DownloadInvoice: Codeunit "GET Iris Invoice";
        //                     EInvoiceSetup: Record "E-Invoicing API Setup";
        //                     GenerateInvoice: Codeunit "Generate E-Invoice";
        //                     GenerateToken: Codeunit "Iris Web service";
        //                     Token: Text;
        //                     LoginJson: Label '{"email":"%1","password":"%2"}';
        //                     IsSuccess: Boolean;
        //                     ResponseText: Text;
        //                     CompanyId: Text;
        //                     Instr: InStream;
        //                     Filename: Text;
        //                 begin
        //                     Rec.TestField("E-Invoice Id");
        //                     EInvoiceSetup.GET;
        //                     EInvoiceSetup.TestField("Download Invoice URL");
        //                     Clear(Token);
        //                     GenerateToken.SetWebseriveProperties(EInvoiceSetup."Base URL" + EInvoiceSetup."Login URL", StrSubstNo(LoginJson, EInvoiceSetup."User Id", EInvoiceSetup.Password), true, '', '', false);
        //                     GenerateToken.Run();
        //                     GenerateToken.GetResponse(IsSuccess, ResponseText);
        //                     if IsSuccess then
        //                         Token := GenerateInvoice.GetAPITokenFromResponse(ResponseText, CompanyId)
        //                     else
        //                         Error(ResponseText);

        //                     Clear(ResponseText);
        //                     Clear(DownloadInvoice);
        //                     DownloadInvoice.SetWebseriveProperties(EInvoiceSetup."Base URL" + EInvoiceSetup."Download Invoice URL" + '?template=STANDARD&id=' + Rec."E-Invoice Id", false, Token, CompanyId);
        //                     DownloadInvoice.Run();
        //                     DownloadInvoice.GetResponse(IsSuccess, ResponseText);
        //                     if IsSuccess then begin
        //                         Instr := DownloadInvoice.GetResStream()
        //                     end else
        //                         Error(ResponseText);

        //                     Filename := DelChr(Rec."No.", '=', ',.-/\:') + '_E_Invoice.pdf';
        //                     DownloadFromStream(instr, '', '', '', Filename)
        //                 end;
        //             }

        //             action("Update Invoice")
        //             {
        //                 ApplicationArea = All;
        //                 Image = UpdateDescription;
        //                 Promoted = true;
        //                 PromotedOnly = true;
        //                 trigger OnAction()
        //                 var
        //                     RecHdr: Record "Sales Invoice Header";
        //                     UpdateInvoice: Page "Update Sales Invoice";
        //                 begin
        //                     Clear(RecHdr);
        //                     RecHdr.SetRange("No.", Rec."No.");
        //                     RecHdr.FindFirst();
        //                     Clear(UpdateInvoice);
        //                     UpdateInvoice.SetTableView(RecHdr);
        //                     if (Rec."IRN Hash" <> '') AND (Rec."E-Invoice EWB No." <> '') then
        //                         UpdateInvoice.Editable := false;
        //                     UpdateInvoice.RunModal();
        //                 end;
        //             }


        //             action("Test QR Code Report")
        //             {
        //                 ApplicationArea = All;
        //                 Image = BarCode;
        //                 Visible = false;
        //                 trigger OnAction()
        //                 var
        //                     testqr: Report TestQRCode;
        //                     SHdr: Record "Sales Invoice Header";
        //                 begin
        //                     Clear(SHdr);
        //                     SHdr.SetRange("No.", Rec."No.");
        //                     if SHdr.FindFirst() then;
        //                     Clear(testqr);
        //                     testqr.SetTableView(SHdr);
        //                     testqr.Run();
        //                 end;
        //             }
        //         }
        //     }

        //     addlast("&Invoice")
        //     {
        //         action("Download E-Invoice JSON")
        //         {
        //             ApplicationArea = All;
        //             Image = Download;
        //             trigger OnAction()
        //             var
        //                 GenEInv: Codeunit "Generate E-Invoice";
        //                 Jsntext: Text;
        //                 Instr: InStream;
        //                 OutStr: OutStream;
        //                 TempBlob: Codeunit "Temp Blob";
        //                 FileName: Text;
        //             begin
        //                 Jsntext := GenEInv.CreateJSONForIRIS(Rec, false);
        //                 Clear(TempBlob);
        //                 TempBlob.CreateOutStream(OutStr);
        //                 OutStr.WriteText(Jsntext);
        //                 TempBlob.CreateInStream(Instr);
        //                 FileName := DelChr(Rec."No." + '_' + FORMAT(CurrentDateTime), '=', ' \/-:AMPM') + '.json';
        //                 DownloadFromStream(Instr, '', '', '', FileName);
        //             end;
        //         }
        //         action("Download EWB JSON")
        //         {
        //             ApplicationArea = All;
        //             Image = Download;
        //             trigger OnAction()
        //             var
        //                 GenEInv: Codeunit "Generate EWB";
        //                 Jsntext: Text;
        //                 Instr: InStream;
        //                 OutStr: OutStream;
        //                 TempBlob: Codeunit "Temp Blob";
        //                 FileName: Text;
        //             begin
        //                 Jsntext := GenEInv.CreateJSONForIRIS(Rec, false);
        //                 Clear(TempBlob);
        //                 TempBlob.CreateOutStream(OutStr);
        //                 OutStr.WriteText(Jsntext);
        //                 TempBlob.CreateInStream(Instr);
        //                 FileName := DelChr(Rec."No." + '_' + FORMAT(CurrentDateTime), '=', ' \/-:AMPM') + '.json';
        //                 DownloadFromStream(Instr, '', '', '', FileName);
        //             end;
        //         }
        //  }
        modify(Print)
        {
            Visible = false;
        }
        addafter(Print)
        {
            group(Report)
            {
                action("Tax Invoice Report")
                {
                    ApplicationArea = all;
                    Promoted = true;
                    Image = Print;
                    PromotedCategory = Category6;
                    trigger OnAction()
                    var
                        SalesInvHeader: Record "Sales Invoice Header";
                        CompanyInfo_lRec: Record "Company Information";
                    begin
                        if (CompanyName = 'Alyachem_1') or   (CompanyName = 'Chemidea_1') then begin
                            SalesInvHeader.Reset();
                            SalesInvHeader.SetRange("No.", rec."No.");
                            if SalesInvHeader.FindFirst() then
                                Report.run(Report::"Tax Invoice_Turkish", true, false, SalesInvHeader);
                        end else begin
                            CompanyInfo_lRec.GET;
                            if CompanyInfo_lRec."Enable GST caption" then begin
                                if rec."GST Bill-to State Code" = rec."Location State Code" then begin

                                    SalesInvHeader.Reset();
                                    SalesInvHeader.SetRange("No.", Rec."No.");

                                    if SalesInvHeader.FindFirst() then
                                        Report.RunModal(64100, true, false, SalesInvHeader);
                                end;
                                if rec."GST Bill-to State Code" <> rec."Location State Code" then
                                    if rec."GST Bill-to State Code" <> '' then begin

                                        SalesInvHeader.Reset();
                                        SalesInvHeader.SetRange("No.", Rec."No.");

                                        if SalesInvHeader.FindFirst() then
                                            Report.RunModal(64102, true, false, SalesInvHeader);
                                    end;

                                if rec."GST Bill-to State Code" = '' then begin
                                    SalesInvHeader.Reset();
                                    SalesInvHeader.SetRange("No.", Rec."No.");

                                    if SalesInvHeader.FindFirst() then
                                        Report.RunModal(50140, true, false, SalesInvHeader);
                                end;
                            end else begin
                                SalesInvHeader.Reset();
                                SalesInvHeader.SetRange("No.", Rec."No.");

                                if SalesInvHeader.FindFirst() then
                                    // Report.RunModal(64101, true, false, SalesInvHeader);//AS-O
                                    Report.RunModal(64103, true, false, SalesInvHeader);//AS-N
                            end;

                        end;
                    end;
                }
            }
            action("Commercial Invoice")
            {
                ApplicationArea = All;
                Image = Print;
                Promoted = true;
                PromotedCategory = Category6;
                trigger OnAction()
                var
                    SalesInvHeader: Record "Sales Invoice Header";
                    CompanyInfo_lRec: Record "Company Information";
                begin
                    CompanyInfo_lRec.GET;
                    SalesInvHeader.Reset();
                    SalesInvHeader.SetRange("No.", Rec."No.");
                    if SalesInvHeader.FindFirst() then
                        if CompanyInfo_lRec."Enable GST caption" then
                            Report.RunModal(64105, true, false, SalesInvHeader)
                        else
                            Report.RunModal(64104, true, false, SalesInvHeader);
                end;

            }
        }
    }



    var
        myInt: Integer;
}