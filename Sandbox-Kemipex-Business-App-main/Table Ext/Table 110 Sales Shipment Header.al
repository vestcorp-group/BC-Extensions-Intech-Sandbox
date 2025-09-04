tableextension 53004 "Sales Shipment Header Ext" extends "Sales Shipment Header"//T12370-Full Comment
{
    fields
    {
        //         field(53000; "Clearance Ship-to Code"; Code[10])
        //         {
        //             Caption = 'Clearance Ship-to Code';
        //         }
        //         field(53001; "Clearance Ship-to Name"; Text[100])
        //         {
        //             Caption = 'Clearance Ship-to Name';
        //         }
        //         field(53002; "Clearance Ship-to Name 2"; Text[50])
        //         {
        //             Caption = 'Clearance Ship-to Name 2';
        //         }
        //         field(53003; "Clearance Ship-to Address"; Text[100])
        //         {
        //             Caption = 'Clearance Ship-to Address';
        //         }
        //         field(53004; "Clearance Ship-to Address 2"; Text[50])
        //         {
        //             Caption = 'Clearance Ship-to Address 2';
        //         }
        //         field(53005; "Clearance Ship-to City"; Text[30])
        //         {
        //             Caption = 'Clearance Ship-to City';
        //         }
        //         field(53006; "Clearance Ship-to Contact"; Text[100])
        //         {
        //             Caption = 'Clearance Ship-to Contact';
        //         }
        //         field(53007; "Clearance Ship-to Post Code"; Code[20])
        //         {
        //             Caption = 'Clearance Ship-to Post Code';
        //         }
        //         field(53008; "Clearance Ship-to County"; Text[30])
        //         {
        //             CaptionClass = '5,1,' + "Clear.Ship-to Country/Reg.Code";
        //             Caption = 'Clearance Ship-to County';
        //         }
        //         field(53009; "Clear.Ship-to Country/Reg.Code"; Code[10])
        //         {
        //             Caption = 'Clearance Ship-to Country/Region Code';
        //         }
        //         field(53010; "Clearance Shipment Method Code"; Code[10])
        //         {
        //             Caption = 'Clearance Shipment Method Code';
        //         }
        //         field(53011; "Clearance Shipping Agent Code"; Code[10])
        //         {
        //             Caption = 'Clearance Shipping Agent Code';
        //         }
        //         field(53012; "Clear.Ship.Agent Service Code"; Code[10])
        //         {
        //             Caption = 'Clear.Ship.Agent Service Code';
        //         }
        //         field(53013; "Clearance Ship.Agent Serv.Code"; Code[10])
        //         {
        //             Caption = 'Clearance Ship.Agent Serv.Code';
        //         }
        //         field(53014; "Clearance Shipping Time"; DateFormula)
        //         {
        //             Caption = 'Clearance Shipping Time';
        //         }
        //         field(53015; "Sub Status"; Text[100])
        //         {
        //             DataClassification = ToBeClassified;
        //         }
        //         field(53016; "Salesperson Name"; Text[50])
        //         {
        //             FieldClass = FlowField;
        //             CalcFormula = lookup("Salesperson/Purchaser".Name where(Code = field("Salesperson Code")));
        //         }
        //         //17-07-2022-start
        //         field(53025; "Release Of Shipping Document"; Option)
        //         {
        //             DataClassification = ToBeClassified;
        //             OptionMembers = " ",Telex,Surrender,Courier,"Documents through the bank","Print OBL at destination";
        //         }
        //         field(53026; "Courier Details"; Text[500])
        //         {
        //             DataClassification = ToBeClassified;
        //         }
        //         field(53027; "Free Time Requested"; Text[500])
        //         {
        //             DataClassification = ToBeClassified;
        //         }
        field(58035; "Customer Incentive Point (CIP)"; Option)//Hypercare 07-03-2025
        {
            OptionMembers = ,"1","2","3","4","5";
        }

        //         //17-07-2022-end

        //         // Agent Representative
        field(53200; "Agent Rep. Code"; Code[20])
        {
            DataClassification = SystemMetadata;
            TableRelation = "Agent Representative";
            trigger OnValidate()
            begin
            end;
        }
        field(53201; "Agent Rep. Name"; Code[100])
        {
            DataClassification = SystemMetadata;
            Editable = false;
        }
        field(53202; "Agent Rep. Address"; Code[100])
        {
            DataClassification = SystemMetadata;
            Editable = false;
        }
        field(53203; "Agent Rep. Address 2"; Code[150])
        {
            DataClassification = SystemMetadata;
            Editable = false;
        }
        field(53204; "Agent Rep. Post Code"; Code[20])
        {
            DataClassification = SystemMetadata;
            Editable = false;
            TableRelation = "Post Code";
            ValidateTableRelation = false;

            trigger OnLookup()
            begin
                PostCode.LookupPostCode("Agent Rep. City", "Agent Rep. Post Code", blankvar, blankvar);
            end;

            trigger OnValidate()
            begin
                PostCode.ValidatePostCode("Agent Rep. City", "Agent Rep. Post Code", blankvar, blankvar, (CurrFieldNo <> 0) and GuiAllowed);
            end;
        }
        field(53217; "Agent Rep. City"; Text[50])
        {
            DataClassification = SystemMetadata;
            Editable = false;
            TableRelation = "Post Code".City;
            ValidateTableRelation = false;

            trigger OnLookup()
            begin
                PostCode.LookupPostCode("Agent Rep. City", "Agent Rep. Post Code", blankvar, blankvar);
            end;

            trigger OnValidate()
            begin

                PostCode.ValidateCity("Agent Rep. City", "Agent Rep. Post Code", blankvar, blankvar, (CurrFieldNo <> 0) and GuiAllowed);
            end;

        }
        field(53218; "Agent Rep. Country/Region Code"; Code[10])
        {
            Caption = 'Agent Rep Country/Region Code';
            TableRelation = "Country/Region";
            Editable = false;

            trigger OnValidate()
            begin
                PostCode.CheckClearPostCodeCityCounty("Agent Rep. City", "Agent Rep. Post Code", blankvar, "Agent Rep. Country/Region Code", xRec."Agent Rep. Country/Region Code");
            end;
        }
    }

    var
        PostCode: Record "Post Code";
        blankvar: Variant;
        AgentRep: Record "Agent Representative";

}