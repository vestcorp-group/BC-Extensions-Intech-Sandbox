page 58040 AccountSchedulePart//T12370-Full Comment     //T13413-Full UnComment
{
    PageType = ListPart;
    SourceTable = "Acc. Schedule Name";
    Editable = false;
    Caption = 'Account Schedules';
    layout
    {
        area(Content)
        {
            repeater(general)
            {
                field(Description; rec.Description)
                {
                    ApplicationArea = all;
                    trigger OnDrillDown()
                    var
                        Accschedpage: Page "Acc. Schedule Overview";
                        accschedtable: Record "Acc. Schedule Line";
                        columnlayout: Record "Column Layout Name";
                    begin
                        Accschedpage.LookupMode(true);
                        accschedpage.SetAccSchedName(rec.Name);
                        Accschedpage.Editable(true);
                        Accschedpage.RunModal();


                        // accschedtable.Reset();
                        //accschedtable.SetRange("Schedule Name", Name);
                        //page.Run(Page::"Acc. Schedule Overview", accschedtable);

                    end;
                }
            }
        }
    }
    actions
    {
    }
}