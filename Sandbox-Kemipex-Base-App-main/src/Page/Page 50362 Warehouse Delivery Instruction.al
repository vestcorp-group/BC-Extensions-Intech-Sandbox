page 50362 "Warehouse Delivery Instruction"//T12370-Full Comment
{
    PageType = Document;
    UsageCategory = Administration;
    SourceTable = "Warehouse Delivery Inst Header";
    Editable = true;
    ModifyAllowed = true;
    DeleteAllowed = true;
    DataCaptionFields = "WDI No", "Location Code";

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("No."; rec."WDI No")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Sales Shipment No."; rec."Sales Shipment No.")
                {
                    ApplicationArea = all;
                }
            }
            group("Location Details")
            {
                field("Location Code"; rec."Location Code")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Location Name"; rec."Location Name")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Location Email Address"; rec."Location E-mail Address")
                {
                    ApplicationArea = all;
                    Editable = true;
                }
                field("Collection Date"; rec."Collection Date")
                {
                    ApplicationArea = all;
                    Editable = true;
                }
                field("Collection Time"; rec."Collection Time")
                {
                    ApplicationArea = all;
                    Editable = true;
                }
                field("Ex-Works"; rec."Ex-Works")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                group("Agent Details")
                {
                    field("Shipping Agent"; rec."Shipping Agent")
                    {
                        Caption = 'Agent';
                        ApplicationArea = all;
                        Editable = true;
                        Enabled = Rec."Agent Enabled";
                    }
                    field("Shipping Agent Name"; rec."Shipping Agent Name")
                    {
                        Caption = 'Agent Name';

                        ApplicationArea = all;
                        Editable = false;
                    }
                    field("Ship Agent Phone No"; rec."Ship Agent Phone No")
                    {
                        ApplicationArea = all;
                        Caption = 'Agent Phone No.';
                        Editable = false;
                    }
                    field("Ship Agent Contact Code"; rec."Ship Agent Contact Code")
                    {
                        Caption = 'Agent Contact';
                        ApplicationArea = all;
                        Enabled = Rec."Agent Enabled";
                    }
                    field("Ship Agent Contact Name"; rec."Ship Agent Contact Name")
                    {
                        ApplicationArea = all;
                        Caption = 'Agent Contact Name';
                        Editable = false;
                    }
                    field("Ship Agent Mobile No."; rec."Ship Agent Mobile No.")
                    {
                        Caption = 'Agent Contact Mobile No.';
                        ApplicationArea = all;
                        Editable = false;
                    }
                    field("Shipping Agent E-mail"; rec."Ship Agent Contact E-mail")
                    {
                        ApplicationArea = all;
                        Editable = false;
                        Caption = 'Agent Contact E-Mail';
                    }
                }
            }
            group("Customer Details")
            {
                field("Bill-to Customer Code"; rec."Bill-to Customer Code")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Bill-to Customer Name"; rec."Bill-to Customer Name")
                {
                    ApplicationArea = all;
                }
                field("Customer Phone No"; rec."Customer Phone No")
                {
                    Caption = 'Customer Phone No.';
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Blanket Order No."; rec."Blanket Order No.")
                {
                    ApplicationArea = all;
                }
                field("Sales Order No."; rec."Order No.")
                {
                    ApplicationArea = all;
                }
                // field("Ship-to Customer Code"; rec."Ship-to Customer Code")
                // {
                //     ApplicationArea = all;
                //     Editable = false;
                // }
                group("Contact Details")
                {
                    field("Customer Contact Code"; rec."Customer Contact Code")
                    {
                        ApplicationArea = all;
                        Editable = false;
                        Caption = 'Contact';
                    }
                    field("Customer Contact Name"; rec."Customer Contact Name")
                    {
                        ApplicationArea = all;
                        Editable = false;
                        Caption = 'Contact Name';
                    }
                    field("Customer Contact Mob No"; rec."Customer Contact Mob No")
                    {
                        Caption = 'Contact Mobile No.';
                        Editable = false;
                        ApplicationArea = all;
                    }
                    field("Customer Contact E-Mail"; rec."Customer Contact E-Mail")
                    {
                        Editable = false;
                        ApplicationArea = all;
                        Caption = 'Contact E-Mail ';
                    }
                }
            }
            part(WHInstructionPart; "Warehouse Instruction Sub Page")
            {
                SubPageLink = "Document No." = field("Sales Shipment No."), "Location Code" = field("Location Code");
                Editable = true;
                Enabled = true;
                UpdatePropagation = Both;
                ApplicationArea = all;
            }
            part(Remarks; UserTaskRemarks)
            {
                SubPageLink = "Document Type" = const("Warehouse Instruction"), "No." = field("WDI No");
                Editable = true;
                Enabled = true;
                UpdatePropagation = Both;
                ApplicationArea = all;
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Print Warehouse Instruction ")
            {
                Caption = 'Print Warehouse Instruction';
                ApplicationArea = all;
                trigger OnAction()
                var
                    SalesShipmentheader: Record "Sales Shipment Header";
                    SalesShipmentLine: Record "Sales Shipment Line";
                    WDIHeader: Record "Warehouse Delivery Inst Header";
                begin
                    SalesShipmentLine.Reset();
                    SalesShipmentLine.SetRange("Document No.", Rec."Sales Shipment No.");
                    SalesShipmentLine.SetRange("Location Code", Rec."Location Code");
                    WDIHeader.Reset();
                    WDIHeader.SetRange("WDI No", Rec."WDI No");
                    if WDIHeader.FindSet() then begin
                        Report.RunModal(58360, true, true, WDIHeader);
                    end;
                end;
            }
            action("Send Warehouse Instruction ")
            {
                Caption = 'Send Warehouse Instruction';
                ApplicationArea = all;
                trigger OnAction()
                var
                    WDISEND: Codeunit WarehouseInstructionMail;
                    userSetup: Record "User Setup";
                begin
                    // rec.TestField("Location E-Mail Address");
                    // userSetup.Get(UserId);
                    // WDISEND.SendWDIMail(Rec, userSetup."E-Mail");
                    // if rec."Revised After Sending" = false then begin
                    //     Rec.Revision := Rec.Revision + 1;
                    // end
                    // else
                    //     rec."Revised After Sending" := false;

                    rec.TestField("Location E-Mail Address");
                    rec.TestField("Collection Date");
                    rec.TestField("Collection Time");
                    if not rec."Ex-Works" then
                        rec.TestField("Shipping Agent");
                    userSetup.Get(UserId);
                    WDISEND.SendWDIMail(Rec, userSetup."E-Mail");

                end;
            }

            //New Action added for report shipping instruction
            action("Shipping Instruction")
            {
                ApplicationArea = All;
                Caption = 'Shipping Instruction';
                Promoted = true;
                PromotedCategory = Report;
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction()
                var
                    SalesShipmentheader: Record "Sales Shipment Header";
                    SalesShipmentLine: Record "Sales Shipment Line";
                    WDIHeader: Record "Warehouse Delivery Inst Header";
                begin

                    WDIHeader.Reset();
                    WDIHeader.SetRange("WDI No", Rec."WDI No");
                    if WDIHeader.FindSet() then begin
                        Report.RunModal(50553, true, true, WDIHeader);
                    end;
                    // if SalesShipmentLine.FindSet() then begin
                    // SalesShipmentheader.Reset();
                    // SalesShipmentheader.SetRange("No.", Rec."Sales Shipment No.");
                    // if SalesShipmentheader.FindSet() then
                    //     Report.RunModal(50553, true, true, SalesShipmentheader);
                end;

            }

        }

    }
    trigger OnAfterGetRecord()
    var
        Contact: Record Contact;
        ShippingAgent: Record "Shipping Agent";
    begin

    end;

    var
        Location: Code[20];
        SSH: Page "Posted Sales Shipments";
        ContactName: Text;

}


