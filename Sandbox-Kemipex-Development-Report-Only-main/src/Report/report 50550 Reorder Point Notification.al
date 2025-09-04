report 50550 "Reorder Point Notification"
{
    //T12067

    Caption = 'Reorder Point Notification';
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Reorder Point Notification.rdl';
    dataset
    {
        dataitem(Item; Item)
        {
            column(No_; "No.")
            {

            }
            column(Description; Description)
            {

            }
            column(Reorder_Point; "Reorder Point")
            {

            }
            column(Inventory; Inventory)
            {

            }
            column(Qty__on_Purch__Order; "Qty. on Purch. Order")
            {

            }
            column(ReservedQty_gDec; ReservedQty_gDec)
            {

            }
            column(UnReservedQty_gRec; UnReservedQty_gRec)
            {

            }
            column(SrNo_gInt; SrNo_gInt)
            { }

            trigger OnPreDataItem()
            begin
                SetFilter("Reordering Policy", '<>%1', Item."Reordering Policy"::" ");
                SetFilter("Reorder Point", '<>%1', 0);
            end;

            trigger OnAfterGetRecord()
            var
                ItemLedgerEntry_lRec: Record "Item Ledger Entry";
                IndentLine_lRec: Record "Purchase Indent Line";
            begin
                CalcFields(Inventory, "Qty. on Purch. Order");
                if Inventory > "Reorder Point" then
                    CurrReport.Skip();
                SrNo_gInt += 1;
                ItemLedgerEntry_lRec.Reset();
                ItemLedgerEntry_lRec.SetRange("Item No.", "No.");
                if ItemLedgerEntry_lRec.FindSet() then begin
                    repeat
                        ReservedQty_gDec += ItemLedgerEntry_lRec."Reserved Quantity";
                    until ItemLedgerEntry_lRec.Next() = 0;
                end;
                UnReservedQty_gRec := ReservedQty_gDec - Inventory;
            end;

        }
    }
    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(Processing)
            {
            }
        }
    }
    var
        ReservedQty_gDec: Decimal;
        UnReservedQty_gRec: Decimal;
        SrNo_gInt: Integer;
}
