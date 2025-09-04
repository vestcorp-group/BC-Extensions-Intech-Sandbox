reportextension 50100 PurchaseCostRepDetExt extends Purchase_Line_Report_Detail
{
    RDLCLayout = './Layouts/B Open Purchase Order Report DetailSA.rdl';
    dataset
    {
        add("Purchase Line")
        {
            column(Remarks_gtxt; Remarks_gtxt)
            {

            }
        }
        modify("Purchase Line")
        {
            trigger OnAfterAfterGetRecord()
            var
                myInt: Integer;
            begin
                Clear(Remarks_gtxt);
                PurchCommentLine_gRec.Reset();
                PurchCommentLine_gRec.SetRange("Document Type", PurchCommentLine_gRec."Document Type"::Order);
                PurchCommentLine_gRec.SetRange("No.", "Purchase Line"."Document No.");
                PurchCommentLine_gRec.SetRange("Document Line No.", "Purchase Line"."Line No.");
                if PurchCommentLine_gRec.FindSet() then
                    repeat
                        Remarks_gtxt += PurchCommentLine_gRec.Comment + ',';
                    until PurchCommentLine_gRec.Next() = 0;
            end;
        }
    }
    var
        PurchCommentLine_gRec: Record "Purch. Comment Line";
        Remarks_gtxt: Text;

}