tableextension 75006 ProdOrderLineTableExt75006 extends "Prod. Order Line"
{
    //AutoFinishProdOrder
    fields
    {

    }


    procedure IsSubcontractingOrder(ProdOrderComp: Record "Prod. Order Component"): Boolean
    begin
        EXIT((
          ProdOrderComp."Flushing Method" = ProdOrderComp."Flushing Method"::Backward) AND
            ("Subcontracting Order No." <> '') AND ("Subcontractor Code" <> ''));
    end;

    var
        myInt: Integer;
}