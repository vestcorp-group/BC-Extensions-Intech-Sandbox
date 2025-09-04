report 50508 "Copy Testing Parameter"
{
    UsageCategory = Administration;
    ApplicationArea = All;
    Caption = 'Copy Testing Parameter';
    DefaultLayout = RDLC;
    //RDLCLayout = './src/Report/Layout/CertificateOfAnalysis.rdl';
    ProcessingOnly = true;
    UseRequestPage = true;

    dataset
    {
        dataitem("Item Variant"; "Item Variant")
        {
            //RequestFilterFields = "Item No.", Code;
            trigger OnPreDataItem()
            var
            begin

                if ItemNoNew = '' then
                    Error('Please select item no.');

                IF ItemNo <> '' THEN
                    "Item Variant".SetRange("Item No.", ItemNo);

                IF ItemVariant <> '' THEN
                    "Item Variant".SetRange(Code, ItemVariant);
            end;

            trigger OnAfterGetRecord()
            var
                ItemTestingParameter: Record "Item Testing Parameter";
                ItemVariantTestingParameter: Record "Item Variant Testing Parameter";
                ItemVariantTestingParameter2: Record "Item Variant Testing Parameter";
                Test002: Label 'Item No. :%1 and Variant Code :%2 and Testing Parameter :%3 are already created !';
                Test003: Label 'Item No. :%1 and Variant Code :%2 and Testing Parameter :%3 are created succefully !';

            begin
                IF (ItemNoNew <> '') and (ItemVariantNew = '') and (TPCode <> '') THEN BEGIN
                    IF NOT Confirm('Do you want to copy item :' + ItemNo + ' testing parameter :' + TPCode + ' ?') THEN
                        exit;
                    ItemTestingParameter.RESET;
                    ItemTestingParameter.SetFilter("Item No.", ItemNoNew);
                    ItemTestingParameter.SetFilter(Code, TPCode);
                    IF ItemTestingParameter.FindFirst THEN
                        repeat
                            ItemVariantTestingParameter.RESET;
                            ItemVariantTestingParameter.SetRange("Item No.", ItemTestingParameter."Item No.");
                            ItemVariantTestingParameter.SetFilter("Variant Code", "Item Variant".Code);
                            ItemVariantTestingParameter.SetFilter(Code, ItemTestingParameter.Code);
                            IF NOT ItemVariantTestingParameter.FindFirst THEN begin
                                ItemVariantTestingParameter.Init;
                                ItemVariantTestingParameter."Item No." := ItemNo;
                                ItemVariantTestingParameter."Variant Code" := ItemVariant;
                                ItemVariantTestingParameter.Code := ItemTestingParameter.Code;
                                ItemVariantTestingParameter.Insert;
                                ItemVariantTestingParameter."Testing Parameter" := ItemTestingParameter."Testing Parameter";
                                ItemVariantTestingParameter.Maximum := ItemTestingParameter.Maximum;
                                ItemVariantTestingParameter.Minimum := ItemTestingParameter.Minimum;
                                ItemVariantTestingParameter.Value2 := ItemTestingParameter.Value2;
                                ItemVariantTestingParameter.Priority := ItemTestingParameter.Priority;
                                ItemVariantTestingParameter."Show in COA" := ItemTestingParameter."Show in COA";
                                ItemVariantTestingParameter."Data Type" := ItemTestingParameter."Data Type";
                                ItemVariantTestingParameter.Symbol := ItemTestingParameter.Symbol;
                                ItemVariantTestingParameter."Default Value" := ItemTestingParameter."Default Value";
                                ItemVariantTestingParameter.Modify;
                            end;
                        until ItemTestingParameter.next = 0;
                    Message(Test003, ItemNoNew, ItemVariantNew, ItemTestingParameter.Code);
                END ELSE begin
                    IF (ItemNoNew <> '') and (ItemVariantNew = '') and (TPCode = '') THEN BEGIN
                        IF NOT Confirm('Do you want to copy item :' + ItemNoNew + ' testing parameter ?') THEN
                            exit;
                        ItemTestingParameter.RESET;
                        ItemTestingParameter.SetRange("Item No.", ItemNoNew);
                        IF ItemTestingParameter.FindFirst THEN
                            repeat
                                ItemVariantTestingParameter.RESET;
                                ItemVariantTestingParameter.SetRange("Item No.", ItemTestingParameter."Item No.");
                                ItemVariantTestingParameter.SetRange("Variant Code", "Item Variant".Code);
                                ItemVariantTestingParameter.SetRange(Code, ItemTestingParameter.Code);
                                IF NOT ItemVariantTestingParameter.FindFirst THEN begin
                                    ItemVariantTestingParameter.Init;
                                    ItemVariantTestingParameter."Item No." := ItemNo;
                                    ItemVariantTestingParameter."Variant Code" := ItemVariant;
                                    ItemVariantTestingParameter.Code := ItemTestingParameter.Code;
                                    ItemVariantTestingParameter.Insert;
                                    ItemVariantTestingParameter."Testing Parameter" := ItemTestingParameter."Testing Parameter";
                                    ItemVariantTestingParameter.Maximum := ItemTestingParameter.Maximum;
                                    ItemVariantTestingParameter.Minimum := ItemTestingParameter.Minimum;
                                    ItemVariantTestingParameter.Value2 := ItemTestingParameter.Value2;
                                    ItemVariantTestingParameter.Priority := ItemTestingParameter.Priority;
                                    ItemVariantTestingParameter."Show in COA" := ItemTestingParameter."Show in COA";
                                    ItemVariantTestingParameter."Data Type" := ItemTestingParameter."Data Type";
                                    ItemVariantTestingParameter.Symbol := ItemTestingParameter.Symbol;
                                    ItemVariantTestingParameter."Default Value" := ItemTestingParameter."Default Value";
                                    ItemVariantTestingParameter.Modify;
                                end;
                            until ItemTestingParameter.next = 0;
                        Message(Test003, ItemNoNew, ItemVariantNew, ItemTestingParameter.Code);
                    end;
                end;
                IF (ItemNoNew <> '') and (ItemVariantNew <> '') and (TPCode = '') THEN BEGIN
                    IF NOT Confirm('Do you want to copy item :' + ItemNoNew + ' and Variant code :' + ItemVariantNew + ' ?') THEN
                        exit;
                    ItemVariantTestingParameter2.RESET;
                    ItemVariantTestingParameter2.SetFilter("Item No.", ItemNoNew);
                    ItemVariantTestingParameter2.SetFilter("Variant Code", ItemVariantNew);
                    IF ItemVariantTestingParameter2.FindSet THEN
                        repeat
                            ItemVariantTestingParameter.RESET;
                            ItemVariantTestingParameter.SetFilter("Item No.", ItemNo);
                            ItemVariantTestingParameter.SetFilter("Variant Code", ItemVariant);
                            ItemVariantTestingParameter.SetFilter(Code, ItemVariantTestingParameter2.Code);
                            IF NOT ItemVariantTestingParameter.FindFirst THEN begin
                                ItemVariantTestingParameter.Init;
                                ItemVariantTestingParameter."Item No." := ItemNo;
                                ItemVariantTestingParameter."Variant Code" := ItemVariant;
                                ItemVariantTestingParameter.Code := ItemVariantTestingParameter2.Code;
                                ItemVariantTestingParameter.Insert;
                                ItemVariantTestingParameter."Testing Parameter" := ItemVariantTestingParameter2."Testing Parameter";
                                ItemVariantTestingParameter.Maximum := ItemVariantTestingParameter2.Maximum;
                                ItemVariantTestingParameter.Minimum := ItemVariantTestingParameter2.Minimum;
                                ItemVariantTestingParameter.Value2 := ItemVariantTestingParameter2.Value2;
                                ItemVariantTestingParameter.Priority := ItemVariantTestingParameter2.Priority;
                                ItemVariantTestingParameter."Show in COA" := ItemVariantTestingParameter2."Show in COA";
                                ItemVariantTestingParameter."Data Type" := ItemVariantTestingParameter2."Data Type";
                                ItemVariantTestingParameter.Symbol := ItemVariantTestingParameter2.Symbol;
                                ItemVariantTestingParameter."Default Value" := ItemVariantTestingParameter2."Default Value";
                                ItemVariantTestingParameter.Modify;
                            end;
                        UNTIL ItemVariantTestingParameter2.Next = 0;
                    Message(Test003, ItemNoNew, ItemVariantNew, ItemVariantTestingParameter2.Code);
                END ELSE begin
                    IF (ItemNoNew <> '') and (ItemVariantNew <> '') and (TPCode <> '') THEN BEGIN
                        IF NOT Confirm('Do you want to copy item :' + ItemNoNew + ' and Variant code :' + ItemVariantNew + ' testing parameter :' + TPCode + ' ?') THEN
                            exit;
                        ItemVariantTestingParameter2.RESET;
                        ItemVariantTestingParameter2.SetFilter("Item No.", ItemNoNew);
                        ItemVariantTestingParameter2.SetFilter("Variant Code", ItemVariantNew);
                        ItemVariantTestingParameter2.SetFilter(Code, TPCode);
                        IF ItemVariantTestingParameter2.FindSet THEN
                            repeat
                                ItemVariantTestingParameter.RESET;
                                ItemVariantTestingParameter.SetFilter("Item No.", ItemNo);
                                ItemVariantTestingParameter.SetFilter("Variant Code", ItemVariant);
                                ItemVariantTestingParameter.SetRange(Code, ItemVariantTestingParameter2.Code);
                                IF NOT ItemVariantTestingParameter.FindFirst THEN begin
                                    ItemVariantTestingParameter.Init;
                                    ItemVariantTestingParameter."Item No." := ItemNo;
                                    ItemVariantTestingParameter."Variant Code" := ItemVariant;
                                    ItemVariantTestingParameter.Code := ItemVariantTestingParameter2.Code;
                                    ItemVariantTestingParameter.Insert;
                                    ItemVariantTestingParameter."Testing Parameter" := ItemVariantTestingParameter2."Testing Parameter";
                                    ItemVariantTestingParameter.Maximum := ItemVariantTestingParameter2.Maximum;
                                    ItemVariantTestingParameter.Minimum := ItemVariantTestingParameter2.Minimum;
                                    ItemVariantTestingParameter.Value2 := ItemVariantTestingParameter2.Value2;
                                    ItemVariantTestingParameter.Priority := ItemVariantTestingParameter2.Priority;
                                    ItemVariantTestingParameter."Show in COA" := ItemVariantTestingParameter2."Show in COA";
                                    ItemVariantTestingParameter."Data Type" := ItemVariantTestingParameter2."Data Type";
                                    ItemVariantTestingParameter.Symbol := ItemVariantTestingParameter2.Symbol;
                                    ItemVariantTestingParameter."Default Value" := ItemVariantTestingParameter2."Default Value";
                                    ItemVariantTestingParameter.Modify;
                                end;
                            UNTIL ItemVariantTestingParameter2.Next = 0;
                        Message(Test003, ItemNoNew, ItemVariantNew, ItemVariantTestingParameter.Code);
                    end;
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
                field("To Item No"; ItemNo)
                {
                    ApplicationArea = all;
                    TableRelation = Item;
                    Editable = FALSE;
                }
                field("To Variant Code"; ItemVariant)
                {
                    ApplicationArea = all;
                    TableRelation = "Item Variant".Code;
                    Editable = FALSE;
                }
                field("From Item No"; ItemNoNew)
                {
                    ApplicationArea = all;
                    TableRelation = Item;
                }
                field("From Variant Code"; ItemVariantNew)
                {
                    ApplicationArea = all;
                    //TableRelation = "Item Variant".Code;
                    trigger OnLookup(var Text: Text): Boolean
                    var
                        ItemVariant: Record "Item Variant";
                        ItemVariantPage: Page "Item Variants";
                        SelectionFilterManagement: Codeunit SelectionFilterManagement;
                        RecRef: RecordRef;
                    begin
                        IF ItemNoNew = '' then
                            Error('Please select item no.');
                        ItemVariant.FILTERGROUP(2);
                        ItemVariant.SETRANGE("Item No.", ItemNoNew);
                        ItemVariantPage.SetTableView(ItemVariant);
                        ItemVariantPage.LookupMode(true);
                        if ItemVariantPage.RunModal = ACTION::LookupOK then begin
                            ItemVariantPage.SetSelectionFilter(ItemVariant);
                            RecRef.GetTable(ItemVariant);
                            ItemVariantNew := SelectionFilterManagement.GetSelectionFilter(RecRef, ItemVariant.FieldNo(Code));
                        end;
                    end;
                }
                field("Testing Parameter Code"; TPCode)
                {
                    ApplicationArea = all; //AJAY >>                    
                    trigger OnLookup(var Text: Text): Boolean
                    var
                        Itemtestingparameter: Record "Item Testing Parameter";
                        ItemTestingParameterPage: Page "Item Testing Parameters";
                        ItemVariantTestingParameter: Record "Item Variant Testing Parameter";
                        ItemVariantTestingParameterPage: Page "Item Variant Test Parameters";
                        SelectionFilterManagement: Codeunit SelectionFilterManagement;
                        RecRef: RecordRef;
                    begin
                        IF ItemNoNew = '' then
                            Error('Please select item no.');
                        IF (ItemNoNew <> '') AND (ItemVariantNew = '') THEN BEGIN
                            Clear(TPCode);
                            Itemtestingparameter.FILTERGROUP(2);
                            Itemtestingparameter.SETRANGE("Item No.", ItemNoNew);
                            ItemTestingParameterPage.SetTableView(Itemtestingparameter);
                            ItemTestingParameterPage.LookupMode(true);
                            if ItemTestingParameterPage.RunModal = ACTION::LookupOK then begin
                                ItemTestingParameterPage.SetSelectionFilter(Itemtestingparameter);
                                RecRef.GetTable(Itemtestingparameter);
                                TPCode := SelectionFilterManagement.GetSelectionFilter(RecRef, Itemtestingparameter.FieldNo(Code));
                            end;
                        END;
                        IF (ItemNoNew <> '') AND (ItemVariantNew <> '') THEN BEGIN
                            Clear(TPCode);
                            ItemVariantTestingParameter.FILTERGROUP(2);
                            ItemVariantTestingParameter.SETRANGE("Item No.", ItemNoNew);
                            ItemVariantTestingParameter.SETRANGE("Variant Code", ItemVariantNew);
                            ItemVariantTestingParameterPage.SetTableView(ItemVariantTestingParameter);
                            ItemVariantTestingParameterPage.LookupMode(true);
                            if ItemVariantTestingParameterPage.RunModal = ACTION::LookupOK then begin
                                ItemVariantTestingParameterPage.SetSelectionFilter(ItemVariantTestingParameter);
                                RecRef.GetTable(ItemVariantTestingParameter);
                                TPCode := SelectionFilterManagement.GetSelectionFilter(RecRef, ItemVariantTestingParameter.FieldNo(Code));
                            end;
                        END;
                    end;  //AJAY <<
                }
            }
        }
        trigger OnInit()
        var
        begin

        end;
    }
    trigger OnPreReport()
    var
    begin
        IF ItemNoNew = '' THEN
            Error('Please select item no.');
    end;

    procedure ReportFiletr2(ItemNo2: Code[100]; ItemVariant2: code[100])
    begin
        ItemNo := ItemNo2;
        ItemNoNew := ItemNo2;
        ItemVariant := ItemVariant2;
        ItemVariantNew := ItemVariant2;
    end;

    var
        ItemNo: Code[100];
        ItemNoNew: Code[100];
        ItemVariant: Code[100];
        ItemVariantNew: Code[100];
        TPCode: code[100];
}