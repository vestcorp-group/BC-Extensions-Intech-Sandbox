Page 74996 "Released Production Orders New"
{
    // -----------------------------------------------------------------------------------------------------------------------------
    // Intech-Systems -> info@intech-systems.com
    // -----------------------------------------------------------------------------------------------------------------------------
    // ID                  Date         Author
    // -----------------------------------------------------------------------------------------------------------------------------
    // I-A010_A-4000070-01 04/06/11     Saurabh
    //                     Onsite Visit for System (Locks on functionality)
    //                     Added Sales Order Column on Page
    // I-A010_A-3000318-01 08/07/2011   Saurabh
    //                     Added Customer Name on Page
    // I-A010_A-3000324-01 09/07/2011   Dipak
    //                     Remaining Quantity in Prod. Order List
    // I-A010_A-4000106-01 25/11/2011   Dipak
    //                     Written Function "GetSelectionFilter_gFnc" for Report 50040.
    //                     09/06/2012   Dipak
    //                     Added field "Description 2" in Page.
    // I-C0046-1006182-01  18/05/12    Nilesh Gajjar
    //                     C0046-Prod Plan Material Availibilty
    // I-C0046-1006182-03  16/03/13    Nilesh Gajjar / Dipak Patel
    //                     Upload to live database after tested in test db

    //
    // -------------------------------------------------------------------------------------------------------------
    //AutoFinishProdOrder
    Caption = 'Prod. Order Change status page';
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = Worksheet;
    SourceTable = "Production Order";
    SourceTableView = where(Status = const(Released));

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field(Select_gBln; Select_gBln)
                {
                    ApplicationArea = Basic;
                    Caption = 'Select';

                    trigger OnValidate()
                    begin
                        ProdOrderSingleInstance_gCdu.UpdateTable_gFnc(Rec, Select_gBln);
                        CurrPage.Update;
                    end;
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Lookup = false;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Description 2"; Rec."Description 2")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Source No."; Rec."Source No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Routing No."; Rec."Routing No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;
                }
                field("Starting Time"; Rec."Starting Time")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;
                }
                field("Starting Date"; Rec."Starting Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Ending Time"; Rec."Ending Time")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;
                }
                field("Ending Date"; Rec."Ending Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Due Date"; Rec."Due Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Assigned User ID"; Rec."Assigned User ID")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Finished Date"; Rec."Finished Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Search Description"; Rec."Search Description")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Last Date Modified"; Rec."Last Date Modified")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;
                }
                field("Bin Code"; Rec."Bin Code")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;
                }

                field("Creation Date"; Rec."Creation Date")
                {
                    ApplicationArea = Basic;
                }

                field("Error on Finish PO"; Rec."Error on Finish PO")
                {
                    ApplicationArea = Basic;
                    Style = Unfavorable;
                    StyleExpr = true;
                }
            }
        }
        area(factboxes)
        {
            systempart(Control1900383207; Links)
            {
                Visible = false;
                ApplicationArea = All;
            }
            systempart(Control1905767507; Notes)
            {
                Visible = true;
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Get Order To Finish")
            {
                ApplicationArea = Basic;
                Caption = 'Get Order To Finish';
                Image = GanttChart;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    AutoFinishProdOrder_lCdu: Codeunit "Auto Finish Prod Order";
                    Win_lDlg: Dialog;
                    Curr_lInt: Integer;
                begin
                    Rec.Reset;
                    Curr_lInt := 0;
                    Win_lDlg.Open('Total Entry #1############\Current #2############');
                    Win_lDlg.Update(1, Rec.Count);
                    repeat
                        Curr_lInt += 1;
                        Win_lDlg.Update(2, Curr_lInt);
                        if AutoFinishProdOrder_lCdu.IsOrderToFinish_gFnc(Rec) then
                            Rec.Mark(true);
                    until Rec.Next = 0;
                    Win_lDlg.Close;
                    Rec.MarkedOnly(true);
                end;
            }
            action("Finish Mark Production Order")
            {
                ApplicationArea = Basic;
                Caption = 'Finish Mark Production Order';
                Image = Hierarchy;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    ProdOrderSingleInstance_gCdu.FinishProdOrder_gFnc;
                end;
            }
            action(Mark)
            {
                ApplicationArea = Basic;
                Image = Approval;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    ProductionOrder_lRec: Record "Production Order";
                begin
                    CurrPage.SetSelectionFilter(ProductionOrder_lRec);
                    if ProductionOrder_lRec.FindSet then begin
                        repeat
                            ProdOrderSingleInstance_gCdu.UpdateTable_gFnc(ProductionOrder_lRec, true);
                        until ProductionOrder_lRec.Next = 0;
                    end;
                end;
            }
            action(UnMark)
            {
                ApplicationArea = Basic;
                Image = Reject;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    ProductionOrder_lRec: Record "Production Order";
                begin
                    CurrPage.SetSelectionFilter(ProductionOrder_lRec);
                    if ProductionOrder_lRec.FindSet then begin
                        repeat
                            ProdOrderSingleInstance_gCdu.UpdateTable_gFnc(ProductionOrder_lRec, false);
                        until ProductionOrder_lRec.Next = 0;
                    end;
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        Select_gBln := ProdOrderSingleInstance_gCdu.GetMarkedProdOrderDetails_gFnc(Rec);
    end;

    trigger OnOpenPage()
    begin
        Clear(ProdOrderSingleInstance_gCdu);
        ProdOrderSingleInstance_gCdu.ClearTempTable_gFnc;
        Rec.MarkedOnly(true);
    end;

    var
        ManuPrintReport: Codeunit "Manu. Print Report";
        Select_gBln: Boolean;
        ProdOrderSingleInstance_gCdu: Codeunit "Prod. Order - Single Instance";
}

