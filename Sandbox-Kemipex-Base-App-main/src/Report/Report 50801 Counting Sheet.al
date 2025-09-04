report 50801 "Counting Sheet"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/CountingSheet.rdl';
    Caption = 'Kemipex Counting Sheet';
    PreviewMode = PrintLayout;

    dataset
    {
        dataitem(ItemJournalLine; "Item Journal Line")
        {

            DataItemTableView = sorting("Journal Template Name", "Journal Batch Name", "Line No.");
            RequestFilterFields = "Location Code";
            column(UserName; USERID) { }
            column(CompanyName; CompInfo.Name) { }
            column(VersionNo; VersionNo) { }
            column(Posting_Date; "Posting Date") { }
            column(JournalTemplateName; JournalTemplateName) { }
            column(Journal_Batch_Name; "Journal Batch Name") { }
            column(Line_No_; "Line No.") { }
            column(Document_No_; "Document No.") { }
            column(Location_Code; "Location Code") { }
            column(Item_No_; "Item No.") { }
            column(Variant_Code; "Variant Code") { }
            column(Description; Description) { }
            column(Lot_No__KMP; customlotNumber) { }
            column(CustomBOENumber; CustomBOENumber) { }
            column(SmallestPackingUOM; SmallestPackingUOM) { }
            column(Qty___Phys__Inventory_; "Qty. (Phys. Inventory)") { }
            column(ConvertionFactor; ConvertionFactor) { }
            column(Unit_of_Measure_Code; "Unit of Measure Code") { }
            column(Qty___Calculated_; "Qty. (Calculated)") { }
            column(QtyCalcSmallestPacking; QtyCalcSmallestPacking) { }

            column(ShowQtyCalc; ShowQtyCalc) { }

            column(Remarks; Remarks) { }
            column(Manufacturing_Date; "Manufacturing Date 2") { }
            column(Expiration_Period; format("Expiration Period")) { }
            column(ShowBOE; ShowBOE) { }

            trigger OnPreDataItem()
            var
                PhysInvtJournal: Record "Item Journal Line";
                UserSetup: Record "User Setup";
                CountSheet: Record "Counting DataSheet";
            begin

                SetRange("Journal Template Name", JournalTemplateName);
                SetRange("Journal Batch Name", JournalBatchName);
                SetRange("Document No.", DocNo);
                SetRange("Posting Date", PostingDate);

                Clear(ConvertionFactor);
                CurrVersionInt := VersionNo + 1;
                PrevVersionInt := VersionNo;

                Clear(ShowQtyCalc);
                UserSetup.Reset();
                UserSetup.SetRange("User ID", UserId);
                if UserSetup.FindFirst() then
                    ShowQtyCalc := UserSetup."Show Qty.Calc.(Counting Sheet)";

                case VersionNo of
                    VersionNo::"1":
                        ;
                    VersionNo::"2", VersionNo::"3":
                        begin
                            //>>PM
                            CountSheet.Reset();
                            CountSheet.SetRange("Journal Template Name", JournalTemplateName);
                            CountSheet.SetRange("Journal Batch Name", JournalBatchName);
                            CountSheet.SetRange("Document No.", DocNo);
                            CountSheet.SetRange("Posting Date", PostingDate);
                            CountSheet.SetFilter("Version No.", '%1', PrevVersionInt);
                            if not CountSheet.FindFirst() then
                                Error('Counting sheet for round %1 can not be generated because round %2 has not been completed', CurrVersionInt, PrevVersionInt);
                            //<<PM

                            // if ItemTemp.IsTemporary then
                            //     ItemTemp.DeleteAll();

                            if IJLtemp.IsTemporary then
                                IJLtemp.DeleteAll();

                            //find if any qty. difference
                            PhysInvtJournal.Reset();
                            PhysInvtJournal.SetCurrentKey("Journal Template Name", "Journal Batch Name", "Line No.");
                            PhysInvtJournal.SetRange("Journal Template Name", JournalTemplateName);
                            PhysInvtJournal.SetRange("Journal Batch Name", JournalBatchName);
                            PhysInvtJournal.SetRange("Document No.", DocNo);
                            PhysInvtJournal.SetRange("Posting Date", PostingDate);

                            if PhysInvtJournal.FindSet() then
                                repeat
                                    //>>PM temp
                                    //if PhysInvtJournal."Item No." = 'IT0000061' then begin
                                    //message('test');
                                    //end;
                                    //<<PM temp
                                    Clear(CountingDataSheet);
                                    if CountingDataSheet.Get(PhysInvtJournal."Journal Template Name", PhysInvtJournal."Journal Batch Name",
                                        PhysInvtJournal."Line No.", PhysInvtJournal."Document No.", PhysInvtJournal."Posting Date", PrevVersionInt) then begin

                                        if (PhysInvtJournal."Qty. (Calculated)" <> CountingDataSheet."Qty. Counted Base UOM") then begin

                                            IJLTemp.reset;
                                            IJLTemp.SetCurrentKey("Journal Template Name", "Journal Batch Name", "Line No.");
                                            IJLTemp.SetRange("Journal Template Name", PhysInvtJournal."Journal Template Name");
                                            IJLTemp.SetRange("Journal Batch Name", PhysInvtJournal."Journal Batch Name");
                                            IJLTemp.SetRange("Line No.", PhysInvtJournal."Line No.");
                                            if IJLTemp.IsEmpty then begin
                                                IJLTemp.Init();
                                                IJLTemp := PhysInvtJournal;
                                                IJLTemp.Insert();
                                            end
                                        end
                                    end;

                                until PhysInvtJournal.Next() = 0;

                            //find if there is any additional 
                            CountingDataSheet.Reset();
                            CountingDataSheet.SetRange("Journal Template Name", JournalTemplateName);
                            CountingDataSheet.SetRange("Journal Batch Name", JournalBatchName);
                            CountingDataSheet.SetRange("Document No.", DocNo);
                            CountingDataSheet.SetRange("Posting Date", PostingDate);
                            CountingDataSheet.SetRange("Version No.", PrevVersionInt);
                            CountingDataSheet.SetRange("Exist in Batch", false);
                            if CountingDataSheet.FindSet() then
                                repeat
                                    //>>PM temp
                                    //if CountingDataSheet."Item No." = 'IT0000061' then begin
                                    //message('test');
                                    //end;
                                    //<<PM temp
                                    IJLTemp.reset;
                                    IJLTemp.SetCurrentKey("Journal Template Name", "Journal Batch Name", "Line No.");
                                    IJLTemp.SetRange("Journal Template Name", CountingDataSheet."Journal Template Name");
                                    IJLTemp.SetRange("Journal Batch Name", CountingDataSheet."Journal Batch Name");
                                    IJLTemp.SetRange("Line No.", CountingDataSheet."Line No.");
                                    if IJLTemp.IsEmpty then begin
                                        IJLTemp.Init();
                                        IJLTemp."Journal Template Name" := CountingDataSheet."Journal Template Name";
                                        IJLTemp."Journal Batch Name" := CountingDataSheet."Journal Batch Name";
                                        IJLTemp."Line No." := CountingDataSheet."Line No.";
                                        IJLTemp."Document No." := CountingDataSheet."Document No.";
                                        IJLTemp."Posting Date" := CountingDataSheet."Posting Date";
                                        IJLTemp."Item No." := CountingDataSheet."Item No.";
                                        IJLTemp."Variant Code" := CountingDataSheet."Variant Code";

                                        IJLTemp."Location Code" := CountingDataSheet."Location Code";
                                        IJLTemp.Insert();
                                    end
                                until CountingDataSheet.Next() = 0;
                        end;

                end;

            end;

            trigger OnAfterGetRecord()
            var

            begin

                if VersionNo in [VersionNo::"2", VersionNo::"3"] then begin

                    IJLTemp.Reset();
                    IJLTemp.SetCurrentKey("Journal Template Name", "Journal Batch Name", "Line No.");
                    IJLTemp.SetRange("Journal Template Name", "Journal Template Name");
                    IJLTemp.SetRange("Journal Batch Name", "Journal Batch Name");
                    IJLTemp.SetRange("Item No.", "Item No.");
                    IJLTemp.SetRange("Variant Code", "Variant Code");
                    IJLTemp.SetRange("Location Code", "Location Code");
                    if not IJLTemp.FindFirst() then
                        //Error('Counting sheet for round %1 can not be generated because round %2 has not been completed', CurrVersionInt, PrevVersionInt);//PM commented
                    CurrReport.Skip(); //PM
                end;

                Clear(SmallestPackingUOM);
                Clear(ConvertionFactor);
                Clear(QtyCalcSmallestPacking);
                ItemUOM.Reset();
                ItemUOM.SetCurrentKey("Item No.", "Qty. per Unit of Measure");
                ItemUOM.SetRange("Item No.", "Item No.");
                if ItemUOM.FindFirst() then begin
                    SmallestPackingUOM := ItemUOM.Code;
                    ConvertionFactor := ItemUOM."Qty. per Unit of Measure";

                    IF ItemUOM."Qty. per Unit of Measure" <> 0 then
                        QtyCalcSmallestPacking := "Qty. (Calculated)" / ItemUOM."Qty. per Unit of Measure"
                    else
                        QtyCalcSmallestPacking := 0;
                end;


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
                    field("Round No."; "VersionNo")
                    {
                        ApplicationArea = All;
                    }
                    field("Show BOE No."; ShowBOE)
                    {
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

        ConvertionFactor:
                        Decimal;
        SmallestPackingUOM:
                        Code[10];

        Remarks:
                        Text;

        VersionNo:
                        Option "1","2","3";
        CountingDataSheet:
                        Record "Counting DataSheet";
        DocNo: Code[20];
        PostingDate: date;
        ItemTemp: Record Item temporary;

        ItemUOM: Record "Item Unit of Measure";
        QtyCalcSmallestPacking: Decimal;
        ShowQtyCalc: Boolean;

        CaptionName: Text;
        CurrVersionInt: Integer;
        PrevVersionInt: integer;
        IJLTemp: Record "Item Journal Line" temporary;
        ShowBOE: Boolean;


}