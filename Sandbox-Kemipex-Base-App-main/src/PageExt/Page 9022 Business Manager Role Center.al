pageextension 50145 "Extend Navigation Area" extends "Business Manager Role Center"//T12370-Full Comment    //T13413
{

    actions
    {

        addlast(Sections)
        {
            group("Kemipex Reports")
            {
                action("Report")
                {
                    RunObject = page KMP_PageReportList;
                    ApplicationArea = All;
                    Caption = 'Reports';
                }

            }
        }


    }
}