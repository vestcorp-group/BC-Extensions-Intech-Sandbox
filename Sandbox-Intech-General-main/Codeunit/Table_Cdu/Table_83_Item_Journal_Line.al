//T07350-NS
codeunit 75017 Table_Subscribe_83_IntGen
{
    [EventSubscriber(ObjectType::Table, Database::"Item Journal Line", OnBeforePostingItemJnlFromProduction, '', false, false)]
    local procedure OnBeforePostingItemJnlFromProduction(var ItemJournalLine: Record "Item Journal Line"; Print: Boolean; var IsHandled: Boolean);
    var
        TmpDimensionSetEntry: Record "Dimension Set Entry" temporary;
        DimnesionChangesMgt_lCdu: Codeunit "INTGEN_Dimension Changes Mgt";
        DefaultDimension_lRec: Record "Default Dimension";
        xDimID_lInt: Integer;
    begin
        IF ItemJournalLine.FindSet() Then begin
            repeat
                xDimID_lInt := ItemJournalLine."Dimension Set ID";
                DefaultDimension_lRec.RESET;
                DefaultDimension_lRec.SETRANGE("Table ID", 27);
                DefaultDimension_lRec.SETRANGE("No.", ItemJournalLine."Item No.");
                DefaultDimension_lRec.SETFILTER("Dimension Value Code", '<>%1', '');
                DefaultDimension_lRec.SetRange("Value Posting", DefaultDimension_lRec."Value Posting"::"Same Code");
                IF DefaultDimension_lRec.FINDSET THEN BEGIN
                    TmpDimensionSetEntry.RESET;
                    TmpDimensionSetEntry.DELETEALL;
                    CLEAR(DimnesionChangesMgt_lCdu);
                    DimnesionChangesMgt_lCdu.FillDimSetEntry_gFnc(ItemJournalLine."Dimension Set ID", TmpDimensionSetEntry);

                    REPEAT
                        DimnesionChangesMgt_lCdu.UpdateDimSetEntry_gFnc(TmpDimensionSetEntry, DefaultDimension_lRec."Dimension Code", DefaultDimension_lRec."Dimension Value Code")
                    UNTIL DefaultDimension_lRec.NEXT = 0;

                    ItemJournalLine."Dimension Set ID" := DimnesionChangesMgt_lCdu.GetDimensionSetID_gFnc(TmpDimensionSetEntry);
                    DimnesionChangesMgt_lCdu.UpdGlobalDimFromSetID_gFnc(ItemJournalLine."Dimension Set ID", ItemJournalLine."Shortcut Dimension 1 Code", ItemJournalLine."Shortcut Dimension 2 Code");
                    IF xDimID_lInt <> ItemJournalLine."Dimension Set ID" Then
                        ItemJournalLine.Modify();
                END;
            until ItemJournalLine.Next() = 0;
        end;
    end;
}