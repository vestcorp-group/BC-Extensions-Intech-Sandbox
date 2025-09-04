pageextension 70300 "My GL Setup" extends "General Ledger Setup"//T12370-Full Comment T12946-Code Uncommented
{
    layout
    {
        addafter("LCY Code")
        {
            field("GP G/L Accounts"; Rec."GP G/L Accounts")
            {
                ApplicationArea = All;
                TRIGGER OnLookup(var Text: Text): Boolean
                BEGIN
                    CLEAR(ChartofAccountPage);
                    ChartofAccountPage.LookupMode(TRUE);
                    IF NOT (ChartofAccountPage.RunModal() = ACTION::LookupOK) THEN
                        EXIT(FALSE);
                    Rec."GP G/L Accounts" := '';
                    ChartofAccountPage.SetSelection(ChartofAccounts);
                    Rec."GP G/L Accounts" := GetSelectionFilterGLAccount(ChartofAccounts);
                END;
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        ChartofAccounts: Record "G/L Account";
        ChartofAccountPage: Page "G/L Account List";
        RecRef: RecordRef;
        FieldRef: FieldRef;
        FirstRecRef: Text[1024];
        LastRecRef: Text[1024];
        SelectionFilter: Text[1024];
        SavePos: Text[1024];
        TempRecRefCount: Integer;
        More: Boolean;

    PROCEDURE GetSelectionFilterGLAccount(var GLAcc: Record "G/L Account"): Text
    VAR
        RecRef: RecordRef;
    BEGIN
        RecRef.GetTable(GLAcc);
        EXIT(GetSelectionFilterForGLAccount(RecRef, GLAcc.FieldNo("No.")));
    END;

    PROCEDURE GetSelectionFilterForGLAccount(var TempRecRef: RecordRef; SelectionFieldID: Integer): Text
    BEGIN
        RecRef.Close();
        IF TempRecRef.ISTEMPORARY THEN BEGIN
            RecRef := TempRecRef.DUPLICATE;
            RecRef.RESET;
        END ELSE
            RecRef.OPEN(TempRecRef.NUMBER);

        TempRecRefCount := TempRecRef.COUNT;
        IF TempRecRefCount > 0 THEN BEGIN
            TempRecRef.ASCENDING(TRUE);
            TempRecRef.FIND('-');
            WHILE TempRecRefCount > 0 DO BEGIN
                TempRecRefCount := TempRecRefCount - 1;
                RecRef.SETPOSITION(TempRecRef.GETPOSITION);
                RecRef.FIND;
                FieldRef := RecRef.FIELD(SelectionFieldID);
                FirstRecRef := FORMAT(FieldRef.VALUE);
                LastRecRef := FirstRecRef;
                More := TempRecRefCount > 0;
                WHILE More DO
                    IF RecRef.NEXT = 0 THEN
                        More := FALSE
                    ELSE BEGIN
                        SavePos := TempRecRef.GETPOSITION;
                        TempRecRef.SETPOSITION(RecRef.GETPOSITION);
                        IF NOT TempRecRef.FIND THEN BEGIN
                            More := FALSE;
                            TempRecRef.SETPOSITION(SavePos);
                        END ELSE BEGIN
                            FieldRef := RecRef.FIELD(SelectionFieldID);
                            LastRecRef := FORMAT(FieldRef.VALUE);
                            TempRecRefCount := TempRecRefCount - 1;
                            IF TempRecRefCount = 0 THEN
                                More := FALSE;
                        END;
                    END;
                IF SelectionFilter <> '' THEN
                    SelectionFilter := SelectionFilter + '|';
                IF FirstRecRef = LastRecRef THEN
                    SelectionFilter := SelectionFilter + AddQuotes(FirstRecRef)
                ELSE
                    SelectionFilter := SelectionFilter + AddQuotes(FirstRecRef) + '|' + AddQuotes(LastRecRef);
                IF TempRecRefCount > 0 THEN
                    TempRecRef.NEXT;
            END;
            EXIT(SelectionFilter);
        END;
    END;

    PROCEDURE AddQuotes(instring: Text[1024]): Text
    BEGIN
        IF DELCHR(inString, '=', ' &|()*') = inString THEN
            EXIT(inString);
        EXIT('''' + inString + '''');
    END;
}