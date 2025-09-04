pageextension 50143 KMP_PageExtItemLedgerEntry extends "Item Ledger Entries"//T12370-Full Comment
{
    layout
    {
        // Add changes to page layout here
        addafter(Quantity)
        {
            field(CustomLotNumber; rec.CustomLotNumber)
            {
                Caption = 'Custom Lot No.';
                ApplicationArea = All;
            }
            field(CustomBOENumber; rec.CustomBOENumber)
            {
                Caption = 'Custom BOE No.';
                ApplicationArea = All;
            }
            field(BillOfExit; rec.BillOfExit)
            {
                ApplicationArea = all;
            }
            field("Supplier Batch No. 2"; rec."Supplier Batch No. 2")
            {
                ApplicationArea = all;
                Caption = 'Supplier Batch No.';
            }
            field("Manufacturing Date 2"; rec."Manufacturing Date 2")
            {
                ApplicationArea = all;
                Caption = 'Manufacturing Date';
            }
            field("Expiry Period 2"; rec."Expiry Period 2")
            {
                ApplicationArea = all;
                Caption = 'Expiry Period';
            }
            field("Net Weight 2"; rec."Net Weight 2")
            {
                ApplicationArea = all;
                Caption = 'Net Weight';
            }
            field("Gross Weight 2"; rec."Gross Weight 2")
            {
                ApplicationArea = all;
                Caption = 'Gross Weight';
            }
            //         }
            //         addafter("Cost Amount (Actual)")
            //         {
            //             field("Profit % IC"; rec."Profit % IC")
            //             {
            //                 ApplicationArea = all;
            //             }
            //         }
            //     }

            //     actions
            //     {
            //         // Add changes to page actions here
            //         addlast(reporting)
            //         {
            //             action("IC-Profit Elimination")
            //             {
            //                 Caption = 'IC-Profit Elimination';
            //                 Image = Report;
            //                 ApplicationArea = All;

            //                 trigger OnAction();
            //                 var
            //                     ItemLedg: Record "Item Ledger Entry";
            //                 begin
            //                     ItemLedg.SetFilter("Item No.", '%1', rec."Item No.");
            //                     report.Run(50600, true, false, ItemLedg);
            //                 end;
            //             }
        }
    }
}