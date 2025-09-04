report 50804 PostedVarianceReport
{
    DefaultLayout = RDLC;
    UsageCategory = ReportsAndAnalysis;
    RDLCLayout = './Layouts/PostedVarianceReport.rdlc';
    Caption = 'Posted Variance Report';
    PreviewMode = PrintLayout;
    ApplicationArea = All;

    dataset
    {
        dataitem(IJLInt; Integer)
        {
            DataItemTableView = sorting(Number);
            // RequestFilterFields = "Item No.";
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
            column(LotNumber; LotNumber) { }
            column(CustomBOENumber; ItemJournalLineTmp.CustomBOENumber) { }
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
            column(DateTimeText; CurrentDateTime) { }
            trigger OnPreDataItem()
            var
                InvSetup: Record "Inventory Setup";
            begin
                //>>PM
                // InvSetup.get();
                // JournalTemplateName := InvSetup."Stock Count Template";
                //JournalBatchName := InvSetup."Stock Count Batch";
                //<<PM
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
                //>>PM
                CountDataSheet1.Reset();
                CountDataSheet1.SetCurrentKey("Journal Template Name", "Journal Batch Name", "Document No.", "Posting Date", "Version No.");
                CountDataSheet1.SetRange("Journal Template Name", ItemJournalLineTmp."Journal Template Name");
                CountDataSheet1.SetRange("Journal Batch Name", ItemJournalLineTmp."Journal Batch Name");
                CountDataSheet1.SetRange("Document No.", ItemJournalLineTmp."Document No.");
                CountDataSheet1.SetRange("Posting Date", ItemJournalLineTmp."Posting Date");
                CountDataSheet1.SetRange("Line No.", ItemJournalLineTmp."Line No.");
                if CountDataSheet1.FindLast() then
                    CurrVersionInt := CountDataSheet1."Version No.";
                //<<PM

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
                            /*                             case loop of
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
                                                        end; */
                        end;

                    end;
                end;
                LotNumber := ItemJournalLineTmp."Lot No. KMP";
                if STRPOS(ItemJournalLineTmp."Lot No. KMP", '@') <> 0 then
                    LotNumber := COPYSTR(ItemJournalLineTmp."Lot No. KMP", 1, STRPOS(ItemJournalLineTmp."Lot No. KMP", '@') - 1);
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
                    // field("Version No."; "VersionNoOpt")
                    // {
                    //     ApplicationArea = All;
                    //     Caption = 'Run Variance for Round No. ';
                    // }
                    field("Document No."; DocNo)
                    {
                        Caption = 'Document No.';
                        ApplicationArea = All;
                    }
                    field("Posting Date"; PostingDate)
                    {
                        Caption = 'Posting Date';
                        ApplicationArea = All;
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
        CompInfo.Get;
        //CurrVersionInt := VersionNoOpt + 1;
        CountingDataSheet.Reset();
        CountingDataSheet.SetCurrentKey("Journal Template Name", "Journal Batch Name", "Document No.", "Posting Date", "Version No.");
        CountingDataSheet.SetRange("Journal Template Name", JournalTemplateName);
        CountingDataSheet.SetRange("Journal Batch Name", JournalBatchName);
        CountingDataSheet.SetRange("Document No.", DocNo);
        CountingDataSheet.SetRange("Posting Date", PostingDate);
        if CountingDataSheet.FindLast() then
            CurrVersionInt := CountingDataSheet."Version No.";


        if ItemJournalLineTmp.IsTemporary then
            ItemJournalLineTmp.DeleteAll();

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
                //insert new line
                if CountingDataSheet."Version No." <= CurrVersionInt then begin
                    LineNoVersion += 1;
                    ItemJournalLineTmp.Init();
                    ItemJournalLineTmp.Validate("Journal Template Name", CountingDataSheet."Journal Template Name");
                    ItemJournalLineTmp.Validate("Journal Batch Name", CountingDataSheet."Journal Batch Name");
                    ItemJournalLineTmp.Validate("Line No.", LineNoVersion);//PM
                    //ItemJournalLineTmp.Validate("Line No.", CountingDataSheet."Line No.");//PM
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

                    //ItemJournalLineTmp.Validate("Qty. (Phys. Inventory)", CountingDataSheet."Qty. Counted Base UOM");
                    if CountingDataSheet."Version No." = 1 then//PM
                        ItemJournalLineTmp.Validate("Qty. (Calculated)", CountingDataSheet."Qty. Calc. Base UOM");

                    ItemJournalLineTmp.FromCountingSheet := true;
                    ItemJournalLineTmp.Insert(true);
                end
            //end;
            until CountingDataSheet.Next() = 0;

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
        ItemJournalLineTmp: Record "Item Journal Line" temporary;
        IJL: Record "Item Journal Line";
        LineNoVersion: Integer;
        LotNumber: Code[100];
        CountDataSheet1: Record "Counting DataSheet";

}