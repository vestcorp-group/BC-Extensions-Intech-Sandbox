tableextension 58080 cust_lookup extends Customer//T12370-Full Comment  //T12574-N
{
    fields
    {
        //         field(58033; "Market Industry Code"; Code[40])
        //         {
        //             TableRelation = KMP_TblMarketIndustry;

        //             trigger OnValidate()
        //             var
        //                 Marketindustry: Record KMP_TblMarketIndustry;
        //             begin
        //                 if Marketindustry.Get("Market Industry Code") then
        //                     "Market Industry Description" := Marketindustry.Description;
        //             end;
        //         }
        //         field(58034; "Market Industry Description"; Text[200])
        //         {
        //             TableRelation = KMP_TblMarketIndustry.Description where("Customer Master Allowed" = const(true));
        //             ValidateTableRelation = false;
        //             trigger OnValidate()
        //             var
        //                 Marketindustry: Record KMP_TblMarketIndustry;
        //             begin
        //                 Marketindustry.SetRange(Description, "Market Industry Description");
        //                 if Marketindustry.FindFirst() then
        //                     "Market Industry Code" := Marketindustry.Code;
        //             end;
        //         }
        //         field(56041; "Block Email Distribution"; Boolean)
        //         {
        //             DataClassification = ToBeClassified;
        //         }
        //         field(53000; "Clearance Ship-To Address"; Code[10])
        //         {

        //             TableRelation = "Clearance Ship-to Address".Code WHERE("Customer No." = FIELD("No."));
        //             Caption = 'Clearance Ship-To Address';
        //         }
        field(53001; "IC Company Code"; Text[30])
        {
            Caption = 'IC Company Code';
            DataClassification = ToBeClassified;
            Description = 'T12574';
        }

        //         field(53010; "Orders -InProcess"; Decimal)
        //         {
        //             AccessByPermission = TableData "Sales Shipment Header" = R;
        //             AutoFormatExpression = "Currency Code";
        //             AutoFormatType = 1;
        //             CalcFormula = Sum("Sales Line"."Outstanding Amount" WHERE("Document Type" = CONST(Order),
        //                                                                        "Bill-to Customer No." = FIELD("No."),
        //                                                                        "Shortcut Dimension 1 Code" = FIELD("Global Dimension 1 Filter"),
        //                                                                        "Shortcut Dimension 2 Code" = FIELD("Global Dimension 2 Filter"),
        //                                                                        "Currency Code" = FIELD("Currency Filter"), "Header Status" = Filter('<>Open')));
        //             Caption = 'Orders -InProcess';
        //             Editable = false;
        //             FieldClass = FlowField;
        //         }
        field(53011; "Orders (LCY)-InProcess"; Decimal)
        {
            AccessByPermission = TableData "Sales Shipment Header" = R;
            AutoFormatType = 1;
            CalcFormula = Sum("Sales Line"."Outstanding Amount (LCY)" WHERE("Document Type" = CONST(Order),
                                                                             "Bill-to Customer No." = FIELD("No."),
                                                                             "Shortcut Dimension 1 Code" = FIELD("Global Dimension 1 Filter"),
                                                                             "Shortcut Dimension 2 Code" = FIELD("Global Dimension 2 Filter"),
                                                                             "Currency Code" = FIELD("Currency Filter"), "Header Status" = Filter('<>Open')));
            Caption = 'Orders (LCY)-InProcess';
            Editable = false;
            FieldClass = FlowField;
            Description = 'T12574';
        }

        //         //08-08-2022-start
        field(53012; "Customer Final Destination"; code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Area";
            Description = 'T12574';
        }
        //         //08-08-2022-end

        //         field(53013; "CRM Code"; Text[50])
        //         {
        //             DataClassification = ToBeClassified;
        //         }

        field(53051; "Agent Rep. Code"; Code[20])
        {
            DataClassification = SystemMetadata;
            TableRelation = "Agent Representative";
        }
        //         field(53052; "Blocked Reason"; Text[1500])
        //         {
        //             DataClassification = ToBeClassified;
        //         }
        //     }
        //     fieldgroups
        //     {
        //         addlast(DropDown; "Search Name")
        //         {
        //         }
    }
    //     var
    //         myInt: Integer;
    //         ShipToAdd: Record "Clearance Ship-to Address";
    //         AgentRep: Record "Agent Representative";

    procedure companytransfer2(cust_from: Record Customer; showMessage: Boolean) // T13353-AS 15-01-2025  Procedure  uncommented
    var
        masterconfig: Record "Release to Company Setup";
        cust_to: Record Customer;
        shiptoaddress_to: Record "Ship-to Address";
        shiptoaddress_from: Record "Ship-to Address";
        CustomerAltAddr_to: Record "Customer Alternet Address";
        CustomerAltAddr_from: Record "Customer Alternet Address";
        Text001: Label 'Customer %1 transfered to %2 Company';
        Text002: Label 'Customer %1 modified in %2 Company';
        Creditlimit: Decimal;
        Insurancelimit: Decimal;
        Paymenttermscode: Text;

    begin
        masterconfig.reset();
        masterconfig.SetRange(masterconfig."Transfer Customer", true);
        masterconfig.SetFilter(masterconfig."Company Name", '<>%1', CompanyName);
        if masterconfig.FindSet() then
            repeat
                cust_to.ChangeCompany(masterconfig."Company Name");
                cust_to.Reset();
                if not cust_to.Get(cust_from."No.") then begin
                    cust_to.Init();
                    cust_to := cust_from;
                    cust_to."Credit Limit (LCY)" := 1;
                    cust_to."Insurance Limit (LCY) 2" := 0;
                    cust_to."Payment Terms Code" := 'CA';
                    if cust_to.Insert() then begin
                        //shipping address table transfer
                        shiptoaddress_from.SetRange("Customer No.", cust_from."No.");
                        shiptoaddress_to.ChangeCompany(masterconfig."Company Name");
                        shiptoaddress_to.Reset();
                        repeat
                            if not shiptoaddress_to.Get(shiptoaddress_from."Customer No.", shiptoaddress_from.Code) then begin
                                shiptoaddress_to.Init();
                                shiptoaddress_to := shiptoaddress_from;
                                if shiptoaddress_to.Insert() then;
                            end;
                        until shiptoaddress_from.Next() = 0;

                        //alternate Customer details transfer 
                        CustomerAltAddr_from.SetRange(CustomerNo, cust_from."No.");
                        if CustomerAltAddr_from.FindSet() then begin
                            CustomerAltAddr_to.ChangeCompany(masterconfig."Company Name");
                            CustomerAltAddr_to.Reset();
                            if not CustomerAltAddr_to.Get(CustomerAltAddr_from.CustomerNo) then begin
                                CustomerAltAddr_to.Init();
                                CustomerAltAddr_to := CustomerAltAddr_from;
                                if CustomerAltAddr_to.Insert() then;
                            end
                            else begin
                                CustomerAltAddr_to.TransferFields(CustomerAltAddr_from, false);
                                if CustomerAltAddr_to.Modify() then;
                            end;
                        end;

                    end;
                    if showMessage then
                        Message(Text001, cust_from.Name, masterconfig."Company Name");

                end
                else begin
                    Creditlimit := cust_to."Credit Limit (LCY)";
                    Insurancelimit := cust_to."Insurance Limit (LCY) 2";
                    Paymenttermscode := cust_to."Payment Terms Code";
                    cust_to.TransferFields(cust_from, false);
                    cust_to."Credit Limit (LCY)" := Creditlimit;
                    cust_to."Insurance Limit (LCY) 2" := Insurancelimit;
                    cust_to."Payment Terms Code" := Paymenttermscode;
                    if cust_to.Modify() then begin
                        //modify ship to address
                        shiptoaddress_from.SetRange("Customer No.", cust_from."No.");
                        shiptoaddress_to.ChangeCompany(masterconfig."Company Name");
                        shiptoaddress_to.Reset();
                        repeat
                            if not shiptoaddress_to.Get(shiptoaddress_from."Customer No.", shiptoaddress_from.Code) then begin
                                shiptoaddress_to.Init();
                                shiptoaddress_to := shiptoaddress_from;
                                if shiptoaddress_to.Insert() then;
                            end
                            else begin
                                shiptoaddress_to.TransferFields(shiptoaddress_from, false);
                                if shiptoaddress_to.Modify() then;
                            end;
                        until shiptoaddress_from.Next() = 0;

                        //alternate Customer details transfer 
                        CustomerAltAddr_from.SetRange(CustomerNo, cust_from."No.");
                        if CustomerAltAddr_from.FindSet() then begin
                            CustomerAltAddr_to.ChangeCompany(masterconfig."Company Name");
                            CustomerAltAddr_to.Reset();
                            if not CustomerAltAddr_to.Get(CustomerAltAddr_from.CustomerNo) then begin
                                CustomerAltAddr_to.Init();
                                CustomerAltAddr_to := CustomerAltAddr_from;
                                if CustomerAltAddr_to.Insert() then;
                            end
                            else begin
                                CustomerAltAddr_to.TransferFields(CustomerAltAddr_from, false);
                                if CustomerAltAddr_to.Modify() then;
                            end;
                        end;
                    end;
                    if showMessage then
                        Message(Text002, cust_to.Name, masterconfig."Company Name");
                end;
            until masterconfig.Next() = 0;
    end;

    //     procedure CopyCust_Reg_type()
    //     var
    //         custreg_from: Record "Customer Registration";
    //         custreg_to: Record "Customer Registration";
    //         masterconfig: Record "Release to Company Setup";
    //     begin
    //         masterconfig.reset();
    //         masterconfig.SetRange(masterconfig."Transfer Customer", true);
    //         masterconfig.SetFilter(masterconfig."Company Name", '<>%1', CompanyName);
    //         if masterconfig.FindSet() then
    //             repeat
    //                 custreg_to.ChangeCompany(masterconfig."Company Name");
    //                 custreg_to.Reset();
    //                 if custreg_from.FindSet() then begin
    //                     repeat
    //                         if not custreg_to.get(custreg_from.Code) then begin
    //                             custreg_to := custreg_from;
    //                             if custreg_to.Insert() then;
    //                         end
    //                         else begin
    //                             custreg_to."Customer Registration Type" := custreg_from."Customer Registration Type";
    //                             if custreg_to.Modify() then;
    //                         end;
    //                     until custreg_from.Next() = 0;
    //                 end;
    //             until masterconfig.Next() = 0;
    //     end;

    //     procedure AltrernateCustTransfer(CustomerAltAddr_from: Record "Customer Alternet Address")
    //     var
    //         masterconfig: Record "Release to Company Setup";
    //         CustomerAltAddr_to: Record "Customer Alternet Address";
    //         Text001: Label 'Customer Alternet Address %1 transfered to %2 Company';
    //         Text002: Label 'Customer Alternet Address %1 modified in %2 Company';
    //     begin
    //         masterconfig.reset();
    //         masterconfig.SetRange(masterconfig."Transfer Customer", true);
    //         masterconfig.SetFilter(masterconfig."Company Name", '<>%1', CompanyName);
    //         if masterconfig.FindSet() then
    //             repeat
    //                 CustomerAltAddr_to.ChangeCompany(masterconfig."Company Name");
    //                 CustomerAltAddr_to.Reset();
    //                 if not CustomerAltAddr_to.Get(CustomerAltAddr_from.CustomerNo) then begin
    //                     CustomerAltAddr_to.Init();
    //                     CustomerAltAddr_to := CustomerAltAddr_from;
    //                     if CustomerAltAddr_to.Insert() then;
    //                     Message(Text001, CustomerAltAddr_to.Name, masterconfig."Company Name");
    //                 end
    //                 else begin
    //                     CustomerAltAddr_to.TransferFields(CustomerAltAddr_from, true);
    //                     if CustomerAltAddr_to.Modify() then;
    //                     Message(Text002, CustomerAltAddr_to.Name, masterconfig."Company Name");
    //                 end;
    //             until masterconfig.Next() = 0;
    //     end;
}
