pageextension 50506 POSubformExt extends "Purchase Order Subform"//T12370-Full Comment   //T13935
{
    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        addafter("Upload Lot No.")
        {
            action("Upload Lot and TP")
            {
                Caption = 'Upload Lot and TP';
                ApplicationArea = all;
                // Promoted = true;
                // PromotedCategory = Category4;
                Image = AnalysisView;
                trigger OnAction()
                var
                    UploadCode: Codeunit "Upload COA Arlanxeo";
                    Trackingmanage: Codeunit "Item Tracking Management";
                    CurrentSourceRowID: Text[250];
                    SecondSourceRowID: Text[250];
                    Text015: Label 'Do you want to synchronize item tracking on the line with item tracking on the related drop shipment ?';
                begin
                    UploadCode.UploadDataCOA(Rec);
                    if rec."Sales Order No." <> '' then begin
                        CurrentSourceRowID := Trackingmanage.ComposeRowID(39, 1, Rec."Document No.", '', 0, rec."Line No.");
                        SecondSourceRowID := Trackingmanage.ComposeRowID(37, 1, Rec."Sales Order No.", '', 0, rec."Sales Order Line No.");
                        Trackingmanage.SynchronizeItemTracking(CurrentSourceRowID, SecondSourceRowID, Text015);
                    end;

                end;
            }
        }
    }

    var
        myInt: Integer;
}