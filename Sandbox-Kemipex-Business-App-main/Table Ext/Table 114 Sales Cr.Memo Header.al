tableextension 58003 "Sales Cr Memo Hdr" extends "Sales Cr.Memo Header"//T12370-Full Comment T12946-Code Uncommented
{
    fields
    {
        // //GST-22/05/2022
        // modify("VAT Base Discount %")
        // {
        //     CaptionClass = 'GSTORVAT,VAT Base Discount %';
        // }
        // modify("VAT Country/Region Code")
        // {
        //     CaptionClass = 'GSTORVAT,VAT Country/Region Code';
        // }
        // modify("VAT Registration No.")
        // {
        //     CaptionClass = 'GSTORVAT,VAT Registration No.';
        // }
        // modify("Amount Including VAT")
        // {
        //     CaptionClass = 'GSTORVAT,Amount Including VAT';
        // }
        // modify("Prices Including VAT")
        // {
        //     CaptionClass = 'GSTORVAT,Prices Including VAT';
        // }

        // field(53010; "Sub Status"; Text[100])
        // {
        //     DataClassification = ToBeClassified;
        // }
        // field(53011; "Salesperson Name"; Text[50])
        // {
        //     FieldClass = FlowField;
        //     CalcFormula = lookup("Salesperson/Purchaser".Name where(Code = field("Salesperson Code")));
        // }

        // //17-07-2022-start
        // field(53025; "Release Of Shipping Document"; Option)
        // {
        //     DataClassification = ToBeClassified;
        //     OptionMembers = " ",Telex,Surrender,Courier,"Documents through the bank","Print OBL at destination";
        // }
        // field(53026; "Courier Details"; Text[500])
        // {
        //     DataClassification = ToBeClassified;
        // }
        // field(53027; "Free Time Requested"; Text[500])
        // {
        //     DataClassification = ToBeClassified;
        // }
        // //17-07-2022-end
        // //08-08-2022-start
        field(58035; "Customer Incentive Point (CIP)"; Option)
        {
            OptionMembers = ,"1","2","3","4","5";
        }
        //08-08-2022-end

        //Agent Representative
        // field(53200; "Agent Rep. Code"; Code[20])
        // {
        //     DataClassification = SystemMetadata;
        //     TableRelation = "Agent Representative";
        //     trigger OnValidate()
        //     begin
        //     end;
        // }
        // field(53201; "Agent Rep. Name"; Code[100])
        // {
        //     DataClassification = SystemMetadata;
        //     Editable = false;
        // }
        // field(53202; "Agent Rep. Address"; Code[100])
        // {
        //     DataClassification = SystemMetadata;
        //     Editable = false;
        // }
        // field(53203; "Agent Rep. Address 2"; Code[150])
        // {
        //     DataClassification = SystemMetadata;
        //     Editable = false;
        // }
        // field(53204; "Agent Rep. Post Code"; Code[20])
        // {
        //     DataClassification = SystemMetadata;
        //     Editable = false;
        //     TableRelation = "Post Code";
        //     ValidateTableRelation = false;

        //     trigger OnLookup()
        //     begin
        //         PostCode.LookupPostCode("Agent Rep. City", "Agent Rep. Post Code", blankvar, blankvar);
        //     end;

        //     trigger OnValidate()
        //     begin
        //         PostCode.ValidatePostCode("Agent Rep. City", "Agent Rep. Post Code", blankvar, blankvar, (CurrFieldNo <> 0) and GuiAllowed);
        //     end;
        // }
        // field(53217; "Agent Rep. City"; Text[50])
        // {
        //     DataClassification = SystemMetadata;
        //     Editable = false;
        //     TableRelation = "Post Code".City;
        //     ValidateTableRelation = false;

        //     trigger OnLookup()
        //     begin
        //         PostCode.LookupPostCode("Agent Rep. City", "Agent Rep. Post Code", blankvar, blankvar);
        //     end;

        //     trigger OnValidate()
        //     begin

        //         PostCode.ValidateCity("Agent Rep. City", "Agent Rep. Post Code", blankvar, blankvar, (CurrFieldNo <> 0) and GuiAllowed);
        //     end;

        // }
        // field(53218; "Agent Rep. Country/Region Code"; Code[10])
        // {
        //     Caption = 'Agent Rep Country/Region Code';
        //     TableRelation = "Country/Region";
        //     Editable = false;

        //     trigger OnValidate()
        //     begin
        //         PostCode.CheckClearPostCodeCityCounty("Agent Rep. City", "Agent Rep. Post Code", blankvar, "Agent Rep. Country/Region Code", xRec."Agent Rep. Country/Region Code");
        //     end;
        // }

    }
    var
        PostCode: Record "Post Code";
        blankvar: Variant;
        AgentRep: Record "Agent Representative";
}
