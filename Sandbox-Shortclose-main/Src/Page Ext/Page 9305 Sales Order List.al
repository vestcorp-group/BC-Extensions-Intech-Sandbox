pageextension 79658 P79658_SalesOrderList extends "Sales Order List"
{
    trigger OnOpenPage()
    begin
        // Rec.SetRange("Short Close Boolean", false);  //T50307-O
    end;
}