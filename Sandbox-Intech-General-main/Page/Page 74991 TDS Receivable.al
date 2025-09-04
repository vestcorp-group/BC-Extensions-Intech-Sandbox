Page 74991 "TDS Receivable"
{
    //I-C0059-1001707-01  - CReate new Page
    // ------------------------------------------------------------------------------------------------------------------------------
    // Intech Systems -info@intech-systems.com
    // ------------------------------------------------------------------------------------------------------------------------------
    // ID                        DATE          AUTHOR
    // ------------------------------------------------------------------------------------------------------------------------------
    // I-C0059-1001707-01        03/01/12      KSP
    //                           Create a form to enter TDS Receivable Amount
    // I-C0059-1400410-01        08/08/14     Chintan Panchal
    //                           C0059-NAV ENHANCEMENTS upgrade to NAV 2013 R2
    // ------------------------------------------------------------------------------------------------------------------------------

    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = List;
    SourceTable = "Gen. Journal Line";

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                field("TDS Receivable Amount"; Rec."TDS Receivable Amount")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }
}

