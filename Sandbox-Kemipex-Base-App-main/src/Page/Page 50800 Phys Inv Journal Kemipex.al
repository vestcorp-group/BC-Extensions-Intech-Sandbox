page 50800 "Phys. Inv. Journal Kemipex"
{
    AdditionalSearchTerms = 'Phys. Inv. Journal Kemipex';
    ApplicationArea = Basic, Suite;
    AutoSplitKey = true;
    Caption = 'Physical Inventory Journals Kemipex';
    DataCaptionFields = "Journal Batch Name";
    DelayedInsert = true;
    PageType = Worksheet;
    PromotedActionCategories = 'New,Process,Report,Post/Print,Prepare,Line,Item,Item Availability by,Kemipex';
    SaveValues = true;
    SourceTable = "Item Journal Line";
    UsageCategory = Tasks;
    // Editable = false;
    // InsertAllowed = false;
    // ModifyAllowed = false;
    // DeleteAllowed = false;

    layout
    {
        area(content)
        {
            field(CurrentJnlBatchName; CurrentJnlBatchName)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Batch Name';
                Lookup = true;
                Enabled = false;
                ToolTip = 'Specifies the name of the journal batch, a personalized journal layout, that the journal is based on.';

                trigger OnLookup(var Text: Text): Boolean
                begin
                    CurrPage.SaveRecord;
                    ItemJnlMgt.LookupName(CurrentJnlBatchName, Rec);
                    CurrPage.Update(false);
                end;

                trigger OnValidate()
                begin
                    ItemJnlMgt.CheckName(CurrentJnlBatchName, Rec);
                    CurrentJnlBatchNameOnAfterVali;
                end;
            }
            repeater(Control1)
            {
                ShowCaption = false;
                Editable = false;

                field("Posting Date"; rec."Posting Date")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the posting date for the entry.';
                }
                field("Document Date"; rec."Document Date")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the date when the related document was created.';
                    Visible = false;
                }
                field("Entry Type"; rec."Entry Type")
                {
                    ApplicationArea = Basic, Suite;
                    // OptionCaption = 'Purchase,Sale,Positive Adjmt.,Negative Adjmt.';
                    ToolTip = 'Specifies the type of transaction that will be posted from the item journal line.';
                }
                field("Document No."; rec."Document No.")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies a document number for the journal line.';
                    ShowMandatory = true;
                }
                field("Item No."; rec."Item No.")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the number of the item on the journal line.';

                    trigger OnValidate()
                    begin
                        ItemJnlMgt.GetItem(rec."Item No.", ItemDescription);
                        rec.ShowShortcutDimCode(ShortcutDimCode);
                    end;
                }
                field("Variant Code"; rec."Variant Code")
                {
                    ApplicationArea = Planning;
                    ToolTip = 'Specifies the variant of the item on the line.';
                    // Visible = false;
                    Visible = true;
                }
                field(Description; rec.Description)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies a description of the item on the journal line.';
                }
                field("Location Code"; rec."Location Code")
                {
                    ApplicationArea = Location;
                    ToolTip = 'Specifies the code for the inventory location where the item on the journal line will be registered.';
                    Visible = true;

                    trigger OnValidate()
                    var
                        WMSManagement: Codeunit "WMS Management";
                    begin
                        WMSManagement.CheckItemJnlLineLocation(Rec, xRec);
                    end;
                }
                field("Bin Code"; rec."Bin Code")
                {
                    ApplicationArea = Warehouse;
                    ToolTip = 'Specifies the bin where the items are picked or put away.';
                    Visible = false;
                }
                field("Salespers./Purch. Code"; rec."Salespers./Purch. Code")
                {
                    ApplicationArea = Suite;
                    ToolTip = 'Specifies the code for the salesperson or purchaser who is linked to the sale or purchase on the journal line.';
                }
                field("Gen. Bus. Posting Group"; rec."Gen. Bus. Posting Group")
                {
                    ApplicationArea = Suite;
                    ToolTip = 'Specifies the vendor''s or customer''s trade type to link transactions made for this business partner with the appropriate general ledger account according to the general posting setup.';
                    Visible = false;
                }
                field("Gen. Prod. Posting Group";
                Rec."Gen. Prod. Posting Group")
                {
                    ApplicationArea = Suite;
                    ToolTip = 'Specifies the item''s product type to link transactions made for this item with the appropriate general ledger account according to the general posting setup.';
                    Visible = false;
                }
                field("Lot No. KMP"; Rec."Lot No. KMP")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies Lot No. KMP';

                }
                field("Custom Lot No."; Rec.CustomLotNumber)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies Custom Lot No.';
                }
                field("Custom BOE No."; Rec.CustomBOENumber)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies Custom BOE No.';
                }
                field("Qty. (Calculated)"; Rec."Qty. (Calculated)")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the quantity on hand of the item.';
                }
                field("Qty. (Phys. Inventory)"; Rec."Qty. (Phys. Inventory)")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the quantity on hand of the item as determined from a physical count.';
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    ToolTip = 'Specifies the number of units of the item to be included on the journal line.';
                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                    ApplicationArea = Suite;
                    ToolTip = 'Specifies how each unit of the item or resource is measured, such as in pieces or hours. By default, the value in the Base Unit of Measure field on the item or resource card is inserted.';
                    Visible = false;
                }
                field("Unit Amount"; Rec."Unit Amount")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the price of one unit of the item on the journal line.';
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the line''s net amount.';
                }
                field("Indirect Cost %"; Rec."Indirect Cost %")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the percentage of the item''s last purchase cost that includes indirect costs, such as freight that is associated with the purchase of the item.';
                    Visible = false;
                }
                field("Unit Cost"; Rec."Unit Cost")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the cost of one unit of the item or resource on the line.';
                }
                field("Applies-to Entry"; Rec."Applies-to Entry")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies if the quantity on the journal line must be applied to an already-posted entry. In that case, enter the entry number that the quantity will be applied to.';
                }
                field("Reason Code"; Rec."Reason Code")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the reason code, a supplementary source code that enables you to trace the entry.';
                    Visible = false;
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = Dimensions;
                    ToolTip = 'Specifies the code for Shortcut Dimension 1, which is one of two global dimension codes that you set up in the General Ledger Setup window.';
                    Visible = DimVisible1;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = Dimensions;
                    ToolTip = 'Specifies the code for Shortcut Dimension 2, which is one of two global dimension codes that you set up in the General Ledger Setup window.';
                    Visible = DimVisible2;
                }
                field(ShortcutDimCode3; ShortcutDimCode[3])
                {
                    ApplicationArea = Dimensions;
                    CaptionClass = '1,2,3';
                    TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(3),
                                                                  "Dimension Value Type" = CONST(Standard),
                                                                  Blocked = CONST(false));
                    Visible = DimVisible3;

                    trigger OnValidate()
                    begin
                        Rec.ValidateShortcutDimCode(3, ShortcutDimCode[3]);

                        OnAfterValidateShortcutDimCode(Rec, ShortcutDimCode, 3);
                    end;
                }
                field(ShortcutDimCode4; ShortcutDimCode[4])
                {
                    ApplicationArea = Dimensions;
                    CaptionClass = '1,2,4';
                    TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(4),
                                                                  "Dimension Value Type" = CONST(Standard),
                                                                  Blocked = CONST(false));
                    Visible = DimVisible4;

                    trigger OnValidate()
                    begin
                        Rec.ValidateShortcutDimCode(4, ShortcutDimCode[4]);

                        OnAfterValidateShortcutDimCode(Rec, ShortcutDimCode, 4);
                    end;
                }
                field(ShortcutDimCode5; ShortcutDimCode[5])
                {
                    ApplicationArea = Dimensions;
                    CaptionClass = '1,2,5';
                    TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(5),
                                                                  "Dimension Value Type" = CONST(Standard),
                                                                  Blocked = CONST(false));
                    Visible = DimVisible5;

                    trigger OnValidate()
                    begin
                        Rec.ValidateShortcutDimCode(5, ShortcutDimCode[5]);

                        OnAfterValidateShortcutDimCode(Rec, ShortcutDimCode, 5);
                    end;
                }
                field(ShortcutDimCode6; ShortcutDimCode[6])
                {
                    ApplicationArea = Dimensions;
                    CaptionClass = '1,2,6';
                    TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(6),
                                                                  "Dimension Value Type" = CONST(Standard),
                                                                  Blocked = CONST(false));
                    Visible = DimVisible6;

                    trigger OnValidate()
                    begin
                        Rec.ValidateShortcutDimCode(6, ShortcutDimCode[6]);

                        OnAfterValidateShortcutDimCode(Rec, ShortcutDimCode, 6);
                    end;
                }
                field(ShortcutDimCode7; ShortcutDimCode[7])
                {
                    ApplicationArea = Dimensions;
                    CaptionClass = '1,2,7';
                    TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(7),
                                                                  "Dimension Value Type" = CONST(Standard),
                                                                  Blocked = CONST(false));
                    Visible = DimVisible7;

                    trigger OnValidate()
                    begin
                        Rec.ValidateShortcutDimCode(7, ShortcutDimCode[7]);

                        OnAfterValidateShortcutDimCode(Rec, ShortcutDimCode, 7);
                    end;
                }
                field(ShortcutDimCode8; ShortcutDimCode[8])
                {
                    ApplicationArea = Dimensions;
                    CaptionClass = '1,2,8';
                    TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(8),
                                                                  "Dimension Value Type" = CONST(Standard),
                                                                  Blocked = CONST(false));
                    Visible = DimVisible8;

                    trigger OnValidate()
                    begin
                        Rec.ValidateShortcutDimCode(8, ShortcutDimCode[8]);

                        OnAfterValidateShortcutDimCode(Rec, ShortcutDimCode, 8);
                    end;
                }
                field("Manufacturing Date"; rec."Manufacturing Date 2")
                {
                    ApplicationArea = All;

                }
                field("Expiration Period"; Rec."Expiration Period")
                {
                    ApplicationArea = All;

                }
            }
            group(Control22)
            {
                ShowCaption = false;
                fixed(Control1900669001)
                {
                    ShowCaption = false;
                    group("Item Description")
                    {
                        Caption = 'Item Description';
                        field(ItemDescription; ItemDescription)
                        {
                            ApplicationArea = Basic, Suite;
                            Editable = false;
                            ShowCaption = false;
                            ToolTip = 'Specifies a description of the item.';
                        }
                    }
                }
            }
        }
        area(factboxes)
        {
            systempart(Control1900383207; Links)
            {
                ApplicationArea = RecordLinks;
                Visible = false;
            }
            systempart(Control1905767507; Notes)
            {
                ApplicationArea = Notes;
                Visible = false;
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Line")
            {
                Caption = '&Line';
                Image = Line;
                action(Dimensions)
                {
                    AccessByPermission = TableData Dimension = R;
                    ApplicationArea = Dimensions;
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    Promoted = true;
                    PromotedCategory = Category6;
                    Scope = Repeater;
                    ShortCutKey = 'Alt+D';
                    ToolTip = 'View or edit dimensions, such as area, project, or department, that you can assign to sales and purchase documents to distribute costs and analyze transaction history.';

                    trigger OnAction()
                    begin
                        Rec.ShowDimensions();
                        CurrPage.SaveRecord;
                    end;
                }
                action("Item &Tracking Lines")
                {
                    ApplicationArea = ItemTracking;
                    Caption = 'Item &Tracking Lines';
                    Image = ItemTrackingLines;
                    Promoted = true;
                    PromotedCategory = Category6;
                    Scope = Repeater;
                    ShortCutKey = 'Shift+Ctrl+I';
                    ToolTip = 'View or edit serial numbers and lot numbers that are assigned to the item on the document or journal line.';

                    trigger OnAction()
                    begin
                        Rec.OpenItemTrackingLines(false);
                    end;
                }
                action("Bin Contents")
                {
                    ApplicationArea = Warehouse;
                    Caption = 'Bin Contents';
                    Image = BinContent;
                    Promoted = true;
                    PromotedCategory = Category6;
                    RunObject = Page "Bin Contents List";
                    RunPageLink = "Location Code" = FIELD("Location Code"),
                                  "Item No." = FIELD("Item No."),
                                  "Variant Code" = FIELD("Variant Code");
                    RunPageView = SORTING("Location Code", "Item No.", "Variant Code");
                    Scope = Repeater;
                    ToolTip = 'View items in the bin if the selected line contains a bin code.';
                }
            }
            group("&Item")
            {
                Caption = '&Item';
                Image = Item;
                action(Card)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Card';
                    Image = EditLines;
                    Promoted = true;
                    PromotedCategory = Category7;
                    RunObject = Page "Item Card";
                    RunPageLink = "No." = FIELD("Item No.");
                    Scope = Repeater;
                    ShortCutKey = 'Shift+F7';
                    ToolTip = 'View or change detailed information about the record on the document or journal line.';
                }
                action("Ledger E&ntries")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Ledger E&ntries';
                    Image = CustomerLedger;
                    Promoted = true;
                    PromotedCategory = Category7;
                    RunObject = Page "Item Ledger Entries";
                    RunPageLink = "Item No." = FIELD("Item No.");
                    RunPageView = SORTING("Item No.");
                    Scope = Repeater;
                    ShortCutKey = 'Ctrl+F7';
                    ToolTip = 'View the history of transactions that have been posted for the selected record.';
                }
                action("Phys. In&ventory Ledger Entries")
                {
                    ApplicationArea = Warehouse;
                    Caption = 'Phys. In&ventory Ledger Entries';
                    Image = PhysicalInventoryLedger;
                    Promoted = true;
                    PromotedCategory = Category7;
                    RunObject = Page "Phys. Inventory Ledger Entries";
                    RunPageLink = "Item No." = FIELD("Item No.");
                    RunPageView = SORTING("Item No.");
                    Scope = Repeater;
                    ToolTip = 'Show the ledger entries for the current journal line.';
                }
                group("Item Availability by")
                {
                    Caption = 'Item Availability by';
                    Image = ItemAvailability;
                    action("Event")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Event';
                        Image = "Event";
                        Promoted = true;
                        PromotedCategory = Category8;
                        Scope = Repeater;
                        ToolTip = 'View how the actual and the projected available balance of an item will develop over time according to supply and demand events.';

                        trigger OnAction()
                        begin
                            ItemAvailFormsMgt.ShowItemAvailFromItemJnlLine(Rec, ItemAvailFormsMgt.ByEvent)
                        end;
                    }
                    action(Period)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Period';
                        Image = Period;
                        Promoted = true;
                        PromotedCategory = Category8;
                        Scope = Repeater;
                        ToolTip = 'Show the projected quantity of the item over time according to time periods, such as day, week, or month.';

                        trigger OnAction()
                        begin
                            ItemAvailFormsMgt.ShowItemAvailFromItemJnlLine(Rec, ItemAvailFormsMgt.ByPeriod)
                        end;
                    }
                    action(Variant)
                    {
                        ApplicationArea = Planning;
                        Caption = 'Variant';
                        Image = ItemVariant;
                        Promoted = true;
                        PromotedCategory = Category8;
                        Scope = Repeater;
                        ToolTip = 'View or edit the item''s variants. Instead of setting up each color of an item as a separate item, you can set up the various colors as variants of the item.';

                        trigger OnAction()
                        begin
                            ItemAvailFormsMgt.ShowItemAvailFromItemJnlLine(Rec, ItemAvailFormsMgt.ByVariant)
                        end;
                    }
                    action(Location)
                    {
                        AccessByPermission = TableData Location = R;
                        ApplicationArea = Location;
                        Caption = 'Location';
                        Image = Warehouse;
                        Promoted = true;
                        PromotedCategory = Category8;
                        Scope = Repeater;
                        ToolTip = 'View the actual and projected quantity of the item per location.';

                        trigger OnAction()
                        begin
                            ItemAvailFormsMgt.ShowItemAvailFromItemJnlLine(Rec, ItemAvailFormsMgt.ByLocation)
                        end;
                    }
                    action("BOM Level")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'BOM Level';
                        Image = BOMLevel;
                        Promoted = true;
                        PromotedCategory = Category8;
                        Scope = Repeater;
                        ToolTip = 'View availability figures for items on bills of materials that show how many units of a parent item you can make based on the availability of child items.';

                        trigger OnAction()
                        begin
                            ItemAvailFormsMgt.ShowItemAvailFromItemJnlLine(Rec, ItemAvailFormsMgt.ByBOM)
                        end;
                    }
                }
            }
        }
        area(processing)
        {
            group("F&unctions")
            {
                Caption = 'F&unctions';
                Image = "Action";
                action(CalculateInventory)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Calculate &Inventory';
                    Ellipsis = true;
                    Image = CalculateInventory;
                    Promoted = true;
                    PromotedCategory = Category5;
                    Scope = Repeater;
                    ToolTip = 'Start the process of counting inventory by filling the journal with known quantities.';

                    trigger OnAction()
                    begin
                        CalcQtyOnHand.SetItemJnlLine(Rec);
                        CalcQtyOnHand.RunModal;
                        Clear(CalcQtyOnHand);
                    end;
                }
                action(CalculateCountingPeriod)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = '&Calculate Counting Period';
                    Ellipsis = true;
                    Image = CalculateCalendar;
                    Promoted = true;
                    PromotedCategory = Category5;
                    Scope = Repeater;
                    ToolTip = 'Show all items that a counting period has been assigned to, according to the counting period, the last counting period update, and the current work date.';

                    trigger OnAction()
                    var
                        PhysInvtCountMgt: Codeunit "Phys. Invt. Count.-Management";
                    begin
                        PhysInvtCountMgt.InitFromItemJnl(Rec);
                        PhysInvtCountMgt.Run;
                        Clear(PhysInvtCountMgt);
                    end;
                }

            }
            group(Kemipex)
            {
                action(CalculateInventoryWithLot)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Calculate &Inventory With Lot';
                    Ellipsis = true;
                    Image = CalculatePlan;
                    Promoted = true;
                    PromotedCategory = Category9;
                    Scope = Repeater;
                    ToolTip = 'Start the process of counting inventory by filling the journal with known quantities.';

                    trigger OnAction()
                    var
                        CalcQtyOnHand: Report "Calculate Inventory With Lot";
                    begin
                        CheckValidation(Rec);
                        CalcQtyOnHand.SetItemJnlLine(Rec);
                        CalcQtyOnHand.RunModal;
                        Clear(CalcQtyOnHand);
                    end;
                }


                action(CountingDataSheet)
                {
                    ApplicationArea = All;
                    Image = Print;
                    Caption = 'Print/Export Counting Sheet';
                    Promoted = true;
                    PromotedIsBig = true;
                    PromotedCategory = Category9;
                    trigger OnAction()
                    var
                        CountingSheet: Report "Counting Sheet";
                    begin
                        Clear(CountingSheet);
                        CountingSheet.SetParam(Rec."Journal Template Name", Rec."Journal Batch Name", Rec."Document No.", Rec."Posting Date");
                        CountingSheet.Run();
                    end;

                }
                // action(ImportCountingSheet)//T12370-Full Comment
                // {
                //     ApplicationArea = All;
                //     Image = Excel;
                //     Caption = 'Import Counting Sheet';
                //     Promoted = true;
                //     PromotedIsBig = true;
                //     PromotedCategory = Category9;


                //     trigger OnAction()
                //     var
                //         PhysInvtJnlMgt: Codeunit PhysInvtJnlMgt;
                //     begin
                //         PhysInvtJnlMgt.ImportItemJournalFromExcel(Rec."Journal Template Name", Rec."Journal Batch Name", rec."Document No.", rec."Posting Date");

                //     end;
                // }
                action(ShowCountingDataSheet)
                {
                    ApplicationArea = All;
                    Image = ListPage;
                    Caption = 'Show Counting DataSheet';
                    Promoted = true;
                    PromotedIsBig = true;
                    PromotedCategory = Category9;
                    trigger OnAction()
                    var
                        CountingDataSheetRec: Record "Counting DataSheet";
                        CountingDataSheetPage: Page "Counting DataSheet";
                    begin
                        CountingDataSheetRec.Reset();
                        CountingDataSheetRec.SetRange("Journal Template Name", Rec."Journal Template Name");
                        CountingDataSheetRec.SetRange("Journal Batch Name", Rec."Journal Batch Name");
                        CountingDataSheetRec.FilterGroup(2);//PM
                        CountingDataSheetRec.SetRange("Document No.", Rec."Document No.");
                        CountingDataSheetRec.FilterGroup(0);//PM
                        if CountingDataSheetRec.FindSet() then begin //PM

                            CountingDataSheetPage.SetTableView(CountingDataSheetRec);
                            CountingDataSheetPage.SetRecord(CountingDataSheetRec);
                            CountingDataSheetPage.Run();
                        end else
                            Error('Record does not exist for document no. %1', Rec."Document No.");//PM
                    end;

                }

                // action("Register Counting Sheet")//T12370-Full Comment
                // {
                //     ApplicationArea = All;
                //     Image = RegisteredDocs;
                //     Caption = 'Register Counting Sheet';
                //     Promoted = true;
                //     PromotedIsBig = true;
                //     PromotedCategory = Category9;
                //     trigger OnAction()
                //     var
                //         PhysInvtJnlMgt: Codeunit PhysInvtJnlMgt;
                //         CountingDataSheet: Record "Counting DataSheet";
                //     begin

                //         //>>PM
                //         CountingDataSheet.Reset();

                //         CountingDataSheet.SetRange("Document No.", rec."Document No.");
                //         CountingDataSheet.SetRange(Status, CountingDataSheet.Status::Registered);
                //         if CountingDataSheet.FindFirst() then
                //             Error('All records are already registered for posting');
                //         //<<PM


                //         PhysInvtJnlMgt.RegisterCountingDataSheet(Rec."Journal Template Name", Rec."Journal Batch Name", Rec."Document No.", Rec."Posting Date");
                //     end;
                // }

                action("Delete All Lines")
                {
                    ApplicationArea = All;
                    Image = Delete;
                    Caption = 'Delete All Lines';
                    Promoted = true;
                    PromotedIsBig = true;
                    PromotedCategory = Category9;
                    trigger OnAction()
                    var
                        ItemJournalLine: Record "Item Journal Line";
                        CountingDataSheet: Record "Counting DataSheet";
                        ReservationEntry: Record "Reservation Entry";
                        ReserveItemJnlLine: Codeunit "Item Jnl. Line-Reserve";

                    begin
                        if Confirm('This action will delete all lines in %1 batch %2 and related counting datasheet. Continue?', false, Rec."Journal Template Name", Rec."Journal Batch Name") then begin
                            ItemJournalLine.Reset();
                            ItemJournalLine.SetCurrentKey("Document No.", "Document Line No.", "Line No.");
                            ItemJournalLine.SetRange("Journal Template Name", Rec."Journal Template Name");
                            ItemJournalLine.SetRange("Journal Batch Name", Rec."Journal Batch Name");
                            ItemJournalLine.SetRange("Document No.", Rec."Document No.");
                            ItemJournalLine.SetRange("Posting Date", Rec."Posting Date");
                            if ItemJournalLine.findset then
                                repeat
                                    //if ItemJournalLine.FromCountingSheet then
                                    DeleteReservationLine(ItemJournalLine);
                                    ItemJournalLine.Delete(true);
                                until ItemJournalLine.Next() = 0;

                            CountingDataSheet.Reset();
                            CountingDataSheet.SetCurrentKey("Journal Template Name", "Journal Batch Name", "Line No.", "Document No.", "Posting Date", "Version No.");
                            CountingDataSheet.SetRange("Journal Template Name", Rec."Journal Template Name");
                            CountingDataSheet.SetRange("Journal Batch Name", Rec."Journal Batch Name");
                            CountingDataSheet.SetRange("Document No.", Rec."Document No.");
                            CountingDataSheet.SetRange("Posting Date", Rec."Posting Date");
                            IF CountingDataSheet.FindSet() then
                                CountingDataSheet.DeleteAll(true);//PM Param True Added

                        end;
                    end;
                }

                action("Variance Report")
                {
                    ApplicationArea = All;
                    Image = Report;
                    Caption = 'Variance Report';
                    Promoted = true;
                    PromotedIsBig = true;
                    PromotedCategory = Category9;
                    trigger OnAction()
                    var
                        ItemJournalLine: Record "Item Journal Line";
                        VarianceReport: Report VarianceReport;
                    begin

                        Clear(VarianceReport);
                        VarianceReport.SetParam(Rec."Journal Template Name", Rec."Journal Batch Name", Rec."Document No.", Rec."Posting Date");
                        VarianceReport.Run();
                    end;
                }

                action("Consolidated Variance Report")
                {
                    ApplicationArea = All;
                    Image = Report;
                    Caption = 'Consolidated Variance Report';
                    Promoted = true;
                    PromotedIsBig = true;
                    PromotedCategory = Category9;
                    trigger OnAction()
                    var
                        ItemJournalLine: Record "Item Journal Line";
                        VarianceReport: Report ConsolidatedVarianceReport;
                    begin
                        Clear(VarianceReport);
                        VarianceReport.SetParam(Rec."Journal Template Name", Rec."Journal Batch Name", Rec."Document No.", Rec."Posting Date");
                        VarianceReport.Run();
                    end;
                }
            }
            action(Print)
            {
                ApplicationArea = Basic, Suite;
                Caption = '&Print';
                Ellipsis = true;
                Image = Print;
                Promoted = true;
                PromotedCategory = Category4;
                Scope = Repeater;
                ToolTip = 'Prepare to print the document. A report request window for the document opens where you can specify what to include on the print-out.';

                trigger OnAction()
                begin
                    ItemJournalBatch.SetRange("Journal Template Name", Rec."Journal Template Name");
                    ItemJournalBatch.SetRange(Name, Rec."Journal Batch Name");
                    REPORT.RunModal(REPORT::"Phys. Inventory List", true, false, ItemJournalBatch);
                end;
            }
            group("P&osting")
            {
                Caption = 'P&osting';
                Image = Post;
                action("Test Report")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Test Report';
                    Ellipsis = true;
                    Image = TestReport;
                    Scope = Repeater;
                    ToolTip = 'View a test report so that you can find and correct any errors before you perform the actual posting of the journal or document.';

                    trigger OnAction()
                    begin
                        ReportPrint.PrintItemJnlLine(Rec);
                    end;
                }
                action("P&ost")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'P&ost';
                    Image = PostOrder;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    Scope = Repeater;
                    ShortCutKey = 'F9';
                    ToolTip = 'Finalize the document or journal by posting the amounts and quantities to the related accounts in your company books.';

                    trigger OnAction()
                    begin
                        CODEUNIT.Run(CODEUNIT::"Item Jnl.-Post", Rec);
                        CurrentJnlBatchName := Rec.GetRangeMax("Journal Batch Name");
                        CurrPage.Update(false);
                    end;
                }
                action("Post and &Print")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Post and &Print';
                    Image = PostPrint;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    Scope = Repeater;
                    ShortCutKey = 'Shift+F9';
                    ToolTip = 'Finalize and prepare to print the document or journal. The values and quantities are posted to the related accounts. A report request window where you can specify what to include on the print-out.';

                    trigger OnAction()
                    begin
                        CODEUNIT.Run(CODEUNIT::"Item Jnl.-Post+Print", Rec);
                        CurrentJnlBatchName := Rec.GetRangeMax("Journal Batch Name");
                        CurrPage.Update(false);
                    end;
                }
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        ItemJnlMgt.GetItem(Rec."Item No.", ItemDescription);
    end;

    trigger OnAfterGetRecord()
    begin
        Rec.ShowShortcutDimCode(ShortcutDimCode);
    end;

    trigger OnDeleteRecord(): Boolean
    var
        ReserveItemJnlLine: Codeunit "Item Jnl. Line-Reserve";
    begin
        //KMP01.01 >
        if rec."Item No." <> '' then //PM
            Error('You are not allowed to delete the record directly. Please use Menu Kemipex > DeleteAll to continue further.');
        //KMP01.01 <
        Commit();
        if not ReserveItemJnlLine.DeleteLineConfirm(Rec) then
            exit(false);
        ReserveItemJnlLine.DeleteLine(Rec);
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec.SetUpNewLine(xRec);
        Clear(ShortcutDimCode);
    end;

    trigger OnOpenPage()
    var
        JnlSelected: Boolean;
        InventorySetup: Record "Inventory Setup";
    begin
        SetDimensionsVisibility;

        if Rec.IsOpenedFromBatch then begin
            CurrentJnlBatchName := Rec."Journal Batch Name";
            ItemJnlMgt.OpenJnl(CurrentJnlBatchName, Rec);
            exit;
        end;
        ItemJnlMgt.TemplateSelection(PAGE::"Phys. Inventory Journal", 2, false, Rec, JnlSelected);
        InventorySetup.GET;
        rec."Journal Template Name" := InventorySetup."Stock Count Template";
        CurrentJnlBatchName := InventorySetup."Stock Count Batch";
        if not JnlSelected then
            Error('');
        ItemJnlMgt.OpenJnl(CurrentJnlBatchName, Rec);
    end;

    var
        ItemJournalBatch: Record "Item Journal Batch";
        CalcQtyOnHand: Report "Calculate Inventory";
        ItemJnlMgt: Codeunit ItemJnlManagement;
        ReportPrint: Codeunit "Test Report-Print";
        ItemAvailFormsMgt: Codeunit "Item Availability Forms Mgt";
        CurrentJnlBatchName: Code[10];
        ItemDescription: Text[100];

    protected var
        ShortcutDimCode: array[8] of Code[20];
        DimVisible1: Boolean;
        DimVisible2: Boolean;
        DimVisible3: Boolean;
        DimVisible4: Boolean;
        DimVisible5: Boolean;
        DimVisible6: Boolean;
        DimVisible7: Boolean;
        DimVisible8: Boolean;

    local procedure CurrentJnlBatchNameOnAfterVali()
    begin
        CurrPage.SaveRecord;
        ItemJnlMgt.SetName(CurrentJnlBatchName, Rec);
        CurrPage.Update(false);
    end;

    local procedure SetDimensionsVisibility()
    var
        DimMgt: Codeunit DimensionManagement;
    begin
        DimVisible1 := false;
        DimVisible2 := false;
        DimVisible3 := false;
        DimVisible4 := false;
        DimVisible5 := false;
        DimVisible6 := false;
        DimVisible7 := false;
        DimVisible8 := false;

        DimMgt.UseShortcutDims(
          DimVisible1, DimVisible2, DimVisible3, DimVisible4, DimVisible5, DimVisible6, DimVisible7, DimVisible8);

        Clear(DimMgt);
    end;

    //KMP01.01 >
    procedure DeleteReservationLine(var IJL: Record "Item Journal Line")
    var
        ReservMgt: Codeunit "Reservation Management";
    begin
        ReservMgt.SetReservSource(IJL);
        // if DeleteItemTracking then
        ReservMgt.SetItemTrackingHandling(1); // Allow Deletion
        ReservMgt.DeleteReservEntries(true, 0);
        IJL.CalcFields("Reserved Qty. (Base)");

    end;

    local procedure CheckValidation(ItemJnlLine: Record "Item Journal Line")
    var
        itemJournalLine2: Record "Item Journal Line";
    begin
        itemJournalLine2.Reset();
        itemJournalLine2.SetRange("Journal Template Name", ItemJnlLine."Journal Template Name");
        itemJournalLine2.SetRange("Journal Batch Name", ItemJnlLine."Journal Batch Name");
        If itemJournalLine2.FindSet() then
            Error('Lines are already exist in this batch');

    end;

    //KMP01.01 <
    [IntegrationEvent(false, false)]
    local procedure OnAfterValidateShortcutDimCode(var ItemJournalLine: Record "Item Journal Line"; var ShortcutDimCode: array[8] of Code[20]; DimIndex: Integer)
    begin
    end;
}

