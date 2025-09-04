page 85654 ApiPostLotVarTestParameter
{
    APIGroup = 'API';
    APIPublisher = 'ISPL';
    APIVersion = 'v2.0';
    ApplicationArea = All;
    Caption = 'apiPostLotVarTestParameter';
    DelayedInsert = true;
    EntityName = 'apiPostLotVarTestParameter';
    EntitySetName = 'apiPostLotVarTestParameter';
    PageType = API;
    SourceTable = "Post Lot Var Testing Parameter";
    Description = 'T13919';
    ODataKeyFields = SystemId;

    layout
    {
        area(Content)
        {
            repeater(General)
            {

                field(sourceID; Rec."Source ID")
                {
                    Caption = 'Source ID';
                }
                field(sourceRefNo; Rec."Source Ref. No.")
                {
                    Caption = 'Source Ref. No.';
                }
                field(itemNo; Rec."Item No.")
                {
                    Caption = 'Item No.';
                }
                field(lotNo; Rec."Lot No.")
                {
                    Caption = 'Lot No.';
                }
                field(boeNo; Rec."BOE No.")
                {
                    Caption = 'BOE No.';
                }
                field("code"; Rec."Code")
                {
                    Caption = 'Testing Parameter';
                }
                field(testingParameter; Rec."Testing Parameter")
                {
                    Caption = 'Testing Parameter description';
                }
                field(minimum; Rec.Minimum)
                {
                    Caption = 'Minimum';
                }
                field(maximum; Rec.Maximum)
                {
                    Caption = 'Maximum';
                }
                field("value"; Rec."Value")
                {
                    Caption = 'Alternate';
                }
                field(actualValue; Rec."Actual Value")
                {
                    Caption = 'Actual Value';
                }
                field(dataType; Rec."Data Type")
                {
                    Caption = 'Data Type';
                }
                field(symbol; Rec.Symbol)
                {
                    Caption = 'Symbol';
                }
                field(ofSpec; Rec."Of Spec")
                {
                    Caption = 'Off-Spec';
                }
                field(value2; Rec.Value2)
                {
                    Caption = 'Alternate';
                }
                field(priority; Rec.Priority)
                {
                    Caption = 'Priority';
                }
                field(showInCOA; Rec."Show in COA")
                {
                    Caption = 'Show in COA';
                }
                field(defaultValue; Rec."Default Value")
                {
                    Caption = 'Default Value';
                }
                field(testingParameterCode; Rec."Testing Parameter Code")
                {
                    Caption = 'Testing Parameter Code';
                }
                field(variantCode; Rec."Variant Code")
                {
                    Caption = 'Variant Code';
                }
                field(type; Rec."Type")
                {
                    Caption = 'Type';
                }
                field(result; Rec.Result)
                {
                    Caption = 'Result';
                }
                field(vendorCOAValueResult; Rec."Vendor COA Value Result")
                {
                    Caption = 'Vendor COA Value Result';
                }
                field(vendorCOATextResult; Rec."Vendor COA Text Result")
                {
                    Caption = 'Vendor COA Text Result';
                }
                field(roundingPrecision; Rec."Rounding Precision")
                {
                    Caption = 'Rounding Precision';
                }
                field(systemId; Rec.SystemId)
                {
                    Caption = 'SystemId';
                }
            }
        }
    }
}
