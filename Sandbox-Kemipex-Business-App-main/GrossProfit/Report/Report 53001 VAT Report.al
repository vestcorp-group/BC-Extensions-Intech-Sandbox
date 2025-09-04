report 53001 "VAT Report"//T12370-Full Comment
{
    ApplicationArea = All;
    Caption = 'VAT Report';
    UsageCategory = ReportsAndAnalysis;
    ProcessingOnly = true;

    dataset
    {
        dataitem(VATEntry; "VAT Entry")
        {
            DataItemTableView = sorting("Entry No.") order(descending) where(Type = filter('Sale|Purchase'));
            RequestFilterFields = "Document No.", "Posting Date";
            trigger OnAfterGetRecord()
            var
                RecSalesInvHdr: Record "Sales Invoice Header";
                RecSalesInvline: Record "Sales Invoice Line";
                RecPurchInvHdr: Record "Purch. Inv. Header";
                RecPurchInvLine: Record "Purch. Inv. Line";
                RecsalesCrmemoHdr: Record "Sales Cr.Memo Header";
                RecSalescrMemoLine: Record "Sales Cr.Memo Line";
                RecPurchCrMemoHdr: Record "Purch. Cr. Memo Hdr.";
                RecPurchCrMemoLine: Record "Purch. Cr. Memo Line";
                RecCustomer: Record Customer;
                RecVendor: Record Vendor;
                RecVatProdPostingGrp: Record "VAT Product Posting Group";
                RecVatBusPostingGrp: Record "VAT Business Posting Group";
                VatPostingGrpdesc: Text;
                RecEntryExit: Record "Entry/Exit Point";
                RecAre: Record "Area";
                ExchangeRate: Decimal;
                RecGenPossetup: Record "General Posting Setup";
                RecGlAccount: Record "G/L Account";
                RecGLSetup: Record "General Ledger Setup";

            //a:page 42
            begin
                RecGLSetup.GET;
                if VATEntry.Type IN [VATEntry.Type::Purchase, VATEntry.Type::Sale] then begin

                    if not CheckList.Contains(FORMAT(VATEntry.Type) + FORMAT(VATEntry."Document Type") + VATEntry."Document No." + VATEntry."VAT Bus. Posting Group" + VATEntry."VAT Prod. Posting Group") then begin
                        CheckList.Add(FORMAT(VATEntry.Type) + FORMAT(VATEntry."Document Type") + VATEntry."Document No." + VATEntry."VAT Bus. Posting Group" + VATEntry."VAT Prod. Posting Group");

                        if VATEntry.Type = VATEntry.Type::Purchase then begin
                            case VATEntry."Document Type" of
                                VAtEntry."Document Type"::Invoice:
                                    begin
                                        if NOT FORMAT(VATEntry."Document No.").Contains('PAI') then begin
                                            Clear(RecPurchInvHdr);
                                            RecPurchInvHdr.SetRange("No.", VATEntry."Document No.");
                                            if RecPurchInvHdr.FindFirst() then begin
                                                Clear(RecPurchInvLine);
                                                RecPurchInvLine.SetRange("Document No.", RecPurchInvHdr."No.");
                                                RecPurchInvLine.SetRange("VAT Bus. Posting Group", VATEntry."VAT Bus. Posting Group");
                                                RecPurchInvLine.SetRange("VAT Prod. Posting Group", VATEntry."VAT Prod. Posting Group");
                                                RecPurchInvLine.SetFilter(Type, '<>%1', RecPurchInvLine.Type::" ");
                                                if RecPurchInvLine.FindSet() then begin
                                                    repeat
                                                        RowNumber += 1;
                                                        ExcelBuf.NewRow;
                                                        ExcelBuf.AddColumn(RowNumber, FALSE, '', false, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
                                                        ExcelBuf.AddColumn(VATEntry."Document Type", FALSE, '', false, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                                                        ExcelBuf.AddColumn(VATEntry."Document No.", FALSE, '', false, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                                                        ExcelBuf.AddColumn(VATEntry."Posting Date", FALSE, '', false, FALSE, FALSE, '', ExcelBuf."Cell Type"::Date);
                                                        ExcelBuf.AddColumn(RecPurchInvHdr."Document Date", FALSE, '', false, FALSE, FALSE, '', ExcelBuf."Cell Type"::Date);
                                                        ExcelBuf.AddColumn(RecPurchInvHdr."No.", FALSE, '', false, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                                                        ExcelBuf.AddColumn(RecPurchInvHdr."Vendor Invoice No.", FALSE, '', false, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                                                        ExcelBuf.AddColumn(RecPurchInvHdr."Buy-from Vendor No.", FALSE, '', false, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                                                        ExcelBuf.AddColumn(RecPurchInvHdr."Buy-from Vendor Name", FALSE, '', false, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                                                        ExcelBuf.AddColumn(VATEntry."VAT Registration No.", FALSE, '', false, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                                                        ExcelBuf.AddColumn(VATEntry."Country/Region Code", FALSE, '', false, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                                                        if RecPurchInvLine.Type = RecPurchInvLine.Type::Item then begin
                                                            ExcelBuf.AddColumn(RecPurchInvLine."No.", FALSE, '', false, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                                                            ExcelBuf.AddColumn(RecPurchInvLine.Description, FALSE, '', false, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                                                            if (RecPurchInvLine."Gen. Bus. Posting Group" <> '') AND (RecPurchInvLine."Gen. Prod. Posting Group" <> '') then begin
                                                                Clear(RecGenPossetup);
                                                                RecGenPossetup.SetRange("Gen. Bus. Posting Group", RecPurchInvLine."Gen. Bus. Posting Group");
                                                                RecGenPossetup.SetRange("Gen. Prod. Posting Group", RecPurchInvLine."Gen. Prod. Posting Group");
                                                                RecGenPossetup.SetFilter("Purch. Account", '<>%1', '');
                                                                if RecGenPossetup.FindFirst() then begin
                                                                    RecGlAccount.GET(RecGenPossetup."Purch. Account");
                                                                    ExcelBuf.AddColumn(RecGlAccount.Name, FALSE, '', false, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text)
                                                                end
                                                                else
                                                                    ExcelBuf.AddColumn('', FALSE, '', false, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);

                                                            end else
                                                                ExcelBuf.AddColumn('', FALSE, '', false, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                                                        end else begin
                                                            ExcelBuf.AddColumn('', FALSE, '', false, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                                                            ExcelBuf.AddColumn('', FALSE, '', false, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                                                            ExcelBuf.AddColumn(RecPurchInvLine.Description, FALSE, '', false, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                                                        end;
                                                        Clear(ExchangeRate);
                                                        if RecPurchInvHdr."Currency Factor" <> 0 then
                                                            ExchangeRate := 1 / RecPurchInvHdr."Currency Factor"
                                                        else
                                                            ExchangeRate := 1;
                                                        ExcelBuf.AddColumn(RecPurchInvLine.Quantity, FALSE, '', false, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                                                        ExcelBuf.AddColumn(RecPurchInvLine."Direct Unit Cost", FALSE, '', false, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                                                        if RecPurchInvHdr."Currency Code" <> '' then
                                                            ExcelBuf.AddColumn(RecPurchInvHdr."Currency Code", FALSE, '', false, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text)
                                                        else
                                                            ExcelBuf.AddColumn(RecGLSetup."LCY Code", FALSE, '', false, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);

                                                        ExcelBuf.AddColumn(ExchangeRate, FALSE, '', false, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
                                                        ExcelBuf.AddColumn(RecPurchInvLine."VAT %", FALSE, '', false, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
                                                        //
                                                        ExcelBuf.AddColumn(RecPurchInvLine."VAT Base Amount" * -1, FALSE, '', false, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
                                                        ExcelBuf.AddColumn((RecPurchInvLine."VAT Base Amount" * ExchangeRate) * -1, FALSE, '', false, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
                                                        ExcelBuf.AddColumn((RecPurchInvLine."Amount Including VAT" - RecPurchInvLine."VAT Base Amount") * -1, FALSE, '', false, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
                                                        ExcelBuf.AddColumn(((RecPurchInvLine."Amount Including VAT" - RecPurchInvLine."VAT Base Amount") * ExchangeRate) * -1, FALSE, '', false, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
                                                        ExcelBuf.AddColumn(RecPurchInvLine."Amount Including VAT" * -1, FALSE, '', false, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
                                                        ExcelBuf.AddColumn((RecPurchInvLine."Amount Including VAT" * ExchangeRate) * -1, FALSE, '', false, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
                                                        //
                                                        Clear(RecVatProdPostingGrp);
                                                        Clear(VatPostingGrpdesc);
                                                        if RecVatProdPostingGrp.GET(VATEntry."VAT Prod. Posting Group") then
                                                            VatPostingGrpdesc := RecVatProdPostingGrp.Description;
                                                        Clear(RecVatBusPostingGrp);
                                                        if RecVatBusPostingGrp.GET(VATEntry."VAT Bus. Posting Group") then
                                                            VatPostingGrpdesc += RecVatBusPostingGrp.Description;
                                                        ExcelBuf.AddColumn(VatPostingGrpdesc, FALSE, '', false, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);

                                                        if RecPurchInvLine."Entry Point" <> '' then begin
                                                            Clear(RecEntryExit);
                                                            RecEntryExit.GET(RecPurchInvLine."Entry Point");
                                                            ExcelBuf.AddColumn(RecEntryExit.Description, FALSE, '', false, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                                                        end else
                                                            ExcelBuf.AddColumn('', FALSE, '', false, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);


                                                        if RecPurchInvLine."Area" <> '' then begin
                                                            Clear(RecAre);
                                                            RecAre.GET(RecPurchInvLine."Area");
                                                            ExcelBuf.AddColumn(RecAre."Text", FALSE, '', false, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                                                        end else
                                                            ExcelBuf.AddColumn('', FALSE, '', false, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);

                                                        ExcelBuf.AddColumn(RecPurchInvLine."Transaction Specification", FALSE, '', false, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                                                    until RecPurchInvLine.Next() = 0;
                                                end;
                                            end;
                                        end;
                                    end;

                                VAtEntry."Document Type"::"Credit Memo":
                                    begin
                                        Clear(RecPurchCrMemoHdr);
                                        RecPurchCrMemoHdr.SetRange("No.", VATEntry."Document No.");
                                        if RecPurchCrMemoHdr.FindFirst() then begin
                                            Clear(RecPurchCrMemoLine);
                                            RecPurchCrMemoLine.SetRange("Document No.", RecPurchCrMemoHdr."No.");
                                            RecPurchCrMemoLine.SetRange("VAT Bus. Posting Group", VATEntry."VAT Bus. Posting Group");
                                            RecPurchCrMemoLine.SetRange("VAT Prod. Posting Group", VATEntry."VAT Prod. Posting Group");
                                            RecPurchCrMemoLine.SetFilter(Type, '<>%1', RecPurchCrMemoLine.Type::" ");
                                            if RecPurchCrMemoLine.FindSet() then begin
                                                repeat
                                                    RowNumber += 1;
                                                    ExcelBuf.NewRow;
                                                    ExcelBuf.AddColumn(RowNumber, FALSE, '', false, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
                                                    ExcelBuf.AddColumn(VATEntry."Document Type", FALSE, '', false, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                                                    ExcelBuf.AddColumn(VATEntry."Document No.", FALSE, '', false, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                                                    ExcelBuf.AddColumn(VATEntry."Posting Date", FALSE, '', false, FALSE, FALSE, '', ExcelBuf."Cell Type"::Date);
                                                    ExcelBuf.AddColumn(RecPurchCrMemoHdr."Document Date", FALSE, '', false, FALSE, FALSE, '', ExcelBuf."Cell Type"::Date);
                                                    ExcelBuf.AddColumn(RecPurchCrMemoHdr."No.", FALSE, '', false, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                                                    ExcelBuf.AddColumn(RecPurchCrMemoHdr."Vendor Cr. Memo No.", FALSE, '', false, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                                                    ExcelBuf.AddColumn(RecPurchCrMemoHdr."Buy-from Vendor No.", FALSE, '', false, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                                                    ExcelBuf.AddColumn(RecPurchCrMemoHdr."Buy-from Vendor Name", FALSE, '', false, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                                                    ExcelBuf.AddColumn(VATEntry."VAT Registration No.", FALSE, '', false, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                                                    ExcelBuf.AddColumn(VATEntry."Country/Region Code", FALSE, '', false, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                                                    if RecPurchCrMemoLine.Type = RecPurchCrMemoLine.Type::Item then begin
                                                        ExcelBuf.AddColumn(RecPurchCrMemoLine."No.", FALSE, '', false, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                                                        ExcelBuf.AddColumn(RecPurchCrMemoLine.Description, FALSE, '', false, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);

                                                        if (RecPurchCrMemoLine."Gen. Bus. Posting Group" <> '') AND (RecPurchCrMemoLine."Gen. Prod. Posting Group" <> '') then begin
                                                            Clear(RecGenPossetup);
                                                            RecGenPossetup.SetRange("Gen. Bus. Posting Group", RecPurchCrMemoLine."Gen. Bus. Posting Group");
                                                            RecGenPossetup.SetRange("Gen. Prod. Posting Group", RecPurchCrMemoLine."Gen. Prod. Posting Group");
                                                            RecGenPossetup.SetFilter("Purch. Credit Memo Account", '<>%1', '');
                                                            if RecGenPossetup.FindFirst() then begin
                                                                RecGlAccount.GET(RecGenPossetup."Purch. Credit Memo Account");
                                                                ExcelBuf.AddColumn(RecGlAccount.Name, FALSE, '', false, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text)
                                                            end
                                                            else
                                                                ExcelBuf.AddColumn('', FALSE, '', false, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                                                        end else
                                                            ExcelBuf.AddColumn('', FALSE, '', false, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);

                                                    end else begin
                                                        ExcelBuf.AddColumn('', FALSE, '', false, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                                                        ExcelBuf.AddColumn('', FALSE, '', false, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                                                        ExcelBuf.AddColumn(RecPurchCrMemoLine.Description, FALSE, '', false, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                                                    end;
                                                    Clear(ExchangeRate);
                                                    if RecPurchCrMemoHdr."Currency Factor" <> 0 then
                                                        ExchangeRate := 1 / RecPurchCrMemoHdr."Currency Factor"
                                                    else
                                                        ExchangeRate := 1;
                                                    ExcelBuf.AddColumn(RecPurchCrMemoLine.Quantity, FALSE, '', false, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                                                    ExcelBuf.AddColumn(RecPurchCrMemoLine."Direct Unit Cost", FALSE, '', false, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);

                                                    if RecPurchCrMemoHdr."Currency Code" <> '' then
                                                        ExcelBuf.AddColumn(RecPurchCrMemoHdr."Currency Code", FALSE, '', false, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text)
                                                    else
                                                        ExcelBuf.AddColumn(RecGLSetup."LCY Code", FALSE, '', false, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);


                                                    ExcelBuf.AddColumn(ExchangeRate, FALSE, '', false, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
                                                    ExcelBuf.AddColumn(RecPurchCrMemoLine."VAT %", FALSE, '', false, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
                                                    ExcelBuf.AddColumn(RecPurchCrMemoLine."VAT Base Amount", FALSE, '', false, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
                                                    ExcelBuf.AddColumn(RecPurchCrMemoLine."VAT Base Amount" * ExchangeRate, FALSE, '', false, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
                                                    ExcelBuf.AddColumn(RecPurchCrMemoLine."Amount Including VAT" - RecPurchCrMemoLine."VAT Base Amount", FALSE, '', false, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
                                                    ExcelBuf.AddColumn((RecPurchCrMemoLine."Amount Including VAT" - RecPurchCrMemoLine."VAT Base Amount") * ExchangeRate, FALSE, '', false, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
                                                    ExcelBuf.AddColumn(RecPurchCrMemoLine."Amount Including VAT", FALSE, '', false, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
                                                    ExcelBuf.AddColumn(RecPurchCrMemoLine."Amount Including VAT" * ExchangeRate, FALSE, '', false, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
                                                    Clear(RecVatProdPostingGrp);
                                                    Clear(VatPostingGrpdesc);
                                                    if RecVatProdPostingGrp.GET(VATEntry."VAT Prod. Posting Group") then
                                                        VatPostingGrpdesc := RecVatProdPostingGrp.Description;
                                                    Clear(RecVatBusPostingGrp);
                                                    if RecVatBusPostingGrp.GET(VATEntry."VAT Bus. Posting Group") then
                                                        VatPostingGrpdesc += RecVatBusPostingGrp.Description;
                                                    ExcelBuf.AddColumn(VatPostingGrpdesc, FALSE, '', false, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);

                                                    if RecPurchCrMemoLine."Entry Point" <> '' then begin
                                                        Clear(RecEntryExit);
                                                        RecEntryExit.GET(RecPurchCrMemoLine."Entry Point");
                                                        ExcelBuf.AddColumn(RecEntryExit.Description, FALSE, '', false, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                                                    end else
                                                        ExcelBuf.AddColumn('', FALSE, '', false, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);


                                                    if RecPurchCrMemoHdr."Area" <> '' then begin
                                                        Clear(RecAre);
                                                        RecAre.GET(RecPurchCrMemoHdr."Area");
                                                        ExcelBuf.AddColumn(RecAre."Text", FALSE, '', false, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                                                    end else
                                                        ExcelBuf.AddColumn('', FALSE, '', false, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);

                                                    ExcelBuf.AddColumn(RecPurchCrMemoHdr."Transaction Specification", FALSE, '', false, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                                                until RecPurchCrMemoLine.Next() = 0;
                                            end;
                                        end;
                                    end;

                            end;
                        end else begin
                            if VATEntry.Type = VATEntry.Type::Sale then begin
                                case VAtEntry."Document Type" of
                                    VAtEntry."Document Type"::Invoice:
                                        begin

                                            Clear(RecSalesInvHdr);
                                            RecSalesInvHdr.SetRange("No.", VATEntry."Document No.");
                                            if RecSalesInvHdr.FindFirst() then begin
                                                Clear(RecSalesInvline);
                                                RecSalesInvline.SetRange("Document No.", RecSalesInvHdr."No.");
                                                RecSalesInvline.SetRange("VAT Bus. Posting Group", VATEntry."VAT Bus. Posting Group");
                                                RecSalesInvline.SetRange("VAT Prod. Posting Group", VATEntry."VAT Prod. Posting Group");
                                                RecSalesInvline.SetFilter(Type, '<>%1', RecSalesInvline.Type::" ");
                                                if RecSalesInvline.FindSet() then begin
                                                    repeat
                                                        RowNumber += 1;
                                                        ExcelBuf.NewRow;
                                                        ExcelBuf.AddColumn(RowNumber, FALSE, '', false, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
                                                        ExcelBuf.AddColumn(VATEntry."Document Type", FALSE, '', false, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                                                        ExcelBuf.AddColumn(VATEntry."Document No.", FALSE, '', false, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                                                        ExcelBuf.AddColumn(VATEntry."Posting Date", FALSE, '', false, FALSE, FALSE, '', ExcelBuf."Cell Type"::Date);
                                                        ExcelBuf.AddColumn(RecSalesInvHdr."Posting Date", FALSE, '', false, FALSE, FALSE, '', ExcelBuf."Cell Type"::Date);
                                                        ExcelBuf.AddColumn(RecSalesInvHdr."No.", FALSE, '', false, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                                                        ExcelBuf.AddColumn('', FALSE, '', false, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                                                        ExcelBuf.AddColumn(RecSalesInvHdr."Sell-to Customer No.", FALSE, '', false, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                                                        ExcelBuf.AddColumn(RecSalesInvHdr."Sell-to Customer Name", FALSE, '', false, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                                                        ExcelBuf.AddColumn(VATEntry."VAT Registration No.", FALSE, '', false, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                                                        ExcelBuf.AddColumn(VATEntry."Country/Region Code", FALSE, '', false, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                                                        if RecSalesInvline.Type = RecSalesInvline.Type::Item then begin
                                                            ExcelBuf.AddColumn(RecSalesInvline."No.", FALSE, '', false, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                                                            ExcelBuf.AddColumn(RecSalesInvline.Description, FALSE, '', false, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);

                                                            if (RecSalesInvline."Gen. Bus. Posting Group" <> '') AND (RecSalesInvline."Gen. Prod. Posting Group" <> '') then begin
                                                                Clear(RecGenPossetup);
                                                                RecGenPossetup.SetRange("Gen. Bus. Posting Group", RecSalesInvline."Gen. Bus. Posting Group");
                                                                RecGenPossetup.SetRange("Gen. Prod. Posting Group", RecSalesInvline."Gen. Prod. Posting Group");
                                                                RecGenPossetup.SetFilter("Sales Account", '<>%1', '');
                                                                if RecGenPossetup.FindFirst() then begin
                                                                    RecGlAccount.GET(RecGenPossetup."Sales Account");
                                                                    ExcelBuf.AddColumn(RecGlAccount.Name, FALSE, '', false, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text)
                                                                end
                                                                else
                                                                    ExcelBuf.AddColumn('', FALSE, '', false, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                                                            end else
                                                                ExcelBuf.AddColumn('', FALSE, '', false, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                                                        end else begin
                                                            ExcelBuf.AddColumn('', FALSE, '', false, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                                                            ExcelBuf.AddColumn('', FALSE, '', false, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                                                            ExcelBuf.AddColumn(RecSalesInvline.Description, FALSE, '', false, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                                                        end;
                                                        Clear(ExchangeRate);
                                                        if RecSalesInvHdr."Currency Factor" <> 0 then
                                                            ExchangeRate := 1 / RecSalesInvHdr."Currency Factor"
                                                        else
                                                            ExchangeRate := 1;

                                                        ExcelBuf.AddColumn(RecSalesInvline.Quantity, FALSE, '', false, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                                                        ExcelBuf.AddColumn(RecSalesInvline."Unit Price", FALSE, '', false, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                                                        if RecSalesInvHdr."Currency Code" <> '' then
                                                            ExcelBuf.AddColumn(RecSalesInvHdr."Currency Code", FALSE, '', false, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text)
                                                        else
                                                            ExcelBuf.AddColumn(RecGLSetup."LCY Code", FALSE, '', false, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);

                                                        ExcelBuf.AddColumn(ExchangeRate, FALSE, '', false, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
                                                        ExcelBuf.AddColumn(RecSalesInvline."VAT %", FALSE, '', false, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
                                                        //
                                                        ExcelBuf.AddColumn(RecSalesInvline."VAT Base Amount", FALSE, '', false, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
                                                        ExcelBuf.AddColumn(RecSalesInvline."VAT Base Amount" * ExchangeRate, FALSE, '', false, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
                                                        ExcelBuf.AddColumn(RecSalesInvline."Amount Including VAT" - RecSalesInvline."VAT Base Amount", FALSE, '', false, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
                                                        ExcelBuf.AddColumn((RecSalesInvline."Amount Including VAT" - RecSalesInvline."VAT Base Amount") * ExchangeRate, FALSE, '', false, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
                                                        ExcelBuf.AddColumn(RecSalesInvline."Amount Including VAT", FALSE, '', false, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
                                                        ExcelBuf.AddColumn(RecSalesInvline."Amount Including VAT" * ExchangeRate, FALSE, '', false, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
                                                        //

                                                        Clear(RecVatProdPostingGrp);
                                                        Clear(VatPostingGrpdesc);
                                                        if RecVatProdPostingGrp.GET(VATEntry."VAT Prod. Posting Group") then
                                                            VatPostingGrpdesc := RecVatProdPostingGrp.Description;
                                                        Clear(RecVatBusPostingGrp);
                                                        if RecVatBusPostingGrp.GET(VATEntry."VAT Bus. Posting Group") then
                                                            VatPostingGrpdesc += RecVatBusPostingGrp.Description;
                                                        ExcelBuf.AddColumn(VatPostingGrpdesc, FALSE, '', false, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);

                                                        if RecSalesInvline."Exit Point" <> '' then begin
                                                            Clear(RecEntryExit);
                                                            RecEntryExit.GET(RecSalesInvline."Exit Point");
                                                            ExcelBuf.AddColumn(RecEntryExit.Description, FALSE, '', false, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                                                        end else
                                                            ExcelBuf.AddColumn('', FALSE, '', false, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);


                                                        if RecSalesInvline."Area" <> '' then begin
                                                            Clear(RecAre);
                                                            RecAre.GET(RecSalesInvline."Area");
                                                            ExcelBuf.AddColumn(RecAre."Text", FALSE, '', false, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                                                        end else
                                                            ExcelBuf.AddColumn('', FALSE, '', false, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);

                                                        ExcelBuf.AddColumn(RecSalesInvline."Transaction Specification", FALSE, '', false, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                                                    until RecSalesInvline.Next() = 0;
                                                end;
                                            end;
                                        end;

                                    VAtEntry."Document Type"::"Credit Memo":
                                        begin
                                            Clear(RecsalesCrmemoHdr);
                                            RecsalesCrmemoHdr.SetRange("No.", VATEntry."Document No.");
                                            if RecsalesCrmemoHdr.FindFirst() then begin
                                                Clear(RecSalescrMemoLine);
                                                RecSalescrMemoLine.SetRange("Document No.", RecsalesCrmemoHdr."No.");
                                                RecSalescrMemoLine.SetRange("VAT Bus. Posting Group", VATEntry."VAT Bus. Posting Group");
                                                RecSalescrMemoLine.SetRange("VAT Prod. Posting Group", VATEntry."VAT Prod. Posting Group");
                                                RecSalescrMemoLine.SetFilter(Type, '<>%1', RecSalescrMemoLine.Type::" ");
                                                if RecSalescrMemoLine.FindSet() then begin
                                                    repeat
                                                        RowNumber += 1;
                                                        ExcelBuf.NewRow;
                                                        ExcelBuf.AddColumn(RowNumber, FALSE, '', false, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
                                                        ExcelBuf.AddColumn(VATEntry."Document Type", FALSE, '', false, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                                                        ExcelBuf.AddColumn(VATEntry."Document No.", FALSE, '', false, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                                                        ExcelBuf.AddColumn(VATEntry."Posting Date", FALSE, '', false, FALSE, FALSE, '', ExcelBuf."Cell Type"::Date);
                                                        ExcelBuf.AddColumn(RecsalesCrmemoHdr."Posting Date", FALSE, '', false, FALSE, FALSE, '', ExcelBuf."Cell Type"::Date);
                                                        ExcelBuf.AddColumn(RecsalesCrmemoHdr."No.", FALSE, '', false, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                                                        ExcelBuf.AddColumn('', FALSE, '', false, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                                                        ExcelBuf.AddColumn(RecsalesCrmemoHdr."Sell-to Customer No.", FALSE, '', false, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                                                        ExcelBuf.AddColumn(RecsalesCrmemoHdr."Sell-to Customer Name", FALSE, '', false, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                                                        ExcelBuf.AddColumn(VATEntry."VAT Registration No.", FALSE, '', false, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                                                        ExcelBuf.AddColumn(VATEntry."Country/Region Code", FALSE, '', false, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                                                        if RecSalescrMemoLine.Type = RecSalescrMemoLine.Type::Item then begin
                                                            ExcelBuf.AddColumn(RecSalescrMemoLine."No.", FALSE, '', false, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                                                            ExcelBuf.AddColumn(RecSalescrMemoLine.Description, FALSE, '', false, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                                                            if (RecSalescrMemoLine."Gen. Bus. Posting Group" <> '') AND (RecSalescrMemoLine."Gen. Prod. Posting Group" <> '') then begin
                                                                Clear(RecGenPossetup);
                                                                RecGenPossetup.SetRange("Gen. Bus. Posting Group", RecSalescrMemoLine."Gen. Bus. Posting Group");
                                                                RecGenPossetup.SetRange("Gen. Prod. Posting Group", RecSalescrMemoLine."Gen. Prod. Posting Group");
                                                                RecGenPossetup.SetFilter("Sales Credit Memo Account", '<>%1', '');
                                                                if RecGenPossetup.FindFirst() then begin
                                                                    RecGlAccount.GET(RecGenPossetup."Sales Credit Memo Account");
                                                                    ExcelBuf.AddColumn(RecGlAccount.Name, FALSE, '', false, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text)
                                                                end
                                                                else
                                                                    ExcelBuf.AddColumn('', FALSE, '', false, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                                                            end else
                                                                ExcelBuf.AddColumn('', FALSE, '', false, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                                                        end else begin
                                                            ExcelBuf.AddColumn('', FALSE, '', false, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                                                            ExcelBuf.AddColumn('', FALSE, '', false, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                                                            ExcelBuf.AddColumn(RecSalescrMemoLine.Description, FALSE, '', false, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                                                        end;
                                                        Clear(ExchangeRate);
                                                        if RecsalesCrmemoHdr."Currency Factor" <> 0 then
                                                            ExchangeRate := 1 / RecsalesCrmemoHdr."Currency Factor"
                                                        else
                                                            ExchangeRate := 1;
                                                        ExcelBuf.AddColumn(RecSalescrMemoLine.Quantity, FALSE, '', false, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                                                        ExcelBuf.AddColumn(RecSalescrMemoLine."Unit Price", FALSE, '', false, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);

                                                        if RecsalesCrmemoHdr."Currency Code" <> '' then
                                                            ExcelBuf.AddColumn(RecsalesCrmemoHdr."Currency Code", FALSE, '', false, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text)
                                                        else
                                                            ExcelBuf.AddColumn(RecGLSetup."LCY Code", FALSE, '', false, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);


                                                        ExcelBuf.AddColumn(ExchangeRate, FALSE, '', false, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
                                                        ExcelBuf.AddColumn(RecSalescrMemoLine."VAT %", FALSE, '', false, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
                                                        //
                                                        ExcelBuf.AddColumn(RecSalescrMemoLine."VAT Base Amount" * -1, FALSE, '', false, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
                                                        ExcelBuf.AddColumn((RecSalescrMemoLine."VAT Base Amount" * ExchangeRate) * -1, FALSE, '', false, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
                                                        ExcelBuf.AddColumn((RecSalescrMemoLine."Amount Including VAT" - RecSalescrMemoLine."VAT Base Amount") * -1, FALSE, '', false, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
                                                        ExcelBuf.AddColumn(((RecSalescrMemoLine."Amount Including VAT" - RecSalescrMemoLine."VAT Base Amount") * ExchangeRate) * -1, FALSE, '', false, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
                                                        ExcelBuf.AddColumn(RecSalescrMemoLine."Amount Including VAT" * -1, FALSE, '', false, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
                                                        ExcelBuf.AddColumn((RecSalescrMemoLine."Amount Including VAT" * ExchangeRate) * -1, FALSE, '', false, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
                                                        //
                                                        Clear(RecVatProdPostingGrp);
                                                        Clear(VatPostingGrpdesc);
                                                        if RecVatProdPostingGrp.GET(VATEntry."VAT Prod. Posting Group") then
                                                            VatPostingGrpdesc := RecVatProdPostingGrp.Description;
                                                        Clear(RecVatBusPostingGrp);
                                                        if RecVatBusPostingGrp.GET(VATEntry."VAT Bus. Posting Group") then
                                                            VatPostingGrpdesc += RecVatBusPostingGrp.Description;
                                                        ExcelBuf.AddColumn(VatPostingGrpdesc, FALSE, '', false, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);

                                                        if RecSalescrMemoLine."Exit Point" <> '' then begin
                                                            Clear(RecEntryExit);
                                                            RecEntryExit.GET(RecSalescrMemoLine."Exit Point");
                                                            ExcelBuf.AddColumn(RecEntryExit.Description, FALSE, '', false, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                                                        end else
                                                            ExcelBuf.AddColumn('', FALSE, '', false, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);


                                                        if RecSalescrMemoLine."Area" <> '' then begin
                                                            Clear(RecAre);
                                                            RecAre.GET(RecSalescrMemoLine."Area");
                                                            ExcelBuf.AddColumn(RecAre."Text", FALSE, '', false, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                                                        end else
                                                            ExcelBuf.AddColumn('', FALSE, '', false, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);

                                                        ExcelBuf.AddColumn(RecSalescrMemoLine."Transaction Specification", FALSE, '', false, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                                                    until RecSalescrMemoLine.Next() = 0;
                                                end;
                                            end;
                                        end;

                                end;
                            end;
                        end;
                    end;
                end;
            end;
        }
    }

    trigger OnPreReport()
    begin
        Clear(RowNumber);
        Clear(CheckList);
        VATFilters := VATEntry.GetFilters;
        //Creating Excel
        MakeExcelInfo;
    end;

    trigger OnPostReport()
    var
        Outstr: OutStream;
        TempBlb: Codeunit "Temp Blob";
        Instr: InStream;
        FileName: Text;
    begin
        Clear(TempBlb);
        TempBlb.CreateOutStream(Outstr);
        GetExcelInToSteam(Outstr);
        TempBlb.CreateInStream(Instr);
        FileName := Text102 + DelChr(Format(CurrentDateTime), '=', ':AMPM\/ ') + '.xlsx';
        DownloadFromStream(Instr, '', '', '', FileName);
    end;

    local procedure MakeExcelInfo()
    begin
        ExcelBuf.SetUseInfoSheet;
        ExcelBuf.AddInfoColumn(FORMAT(Text103), FALSE, TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddInfoColumn(CompanyName, FALSE, FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn(FORMAT(Text105), FALSE, TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddInfoColumn(FORMAT(Text102), FALSE, FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);

        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn(FORMAT(Text108), FALSE, TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddInfoColumn(FORMAT(VATFilters), FALSE, FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn(FORMAT(Text104), FALSE, TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddInfoColumn(REPORT::"VAT Report", FALSE, FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn(FORMAT(Text106), FALSE, TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddInfoColumn(USERID, FALSE, FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn(FORMAT(Text107), FALSE, TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddInfoColumn(TODAY, FALSE, FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Date);
        ExcelBuf.AddInfoColumn(TIME, FALSE, FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Time);
        ExcelBuf.NewRow;
        ExcelBuf.ClearNewRow;
        MakeExcelDataHeader;
    end;

    local procedure MakeExcelDataHeader()
    begin
        ExcelBuf.NewRow;
        ExcelBuf.AddColumn('SN.', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn('Document Type', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Document Number', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Posting Date', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Invoice Date', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Invoice Number', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Vendor Invoice No.', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Customer/Vendor code', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Customer/Vendor Name', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('TRN', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Country', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Item Code', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Item Name', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('GL Name', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Quantity ', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Unit Price', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Currency Code', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Currency Exchange rate', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Tax %', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Base Amount Excl. VAT', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Base Amount Excl. VAT (LCY)', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('VAT Amount', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('VAT Amount (LCY) ', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Total Amount', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Total Amount (LCY)', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('VAT Posting Description', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Port of loading', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Port of destination', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Inco term', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
    END;

    procedure GetExcelInToSteam(var ReportInOutStream: OutStream)
    begin
        ExcelBuf.CreateNewBook(Text101);
        ExcelBuf.WriteSheet(Text102, COMPANYNAME, USERID);
        ExcelBuf.CloseBook();
        ExcelBuf.SaveToStream(ReportInOutStream, true);
    end;

    var
        ExcelBuf: Record "Excel Buffer" temporary;
        ReportName: Label 'VAT Report';
        TenantMedia: Record "Tenant Media";
        OutStr: OutStream;
        Text101: Label 'Data';
        Text103: Label 'Company Name';
        Text102: Label 'VAT Report';
        Text104: Label 'Report No.';
        Text105: Label 'Report Name';
        Text106: Label 'User ID';
        Text107: Label 'Date / Time';
        Text108: Label 'Filter';
        VATFilters: Text;
        RowNumber: Integer;
        CheckList: List of [Text];
}
