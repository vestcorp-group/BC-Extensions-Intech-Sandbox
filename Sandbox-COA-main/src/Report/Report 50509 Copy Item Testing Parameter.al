report 50509 "Copy Item Testing Parameter"
{
    UsageCategory = Administration;
    ApplicationArea = All;
    Caption = 'Copy Item Testing Parameter';
    DefaultLayout = RDLC;
    ProcessingOnly = true;
    UseRequestPage = true;

    dataset
    {
        dataitem(Item; Item)
        {
            //RequestFilterFields = "No.";
            trigger OnPreDataItem()
            var
            begin
                IF ItemNo <> '' THEN
                    Item.SetRange("No.", ItemNo);
            end;

            trigger OnAfterGetRecord()
            var
                ItemTestingParameter: Record "Item Testing Parameter";
                ItemTestingParameter2: Record "Item Testing Parameter";
                ItemTestingParameter3: Record "Item Testing Parameter";
                ItemVariantTestingParameter: Record "Item Variant Testing Parameter";
                ItemVariantTestingParameter2: Record "Item Variant Testing Parameter";
                Test002: Label 'Item No. :%1 and Testing Parameter :%2 are already created !';
                Test003: Label 'Item No. :%1 and Testing Parameter :%2 are created successfully !';
            begin
                IF NOT Confirm('Do you want to copy item :' + ItemNo + ' testing parameter :' + TPCode + ' ?') THEN
                    exit;
                IF (ItemNoNew <> '') AND (TPCode <> '') AND (ItemVariant = '') THEN BEGIN
                    IF ItemNo = ItemNoNew THEN BEGIN
                        ItemTestingParameter.RESET;
                        ItemTestingParameter.SetRange("Item No.", ItemNo);
                        ItemTestingParameter.SetFilter(Code, TPCode);
                        IF Not ItemTestingParameter.FindFirst THEN BEGIN
                            ItemTestingParameter2.Init;
                            ItemTestingParameter2."Item No." := ItemNo;
                            ItemTestingParameter2.Code := TPCode;
                            ItemTestingParameter2.Insert;
                            ItemTestingParameter2."Testing Parameter" := ItemTestingParameter."Testing Parameter";
                            ItemTestingParameter2.Maximum := ItemTestingParameter.Maximum;
                            ItemTestingParameter2.Minimum := ItemTestingParameter.Minimum;
                            ItemTestingParameter2.Value2 := ItemTestingParameter.Value2;
                            ItemTestingParameter2.Priority := ItemTestingParameter.Priority;
                            ItemTestingParameter2."Show in COA" := ItemTestingParameter."Show in COA";
                            ItemTestingParameter2."Data Type" := ItemTestingParameter."Data Type";
                            ItemTestingParameter2.Symbol := ItemTestingParameter.Symbol;
                            ItemTestingParameter2."Default Value" := ItemTestingParameter."Default Value";
                            ItemTestingParameter2.Modify;
                            Message(Test003, ItemNo, TPCode);
                        end ELSE
                            Message(Test002, ItemNo, TPCode);
                    END ELSE begin
                        ItemTestingParameter3.RESET;
                        ItemTestingParameter3.SetRange("Item No.", ItemNoNew);
                        ItemTestingParameter3.SetFilter(Code, TPCode);
                        IF ItemTestingParameter3.FindFirst THEN
                            repeat
                                ItemTestingParameter.RESET;
                                ItemTestingParameter.SetRange("Item No.", ItemNo);
                                ItemTestingParameter.SetFilter(Code, ItemTestingParameter3.Code);
                                IF Not ItemTestingParameter.FindFirst THEN BEGIN
                                    ItemTestingParameter2.Init;
                                    ItemTestingParameter2."Item No." := ItemNo;
                                    ItemTestingParameter2.Code := ItemTestingParameter3.Code;
                                    ItemTestingParameter2.Insert;
                                    ItemTestingParameter2."Testing Parameter" := ItemTestingParameter3."Testing Parameter";
                                    ItemTestingParameter2.Maximum := ItemTestingParameter3.Maximum;
                                    ItemTestingParameter2.Minimum := ItemTestingParameter3.Minimum;
                                    ItemTestingParameter2.Value2 := ItemTestingParameter3.Value2;
                                    ItemTestingParameter2.Priority := ItemTestingParameter3.Priority;
                                    ItemTestingParameter2."Show in COA" := ItemTestingParameter3."Show in COA";
                                    ItemTestingParameter2."Data Type" := ItemTestingParameter3."Data Type";
                                    ItemTestingParameter2.Symbol := ItemTestingParameter3.Symbol;
                                    ItemTestingParameter2."Default Value" := ItemTestingParameter3."Default Value";
                                    ItemTestingParameter2.Modify;
                                end;
                            until ItemTestingParameter3.Next = 0;
                        Message(Test003, ItemNo, TPCode);
                    end;
                END ELSE begin
                    IF (ItemNoNew <> '') AND (ItemVariant = '') AND (TPCode = '') THEN BEGIN
                        ItemTestingParameter3.RESET;
                        ItemTestingParameter3.SetRange("Item No.", ItemNoNew);
                        IF ItemTestingParameter3.FindFirst THEN
                            repeat
                                ItemTestingParameter.RESET;
                                ItemTestingParameter.SetRange("Item No.", ItemNo);
                                ItemTestingParameter.SetFilter(Code, ItemTestingParameter3.Code);
                                IF Not ItemTestingParameter.FindFirst THEN BEGIN
                                    ItemTestingParameter2.Init;
                                    ItemTestingParameter2."Item No." := ItemNo;
                                    ItemTestingParameter2.Code := ItemTestingParameter3.Code;
                                    ItemTestingParameter2.Insert;
                                    ItemTestingParameter2."Testing Parameter" := ItemTestingParameter3."Testing Parameter";
                                    ItemTestingParameter2.Maximum := ItemTestingParameter3.Maximum;
                                    ItemTestingParameter2.Minimum := ItemTestingParameter3.Minimum;
                                    ItemTestingParameter2.Value2 := ItemTestingParameter3.Value2;
                                    ItemTestingParameter2.Priority := ItemTestingParameter3.Priority;
                                    ItemTestingParameter2."Show in COA" := ItemTestingParameter3."Show in COA";
                                    ItemTestingParameter2."Data Type" := ItemTestingParameter3."Data Type";
                                    ItemTestingParameter2.Symbol := ItemTestingParameter3.Symbol;
                                    ItemTestingParameter2."Default Value" := ItemTestingParameter3."Default Value";
                                    ItemTestingParameter2.Modify;
                                end;
                            until ItemTestingParameter3.Next = 0;
                    END;
                    Message(Test003, ItemNo, TPCode);
                end;
                IF (ItemNoNew <> '') AND (ItemVariant <> '') AND (TPCode = '') THEN BEGIN
                    ItemVariantTestingParameter.RESET;
                    ItemVariantTestingParameter.SetRange("Item No.", ItemNoNew);
                    ItemVariantTestingParameter.SetFilter("Variant Code", ItemVariant);
                    IF ItemVariantTestingParameter.FindSet THEN
                        repeat
                            ItemTestingParameter.RESET;
                            ItemTestingParameter.SetRange("Item No.", ItemNo);
                            ItemTestingParameter.SetFilter(Code, ItemVariantTestingParameter.Code);
                            IF Not ItemTestingParameter.FindFirst THEN BEGIN
                                ItemTestingParameter2.Init;
                                ItemTestingParameter2."Item No." := ItemNo;
                                ItemTestingParameter2.Code := ItemVariantTestingParameter.Code;
                                ItemTestingParameter2.Insert;
                                ItemTestingParameter2."Testing Parameter" := ItemVariantTestingParameter."Testing Parameter";
                                ItemTestingParameter2.Maximum := ItemVariantTestingParameter.Maximum;
                                ItemTestingParameter2.Minimum := ItemVariantTestingParameter.Minimum;
                                ItemTestingParameter2.Value2 := ItemVariantTestingParameter.Value2;
                                ItemTestingParameter2.Priority := ItemVariantTestingParameter.Priority;
                                ItemTestingParameter2."Show in COA" := ItemVariantTestingParameter."Show in COA";
                                ItemTestingParameter2."Data Type" := ItemVariantTestingParameter."Data Type";
                                ItemTestingParameter2.Symbol := ItemVariantTestingParameter.Symbol;
                                ItemTestingParameter2."Default Value" := ItemVariantTestingParameter."Default Value";
                                ItemTestingParameter2.Modify;
                            END;
                        UNTIL ItemVariantTestingParameter.NEXT = 0;
                    Message(Test003, ItemNo, TPCode);
                END ELSE begin
                    IF (ItemNoNew <> '') AND (ItemVariant <> '') AND (TPCode <> '') THEN BEGIN
                        ItemVariantTestingParameter.RESET;
                        ItemVariantTestingParameter.SetRange("Item No.", ItemNoNew);
                        ItemVariantTestingParameter.SetFilter("Variant Code", ItemVariant);
                        ItemVariantTestingParameter.SetFilter(Code, TPCode);
                        IF ItemVariantTestingParameter.FindSet THEN
                            repeat
                                ItemTestingParameter.RESET;
                                ItemTestingParameter.SetRange("Item No.", ItemNo);
                                ItemTestingParameter.SetFilter(Code, ItemVariantTestingParameter.Code);
                                IF Not ItemTestingParameter.FindFirst THEN BEGIN
                                    ItemTestingParameter2.Init;
                                    ItemTestingParameter2."Item No." := ItemNo;
                                    ItemTestingParameter2.Code := ItemVariantTestingParameter.Code;
                                    ItemTestingParameter2.Insert;
                                    ItemTestingParameter2."Testing Parameter" := ItemVariantTestingParameter."Testing Parameter";
                                    ItemTestingParameter2.Maximum := ItemVariantTestingParameter.Maximum;
                                    ItemTestingParameter2.Minimum := ItemVariantTestingParameter.Minimum;
                                    ItemTestingParameter2.Value2 := ItemVariantTestingParameter.Value2;
                                    ItemTestingParameter2.Priority := ItemVariantTestingParameter.Priority;
                                    ItemTestingParameter2."Show in COA" := ItemVariantTestingParameter."Show in COA";
                                    ItemTestingParameter2."Data Type" := ItemVariantTestingParameter."Data Type";
                                    ItemTestingParameter2.Symbol := ItemVariantTestingParameter.Symbol;
                                    ItemTestingParameter2."Default Value" := ItemVariantTestingParameter."Default Value";
                                    ItemTestingParameter2.Modify;
                                END;
                            UNTIL ItemVariantTestingParameter.NEXT = 0;
                        Message(Test003, ItemNo, TPCode);
                    END;
                end;
            END;
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
                    Editable = false;
                }
                field("From Item No"; ItemNoNew)
                {
                    ApplicationArea = all;
                    TableRelation = Item;
                }
                field("From Variant Code"; ItemVariant)
                {
                    ApplicationArea = all;
                    //TableRelation = "Item Variant".Code;
                    trigger OnLookup(var Text: Text): Boolean
                    var
                        ItemVariantRec: Record "Item Variant";
                        ItemVariantPage: Page "Item Variants";
                        SelectionFilterManagement: Codeunit SelectionFilterManagement;
                        RecRef: RecordRef;
                    begin
                        IF ItemNoNew = '' then
                            Error('Please select item no.');
                        ItemVariantRec.FILTERGROUP(2);
                        ItemVariantRec.SETRANGE("Item No.", ItemNoNew);
                        ItemVariantPage.SetTableView(ItemVariantRec);
                        ItemVariantPage.LookupMode(true);
                        if ItemVariantPage.RunModal = ACTION::LookupOK then begin
                            ItemVariantPage.SetSelectionFilter(ItemVariantRec);
                            RecRef.GetTable(ItemVariantRec);
                            ItemVariant := SelectionFilterManagement.GetSelectionFilter(RecRef, ItemVariantRec.FieldNo(Code));
                        end;
                    end;
                }
                field("Testing Parameter Code"; TPCode)
                {
                    ApplicationArea = all;  //AJAY >>                    
                    trigger OnLookup(var Text: Text): Boolean
                    var
                        Itemtestingparameter: Record "Item Testing Parameter";
                        ItemTestingParameterPage: Page "Item Testing Parameters";
                        ItemVariantTestingParameter: Record "Item Variant Testing Parameter";
                        ItemVariantTestingParameterPage: page "Item Variant Test Parameters";
                        SelectionFilterManagement: Codeunit SelectionFilterManagement;
                        RecRef: RecordRef;

                    begin
                        IF ItemNoNew = '' then
                            Error('Please select item no.');

                        IF (ItemNoNew <> '') and (ItemVariant = '') then begin
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
                        end;
                        IF (ItemNoNew <> '') and (ItemVariant <> '') then begin
                            Clear(TPCode);
                            ItemVariantTestingParameter.FILTERGROUP(2);
                            ItemVariantTestingParameter.SETRANGE("Item No.", ItemNoNew);
                            ItemVariantTestingParameter.SETRANGE("Variant Code", ItemVariant);
                            ItemVariantTestingParameterPage.SetTableView(ItemVariantTestingParameter);
                            ItemVariantTestingParameterPage.LookupMode(true);
                            if ItemVariantTestingParameterPage.RunModal = ACTION::LookupOK then begin
                                ItemVariantTestingParameterPage.SetSelectionFilter(ItemVariantTestingParameter);
                                RecRef.GetTable(ItemVariantTestingParameter);
                                TPCode := SelectionFilterManagement.GetSelectionFilter(RecRef, ItemVariantTestingParameter.FieldNo(Code));
                            end;
                        end;
                    end; //AJAY <<
                }
            }
        }
        trigger OnInit()
        var
        begin
            //ItemNo := item."No.";
        end;
    }
    trigger OnPreReport()
    var
    begin
        IF ItemNo = '' THEN
            Error('Please select item no.');
    end;

    procedure ReportFiletr2(ItemNo2: Code[100])
    begin
        ItemNo := ItemNo2;
        ItemNoNew := ItemNo2;
    end;

    var
        ItemNo: Code[100];
        ItemNoNew: Code[100];
        ItemVariant: code[100];
        TPCode: code[100];
}