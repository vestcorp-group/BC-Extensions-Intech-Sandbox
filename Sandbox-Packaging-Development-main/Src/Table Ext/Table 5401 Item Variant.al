tableextension 80214 ItemVariantExt extends "Item Variant"
{
    fields
    {
        field(80201; "Packaging Code"; Code[250])
        {
            Caption = 'Packaging Code';
            TableRelation = "Packaging Detail Header";
            DataClassification = ToBeClassified;
            // trigger OnValidate()
            // var
            //     PackagingdetailLine_lRec: Record "Packaging detail Line";
            // begin
            //     if Rec."Packaging Code" <> '' then begin
            //         PackagingdetailLine_lRec.Reset();
            //         PackagingdetailLine_lRec.SetRange("Packaging Code", Rec."Packaging Code");
            //         PackagingdetailLine_lRec.SetRange("Unit of Measure", Rec."Sales UOM");
            //         if not PackagingdetailLine_lRec.FindFirst() then
            //             Error('Packaging Detail Line does not have the UOM : %1 in Packaging Code: %2', "Sales UOM", PackagingdetailLine_lRec."Packaging Code");
            //     end;
            // end;
        }
        // modify("Sales UOM")
        // {
        // trigger OnAfterValidate()
        // var
        //     PackagingdetailLine_lRec: Record "Packaging detail Line";
        // begin
        //     if (Rec."Sales UOM" <> '') AND (Rec."Packaging Code" <> '') then begin
        //         PackagingdetailLine_lRec.Reset();
        //         PackagingdetailLine_lRec.SetRange("Packaging Code", Rec."Packaging Code");
        //         PackagingdetailLine_lRec.SetRange("Unit of Measure", Rec."Sales UOM");
        //         if not PackagingdetailLine_lRec.FindFirst() then
        //             Error('Packaging Detail Line does not have the UOM : %1 in Packaging Code: %2', "Sales UOM", PackagingdetailLine_lRec."Packaging Code");
        //     end;
        // end;
        // }
    }
}
