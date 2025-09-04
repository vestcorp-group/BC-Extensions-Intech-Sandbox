pageextension 70008 "Item Ledger Entry Extension" extends "Item Ledger Entries"//T12370-Full Comment T12946-Code Uncommented
{
    layout
    {
        //         addafter("Location Code")
        //         {
        //             field("Production Wh."; rec."Production Wh.")
        //             {
        //                 ApplicationArea = all;

        //             }
        //         }
        addlast(Control1)
        {
            //             /* field("Unit of Measure Code"; "Unit of Measure Code")
            //              {
            //                  ApplicationArea = all;
            //              }
            //              */

            field("Group GRN Date"; rec."Group GRN Date")
            {
                ApplicationArea = All;
            }
        }
        //         /*   modify("Unit of Measure Code")
        //            {
        //                Visible = true;
        //            }
        //            */
    }

    actions
    {
        addlast(processing)
        {
            action("Update Custom Lot & Custome BOE")//Hypercare T13358-N
            {
                ApplicationArea = All;
                Image = Change;
                Promoted = true;
                //  RunObject = page "Remarks Part";
                // RunPageLink = "Document No." = field("No."), "Document Type" = filter("Blanket Order"), "Document Line No." = const(0);
                trigger OnAction()
                var
                    BlnktOrdToOrd: Codeunit "Blanket Order to Order";
                begin
                    BlnktOrdToOrd.UpdateILEforCustomBOEnLOT();
                end;

            }
            action("Update GRN DATE")//Hypercare T13358-N
            {
                Promoted = true;
                PromotedCategory = Process;
                Image = ImportExcel;
                ApplicationArea = all;
                RunObject = report "Import Group GRN Date";
                trigger OnAction()
                begin
                    Report.RunModal(80101, false, false);
                end;
            }
        }
    }

    //     var
    //         ProgressWindow: Dialog;
    //         NoOfRecs: Integer;
    //         CurrRec: Integer;
}