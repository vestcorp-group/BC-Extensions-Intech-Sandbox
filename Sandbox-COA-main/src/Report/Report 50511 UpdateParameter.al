//TBC-26-NS
report 50511 "UpdateParameter"
{

    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    ProcessingOnly = true;

    dataset
    {
        dataitem("Item Testing Parameter"; "Item Testing Parameter")
        {
            //RequestFilterFields = "Document No.", "Entry No.";
            trigger OnAfterGetRecord()
            var
                TP_lRec: Record "Testing Parameter";

            begin
                Clear(TP_lRec);
                if TP_lRec.Get("Item Testing Parameter".Code) then begin
                    "Item Testing Parameter"."Testing Parameter Code" := TP_lRec."Testing Parameter Code";
                    "Item Testing Parameter".Modify();
                end;

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


    }



    var





}
