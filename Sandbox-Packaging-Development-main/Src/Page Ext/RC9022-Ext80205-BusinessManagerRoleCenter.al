pageextension 80205 INTPackConfiguratorRC extends "Business Manager Role Center"
{
    // version NAVW111.00
    // -----------------------------------------------------------------------------------------------------------------------------
    // Intech Systems Pvt. Ltd. - support@intech-systems.com
    // -----------------------------------------------------------------------------------------------------------------------------
    // ID                        Date            Author
    // -----------------------------------------------------------------------------------------------------------------------------
    // 1.0.0.0                  07/04/18        Intech Systems Pvt. Ltd.
    // -----------------------------------------------------------------------------------------------------------------------------    

    actions
    {
        addafter(New)
        {
            group("INT Packaging Configurator")
            {
                Caption = 'Packaging Configurator';
                group("INT Design")
                {
                    Caption = 'Design';
                    action("INT Packaging List")
                    {
                        ApplicationArea = All;
                        Caption = 'Packaging List';
                        Image = Item;
                        RunObject = page "INT Packaging List";
                        //RunPageMode = Create;
                        ToolTip = 'View the Packaging list.';
                    }
                    action("INT Parameter List")
                    {
                        ApplicationArea = All;
                        Caption = 'Parameter List';
                        Image = Production;
                        RunObject = page "INT Packaging Parameter List";
                        //RunPageMode = Create;
                        ToolTip = 'View the Parameters list.';
                    }
                    action("INT Packaging Param Dependency List")
                    {
                        ApplicationArea = All;
                        Caption = 'Packaging Param Dependency List';
                        Image = Production;
                        RunObject = page "INT Pack Param Dependency List";
                        //RunPageMode = Create;
                        ToolTip = 'View the INT Prod Param Dependency list.';
                    }
                }
                group("INT Process")
                {
                    Caption = 'Process';
                    action("INT Packaging Configuration List")
                    {
                        ApplicationArea = All;
                        Caption = 'Packaging Configuration List';
                        Image = Production;
                        RunObject = page "INT Packaging Config List";
                        //RunPageMode = Create;
                        ToolTip = 'View the Packaging Configurator list.';
                    }
                }
                group("INT Packaging Config. Setup")
                {
                    Caption = 'Packaging Config. Setup';
                    action("INT Packaging Configurator Setup")
                    {
                        ApplicationArea = All;
                        Caption = 'Packaging Configurator Setup';
                        Image = Setup;
                        RunObject = page "INT Packaging Config Setup";
                        //RunPageMode = Create;
                        ToolTip = 'View the Packaging Configurator Setup.';
                    }
                }
            }
        }
    }
}