tableextension 58145 SalesInvoiceHeader extends "Sales Invoice Header"//T12370-Full Comment  //T12574-N
{
    fields
    {
        field(58026; "Declaration Type"; Option)
        {
            OptionMembers = " ",ED,Direct,LGP;
            OptionCaption = ' ,Export Declaration,Direct,LGP';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                YesUpdate: Boolean;
                EnableFalse: Boolean;
            begin
                /*   if ("Declaration Type" = "Declaration Type"::Direct) then begin
                       YesUpdate := Dialog.Confirm('Do you want to Update Customs Declaration?', true);
                       if YesUpdate = true then
                           Validate(BillOfExit, Format("Declaration Type"))
                       else
                           exit;
                   end;   */
            end;
        }
        field(58027; "Actual Shipment Date"; Date)
        {
            DataClassification = ToBeClassified;

        }
        field(53015; "Bill of Lading No."; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Bill of Lading No.';

        }
        field(53016; "Carrier Name"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Carrier Name';

        }
        field(53017; ETA; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'ETA';
            trigger OnValidate()
            begin
                if xRec.ETA <> rec.ETA then begin
                    clear(cuCodeunitSubscribers);
                    cuCodeunitSubscribers.fnSendETAnotifications(Rec, xRec.ETA);
                end;
            end;
        }
        field(53018; ETD; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'ETD';
            trigger OnValidate()
            begin
                if xRec.ETD <> rec.ETD then begin
                    clear(cuCodeunitSubscribers);
                    cuCodeunitSubscribers.fnSendETDnotifications(Rec, xRec.ETD);
                end;
            end;
        }

        field(53000; "Clearance Ship-to Code"; Code[10])
        {
            Caption = 'Clearance Ship-to Code';
        }
        field(53001; "Clearance Ship-to Name"; Text[100])
        {
            Caption = 'Clearance Ship-to Name';
        }
        field(53002; "Clearance Ship-to Name 2"; Text[50])
        {
            Caption = 'Clearance Ship-to Name 2';
        }
        field(53003; "Clearance Ship-to Address"; Text[100])
        {
            Caption = 'Clearance Ship-to Address';
        }
        field(53004; "Clearance Ship-to Address 2"; Text[50])
        {
            Caption = 'Clearance Ship-to Address 2';
        }
        field(53005; "Clearance Ship-to City"; Text[30])
        {
            Caption = 'Clearance Ship-to City';
        }
        field(53006; "Clearance Ship-to Contact"; Text[100])
        {
            Caption = 'Clearance Ship-to Contact';
        }
        field(53007; "Clearance Ship-to Post Code"; Code[20])
        {
            Caption = 'Clearance Ship-to Post Code';
        }
        field(53008; "Clearance Ship-to County"; Text[30])
        {
            CaptionClass = '5,1,' + "Clear.Ship-to Country/Reg.Code";
            Caption = 'Clearance Ship-to County';
        }
        field(53009; "Clear.Ship-to Country/Reg.Code"; Code[10])
        {
            Caption = 'Clearance Ship-to Country/Region Code';
        }
        field(53010; "Clearance Shipment Method Code"; Code[10])
        {
            Caption = 'Clearance Shipment Method Code';
        }
        field(53011; "Clearance Shipping Agent Code"; Code[10])
        {
            Caption = 'Clearance Shipping Agent Code';
        }
        field(53012; "Clear.Ship.Agent Service Code"; Code[10])
        {
            Caption = 'Clear.Ship.Agent Service Code';
        }
        field(53013; "Clearance Ship.Agent Serv.Code"; Code[10])
        {
            Caption = 'Clearance Ship.Agent Serv.Code';
        }
        field(53014; "Clearance Shipping Time"; DateFormula)
        {
            Caption = 'Clearance Shipping Time';
        }
        //17-07-2022-start
        field(53025; "Release Of Shipping Document"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ",Telex,Surrender,Courier,"Documents through the bank","Print OBL at destination";
        }
        field(53026; "Courier Details"; Text[500])
        {
            DataClassification = ToBeClassified;
        }
        field(53027; "Free Time Requested"; Text[500])
        {
            DataClassification = ToBeClassified;
        }
        //17-07-2022-end
        //08-08-2022-start
        field(58033; "Customer Final Destination"; code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Area";
            Description = 'T12574';
        }
        field(58035; "Customer Incentive Point (CIP)"; Option)
        {
            OptionMembers = ,"1","2","3","4","5"; // T12946-Code Uncommented
        }
        // //08-08-2022-end

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
        // field(53105; "Salesperson Name"; Text[50])
        // {
        //     FieldClass = FlowField;
        //     CalcFormula = lookup("Salesperson/Purchaser".Name where(Code = field("Salesperson Code")));
        // }



        // //Agent Representative
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
        field(53120; "Custom Ship to Option"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = '50307';
        }
    }

    var
        cuCodeunitSubscribers: Codeunit "ETD ETA Notification";

        PostCode: Record "Post Code";
        blankvar: Variant;
        AgentRep: Record "Agent Representative";
}
