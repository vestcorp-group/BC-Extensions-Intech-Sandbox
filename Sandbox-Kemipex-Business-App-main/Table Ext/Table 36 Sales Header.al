tableextension 58059 salesheader extends "Sales Header"//T12370-Full Comment  //T12574-N
{
    fields
    {
        // field(58022; "Advance Payment"; Boolean)
        // {
        //     Editable = false;
        // }
        // field(58032; "Management Approval"; Boolean)
        // {
        //     Editable = false;
        //     DataClassification = ToBeClassified;
        // }
        // //08-08-2022-start
        field(58033; "Customer Final Destination"; code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Area";
            Description = 'T12574';
        }
        field(58035; "Customer Incentive Point (CIP)"; Option)
        {
            OptionMembers = ,"1","2","3","4","5";
            Description = 'T12574';
        }
        // modify("Promised Delivery Date")
        // {
        //     Caption = 'Proposed Delivery Date';
        //     trigger OnBeforeValidate()
        //     begin
        //         StatusCheckSuspended := true;
        //         TestStatusOpen();
        //     end;
        // }
        // //08-08-2022-end
        modify("Sell-to Customer No.")
        {
            //     trigger OnBeforeValidate()
            //     var
            //         user_setup: Record "User Setup";
            //     begin
            //         if "Document Type" = "Document Type"::Invoice then begin
            //             user_setup.get(UserId);
            //             if user_setup."Allow Pre SI Creation" = false then
            //                 Error('Sales Invoice Creation is not allowed, please contact administrator')
            //             else
            //                 exit;
            //         end;
            //     end;

            // Agent Representative
            trigger OnAfterValidate()
            begin
                if Cust.Get("Sell-to Customer No.") then
                    Validate("Agent Rep. Code", Cust."Agent Rep. Code");
            end;

            //     /*
            //                 trigger OnAfterValidate()
            //                 var
            //                     CustomerRec: Record Customer;
            //                 begin
            //                     CustomerRec.get(Rec."Sell-to Customer No.");
            //                     Rec."Tax Type" := CustomerRec."Tax Type";
            //                     if Rec.Modify() then;

            //                 end;
            //                 */
        }
        // modify("VAT Bus. Posting Group")
        // {
        //     CaptionClass = 'GSTORVAT,VAT Bus. Posting Group';//GST
        //     trigger OnAfterValidate()
        //     begin
        //         if ("Transaction Specification" = 'DDP') and ("VAT Bus. Posting Group" <> 'C-LOCAL-DDP') then Error('DDP Requires Vat');
        //     end;
        // }
        // modify("Currency Code")
        // {
        //     trigger OnAfterValidate()
        //     var
        //         GLS: Record "General Ledger Setup";
        //     begin
        //         GLS.Get();
        //         if "Currency Code" = GLS."LCY Code" then Error('Currency Code should be Blank for Local Currency');
        //     end;
        // }
        // modify("Payment Terms Code")
        // {
        //     trigger OnAfterValidate()
        //     var
        //         customer: Record Customer;
        //         payment_terms: Record "Payment Terms";
        //     begin
        //         if ("Document Type" = "Document Type"::Order) or ("Document Type" = "Document Type"::"Blanket Order") then begin
        //             payment_terms.Get("Payment Terms Code");
        //             if payment_terms."Sales Blocked" = true then Error('Selected Payment Terms is Blocked from Selection');
        //             if payment_terms."Advance Payment" = true then
        //                 "Advance Payment" := true else
        //                 "Advance Payment" := false;
        //             if payment_terms."Management Approval" then
        //                 "Management Approval" := true else
        //                 "Management Approval" := false;
        //         end;
        //         if "Payment Terms Code" <> 'FOC SAMPLE' then begin
        //             customer.Get("Bill-to Customer No.");
        //             if customer."Payment Terms Code" = 'FOC SAMPLE' then
        //                 Error('Customer %1 is registered for Sample Purpose Only', "Bill-to Name")
        //         end;
        //     end;
        // }

        field(53000; "Clearance Ship-to Code"; Code[10])
        {
            Caption = 'Clearance Ship-to Code';
            TableRelation = "Clearance Ship-to Address".Code WHERE("Customer No." = FIELD("Sell-to Customer No."));

            trigger OnValidate()
            var
                ShipToAddr: Record "Clearance Ship-to Address";
                IsHandled: Boolean;
                CopyShipToAddress: Boolean;
            begin
                IsHandled := false;
                //OnBeforeValidateShipToCode(Rec, xRec, Cust, ShipToAddr, IsHandled);
                if IsHandled then
                    exit;

                ShipToAddr.GET("Sell-to Customer No.", "Clearance Ship-to Code");
                "Clearance Ship-to Name" := ShipToAddr.Name;
                "Clearance Ship-to Name 2" := ShipToAddr."Name 2";
                "Clearance Ship-to Address" := ShipToAddr.Address;
                "Clearance Ship-to Address 2" := ShipToAddr."Address 2";
                "Clearance Ship-to City" := ShipToAddr.City;
                "Clearance Ship-to Post Code" := ShipToAddr."Post Code";
                "Clearance Ship-to County" := ShipToAddr.County;
                VALIDATE("Clear.Ship-to Country/Reg.Code", ShipToAddr."Country/Region Code");
                "Clearance Ship-to Contact" := ShipToAddr.Contact;
                "Clearance Shipment Method Code" := ShipToAddr."Shipment Method Code";
                //IF ShipToAddr."Location Code" <> '' THEN
                //    VALIDATE("Location Code", ShipToAddr."Location Code");
                "Clearance Shipping Agent Code" := ShipToAddr."Shipping Agent Code";
                "Clear.Ship.Agent Service Code" := ShipToAddr."Shipping Agent Service Code";
                fnGetShippingTime(FieldNo("Clearance Ship-to Code"));


            end;
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
            TableRelation = IF ("Clear.Ship-to Country/Reg.Code" = CONST('')) "Post Code".City
            ELSE
            IF ("Clear.Ship-to Country/Reg.Code" = FILTER(<> '')) "Post Code".City WHERE("Country/Region Code" = FIELD("Clear.Ship-to Country/Reg.Code"));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnLookup()
            begin
                //OnBeforeLookupShipToCity(Rec, PostCode);

                PostCode.LookupPostCode("Clearance Ship-to City", "Clearance Ship-to Post Code", "Clearance Ship-to County", "Clear.Ship-to Country/Reg.Code");

                //OnAfterLookupShipToCity(Rec, PostCode);
            end;

            trigger OnValidate()
            begin
                PostCode.ValidateCity(
                  "Clearance Ship-to City", "Clearance Ship-to Post Code", "Clearance Ship-to County", "Clear.Ship-to Country/Reg.Code", (CurrFieldNo <> 0) and GuiAllowed);
            end;
        }
        field(53006; "Clearance Ship-to Contact"; Text[100])
        {
            Caption = 'Clearance Ship-to Contact';
        }
        field(53007; "Clearance Ship-to Post Code"; Code[20])
        {
            Caption = 'Clearance Ship-to Post Code';
            TableRelation = IF ("Clear.Ship-to Country/Reg.Code" = CONST('')) "Post Code"
            ELSE
            IF ("Clear.Ship-to Country/Reg.Code" = FILTER(<> '')) "Post Code" WHERE("Country/Region Code" = FIELD("Clear.Ship-to Country/Reg.Code"));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnLookup()
            begin
                //OnBeforeLookupShipToPostCode(Rec, PostCode);

                PostCode.LookupPostCode("Clearance Ship-to City", "Clearance Ship-to Post Code", "Clearance Ship-to County", "Clear.Ship-to Country/Reg.Code");

                //OnAfterLookupShipToPostCode(Rec, PostCode);
            end;

            trigger OnValidate()
            begin
                //OnBeforeValidateShipToPostCode(Rec, PostCode);

                PostCode.ValidatePostCode(
                  "Clearance Ship-to City", "Clearance Ship-to Post Code", "Clearance Ship-to County", "Clear.Ship-to Country/Reg.Code", (CurrFieldNo <> 0) and GuiAllowed);
            end;
        }
        field(53008; "Clearance Ship-to County"; Text[30])
        {
            CaptionClass = '5,1,' + "Clear.Ship-to Country/Reg.Code";
            Caption = 'Clearance Ship-to County';
        }
        field(53009; "Clear.Ship-to Country/Reg.Code"; Code[10])
        {
            Caption = 'Clearance Ship-to Country/Region Code';
            TableRelation = "Country/Region";
        }
        field(53010; "Clearance Shipment Method Code"; Code[10])
        {
            Caption = 'Clearance Shipment Method Code';
            TableRelation = "Shipment Method";

        }
        field(53011; "Clearance Shipping Agent Code"; Code[10])
        {
            AccessByPermission = TableData "Shipping Agent Services" = R;
            Caption = 'Clearance Shipping Agent Code';
            TableRelation = "Shipping Agent";
        }
        field(53012; "Clear.Ship.Agent Service Code"; Code[10])
        {
            Caption = 'Shipping Agent Service Code';
            TableRelation = "Shipping Agent Services".Code WHERE("Shipping Agent Code" = FIELD("Clearance Shipping Agent Code"));
        }
        field(53013; "Clearance Ship.Agent Serv.Code"; Code[10])
        {


        }
        field(53014; "Clearance Shipping Time"; DateFormula)
        {

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
        //GST-22/05/2022
        modify("VAT Base Discount %")
        {
            CaptionClass = 'GSTORVAT,VAT Base Discount %';
        }
        modify("VAT Country/Region Code")
        {
            CaptionClass = 'GSTORVAT,VAT Country/Region Code';
        }
        modify("VAT Registration No.")
        {
            CaptionClass = 'GSTORVAT,VAT Registration No.';
        }
        modify("Amount Including VAT")
        {
            CaptionClass = 'GSTORVAT,Amount Including VAT';
        }
        modify("Prices Including VAT")
        {
            CaptionClass = 'GSTORVAT,Prices Including VAT';
        }

        // Agent Representative

        field(53200; "Agent Rep. Code"; Code[20])
        {
            DataClassification = SystemMetadata;
            TableRelation = "Agent Representative";
            trigger OnValidate()
            begin
                if AgentRep.Get("Agent Rep. Code") then begin
                    "Agent Rep. Name" := AgentRep.Name;
                    "Agent Rep. Address" := AgentRep.Address;
                    "Agent Rep. Address 2" := AgentRep."Address 2";
                    "Agent Rep. City" := AgentRep.City;
                    "Agent Rep. Post Code" := AgentRep."Post Code";
                    "Agent Rep. Country/Region Code" := AgentRep."Country/Region Code";
                end else begin
                    "Agent Rep. Name" := '';
                    "Agent Rep. Address" := '';
                    "Agent Rep. Address 2" := '';
                    "Agent Rep. City" := '';
                    "Agent Rep. Post Code" := '';
                    "Agent Rep. Country/Region Code" := '';
                end;
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
            DataClassification = SystemMetadata;
            Caption = 'Agent Rep Country/Region Code';
            TableRelation = "Country/Region";
            Editable = false;

            trigger OnValidate()
            begin
                PostCode.CheckClearPostCodeCityCounty("Agent Rep. City", "Agent Rep. Post Code", blankvar, "Agent Rep. Country/Region Code", xRec."Agent Rep. Country/Region Code");
            end;
        }
        // Agent Representative


        //+++

        field(53100; "Price Changed"; Boolean)
        {
            Caption = 'Price Changed';
            //DataClassification = ToBeClassified;
            FieldClass = FlowField;
            CalcFormula = exist("Sales Line" where("Document Type" = field("Document Type"), "Document No." = field("No."), "Price Changed" = const(true), Type = const(Item)));
        }
        field(53101; "Payment Terms Changed"; Boolean)
        {
            Caption = 'Payment Terms Changed';
            DataClassification = ToBeClassified;
            Editable = false;
            Description = 'T12574';
        }
        field(53102; "Initial Payment Period"; DateFormula)
        {
            DataClassification = ToBeClassified;
            Editable = false;
            Description = 'T12574';
        }
        field(53103; "Excess Payment Terms Days"; DateFormula)
        {
            DataClassification = ToBeClassified;
            Description = 'T12574';
        }
        field(53104; "Sub Status"; Text[150])
        {
            DataClassification = ToBeClassified;
            Description = 'T12574';
            //Editable = false;
            trigger OnValidate()
            begin
                if Rec."Document Type" = Rec."Document Type"::Order then begin
                    Rec.CalcFields(Shipped);
                    if rec.Shipped then
                        Rec."Sub Status" := 'Dispatched';
                end;
            end;
        }
        field(53105; "Salesperson Name"; Text[50])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Salesperson/Purchaser".Name where(Code = field("Salesperson Code")));
            Description = 'T12574';
        }
        field(53106; "Credit Limit Percentage"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 2 : 2;
            Description = 'T12574';
            trigger OnValidate()
            begin
                UpdatePriceChangeRange();
            end;
        }
        field(53107; "Price Change %"; Decimal)
        {
            Caption = 'Price Change %';
            DecimalPlaces = 2 : 2;
            //DataClassification = ToBeClassified;
            Description = 'T12574';
            FieldClass = FlowField;
            CalcFormula = min("Sales Line"."Price Change %" where("Document Type" = field("Document Type"), "Document No." = field("No."), Type = const(Item), "Price Change %" = filter('<>0')));
        }
        field(53108; "Credit Limit 1st Range"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'T12574';
            trigger OnValidate()
            begin
                if "Credit Limit 1st Range" then begin
                    "Credit Limit 2nd Range" := false;
                    "Credit Limit 3rd Range" := false;
                end;
            end;
        }
        field(53109; "Credit Limit 2nd Range"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'T12574';
            trigger OnValidate()
            begin
                if "Credit Limit 2nd Range" then begin
                    "Credit Limit 1st Range" := false;
                    "Credit Limit 3rd Range" := false;
                end;
            end;
        }
        field(53111; "Credit Limit 3rd Range"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'T12574';
            trigger OnValidate()
            begin
                if "Credit Limit 3rd Range" then begin
                    "Credit Limit 1st Range" := false;
                    "Credit Limit 2nd Range" := false;
                end;
            end;
        }
        field(53112; "Price Change % 1st Range"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'T12574';
            trigger OnValidate()
            begin
                if "Price Change % 1st Range" then begin
                    "Price Change % 2nd Range" := false;
                    "Price Change % 3rd Range" := false;
                end;
            end;
        }
        field(53113; "Price Change % 2nd Range"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'T12574';
            trigger OnValidate()
            begin
                if "Price Change % 2nd Range" then begin
                    "Price Change % 1st Range" := false;
                    "Price Change % 3rd Range" := false;
                end;
            end;
        }
        field(53114; "Price Change % 3rd Range"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'T12574';
            trigger OnValidate()
            begin
                if "Price Change % 3rd Range" then begin
                    "Price Change % 1st Range" := false;
                    "Price Change % 2nd Range" := false;
                end;
            end;
        }
        //---

        //04-08-2022-start
        field(53116; "Amount LCY"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'T12574';
        }
        field(53117; "Unit Price Difference"; Decimal)
        {
            Caption = 'Unit Price Difference';
            DecimalPlaces = 2 : 2;
            //DataClassification = ToBeClassified;
            Description = 'T12574';
            FieldClass = FlowField;
            CalcFormula = min("Sales Line"."Unit Price Difference" where("Document Type" = field("Document Type"), "Document No." = field("No."), Type = const(Item), "Unit Price Difference" = filter('<>0')));
        }
        field(53118; "Available Credit Limit"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'T12574';
        }
        field(53119; "Price < Suggested But > Min."; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'T12574';
        }
        //14-08-2022-end

        field(53120; "Custom Ship to Option"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = '50307';
        }
        field(53121; "Advance Payment Approval"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = '50307';
        }
        field(53122; "HSN Code Approval"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = '50307';
        }
        field(50123; "Item Description Approval"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = '50307';
        }
        Field(50124; "Minimum Selling Price Approval"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = '50307';
        }
        Field(50125; "Minimum Initial Price Approval"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = '50307';
        }
        Field(50126; "Shipping Address Approval"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = '50307';
        }
        field(50127; "Shipment Method Approval"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = '50307';
        }
        Field(50128; "Shorter Delivery Date Approval"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = '50307';
        }
        Field(50129; "Country Of Origin Approval"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = '50307';
        }
        Field(50130;"Payment Terms Approval"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = '50307';
        }

    }


    LOCAL procedure fnGetShippingTime(CalledByFieldNo: Integer)
    var
        ShippingAgentServices: Record "Shipping Agent Services";
    begin
        IF (CalledByFieldNo <> CurrFieldNo) AND (CurrFieldNo <> 0) THEN
            EXIT;

        IF ShippingAgentServices.GET("Clearance Shipping Agent Code", "Clearance Ship.Agent Serv.Code") THEN
            "Clearance Shipping Time" := ShippingAgentServices."Shipping Time"
        ELSE BEGIN
            GetCust("Sell-to Customer No.");
            "Clearance Shipping Time" := Cust."Shipping Time"
        END;
        IF NOT (CalledByFieldNo IN [FIELDNO("Clearance Shipping Agent Code"), FIELDNO("Clearance Ship.Agent Serv.Code")]) THEN
            VALIDATE("Clearance Shipping Time");
    end;

    procedure DDP_validation()
    var
        customer: Record Customer;
    Begin
        if (rec."Transaction Specification" = 'DDP') and (rec."VAT Bus. Posting Group" = 'C-LOCAL')
                               then begin
            rec.Validate("VAT Bus. Posting Group", 'C-LOCAL-DDP');
            rec.Modify()
        end
        else
            if rec."Transaction Specification" <> 'DDP'
           then begin
                customer.get(rec."Bill-to Customer No.");
                rec.Validate("VAT Bus. Posting Group", customer."VAT Bus. Posting Group");
                rec.Modify()
            end;
    End;

    procedure UpdatePriceChangeRange()
    var
        SalesSetup: Record "Sales & Receivables Setup";
    begin
        SalesSetup.GET;
        Rec."Price Change % 1st Range" := false;
        Rec."Price Change % 2nd Range" := false;
        Rec."Price Change % 3rd Range" := false;
        Rec.CalcFields("Price Change %");
        if Rec."Price Change %" < 0 then begin
            if (ABS(Rec."Price Change %") >= SalesSetup."Price Change % 1st From Range") AND (ABS(Rec."Price Change %") <= SalesSetup."Price Change % 1st To Range") then begin
                Rec.Validate("Price Change % 1st Range", true);
            end else
                if (ABS(Rec."Price Change %") >= SalesSetup."Price Change % 2nd From Range") AND (ABS(Rec."Price Change %") <= SalesSetup."Price Change % 2nd To Range") then begin
                    Rec.Validate("Price Change % 2nd Range", true);
                end
                else
                    if (ABS(Rec."Price Change %") >= SalesSetup."Price Change % 3rd From Range") AND (ABS(Rec."Price Change %") <= SalesSetup."Price Change % 3rd To Range") then begin
                        Rec.Validate("Price Change % 3rd Range", true);
                    end else
                        if (ABS(Rec."Price Change %") >= SalesSetup."Price Change % 3rd To Range") then
                            Rec.Validate("Price Change % 3rd Range", true);
        end;

        Rec."Credit Limit 1st Range" := false;
        Rec."Credit Limit 2nd Range" := false;
        Rec."Credit Limit 3rd Range" := false;
        if Rec."Credit Limit Percentage" < 0 then begin
            if (ABS(Rec."Credit Limit Percentage") >= SalesSetup."Credit Limit 1st From Range") AND (ABS(Rec."Credit Limit Percentage") <= SalesSetup."Credit Limit 1st To Range") then begin
                Rec.Validate("Credit Limit 1st Range", true);
            end else
                if (ABS(Rec."Credit Limit Percentage") >= SalesSetup."Credit Limit 2nd From Range") AND (ABS(Rec."Credit Limit Percentage") <= SalesSetup."Credit Limit 2nd To Range") then begin
                    Rec.Validate("Credit Limit 2nd Range", true);
                end
                else
                    if (ABS(Rec."Credit Limit Percentage") >= SalesSetup."Credit Limit 3rd From Range") AND (ABS(Rec."Credit Limit Percentage") <= SalesSetup."Credit Limit 3rd To Range") then begin
                        Rec.Validate("Credit Limit 3rd Range", true);
                    end else
                        if (ABS(Rec."Credit Limit Percentage") >= SalesSetup."Credit Limit 3rd To Range") then
                            Rec.Validate("Credit Limit 3rd Range", true);
        end;
        //Modify;
    end;


    var
        Cust: Record Customer;
        PostCode: Record "Post Code";
        blankvar: Variant;
        AgentRep: Record "Agent Representative";
}
