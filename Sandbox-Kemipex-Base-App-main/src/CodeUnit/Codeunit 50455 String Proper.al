codeunit 50455 "String Proper"//T12370-N
{
    trigger OnRun()
    begin

    end;

    procedure SplitString(Var String: Text[1024]; Seperator: Text[1]) OutPutString: Text[1024];
    var
        POS: Integer;
    begin
        Clear(POS);
        POS := StrPos(String, Seperator);
        if POS > 0 then begin
            OutPutString := CopyStr(String, 1, POS);
            if POS + 1 <= StrLen(String) then
                String := CopyStr(String, POS + 1)
            else
                Clear(String);
        end else begin
            OutPutString := String;
            Clear(String);
        end;
    end;


    procedure ConvertString(InputString: Text[1024]) OutPutString: Text[1024]
    var
        i: Integer;
        Midstring: array[100] of Text[1024];
    begin
        While StrLen(InputString) > 0 do begin
            i := i + 1;
            Midstring[i] := SplitString(InputString, ' ');
            OutPutString := OutPutString + UpperCase(CopyStr(Midstring[i], 1, 1)) + LowerCase(CopyStr(Midstring[i], 2));
        end;
        exit(OutPutString);
    end;

    var
        myInt: Integer;
}