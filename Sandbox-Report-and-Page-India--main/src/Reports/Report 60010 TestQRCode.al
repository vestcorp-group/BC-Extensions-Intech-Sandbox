report 60010 TestQRCode//T12370-N //T12574-MIG USING ISPL E-Invoice Ext.
{
    Caption = 'TestQRCode';
    RDLCLayout = './Layouts/Rep60010.TestQRCode.rdlc';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem(SalesInvoiceHeader; "Sales Invoice Header")
        {
            RequestFilterFields = "No.";
            column(E_Invoice_QR_Code; QrCode)
            {

            }
            column(E_Invoice_signedQrCode; SignedQR)
            {

            }
            column(E_Invoice_Signed_Invoice; SignedInv)
            {

            }

            trigger OnAfterGetRecord()
            var
                base64: Codeunit "Base64 Convert";
                Instr: InStream;
                Instr2: InStream;
                Instr3: InStream;
                TypeHelper: Codeunit "Type Helper";
                aaaa: Codeunit 1266;
            //FontProvide: Interface "Barcode Font Provider 2D";
            begin
                //T12574-MIG USING ISPL E-Invoice Ext. CalcFields("E-Invoice QR Code", "E-Invoice signedQrCode", "E-Invoice Signed Invoice");
                Clear(QrCode);
                Clear(SignedInv);
                Clear(SignedQR);
                Clear(Instr);
                Clear(Instr2);
                Clear(Instr3);
                //T12574-MIG USING ISPL E-Invoice Ext. "E-Invoice QR Code".CreateInStream(instr2);
                TypeHelper.TryReadAsTextWithSeparator(instr2, TypeHelper.LFSeparator(), QRCode);
                //Message(QrCode);
                QRCode := CopyStr(QRCode, 2, StrLen(QrCode) - 2);
                //Message(QrCode);

                // "E-Invoice Signed Invoice".CreateInStream(instr);
                // TypeHelper.TryReadAsTextWithSeparator(instr, TypeHelper.LFSeparator(), SignedInv);
                // Message(SignedInv);
                // SignedInv := CopyStr(SignedInv, 2, StrLen(SignedInv) - 2);
                // Message(SignedInv);
                // SignedInv := aaaa.GenerateHashAsBase64String(SignedInv, Enum::"Hash Algorithm"::SHA256.AsInteger());
                // Message(SignedInv);




                //T12574-MIG USING ISPL E-Invoice Ext. "E-Invoice signedQrCode".CreateInStream(instr3);
                TypeHelper.TryReadAsTextWithSeparator(instr3, TypeHelper.LFSeparator(), SignedQR);
                Message(SignedQR);
                SignedQR := CopyStr(SignedQR, 2, StrLen(SignedQR) - 2);
                Message(SignedQR);

                SignedQR := base64.ToBase64(SignedQR);
                Message(SignedQR);
            end;
        }
    }
    var
        QrCode: Text;
        SignedQR: Text;
        SignedInv: Text;
}
