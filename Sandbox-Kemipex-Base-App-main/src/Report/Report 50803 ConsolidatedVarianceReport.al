report 50803 ConsolidatedVarianceReport
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/ConsolidatedVarianceReport.rdlc';
    Caption = 'ConsolidatedVarianceReport';
    PreviewMode = PrintLayout;

    dataset
    {
        dataitem(Company; Company)
        {

            dataitem(IJLInt; Integer)
            {
                // DataItemTableView = sorting("Journal Template Name", "Journal Batch Name", "Line No.");

                column(UserName; USERID) { }
                column(CompanyName; CompInfo.Name) { }
                column(Posting_Date; ItemJournalLineTmp."Posting Date") { }
                column(JournalTemplateName; ItemJournalLineTmp."Journal Template Name") { }
                column(Journal_Batch_Name; ItemJournalLineTmp."Journal Batch Name") { }
                column(Line_No_; ItemJournalLineTmp."Line No.") { }
                column(Document_No_; ItemJournalLineTmp."Document No.") { }
                column(Location_Code; ItemJournalLineTmp."Location Code") { }
                column(Item_No_; ItemJournalLineTmp."Item No.") { }
                column(Description; ItemJournalLineTmp.Description) { }
                column(VarianceCode; ItemJournalLineTmp."Variant Code") { }
                column(Lot_No__KMP; ItemJournalLineTmp."Lot No. KMP") { }
                column(Qty___Phys__Inventory_; ItemJournalLineTmp."Qty. (Phys. Inventory)") { }
                column(Unit_of_Measure_Code; ItemJournalLineTmp."Unit of Measure Code") { }
                column(Qty___Calculated_; ItemJournalLineTmp."Qty. (Calculated)") { }
                column(Quantity; ItemJournalLineTmp.Quantity) { }
                column(Unit_Cost; ItemJournalLineTmp."Unit Cost") { }
                column(Amount; ItemJournalLineTmp."Qty. (Calculated)" * ItemJournalLineTmp."Unit Cost") { }
                column(QtyCounted1; QtyCounted1) { }
                column(QtyCounted2; QtyCounted2) { }
                column(QtyCounted3; QtyCounted3) { }

                column(QtyVariance; QtyVariance) { }
                column(CostVariance; CostVariance) { }
                column(Remarks; Remarks) { }



                trigger OnPreDataItem()
                var
                begin

                    ItemJournalLineTmp.Reset();
                    SetRange(Number, 1, ItemJournalLineTmp.Count);
                end;

                trigger OnAfterGetRecord()
                var
                    loop: Integer;
                begin
                    if Number = 1 then
                        ItemJournalLineTmp.FindFirst()
                    else
                        ItemJournalLineTmp.next;


                    Clear(CountingDataSheet);
                    Clear(QtyCounted1);
                    Clear(QtyCounted2);
                    Clear(QtyCounted3);
                    Clear(Remarks);
                    Clear(QtyVariance);
                    Clear(CostVariance);

                    if ItemJournalLineTmp.FromCountingSheet then begin
                        CountingDataSheet.Reset();
                        CountingDataSheet.SetRange("Journal Template Name", ItemJournalLineTmp."Journal Template Name");
                        CountingDataSheet.SetRange("Journal Batch Name", ItemJournalLineTmp."Journal Batch Name");
                        CountingDataSheet.SetRange("Line No.", ItemJournalLineTmp."Order Line No.");
                        CountingDataSheet.SetRange("Version No.", ItemJournalLineTmp."Document Line No.");
                        CountingDataSheet.SetRange("Document No.", ItemJournalLineTmp."Document No.");
                        CountingDataSheet.SetRange("Posting Date", ItemJournalLineTmp."Posting Date");
                        if CountingDataSheet.FindFirst() then begin
                            case ItemJournalLineTmp."Document Line No." of //check version
                                1:
                                    begin

                                        QtyCounted1 := CountingDataSheet."Qty. Counted Base UOM";
                                        if ItemJournalLineTmp."Document Line No." = CurrVersionInt then begin
                                            QtyVariance := QtyCounted1 - ItemJournalLineTmp."Qty. (Calculated)";
                                            CostVariance := QtyVariance * ItemJournalLineTmp."Unit Cost";
                                        end
                                    end;
                                2:
                                    begin

                                        QtyCounted2 := CountingDataSheet."Qty. Counted Base UOM";
                                        if ItemJournalLineTmp."Document Line No." = CurrVersionInt then begin
                                            QtyVariance := QtyCounted2 - ItemJournalLineTmp."Qty. (Calculated)";
                                            CostVariance := QtyVariance * ItemJournalLineTmp."Unit Cost";
                                        end;

                                    end;
                                3:
                                    begin

                                        QtyCounted3 := CountingDataSheet."Qty. Counted Base UOM";
                                        if ItemJournalLineTmp."Document Line No." = CurrVersionInt then begin
                                            QtyVariance := QtyCounted3 - ItemJournalLineTmp."Qty. (Calculated)";
                                            CostVariance := QtyVariance * ItemJournalLineTmp."Unit Cost";
                                        end;
                                    end;
                            end;
                        end;

                    end else begin

                        for loop := 1 to CurrVersionInt do begin
                            if CountingDataSheet.Get(ItemJournalLineTmp."Journal Template Name", ItemJournalLineTmp."Journal Batch Name",
                             ItemJournalLineTmp."Line No.", ItemJournalLineTmp."Document No.", ItemJournalLineTmp."Posting Date", loop) then begin
                                case loop of
                                    1:
                                        begin
                                            QtyCounted1 := CountingDataSheet."Qty. Counted Base UOM";
                                            QtyVariance := QtyCounted1 - ItemJournalLineTmp."Qty. (Calculated)";
                                            CostVariance := QtyVariance * ItemJournalLineTmp."Unit Cost";
                                        end;
                                    2:
                                        begin
                                            QtyCounted2 := CountingDataSheet."Qty. Counted Base UOM";
                                            QtyVariance := QtyCounted2 - ItemJournalLineTmp."Qty. (Calculated)";
                                            CostVariance := QtyVariance * ItemJournalLineTmp."Unit Cost";

                                        end;
                                    3:
                                        begin
                                            QtyCounted3 := CountingDataSheet."Qty. Counted Base UOM";
                                            QtyVariance := QtyCounted3 - ItemJournalLineTmp."Qty. (Calculated)";
                                            CostVariance := QtyVariance * ItemJournalLineTmp."Unit Cost";
                                        end;
                                end;

                                Remarks := CountingDataSheet.Remarks;
                            end else begin
                                case loop of
                                    1:
                                        begin
                                            QtyCounted1 := ItemJournalLineTmp."Qty. (Calculated)";
                                            QtyVariance := QtyCounted1 - ItemJournalLineTmp."Qty. (Calculated)";
                                            CostVariance := QtyVariance * ItemJournalLineTmp."Unit Cost";
                                        end;
                                    2:
                                        begin
                                            QtyCounted2 := ItemJournalLineTmp."Qty. (Calculated)";
                                            QtyVariance := QtyCounted2 - ItemJournalLineTmp."Qty. (Calculated)";
                                            CostVariance := QtyVariance * ItemJournalLineTmp."Unit Cost";

                                        end;
                                    3:
                                        begin
                                            QtyCounted3 := ItemJournalLineTmp."Qty. (Calculated)";
                                            QtyVariance := QtyCounted3 - ItemJournalLineTmp."Qty. (Calculated)";
                                            CostVariance := QtyVariance * ItemJournalLineTmp."Unit Cost";
                                        end;
                                end;
                            end;

                        end;
                    end;

                end;

            }

            trigger OnAfterGetRecord()
            begin
                CompInfo.ChangeCompany(Company.Name);
                CompInfo.Get;
                CurrVersionInt := VersionNoOpt + 1;

                if ItemJournalLineTmp.IsTemporary then
                    ItemJournalLineTmp.DeleteAll();

                IJL.ChangeCompany(Company.Name);

                IJL.Reset();
                IJL.SetCurrentKey("Journal Template Name", "Journal Batch Name", "Line No.");
                IJL.SetRange("Journal Template Name", JournalTemplateName);
                IJL.SetRange("Journal Batch Name", JournalBatchName);
                IJL.SetRange("Document No.", DocNo);
                IJL.SetRange("Posting Date", PostingDate);
                If IJL.FindSet() then
                    repeat
                        ItemJournalLineTmp.Init();
                        ItemJournalLineTmp := IJL;
                        ItemJournalLineTmp.Insert();

                    until IJL.Next() = 0;

                Clear(LineNoVersion);
                CountingDataSheet.ChangeCompany(Company.Name);
                CountingDataSheet.Reset();
                CountingDataSheet.SetCurrentKey("Journal Template Name", "Journal Batch Name", "Line No.", "Document No.", "Posting Date", "Version No.");
                CountingDataSheet.SetRange("Journal Template Name", JournalTemplateName);
                CountingDataSheet.SetRange("Journal Batch Name", JournalBatchName);
                CountingDataSheet.SetRange("Document No.", DocNo);
                CountingDataSheet.SetRange("Posting Date", PostingDate);
                // CountingDataSheet.SetRange("Version No.", CurrVersionInt);
                CountingDataSheet.SetRange("Exist in Batch", false);
                if CountingDataSheet.FindSet() then
                    repeat
                        if CountingDataSheet."Version No." <= CurrVersionInt then begin
                            //insert new line
                            LineNoVersion += 1;
                            ItemJournalLineTmp.Init();
                            ItemJournalLineTmp.Validate("Journal Template Name", CountingDataSheet."Journal Template Name");
                            ItemJournalLineTmp.Validate("Journal Batch Name", CountingDataSheet."Journal Batch Name");
                            ItemJournalLineTmp.Validate("Line No.", LineNoVersion);
                            ItemJournalLineTmp."Order Line No." := CountingDataSheet."Line No.";  //original line no.
                            ItemJournalLineTmp."Document Line No." := CountingDataSheet."Version No."; //version
                            ItemJournalLineTmp.Validate("Posting Date", CountingDataSheet."Posting Date");
                            ItemJournalLineTmp.Validate("Document No.", CountingDataSheet."Document No.");
                            ItemJournalLineTmp.Validate("Item No.", CountingDataSheet."Item No.");
                            ItemJournalLineTmp.Validate("Variant Code", CountingDataSheet."Variant Code");
                            ItemJournalLineTmp.Validate("Location Code", CountingDataSheet."Location Code");
                            ItemJournalLineTmp.Validate(Description, CountingDataSheet.Description);

                            ItemJournalLineTmp.Validate("Lot No. KMP", CountingDataSheet."Lot No.");

                            ItemJournalLineTmp.Validate("Unit of Measure Code", CountingDataSheet."Base UOM");

                            ItemJournalLineTmp."Phys. Inventory" := true;

                            ItemJournalLineTmp.Validate("Qty. (Phys. Inventory)", CountingDataSheet."Qty. Counted Base UOM");

                            ItemJournalLineTmp.FromCountingSheet := true;
                            ItemJournalLineTmp.Insert(true);
                        end;
                    //end;
                    until CountingDataSheet.Next() = 0;



            end;


        }

    }


    requestpage
    {

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field("Version No."; "VersionNoOpt")
                    {
                        ApplicationArea = All;
                        Caption = 'Run Variance for Version ';
                    }
                }
            }
        }

    }

    labels
    {
    }

    trigger OnPreReport()
    begin

    end;

    procedure SetParam(pJournalTemplateName: Code[10];
                    pJournalBatchName:
                        Code[10]; pDocNo: Code[20]; pPostingDate: Date)
    begin
        JournalTemplateName := pJournalTemplateName;
        JournalBatchName := pJournalBatchName;
        DocNo := pDocNo;
        PostingDate := pPostingDate;
    end;

    var

        CompInfo: Record "Company Information";
        JournalTemplateName:
                        code[10];
        JournalBatchName:
                        Code[10];
        Remarks:
                        Text;

        CountingDataSheet:
                        Record "Counting DataSheet";
        DocNo: Code[20];
        PostingDate: date;

        ShowQtyCalc: Boolean;

        CaptionName: Text;
        QtyCounted1: Decimal;
        QtyCounted2: Decimal;
        QtyCounted3: Decimal;
        LineNo: integer;

        VersionNoOpt: option "1","2","3";
        CurrVersionInt: Integer;

        QtyVariance: Decimal;
        CostVariance: Decimal;

        TotalCompany: integer;
        TotalAmount: Decimal;

        ItemJournalLineTmp: Record "Item Journal Line" temporary;
        IJL: Record "Item Journal Line";

        LineNoVersion: Integer;
}