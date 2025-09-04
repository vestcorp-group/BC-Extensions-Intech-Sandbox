reportextension 74982 Copy_Purchase_Document_74982 extends "Copy Purchase Document"
{
    dataset
    {
        // Add changes to dataitems and columns here
    }

    requestpage
    {
        layout
        {
            addafter(IncludeHeader_Options)
            {
                // add field from table extension to request page
                field(SkipLines_gBln; SkipLines_gBln)
                {
                    Caption = 'Skip Lines';
                    ApplicationArea = All;
                    trigger OnValidate()
                    var
                        myInt: Integer;
                    begin
                        //I-C0059-1005710-01-NS
                        IF SkipLines_gBln THEN
                            RecalculateLines := NOT SkipLines_gBln;
                        //I-C0059-1005710-01-NE
                    end;
                }

            }
            modify(RecalculateLines)
            {
                trigger OnAfterValidate()
                var
                    myInt: Integer;
                begin
                    //I-C0059-1005710-01-NS
                    IF RecalculateLines THEN
                        SkipLines_gBln := NOT RecalculateLines;
                    //I-C0059-1005710-01-NE
                end;
            }
        }

        //T11531-NS
        trigger OnOpenPage()
        begin
            SkipLines_gBln := true;
        end;
        //T11531-NE

        //Hypercare-21-03-25-NS
        trigger OnQueryClosePage(CloseAction: Action): Boolean
        var
            myInt: Integer;
        begin
            CopySalesDocument.SetSkipLines_gFnc(SkipLines_gBln);
        end;
        //Hypercare-21-03-25-NE
    }
    //Hypercare-21-03-25-OS
    // trigger OnPreReport()
    // var
    //     myInt: Integer;
    // begin
    //     CopySalesDocument.SetSkipLines_gFnc(SkipLines_gBln);
    // end;
    //Hypercare-21-03-25-OE


    var
        SkipLines_gBln: Boolean;
        CopySalesDocument: Codeunit CopySalesPurchaseDocument;
}