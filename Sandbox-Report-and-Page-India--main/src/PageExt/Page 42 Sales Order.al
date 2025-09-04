pageextension 50339 "SOExt" extends "Sales Order"//T12370-Full Comment
{
    //     layout
    //     {
    //         modify(ShippingOptions)
    //         {
    //             trigger OnAfterValidate()
    //             begin
    //                 if ShipToOptions = ShipToOptions::"Custom Address" then
    //                     rec.Shipping := true
    //                 else
    //                     rec.Shipping := false;

    //             end;
    //         }
    //         modify(BillToOptions)
    //         {
    //             trigger OnAfterValidate()
    //             begin
    //                 if BillToOptions = BillToOptions::"Custom Address" then
    //                     rec.Billing := true
    //                 else
    //                     rec.Billing := false;
    //             end;
    //         }
    //         addlast(General)
    //         {
    //             field("Transport Doc No."; Rec."Transport Doc No.")
    //             {
    //                 ApplicationArea = All;
    //                 ShowMandatory = true;
    //             }
    //             field("Transport Doc Date"; Rec."Transport Doc Date")
    //             {
    //                 ApplicationArea = All;
    //                 ShowMandatory = true;
    //             }
    //             field("Transporter ID"; Rec."Transporter ID")
    //             {
    //                 ApplicationArea = All;
    //             }
    //             field("Transporter Name"; Rec."Transporter Name")
    //             {
    //                 ApplicationArea = All;
    //             }
    //         }
    //         modify("Customer GST Reg. No.")
    //         {
    //             ShowMandatory = true;
    //         }
    //         modify("GST Bill-to State Code")
    //         {
    //             ShowMandatory = true;
    //         }
    //         modify("Transport Method")
    //         {
    //             ShowMandatory = true;
    //         }
    //         modify("Vehicle Type")
    //         {
    //             ShowMandatory = true;
    //         }
    //         modify("Vehicle No.")
    //         {
    //             ShowMandatory = true;
    //         }
    //         modify("Location State Code")
    //         {
    //             ShowMandatory = true;
    //         }
    //         modify("Nature of Supply")
    //         {
    //             ShowMandatory = true;
    //             Editable = true;
    //         }

    //         addlast("Tax Info")
    //         {
    //             field("Transaction Mode"; Rec."Transaction Mode")
    //             {
    //                 ApplicationArea = All;
    //             }
    //             field("Dispatch From GSTIN"; Rec."Dispatch From GSTIN")
    //             {
    //                 ApplicationArea = All;
    //                 ToolTip = 'Specifies the value of the Dispatch From GSTIN field.';
    //             }
    //             field("Dispatch From Trade Name"; Rec."Dispatch From Trade Name")
    //             {
    //                 ApplicationArea = All;
    //                 ToolTip = 'Specifies the value of the Dispatch From Trade Name field.';
    //             }
    //             field("Dispatch From Legal Name"; Rec."Dispatch From Legal Name")
    //             {
    //                 ApplicationArea = All;
    //                 ToolTip = 'Specifies the value of the Dispatch From Legal Name field.';
    //             }
    //             field("Dispatch From Address 1"; Rec."Dispatch From Address 1")
    //             {
    //                 ApplicationArea = All;
    //                 ToolTip = 'Specifies the value of the Dispatch From Address 1 field.';
    //             }
    //             field("Dispatch From Address 2"; Rec."Dispatch From Address 2")
    //             {
    //                 ApplicationArea = All;
    //                 ToolTip = 'Specifies the value of the Dispatch From Address 2 field.';
    //             }
    //             field("Dispatch From Location"; Rec."Dispatch From Location")
    //             {
    //                 ApplicationArea = All;
    //                 ToolTip = 'Specifies the value of the Dispatch From Location field.';
    //             }
    //             field("Dispatch From State Code"; Rec."Dispatch From State Code")
    //             {
    //                 ApplicationArea = All;
    //                 ToolTip = 'Specifies the value of the Dispatch From State Code field.';
    //             }
    //             field("Dispatch From Pincode"; Rec."Dispatch From Pincode")
    //             {
    //                 ApplicationArea = All;
    //                 ToolTip = 'Specifies the value of the Dispatch From Pincode field.';
    //             }
    //         }
    //     }

    //     var
    //         myInt: Integer;
    actions
    {
        //T53930-NS
        modify(SendEmailConfirmation)
        {
            Visible = false;
        }
        modify(AttachAsPDF)
        {
            Visible = false;
        }
        modify("Proforma Invoice")
        {
            Visible = false;
        }
        modify(ProformaInvoice)
        {
            Visible = false;
        }
        //T53930-NE
    }
}