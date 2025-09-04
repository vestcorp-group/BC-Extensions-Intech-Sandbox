/// <summary>
/// XmlPort Import Purchase Invoice (ID 50100).
/// </summary>
xmlport 54000 "Import Purchase Invoice"
{
    Direction = Import;
    Format = VariableText;
    FormatEvaluate = Legacy;
    schema
    {
        textelement(Root)
        {
            tableelement(Integer; Integer)
            {
                UseTemporary = true;
                textelement(Vendor_No) { }
                textelement(Vendor_Refrence) { }
                textelement(Posting_Date) { }
                textelement(Document_Date) { }
                textelement(Currency_Code) { }
                textelement(Header_Description) { }
                textelement(Your_Reference_PO_Refernce) { }
                //textelement(Receipt_No) { }
                textelement(T_type) { }
                textelement(Item_No) { }
                textelement(Description) { }
                textelement(Quantity) { }
                textelement(Direct_Unit_Cost) { }
                textelement(Charge_Item_Types) { }
                textelement(Charge_Item_Doc1) { }
                textelement(Charge_Item_Doc2) { }
                textelement(Alloction) { }
                //textelement(locationcode){}
                trigger OnPreXmlItem()
                begin
                    Vendor_Refrence_g := '';
                end;

                trigger OnAfterInsertRecord()
                begin

                    if RecordCount = 0 then begin
                        Clear(TransactionNo);
                        TransactionNo := LastTransactionNo();

                    end else begin
                        Clear(StagingPurchInvoice);
                        StagingPurchInvoice.LockTable();
                        StagingPurchInvoice.Init();
                        StagingPurchInvoice."Upload Batch No." := TransactionNo;
                        StagingPurchInvoice."Vendor No." := Vendor_No;
                        StagingPurchInvoice."Vendor Refrence" := Vendor_Refrence;
                        Evaluate(StagingPurchInvoice."Posting Date", Posting_Date);
                        Evaluate(StagingPurchInvoice."Document Date", Document_Date);
                        StagingPurchInvoice."Currency Code" := Currency_Code;
                        StagingPurchInvoice."Header Description" := Header_Description;
                        StagingPurchInvoice."Your Reference/PO Refernce" := Your_Reference_PO_Refernce;
                        // StagingPurchInvoice."Receipt No." := Receipt_No;
                        StagingPurchInvoice."Line No." := LineNo_fun;
                        Evaluate(StagingPurchInvoice.Type, T_type);
                        StagingPurchInvoice.validate("Item No.", Item_No);
                        StagingPurchInvoice.Description := Description;
                        if StagingPurchInvoice.Type = StagingPurchInvoice.Type::"Charge (Item)" then begin
                            //StagingPurchInvoice.Quantity := 1;
                            Evaluate(StagingPurchInvoice.Quantity, Quantity);
                            StagingPurchInvoice.Alloction := Alloction;
                            if Charge_Item_Doc1 = '' then
                                if Charge_Item_Doc2 = '' then
                                    Error('Charge_Item_Doc1 or Charge_Item_Doc2 must have a value.');
                            StagingPurchInvoice."Charge Item Doc1" := Charge_Item_Doc1;
                            StagingPurchInvoice."Charge Item Doc2" := Charge_Item_Doc2;
                            if Charge_Item_Types = '' then
                                Error('Charge Item Type must have a value.');
                            Evaluate(StagingPurchInvoice."Charge Item Types", Charge_Item_Types);
                        end else
                            Evaluate(StagingPurchInvoice.Quantity, Quantity);
                        if Direct_Unit_Cost <> '' then
                            Evaluate(StagingPurchInvoice."Direct Unit Cost", Direct_Unit_Cost);
                        // StagingPurchInvoice."Location Code" := locationcode;
                        StagingPurchInvoice."Uploaded By" := UserId;
                        StagingPurchInvoice."Uploaded Date/Time" := CurrentDateTime;
                        StagingPurchInvoice.Insert(true);
                    end;
                    RecordCount += 1;
                end;

                trigger OnAfterInitRecord()
                begin
                    Int1 += 1;
                    Integer.Number := Int1;
                end;
            }
        }
    }

    requestpage
    {
        layout
        {
            area(content)
            {
                group(GroupName)
                {
                    /*field(Name; SourceExpression)
                    {

                    }
                    */
                }
            }
        }

        actions
        {
            area(processing)
            {
                action(ActionName)
                {
                    ApplicationArea = All; // added by B

                }
            }
        }
    }
    trigger OnPreXmlPort()
    begin
    end;

    local procedure CheckduplicateCendorInvoiceNo(var UpdateBatchNo: Integer; Vendor_Refrence: Code[20]) Response: Boolean;
    begin
        Clear(StagingPurchInvoice2);
        StagingPurchInvoice2.SetRange("Vendor Refrence", Vendor_Refrence_g);
        StagingPurchInvoice2.SetFilter("Upload Batch No.", '<>%1', UpdateBatchNo);
        if StagingPurchInvoice2.FindLast() then
            if Confirm('Vendor Invoice No. already Exist in Upload Batch No. %1 Line No. %2, Do you want to continue?', true, StagingPurchInvoice2."Upload Batch No.", StagingPurchInvoice2."Line No.") then
                exit(true)
            else
                exit(false);
    end;

    local procedure LineNo_fun() LineNo: Integer;
    begin
        Clear(StagingPurchInvoice2);
        StagingPurchInvoice2.SetRange("Vendor Refrence", Vendor_Refrence);
        if StagingPurchInvoice2.FindLast() then
            exit(StagingPurchInvoice2."Line No." + 10000)
        else
            exit(10000);
    end;

    local procedure LastTransactionNo() LastTransNo: Integer;
    begin
        Clear(StagingPurchInvoice2);
        StagingPurchInvoice2.Reset();
        StagingPurchInvoice2.SetCurrentKey("Upload Batch No.");
        StagingPurchInvoice2.Ascending(true);
        if StagingPurchInvoice2.FindLast() then
            exit(StagingPurchInvoice2."Upload Batch No." + 1)
        else
            exit(1);
    end;

    var
        Int1: Integer;
        RecordCount: Integer;
        StagingPurchInvoice: Record "Staging Purchase Invoice";
        StagingPurchInvoice2: Record "Staging Purchase Invoice";
        TransactionNo: Integer;
        Vendor_Refrence_g: Code[50];


}