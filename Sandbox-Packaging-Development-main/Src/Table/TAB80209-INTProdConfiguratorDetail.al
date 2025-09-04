table 80209 "INT Pack. Configurator Detail"
{
    // -----------------------------------------------------------------------------------------------------------------------------
    // Intech Systems Pvt. Ltd. - support@intech-systems.com
    // -----------------------------------------------------------------------------------------------------------------------------
    // ID                        Date            Author
    // -----------------------------------------------------------------------------------------------------------------------------
    // 1.0.0.0                  07/04/18        Intech Systems Pvt. Ltd.
    // -----------------------------------------------------------------------------------------------------------------------------

    DataCaptionFields = "Configurator No.";
    Caption = 'Packaging Configurator Detail';

    fields
    {
        field(70144421; "Configurator No."; Code[20])
        {
            Caption = 'Configurator No.';
            DataClassification = CustomerContent;
        }
        field(70144422; "Line No."; Integer)
        {
            Caption = 'Line No.';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(70144441; "Product Code"; Code[20])
        {
            Caption = 'Product Code';
            TableRelation = "INT Packaging"."Product Code" WHERE(Approved = FILTER(true),
                                                                 Blocked = FILTER(false));
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                IF ("Product Code" <> '') THEN BEGIN
                    ProductGlobal.GET("Product Code");
                    "Product Description" := ProductGlobal."Product Description";
                END ELSE BEGIN
                    "Product Description" := '';
                END;
            end;
        }
        field(70144442; "Product Description"; Text[50])
        {
            Caption = 'Product Description';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(70144443; "Assembly Code"; Code[20])
        {
            Caption = 'Assembly Code';
            Editable = false;
            TableRelation = "INT Packaging Assembly"."Assembly Code" WHERE("Product Code" = FIELD("Product Code"));
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TESTFIELD("Product Code");
                IF "Assembly Code" <> '' THEN BEGIN
                    ProductAssy.GET("Product Code", "Assembly Code");
                    "Assembly Description" := ProductAssy."Assembly Description";
                END ELSE
                    "Assembly Description" := '';
            end;
        }
        field(70144444; "Serial No"; Integer)
        {
            Caption = 'Serial No';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(70144445; "Assembly Line No."; Integer)
        {
            Caption = 'Line No.';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(70144447; "Assembly Description"; Text[50])
        {
            Caption = 'Assembly Description';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(70144448; "Parameter Code"; Code[20])
        {
            Caption = 'Parameter Code';
            Editable = false;
            TableRelation = "INT Packaging Parameter"."Packaging Parameter Code";
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                IF "Parameter Code" <> '' THEN BEGIN
                    ProductParameterGlobal.GET("Parameter Code");
                    "Parameter Description" := ProductParameterGlobal."Packaging Parameter Description";
                END ELSE
                    "Parameter Description" := '';
            end;
        }
        field(70144449; "Parameter Description"; Text[50])
        {
            Caption = 'Parameter Description';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(70144450; "Parameter Value"; Code[20])
        {
            Caption = 'Parameter Value';
            TableRelation = "INT Pack Param Relationship"."Parameter Value" WHERE("Product Code" = FIELD("Product Code"),
                                                                                      "Parameter Code" = FIELD("Parameter Code"));
            DataClassification = CustomerContent;

            trigger OnLookup();
            begin
                //LookupParameter();
            end;

            trigger OnValidate();
            begin
                IF "Parameter Value" <> xRec."Parameter Value" THEN BEGIN
                    ProductParemeterDependenceGlobal.RESET();
                    ProductParemeterDependenceGlobal.SETRANGE("Product Code", "Product Code");
                    ProductParemeterDependenceGlobal.SETRANGE("Parameter Depend On", "Parameter Code");
                    IF ProductParemeterDependenceGlobal.FINDFIRST() THEN
                        REPEAT
                            ProductConfiDetail2Global.RESET();
                            ProductConfiDetail2Global.SETRANGE("Configurator No.", "Configurator No.");
                            ProductConfiDetail2Global.SETRANGE("Product Code", "Product Code");
                            ProductConfiDetail2Global.SETRANGE("Parameter Code", ProductParemeterDependenceGlobal."Parameter Code");
                            ProductConfiDetail2Global.SETRANGE(Type, ProductConfiDetail2Global.Type::Parameter);
                            IF ProductConfiDetail2Global.FINDFIRST() THEN BEGIN
                                ProductConfiDetail2Global."Parameter Value" := '';
                                ProductConfiDetail2Global."Parameter Value Description" := '';
                                ProductConfiDetail2Global."Code for Item" := '';
                                ProductConfiDetail2Global.MODIFY();
                            END;
                        UNTIL ProductParemeterDependenceGlobal.NEXT() = 0;

                END;

                IF "Parameter Value" <> '' THEN BEGIN
                    GetParameterValues(P1Value, P2Value, P3Value, P4Value, P5Value, P6Value);
                    ProdParameterRelation.SETRANGE("Parameter Value", "Parameter Value");
                    ProdParameterRelation.FINDFIRST();
                    "Parameter Value Description" := ProdParameterRelation."Parameter Value Description";

                    "Code for Item" := ProdParameterRelation."Code for Item";
                END ELSE BEGIN
                    "Parameter Value Description" := '';
                    "Code for Item" := '';
                END;
                //For Set Visible Boolean - N
                UpdateVisibleParameterLine();
            end;
        }
        field(70144451; "Parameter Value Description"; Text[50])
        {
            Caption = 'Parameter Value Description';
            DataClassification = CustomerContent;
        }
        field(70144452; Mandatory; Boolean)
        {
            Caption = 'Mandatory';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(70144453; "Code for Item"; Code[5])
        {
            Caption = 'Code for Item';
            DataClassification = CustomerContent;
        }
        field(70144454; Type; Option)
        {
            Caption = 'Type';
            Editable = false;
            OptionCaption = 'Product,Assembly,Parameter';
            OptionMembers = Product,Assembly,Parameter;
            DataClassification = CustomerContent;
        }
        field(70144455; "Creation Date"; Date)
        {
            Caption = 'Creation Date';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(70144456; "Created By"; Code[50])
        {
            Caption = 'Created By';
            Editable = false;
            TableRelation = User."User Name";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
            DataClassification = CustomerContent;
        }
        field(70144457; "Last Date Modified"; Date)
        {
            Caption = 'Last Date Modified';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(70144458; Status; Option)
        {
            Caption = 'Status';
            OptionCaption = 'New,Certified';
            OptionMembers = New,Certified;
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                IF Status = Status::Certified THEN BEGIN
                    TESTFIELD("Product Code");
                    CheckforParameterValues();
                END;
            end;
        }
        field(70144462; "Packaging Code Exists"; Boolean)
        {
            Caption = 'Packaging Code Exists';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(70144463; "Suggested Packaging Code"; Code[250])
        {
            //Caption = 'Suggested Item Code';
            Caption = 'Suggested Packaging Code';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(70144469; "Suggested Code"; Code[250])
        {
            Caption = 'Suggested Code';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(70144475; "Set Visible on Page"; Boolean)
        {
            Caption = 'Set Visible on Page';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(70144476; "Allow Multiple Selection"; Boolean)
        {
            Caption = 'Allow Multiple Selection';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(70144479; "Text Parameter"; Boolean)
        {
            Caption = 'Text Parameter';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(70144483; "Suggested Description"; Text[1024])//100325
        {
            Caption = 'Suggested Description';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(70144484; "Packaging Code Created"; Code[250])
        {
            Caption = 'Packaging Code Created';
            Editable = false;
            DataClassification = CustomerContent;
            TableRelation = "Packaging Detail Header";
        }
    }

    keys
    {
        key(Key1; "Configurator No.", "Line No.")
        {
        }
        key(Key2; "Product Code", "Assembly Code", "Serial No")
        {
        }
        key(Key3; "Assembly Line No.")
        {
        }
        key(Key4; "Serial No")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete();
    var
        SalesLine: Record "Sales Line";
    begin
        TESTFIELD(Status, Status::New);
        IF "Line No." = 0 THEN BEGIN
            ProductConfiDetail2Global.RESET();
            ProductConfiDetail2Global.SETRANGE("Configurator No.", "Configurator No.");
            ProductConfiDetail2Global.SETFILTER("Line No.", '<>0');
            IF ProductConfiDetail2Global.FINDSET() THEN
                ProductConfiDetail2Global.DELETEALL(TRUE);
        END;
    end;

    trigger OnInsert();
    var
        UserSetup: Record "User Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
    begin
        TESTFIELD(Status, Status::New);
        IF ("Line No." = 0) AND ("Configurator No." = '') THEN BEGIN
            ProductConfigSetupGlobal.GET();
            ProductConfigSetupGlobal.TESTFIELD("Configurator Nos.");
            "Configurator No." := NoSeriesMgt.GetNextNo(ProductConfigSetupGlobal."Configurator Nos.", WORKDATE(), TRUE);
        END;
        IF ("Line No." = 0) THEN BEGIN
            "Creation Date" := TODAY();
            "Created By" := copystr(USERID(), 1, 50);

            UserSetup.GET(USERID());
        END;
    end;

    trigger OnModify();
    begin
        "Last Date Modified" := TODAY();
    end;

    procedure SuggestPackagingCode_gFnc()
    var
        myInt: Integer;
        ProductConfiDetail: Record "INT Pack. Configurator Detail";
    begin
        CLEAR(SuggestedCode);
        CLEAR(GeneratedItemCode);
        ItemCodeDoesntExist := FALSE;
        TotalProductPrice := 0;
        IF GUIALLOWED() THEN
            IF NOT CONFIRM(ConfirmCreateSuggestedQst) THEN
                EXIT;
        ProductConfiDetail.RESET();
        ProductConfiDetail.SETRANGE("Configurator No.", "Configurator No.");
        ProductConfiDetail.SETRANGE("Line No.", 0);
        ProductConfiDetail.FINDFIRST();
        ProductConfiDetail.TESTFIELD(Status, Status::New);


        ProductConfiDetail2Global.RESET();
        ProductConfiDetail2Global.SETRANGE("Configurator No.", "Configurator No.");
        ProductConfiDetail2Global.SETRANGE(Type, ProductConfiDetail2Global.Type::Parameter);
        //ProductConfiDetail2Global.SETFILTER("Line No.",'<>0');
        ProductConfiDetail2Global.SETCURRENTKEY("Serial No");
        ItemLengthExceed := FALSE;
        IF ProductConfiDetail2Global.FINDSET() THEN
            REPEAT
                ProductConfiDetail2Global.TestField("Code for Item");
                ProductConfiDetail2Global.TestField("Parameter Value Description");
                IF STRLEN(SuggestedCode) + STRLEN(ProductConfiDetail2Global."Code for Item") <= MAXSTRLEN(SuggestedCode) THEN
                    IF SuggestedCode = '' THEN begin
                        SuggestedCode := ProductConfiDetail2Global."Code for Item";
                    end ELSE BEGIN
                        SuggestedCode := SuggestedCode + ProductConfiDetail2Global."Code for Item";
                    END
                ELSE BEGIN
                    Error('Suggested Packaging Code Length has increased more than 250 characters which is not valid.');
                END;

                IF STRLEN(SuggestedDesc) + STRLEN(ProductConfiDetail2Global."Parameter Value Description") <= MAXSTRLEN(SuggestedDesc) THEN
                    IF SuggestedDesc = '' THEN begin
                        SuggestedDesc := ProductConfiDetail2Global."Parameter Value Description"
                    end ELSE BEGIN
                        SuggestedDesc += ',' + ProductConfiDetail2Global."Parameter Value Description";
                    END
                ELSE BEGIN
                    Error('Suggested Packaging Description Length has increased more than 1024 characters which is not valid.');
                END;
            UNTIL ProductConfiDetail2Global.NEXT() = 0;



        ProductConfiDetail."Suggested Code" := SuggestedCode;
        ProductConfiDetail."Suggested Description" := SuggestedDesc;
        ProductConfiDetail.MODIFY();


    end;

    procedure GeneratePackagingCode_gfnc();
    var
        ProdConfiguratorDetail2: Record "INT Pack. Configurator Detail";

        PackingDtlHdr_lRec: Record "Packaging Detail Header";
    begin
        TestField("Suggested Code");
        TestField("Suggested Description");
        IF GUIALLOWED() THEN
            IF NOT CONFIRM(ConfirmAcceptQst) THEN
                EXIT;
        ProdConfiguratorDetail2.RESET();
        ProdConfiguratorDetail2.SETRANGE("Configurator No.", "Configurator No.");
        ProdConfiguratorDetail2.SETRANGE("Line No.", 0);
        ProdConfiguratorDetail2.FINDFIRST();
        ProdConfiguratorDetail2.TESTFIELD(Status, ProdConfiguratorDetail2.Status::Certified);
        ProdConfiguratorDetail2.TestField("Suggested Code");

        PackingDtlHdr_lRec.Reset();
        PackingDtlHdr_lRec.SetRange("Packaging Code", ProdConfiguratorDetail2."Suggested Code");
        IF PackingDtlHdr_lRec.FINDFIRST() THEN
            Error('Suggested Packaging Code:%1 already exist in Packaging Detail Header', ProdConfiguratorDetail2."Suggested Code")
        else begin
            Clear(PackingDtlHdr_lRec);
            PackingDtlHdr_lRec.Init();
            PackingDtlHdr_lRec."Packaging Code" := ProdConfiguratorDetail2."Suggested Code";
            PackingDtlHdr_lRec."Product Code" := ProdConfiguratorDetail2."Product Code";
            PackingDtlHdr_lRec.Description := ProdConfiguratorDetail2."Suggested Description";
            PackingDtlHdr_lRec.Insert();

            ProdConfiguratorDetail2."Packaging Code Created" := PackingDtlHdr_lRec."Packaging Code";
            ProdConfiguratorDetail2.Modify();
        end;
    end;

    var


        ProductGlobal: Record "INT Packaging";
        ProductAssy: Record "INT Packaging Assembly";
        ProductConfiDetailGlobal: Record "INT Pack. Configurator Detail";
        ProductConfiDetail2Global: Record "INT Pack. Configurator Detail";
        ProductAssyDetailsGlobal: Record "INT Packaging Parameters";
        ProductParameterGlobal: Record "INT Packaging Parameter";
        ProdParameterRelation: Record "INT Pack Param Relationship";
        ProductParemeterDependenceGlobal: Record "INT Packaging Param Dependency";
        ItemGlobal: Record Item;
        DataTemplateHeader: Record "Config. Template Header";
        DataTemplateLine: Record "Config. Template Line";
        ItemUnitOfMeasure: Record "Item Unit of Measure";
        ProductConfigSetupGlobal: Record "INT Packaging Config Setup";
        TemplateMgt: Codeunit "Config. Template Management";
        RecRef: RecordRef;
        LastLineNo: Integer;
        I: Integer;
        P1Value: Code[250];
        P2Value: Code[250];
        P3Value: Code[250];
        P4Value: Code[250];
        P5Value: Code[250];
        P6Value: Code[250];
        GeneratedItemCode: Code[250];
        ItemCodesMsg: Label 'Item Codes are suggested successfully. Some Assembly Item Codes are not available in Item Master.';
        ConfirmCreateSuggestedQst: Label 'Do you want to create Suggested Pacakaging Code ?';   //Comment-Mayank
        SuccessMsg: Label 'Item Codes are suggested successfully.';
        SuggestedCode: Code[250]; //10032025
        SuggestedDesc: Text[1024]; //10032025
        ItemCodeDoesntExist: Boolean;
        TotalProductPrice: Decimal;
        ConfirmAcceptQst: Label 'Do you want to accept Configurator ?';
        Text00005Err: Label 'Either "Suggested Item Code" or "No Series" must not be emply for Configurator No. = ''%1''.';
        Text00006Msg: Label 'Packaging Configurator has been accepted successfully.\New Created Item code = ''%1''.';
        ItemLengthExceed: Boolean;
        AcceptanceMsg: Label 'Packaging Configurator has been accepted successfully.';
        Text00008Err: Label '"No Series" must not be emply for Configurator No. = ''%1''.';

    procedure AssistEdit(): Boolean;
    var
        NoSeriesManagement: Codeunit NoSeriesManagement;
    begin
        ProductConfigSetupGlobal.GET();
        ProductConfigSetupGlobal.TESTFIELD("Configurator Nos.");
        IF NoSeriesManagement.SelectSeries(ProductConfigSetupGlobal."Configurator Nos.",
                                         ProductConfigSetupGlobal."Configurator Nos.",
                                         ProductConfigSetupGlobal."Configurator Nos.")
        THEN BEGIN
            NoSeriesManagement.SetSeries("Configurator No.");
            EXIT(TRUE);
        END;
    end;

    procedure GetParameterandAssembly();
    var
        ProdConfigDetail: Record "INT Pack. Configurator Detail";
        ProductConfiDetail: Record "INT Pack. Configurator Detail";
        ProductParemeterDependencLocal: Record "INT Packaging Param Dependency";
        ProductConfigurationDetail: Record "INT Pack. Configurator Detail";
    begin
        ProdConfigDetail.RESET();
        ProdConfigDetail.SETRANGE("Configurator No.", "Configurator No.");
        ProdConfigDetail.SETRANGE("Line No.", 0);
        IF ProdConfigDetail.FINDFIRST() THEN BEGIN
            ProdConfigDetail.TESTFIELD("Product Code");
            ProdConfigDetail.TESTFIELD(Status, Status::New);
        END;
        ProductAssy.RESET();
        ProductAssy.SETRANGE("Product Code", "Product Code");
        IF ProductConfiDetailGlobal.FINDLAST() THEN
            LastLineNo := ProductConfiDetailGlobal."Line No.";

        IF ProductAssy.FINDFIRST() THEN
            REPEAT
                ProductConfiDetailGlobal.INIT();
                ProductConfiDetailGlobal."Configurator No." := "Configurator No.";
                ProductConfiDetailGlobal."Line No." := LastLineNo + 10000;
                ProductConfiDetailGlobal.Type := ProductConfiDetailGlobal.Type::Assembly;
                ProductConfiDetailGlobal.VALIDATE("Product Code", "Product Code");
                ProductConfiDetailGlobal.VALIDATE("Assembly Code", ProductAssy."Assembly Code");
                ProductConfiDetailGlobal."Assembly Line No." := ProductAssy."Line No.";

                ProductConfiDetail.RESET();
                ProductConfiDetail.SETRANGE("Configurator No.", "Configurator No.");
                ProductConfiDetail.SETRANGE("Product Code", "Product Code");
                ProductConfiDetail.SETRANGE("Assembly Code", ProductAssy."Assembly Code");
                IF NOT ProductConfiDetail.FINDFIRST() THEN BEGIN
                    ProductConfiDetailGlobal.INSERT(TRUE);
                    LastLineNo := LastLineNo + 10000;
                END;
            UNTIL ProductAssy.NEXT() = 0;


        IF ProductAssy.FINDFIRST() THEN
            REPEAT
                ProductAssyDetailsGlobal.RESET();
                ProductAssyDetailsGlobal.SETRANGE("Product Code", "Product Code");
                ProductAssyDetailsGlobal.SETRANGE("Assembly Code", ProductAssy."Assembly Code");
                ProductAssyDetailsGlobal.SETCURRENTKEY("Serial No.");
                IF ProductAssyDetailsGlobal.FINDFIRST() THEN
                    REPEAT
                        ProductConfiDetailGlobal.INIT();
                        ProductConfiDetailGlobal."Configurator No." := "Configurator No.";
                        ProductConfiDetailGlobal."Line No." := LastLineNo + 10000;
                        ProductConfiDetailGlobal.Type := ProductConfiDetailGlobal.Type::Parameter;
                        ProductConfiDetailGlobal.VALIDATE("Product Code", "Product Code");
                        ProductConfiDetailGlobal.VALIDATE("Assembly Code", ProductAssy."Assembly Code");
                        ProductConfiDetailGlobal.VALIDATE("Parameter Code", ProductAssyDetailsGlobal."Parameter Code");
                        ProductConfiDetailGlobal."Serial No" := ProductAssyDetailsGlobal."Serial No.";
                        ProductConfiDetailGlobal.Mandatory := ProductAssyDetailsGlobal."Mandatory Parameter";
                        ProductConfiDetailGlobal."Set Visible on Page" := FALSE;
                        ProductConfiDetailGlobal."Allow Multiple Selection" := ProductAssyDetailsGlobal."Allow Multiple Selection";
                        ProductConfiDetailGlobal."Text Parameter" := ProductAssyDetailsGlobal."Text Parameter";

                        ProductConfiDetail.RESET();
                        ProductConfiDetail.SETRANGE("Product Code", "Product Code");
                        ProductConfiDetail.SETRANGE("Assembly Code", ProductAssy."Assembly Code");

                        ProductConfiDetail.RESET();
                        ProductConfiDetail.SETRANGE("Configurator No.", "Configurator No.");
                        ProductConfiDetail.SETRANGE("Product Code", "Product Code");
                        ProductConfiDetail.SETRANGE("Assembly Code", ProductAssy."Assembly Code");
                        ProductConfiDetail.SETRANGE("Parameter Code", ProductAssyDetailsGlobal."Parameter Code");
                        IF NOT ProductConfiDetail.FINDFIRST() THEN BEGIN
                            ProductConfiDetailGlobal.INSERT(TRUE);
                            LastLineNo := LastLineNo + 10000;
                        END;
                    UNTIL ProductAssyDetailsGlobal.NEXT() = 0;
            UNTIL ProductAssy.NEXT() = 0;



        //Set Configuration Line Visible -> Start
        ProductConfigurationDetail.RESET();
        ProductConfigurationDetail.SETRANGE("Configurator No.", "Configurator No.");
        ProductConfigurationDetail.SETRANGE(Type, ProductConfigurationDetail.Type::Parameter);
        IF ProductConfigurationDetail.FINDSET() THEN
            REPEAT
                ProductParemeterDependencLocal.RESET();
                ProductParemeterDependencLocal.SETCURRENTKEY("Product Code", "Parameter Code", "Parameter Depend On Serial");
                ProductParemeterDependencLocal.SETRANGE("Product Code", ProductConfigurationDetail."Product Code");
                ProductParemeterDependencLocal.SETRANGE("Parameter Code", ProductConfigurationDetail."Parameter Code");
                IF NOT ProductParemeterDependencLocal.FINDFIRST() THEN BEGIN
                    ProductConfigurationDetail."Set Visible on Page" := TRUE;
                    ProductConfigurationDetail.MODIFY();
                END;
            UNTIL ProductConfigurationDetail.NEXT() = 0;
        //Set Configuration Line Visible <- End
    end;

    procedure LookupParameter();
    var
        ProductConfiguratorSetup: Record "INT Packaging Config Setup";
    begin
        //Comment-Mayank-OS
        ProdParameterRelation.RESET();
        GetParameterValues(P1Value, P2Value, P3Value, P4Value, P5Value, P6Value);

        CLEAR(ProductConfiguratorSetup);
        ProductConfiguratorSetup.GET();


        IF "Allow Multiple Selection" THEN
            InsertMultipleSelectedLine()
        ELSE
            IF PAGE.RUNMODAL(PAGE::"INT Parameter Relationship", ProdParameterRelation) = ACTION::LookupOK THEN BEGIN
                "Parameter Value" := ProdParameterRelation."Parameter Value";
                "Parameter Value Description" := ProdParameterRelation."Parameter Value Description";

                "Code for Item" := ProdParameterRelation."Code for Item";
            END
            ELSE
                IF PAGE.RUNMODAL(PAGE::"INT Parameter Relationship", ProdParameterRelation) = ACTION::LookupOK THEN BEGIN
                    "Parameter Value" := ProdParameterRelation."Parameter Value";
                    "Parameter Value Description" := ProdParameterRelation."Parameter Value Description";
                    "Code for Item" := ProdParameterRelation."Code for Item";
                END;

    end;

    procedure CheckforParameterValues();
    begin
        ProductConfiDetail2Global.RESET();
        ProductConfiDetail2Global.SETRANGE("Configurator No.", "Configurator No.");
        ProductConfiDetail2Global.SETRANGE(Type, ProductConfiDetail2Global.Type::Parameter);
        IF ProductConfiDetail2Global.FINDFIRST() THEN
            REPEAT
                IF ProductConfiDetail2Global.Mandatory THEN BEGIN
                    ProductConfiDetail2Global.TESTFIELD("Parameter Value");
                END;
            UNTIL ProductConfiDetail2Global.NEXT() = 0;
    end;

    procedure GenerateItemCode();
    var
        ProductConfiDetail: Record "INT Pack. Configurator Detail";
        Products: Record "INT Packaging";
        ProductSubassembly: Record "INT Packaging Assembly";
    begin
    end;

    procedure FindSalesPrice(CustNo: Code[20]; ItemNo: Code[20]; VariantCode: Code[10]; UOM: Code[10]; CurrencyCode: Code[10]; StartingDate: Date): Decimal;
    var
        FromSalesPrice: Record "Sales Price";
        IsLineFound: Boolean;
    begin
        IsLineFound := false;
        FromSalesPrice.SETRANGE("Item No.", ItemNo);
        FromSalesPrice.SETRANGE("Starting Date", 0D, StartingDate);
        FromSalesPrice.SETFILTER("Variant Code", '%1|%2', VariantCode, '');
        FromSalesPrice.SETRANGE("Minimum Quantity", 0);
        IF CurrencyCode <> '' THEN
            FromSalesPrice.SETFILTER("Currency Code", '%1', CurrencyCode)
        ELSE
            FromSalesPrice.SETFILTER("Currency Code", '%1', '');
        IF UOM <> '' THEN
            FromSalesPrice.SETFILTER("Unit of Measure Code", '%1|%2', UOM)
        ELSE
            FromSalesPrice.SETFILTER("Unit of Measure Code", '%1', '');

        IF CustNo <> '' THEN BEGIN
            FromSalesPrice.SETRANGE("Sales Type", FromSalesPrice."Sales Type"::Customer);
            FromSalesPrice.SETRANGE("Sales Code", CustNo);
        END;
        //IF FromSalesPrice.FINDFIRST() THEN
        //  EXIT(FromSalesPrice."Unit Price")
        //ELSE 
        //  IF ItemGlobal.GET(ItemNo) THEN
        //    EXIT(ItemGlobal."Unit Price")
        //  ELSE
        //    EXIT(0);     
        IF FromSalesPrice.FINDFIRST() THEN
            IsLineFound := TRUE;
        CASE IsLineFound OF
            TRUE:
                EXIT(FromSalesPrice."Unit Price");

            FALSE:
                IF ItemGlobal.GET(ItemNo) THEN
                    EXIT(ItemGlobal."Unit Price")
                ELSE
                    EXIT(0);
        END;
    end;

    procedure GenerateItem();
    var
        SalesLine: Record "Sales Line";
        ProdBOMHeader: Record "Production BOM Header";
        ProdBOMLine: Record "Production BOM Line";
        ProdConfiguratorDetail: Record "INT Pack. Configurator Detail";
        ProdConfiguratorDetail2: Record "INT Pack. Configurator Detail";
        ItemUnitOfMeasure: Record "Item Unit of Measure";
        ProdConfigSetup: Record "INT Packaging Config Setup";
        NoSeriesManagement: Codeunit NoSeriesManagement;
        NextLineNo: Integer;
        SuggestedCodeExist: Boolean;
    begin
    end;

    procedure GetParameterValues(var P1Value: Code[250]; var P2Value: Code[250]; var P3Value: Code[250]; var P4Value: Code[250]; var P5Value: Code[250]; var P6Value: Code[250]);
    begin
        //ProductParameterGlobal.SETRANGE("Parameter Value","Parameter Value");
        P1Value := '';
        P2Value := '';
        P3Value := '';
        P4Value := '';
        P5Value := '';
        P6Value := '';

        TESTFIELD("Parameter Code");

        ProdParameterRelation.RESET();
        ProdParameterRelation.FILTERGROUP(2);
        ProdParameterRelation.SETRANGE("Product Code", "Product Code");
        ProdParameterRelation.SETRANGE("Parameter Code", "Parameter Code");
        IF ProdParameterRelation.FINDFIRST() THEN;
        ProductAssyDetailsGlobal.RESET();
        ProductAssyDetailsGlobal.SETRANGE("Product Code", "Product Code");
        ProductAssyDetailsGlobal.SETRANGE("Parameter Code", "Parameter Code");
        ProductAssyDetailsGlobal.FINDFIRST();
        ProductAssyDetailsGlobal.CALCFIELDS("Parameter Depend On");
        IF ProductAssyDetailsGlobal."Parameter Depend On" THEN BEGIN
            ProductParemeterDependenceGlobal.RESET();
            ProductParemeterDependenceGlobal.SETRANGE("Product Code", "Product Code");
            ProductParemeterDependenceGlobal.SETRANGE("Parameter Code", "Parameter Code");
            ProductParemeterDependenceGlobal.SETCURRENTKEY("Product Code", "Parameter Code", "Parameter Depend On Serial");
            IF ProductParemeterDependenceGlobal.FINDSET() THEN
                FOR I := 1 TO ProductParemeterDependenceGlobal.COUNT() DO BEGIN
                    CASE I OF
                        1:
                            BEGIN
                                ProductConfiDetail2Global.RESET;
                                ProductConfiDetail2Global.SETRANGE("Configurator No.", "Configurator No.");
                                ProductConfiDetail2Global.SETRANGE("Product Code", "Product Code");
                                ProductConfiDetail2Global.SETRANGE("Parameter Code", ProductParemeterDependenceGlobal."Parameter Depend On");
                                //IF ProductConfiDetail2Global.FINDFIRST THEN
                                //  P1Value := ProductConfiDetail2Global."Parameter Value";
                                //(For Multiple selection, set filter value as multiple parameter)
                                IF ProductConfiDetail2Global.FINDSET() THEN
                                    REPEAT
                                        IF ProductConfiDetail2Global."Parameter Value" <> '' THEN
                                            IF P1Value = '' THEN
                                                P1Value := ProductConfiDetail2Global."Parameter Value"
                                            ELSE
                                                P1Value := P1Value + '|' + ProductConfiDetail2Global."Parameter Value";
                                    UNTIL ProductConfiDetail2Global.NEXT() = 0;

                            END;
                        2:
                            BEGIN
                                ProductConfiDetail2Global.RESET();
                                ProductConfiDetail2Global.SETRANGE("Configurator No.", "Configurator No.");
                                ProductConfiDetail2Global.SETRANGE("Product Code", "Product Code");
                                ProductConfiDetail2Global.SETRANGE("Parameter Code", ProductParemeterDependenceGlobal."Parameter Depend On");
                                //IF ProductConfiDetail2Global.FINDFIRST THEN
                                //  P2Value := ProductConfiDetail2Global."Parameter Value";
                                IF ProductConfiDetail2Global.FINDSET() THEN
                                    REPEAT
                                        IF ProductConfiDetail2Global."Parameter Value" <> '' THEN
                                            IF P2Value = '' THEN
                                                P2Value := ProductConfiDetail2Global."Parameter Value"
                                            ELSE
                                                P2Value := P2Value + '|' + ProductConfiDetail2Global."Parameter Value";

                                    UNTIL ProductConfiDetail2Global.NEXT() = 0;
                            END;
                        3:
                            BEGIN
                                ProductConfiDetail2Global.RESET();
                                ProductConfiDetail2Global.SETRANGE("Configurator No.", "Configurator No.");
                                ProductConfiDetail2Global.SETRANGE("Product Code", "Product Code");
                                ProductConfiDetail2Global.SETRANGE("Parameter Code", ProductParemeterDependenceGlobal."Parameter Depend On");
                                //IF ProductConfiDetail2Global.FINDFIRST() THEN
                                //  P3Value := ProductConfiDetail2Global."Parameter Value";
                                IF ProductConfiDetail2Global.FINDSET() THEN
                                    REPEAT
                                        IF ProductConfiDetail2Global."Parameter Value" <> '' THEN
                                            IF P3Value = '' THEN
                                                P3Value := ProductConfiDetail2Global."Parameter Value"
                                            ELSE
                                                P3Value := P3Value + '|' + ProductConfiDetail2Global."Parameter Value";

                                    UNTIL ProductConfiDetail2Global.NEXT() = 0;

                            END;
                        4:
                            begin
                                ProductConfiDetail2Global.RESET();
                                ProductConfiDetail2Global.SETRANGE("Configurator No.", "Configurator No.");
                                ProductConfiDetail2Global.SETRANGE("Product Code", "Product Code");
                                ProductConfiDetail2Global.SETRANGE("Parameter Code", ProductParemeterDependenceGlobal."Parameter Depend On");
                                //IF ProductConfiDetail2Global.FINDFIRST THEN
                                //  P4Value := ProductConfiDetail2Global."Parameter Value";
                                IF ProductConfiDetail2Global.FINDSET() THEN
                                    REPEAT
                                        IF ProductConfiDetail2Global."Parameter Value" <> '' THEN
                                            IF P4Value = '' THEN
                                                P4Value := ProductConfiDetail2Global."Parameter Value"
                                            ELSE
                                                P4Value := P4Value + '|' + ProductConfiDetail2Global."Parameter Value";

                                    UNTIL ProductConfiDetail2Global.NEXT = 0;

                            end;
                        5:
                            BEGIN
                                ProductConfiDetail2Global.RESET;
                                ProductConfiDetail2Global.SETRANGE("Configurator No.", "Configurator No.");
                                ProductConfiDetail2Global.SETRANGE("Product Code", "Product Code");
                                ProductConfiDetail2Global.SETRANGE("Parameter Code", ProductParemeterDependenceGlobal."Parameter Depend On");
                                //IF ProductConfiDetail2Global.FINDFIRST THEN
                                //  P5Value := ProductConfiDetail2Global."Parameter Value";
                                IF ProductConfiDetail2Global.FINDSET THEN
                                    REPEAT
                                        IF ProductConfiDetail2Global."Parameter Value" <> '' THEN
                                            IF P5Value = '' THEN
                                                P5Value := ProductConfiDetail2Global."Parameter Value"
                                            ELSE
                                                P5Value := P5Value + '|' + ProductConfiDetail2Global."Parameter Value";
                                    UNTIL ProductConfiDetail2Global.NEXT = 0;
                            END;
                        6:
                            BEGIN
                                ProductConfiDetail2Global.RESET;
                                ProductConfiDetail2Global.SETRANGE("Configurator No.", "Configurator No.");
                                ProductConfiDetail2Global.SETRANGE("Product Code", "Product Code");
                                ProductConfiDetail2Global.SETRANGE("Parameter Code", ProductParemeterDependenceGlobal."Parameter Depend On");
                                //IF ProductConfiDetail2Global.FINDFIRST THEN
                                //  P6Value := ProductConfiDetail2Global."Parameter Value";
                                IF ProductConfiDetail2Global.FINDSET THEN
                                    REPEAT
                                        IF ProductConfiDetail2Global."Parameter Value" <> '' THEN
                                            IF P6Value = '' THEN
                                                P6Value := ProductConfiDetail2Global."Parameter Value"
                                            ELSE
                                                P6Value := P6Value + '|' + ProductConfiDetail2Global."Parameter Value";
                                    UNTIL ProductConfiDetail2Global.NEXT = 0;

                            END;
                    END;
                    ProductParemeterDependenceGlobal.NEXT();
                END;
        END;
        ProdParameterRelation.SETFILTER("Parameter 1", P1Value);
        ProdParameterRelation.SETFILTER("Parameter 2", P2Value);
        ProdParameterRelation.SETFILTER("Parameter 3", P3Value);
        ProdParameterRelation.SETFILTER("Parameter 4", P4Value);
        ProdParameterRelation.SETFILTER("Parameter 5", P5Value);
        ProdParameterRelation.SETFILTER("Parameter 6", P6Value);
        ProdParameterRelation.FILTERGROUP(0);
    END;

    procedure GetItemSalesPrice(ConfiguratorCode: Code[20]; LineNo: Integer): Decimal;
    var
        ProdConfigDetail: Record "INT Pack. Configurator Detail";
        ProdConfigDetail2: Record "INT Pack. Configurator Detail";
        Item: Record Item;
        SalesHeader: Record "Sales Header";
        FromSalesPrice: Record "Sales Price";
        ToSalesPriceTmp: Record "Sales Price" temporary;
        Customer: Record Customer;
        ProductConfiguratorSetup: Record "INT Packaging Config Setup";
        CustNo: Code[20];
        ContNo: Code[20];
        CustPriceGrCode: Code[10];
        CampaignNo: Code[20];
        ItemNo: Code[20];
        VariantCode: Code[10];
        UOM: Code[10];
        CurrencyCode: Code[10];
        StartingDate: Date;
        ShowAll: Boolean;
    begin
    end;

    procedure CopySalesPriceToSalePrice(var FromSalesPrice: Record "Sales Price"; var ToSalesPrice: Record "Sales Price");
    begin
        IF FromSalesPrice.FINDSET() THEN
            REPEAT
                IF FromSalesPrice."Unit Price" <> 0 THEN BEGIN
                    ToSalesPrice := FromSalesPrice;
                    ToSalesPrice.INSERT();
                END;
            UNTIL FromSalesPrice.NEXT() = 0;

    end;

    procedure GetItemSalesDiscount(ConfiguratorCode: Code[20]; LineNo: Integer): Decimal;
    var
        FromSalesLineDisc: Record "Sales Line Discount";
        ToSalesLineDiscTmp: Record "Sales Line Discount" temporary;
        SalesHeader: Record "Sales Header";
        ProdConfigDetail: Record "INT Pack. Configurator Detail";
        ProdConfigDetail2: Record "INT Pack. Configurator Detail";
        Item: Record Item;
        Customer: Record Customer;
        CustNo: Code[20];
        ContNo: Code[20];
        CustDiscGrCode: Code[10];
        CampaignNo: Code[20];
        ItemNo: Code[20];
        ItemDiscGrCode: Code[10];
        VariantCode: Code[10];
        UOM: Code[10];
        CurrencyCode: Code[10];
        StartingDate: Date;
        ShowAll: Boolean;
        InclCampaigns: Boolean;
    begin
    end;

    procedure CopySalesDiscToSalesDisc(var FromSalesLineDisc: Record "Sales Line Discount"; var ToSalesLineDisc: Record "Sales Line Discount");
    begin
        IF FromSalesLineDisc.FINDSET() THEN
            REPEAT
                IF FromSalesLineDisc."Line Discount %" <> 0 THEN BEGIN
                    ToSalesLineDisc := FromSalesLineDisc;
                    ToSalesLineDisc.INSERT();
                END;
            UNTIL FromSalesLineDisc.NEXT() = 0;
    end;

    procedure InsertMultipleSelectedLine();
    var
        TempProdParameterRelation: Record "INT Pack Param Relationship" temporary;
        ProductConfiguratorDetail: Record "INT Pack. Configurator Detail";
        InsertProductConfiguratorDetail: Record "INT Pack. Configurator Detail";
        NextProductConfiguratorDetail: Record "INT Pack. Configurator Detail";
        CheckProdConfigLineExist: Record "INT Pack. Configurator Detail";
        ParameterRelationship: Page "INT Multi. Param. Relationshi";
        LastLineNo: Integer;
        LineCount: Integer;
    begin
        //Comment-Mayank-OS
        // //For multiple parameter selection - Start
        // LineCount := 0;
        // CLEAR(ParameterRelationship);
        // ParameterRelationship.LOOKUPMODE(TRUE);
        // ParameterRelationship.EDITABLE(TRUE);
        // ParameterRelationship.SETTABLEVIEW(ProdParameterRelation);
        // IF ParameterRelationship.RUNMODAL() = ACTION::LookupOK THEN BEGIN
        //     ParameterRelationship.GetSelectedLine(TempProdParameterRelation);
        //     IF TempProdParameterRelation.FINDSET() THEN
        //         REPEAT
        //             CheckProdConfigLineExist.RESET();
        //             CheckProdConfigLineExist.SETRANGE("Configurator No.", "Configurator No.");
        //             CheckProdConfigLineExist.SETRANGE(Type, CheckProdConfigLineExist.Type::Parameter);
        //             CheckProdConfigLineExist.SETRANGE("Parameter Code", "Parameter Code");
        //             CheckProdConfigLineExist.SETRANGE("Parameter Value", TempProdParameterRelation."Parameter Value");
        //             IF NOT CheckProdConfigLineExist.FINDFIRST() THEN BEGIN
        //                 LineCount += 1;
        //                 IF LineCount = 1 THEN BEGIN
        //                     "Parameter Value" := TempProdParameterRelation."Parameter Value";
        //                     "Parameter Value Description" := TempProdParameterRelation."Parameter Value Description";
        //                     "Code for Item" := TempProdParameterRelation."Code for Item";
        //                     "Item Code For BOM" := TempProdParameterRelation."Item Code For BOM";
        //                     MODIFY();
        //                     LastLineNo := "Line No.";
        //                 END ELSE BEGIN
        //                     ProductConfiguratorDetail.RESET();
        //                     ProductConfiguratorDetail.SETCURRENTKEY("Product Code", "Assembly Code", "Serial No");
        //                     ProductConfiguratorDetail.SETRANGE(Type, ProductConfiguratorDetail.Type::Parameter);
        //                     ProductConfiguratorDetail.SETRANGE("Configurator No.", "Configurator No.");
        //                     ProductConfiguratorDetail.SETRANGE("Serial No", "Serial No");
        //                     IF ProductConfiguratorDetail.FINDLAST() THEN BEGIN
        //                         InsertProductConfiguratorDetail.INIT();
        //                         InsertProductConfiguratorDetail.TRANSFERFIELDS(Rec);

        //                         InsertProductConfiguratorDetail."Parameter Value" := TempProdParameterRelation."Parameter Value";
        //                         InsertProductConfiguratorDetail."Parameter Value Description" := TempProdParameterRelation."Parameter Value Description";
        //                         InsertProductConfiguratorDetail."Code for Item" := TempProdParameterRelation."Code for Item";
        //                         InsertProductConfiguratorDetail."Item Code For BOM" := TempProdParameterRelation."Item Code For BOM";

        //                         NextProductConfiguratorDetail.RESET();
        //                         ProductConfiguratorDetail.SETCURRENTKEY("Configurator No.", "Line No.");
        //                         NextProductConfiguratorDetail.SETRANGE("Configurator No.", "Configurator No.");
        //                         NextProductConfiguratorDetail.SETFILTER("Line No.", '>%1', LastLineNo);
        //                         IF NextProductConfiguratorDetail.FINDFIRST() THEN
        //                             LastLineNo := ROUND(((NextProductConfiguratorDetail."Line No." + LastLineNo) / 2), 1, '>')
        //                         ELSE
        //                             LastLineNo := LastLineNo + 10000;

        //                         InsertProductConfiguratorDetail."Line No." := LastLineNo;
        //                         InsertProductConfiguratorDetail.INSERT();
        //                     END;
        //                 END;
        //             END ELSE
        //                 LineCount += 1;
        //         UNTIL TempProdParameterRelation.NEXT() = 0;
        // END;
        // //For multiple parameter selection - End
        //Comment-Mayank-OS
    end;

    procedure UpdateVisibleParameterLine();
    var
        ProductParemeterDependenc: Record "INT Packaging Param Dependency";
        ProductConfigDetail: Record "INT Pack. Configurator Detail";
        ProdParameterDepends: Record "INT Packaging Param Dependency";
        CheckProdConfigParameterExsit: Record "INT Pack. Configurator Detail";
        CountDependency: Integer;
    begin
        //For Set Visible Boolean - Start
        ProductParemeterDependenc.RESET();
        ProductParemeterDependenc.SETCURRENTKEY("Parameter Depend On Serial");
        ProductParemeterDependenc.SETRANGE("Product Code", "Product Code");
        ProductParemeterDependenc.SETRANGE("Parameter Depend On", "Parameter Code");
        IF ProductParemeterDependenc.FINDSET() THEN
            REPEAT
                ProductConfigDetail.RESET();
                ProductConfigDetail.SETRANGE("Configurator No.", "Configurator No.");
                ProductConfigDetail.SETRANGE(Type, ProductConfigDetail.Type::Parameter);
                ProductConfigDetail.SETRANGE("Product Code", "Product Code");
                ProductConfigDetail.SETRANGE("Parameter Code", ProductParemeterDependenc."Parameter Code");
                IF ProductConfigDetail.FINDSET() THEN
                    REPEAT
                        CountDependency := 0;
                        ProdParameterDepends.RESET();
                        ProdParameterDepends.SETRANGE("Product Code", "Product Code");
                        ProdParameterDepends.SETRANGE("Parameter Code", ProductConfigDetail."Parameter Code");
                        IF ProdParameterDepends.FINDSET() THEN
                            REPEAT
                                CheckProdConfigParameterExsit.RESET();
                                CheckProdConfigParameterExsit.SETRANGE("Configurator No.", "Configurator No.");
                                CheckProdConfigParameterExsit.SETRANGE(Type, CheckProdConfigParameterExsit.Type::Parameter);
                                CheckProdConfigParameterExsit.SETRANGE("Product Code", "Product Code");
                                CheckProdConfigParameterExsit.SETRANGE("Parameter Code", ProdParameterDepends."Parameter Depend On");
                                CheckProdConfigParameterExsit.SETFILTER("Parameter Value", '<>%1', '');
                                IF CheckProdConfigParameterExsit.FINDSET() THEN
                                    REPEAT
                                        IF CountDependency = 0 THEN BEGIN
                                            ProductConfigDetail."Set Visible on Page" := TRUE;
                                            ProductConfigDetail.MODIFY();
                                        END;
                                    UNTIL CheckProdConfigParameterExsit.NEXT() = 0
                                ELSE BEGIN
                                    ProductConfigDetail."Set Visible on Page" := FALSE;
                                    ProductConfigDetail."Parameter Value" := '';
                                    ProductConfigDetail."Parameter Value Description" := '';
                                    //Comment-Mayank-OS
                                    // ProductConfigDetail."Code for Item" := '';
                                    // ProductConfigDetail."Unit Price" := 0;
                                    //Comment-Mayank-OE
                                    ProductConfigDetail.MODIFY();
                                    CountDependency += 1;
                                END;
                            UNTIL ProdParameterDepends.NEXT() = 0;
                    UNTIL ProductConfigDetail.NEXT() = 0;
            UNTIL ProductParemeterDependenc.NEXT() = 0;

        //For Set Visible Boolean - End
    end;

    procedure GetNewProduct(): Code[20];
    begin
        EXIT(ItemGlobal."No.");
    end;
}

