tableextension 74991 Transfer_Header_74991 extends "Transfer Header"
{
    fields
    {
        // Add changes to table fields here
        field(74331; "Party No."; Code[20])
        {
            TableRelation = IF ("Party Type" = CONST(Customer)) Customer ELSE
            IF ("Party Type" = CONST(Vendor)) Vendor ELSE
            IF ("Party Type" = CONST(Employee)) Employee;

            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                myInt: Integer;
                Customer_lRec: Record Customer;
                Vendor_lRec: Record Vendor;
                Employee_lRec: Record Employee;
            begin
                //ReturnTO-NS
                IF "Party Type" = "Party Type"::Customer THEN BEGIN
                    IF Customer_lRec.GET("Party No.") THEN BEGIN
                        Name := Customer_lRec.Name;
                        "Transfer-to Name" := Customer_lRec.Name;
                        "Name 2" := Customer_lRec."Name 2";
                        "Transfer-to Name 2" := Customer_lRec."Name 2";
                        Address := Customer_lRec.Address;
                        "Transfer-to Address" := Customer_lRec.Address;
                        "Address 2" := Customer_lRec."Address 2";
                        "Transfer-to Address 2" := Customer_lRec."Address 2";
                        "Post Code" := Customer_lRec."Post Code";
                        "Transfer-to Post Code" := Customer_lRec."Post Code";
                        City := Customer_lRec.City;
                        "Transfer-to City" := Customer_lRec.City;
                        "Country/Region Code" := Customer_lRec."Country/Region Code";
                        "Trsf.-to Country/Region Code" := Customer_lRec."Country/Region Code";
                    END;
                END
                ELSE
                    IF "Party Type" = "Party Type"::Vendor THEN BEGIN
                        IF Vendor_lRec.GET("Party No.") THEN BEGIN
                            Name := Vendor_lRec.Name;
                            "Transfer-to Name" := Vendor_lRec.Name;
                            "Name 2" := Vendor_lRec."Name 2";
                            "Transfer-to Name 2" := Vendor_lRec."Name 2";
                            Address := Vendor_lRec.Address;
                            "Transfer-to Address" := Vendor_lRec.Address;
                            "Address 2" := Vendor_lRec."Address 2";
                            "Transfer-to Address 2" := Vendor_lRec."Address 2";
                            "Post Code" := Vendor_lRec."Post Code";
                            "Transfer-to Post Code" := Vendor_lRec."Post Code";
                            City := Vendor_lRec.City;
                            "Transfer-to City" := Vendor_lRec.City;
                            "Country/Region Code" := Vendor_lRec."Country/Region Code";
                            "Trsf.-to Country/Region Code" := Vendor_lRec."Country/Region Code";
                        END;
                    END ELSE
                        IF "Party Type" = "Party Type"::Employee THEN BEGIN
                            IF Employee_lRec.GET("Party No.") THEN BEGIN
                                Name := Employee_lRec.FullName;
                                "Transfer-to Name" := Employee_lRec.FullName;
                                Address := Employee_lRec.Address;
                                "Transfer-to Address" := Employee_lRec.Address;
                                "Address 2" := Employee_lRec."Address 2";
                                "Transfer-to Address 2" := Employee_lRec."Address 2";
                                "Post Code" := Employee_lRec."Post Code";
                                "Transfer-to Post Code" := Employee_lRec."Post Code";
                                City := Employee_lRec.City;
                                "Transfer-to City" := Employee_lRec.City;
                                "Country/Region Code" := Employee_lRec."Country/Region Code";
                                "Trsf.-to Country/Region Code" := Employee_lRec."Country/Region Code";
                            END;
                        END;
                //ReturnTO-NE
            end;
        }
        field(74332; Name; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(74333; "Name 2"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(74334; Address; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(74335; "Address 2"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(74336; "Post Code"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(74337; City; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(74338; "Country/Region Code"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(74339; "Party Type"; Enum "Transfer Party Type Enum")
        {
            DataClassification = ToBeClassified;
        }
        field(74340; "Returnable Type"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
    }
    //ViewShortCutDim-NS
    procedure ShowShortcutDimCode_gFnc(var ShortcutDimCode_lCode: array[8] of Code[20])
    var
        DimMgt: Codeunit DimensionManagement;
    begin
        DimMgt.GetShortcutDimensions("Dimension Set ID", ShortcutDimCode_lCode);
    end;

    procedure LookupShortcutDimCode_gFnc(FieldNumber_lInt: Integer; var ShortcutDimCode_lCode: Code[20])
    var
        DimMgt: Codeunit DimensionManagement;
    begin
        DimMgt.LookupDimValueCode(FieldNumber_lInt, ShortcutDimCode_lCode);
        ValidateShortcutDimCode(FieldNumber_lInt, ShortcutDimCode_lCode);
    end;
    //ViewShortCutDim-NE


    procedure CheckExistingLines_gFnc()
    var
        TransferLine_lRec: Record "Transfer Line";
    begin
        //ReturnTO-NS
        TransferLine_lRec.Reset;
        TransferLine_lRec.SetRange("Document No.", "No.");
        if TransferLine_lRec.FindFirst then
            Error('You cannot modify In-Transit Code as lines already exist for the Transfer Document %1', "No.");
        //ReturnTO-NE
    end;
}
