// page 50001 "Update Sales Invoice"//T12370-N //T12574-MIG USING ISPL E-Invoice Ext.
// {
//     Caption = 'Sales Invoice';
//     PageType = Card;
//     SourceTable = "Sales Invoice Header";
//     Permissions = tabledata "Sales Invoice Header" = RM;
//     DeleteAllowed = false;
//     InsertAllowed = false;
//     ModifyAllowed = true;
//     layout
//     {
//         area(content)
//         {
//             group(General)
//             {
//                 field("Sell-to Post Code"; Rec."Sell-to Post Code")
//                 {
//                     ApplicationArea = All;
//                 }
//                 field("Bill-to Post Code"; Rec."Bill-to Post Code")
//                 {
//                     ApplicationArea = All;
//                 }
//                 field("Ship-to Post Code"; Rec."Ship-to Post Code")
//                 {
//                     ApplicationArea = All;
//                 }
//                 field("Vehicle No."; Rec."Vehicle No.")
//                 {
//                     ApplicationArea = All;
//                 }
//                 field("Vehicle Type"; Rec."Vehicle Type")
//                 {
//                     ApplicationArea = All;
//                 }
//                 field("Transport Doc No."; Rec."Transport Doc No.")
//                 {
//                     ApplicationArea = All;
//                 }
//                 field("Transport Doc Date"; Rec."Transport Doc Date")
//                 {
//                     ApplicationArea = All;
//                 }
//                 field("Transporter ID"; Rec."Transporter ID")
//                 {
//                     ApplicationArea = All;
//                 }
//                 field("Transporter Name"; Rec."Transporter Name")
//                 {
//                     ApplicationArea = All;
//                 }
//                 field("Transport Method"; Rec."Transport Method")
//                 {
//                     ApplicationArea = All;
//                 }
//             }
//             group("Tax Info")
//             {
//                 field("Transaction Mode"; Rec."Transaction Mode")
//                 {
//                     ApplicationArea = All;
//                 }
//                 field("Dispatch From GSTIN"; Rec."Dispatch From GSTIN")
//                 {
//                     ApplicationArea = All;
//                     ToolTip = 'Specifies the value of the Dispatch From GSTIN field.';
//                 }
//                 field("Dispatch From Trade Name"; Rec."Dispatch From Trade Name")
//                 {
//                     ApplicationArea = All;
//                     ToolTip = 'Specifies the value of the Dispatch From Trade Name field.';
//                 }
//                 field("Dispatch From Legal Name"; Rec."Dispatch From Legal Name")
//                 {
//                     ApplicationArea = All;
//                     ToolTip = 'Specifies the value of the Dispatch From Legal Name field.';
//                 }
//                 field("Dispatch From Address 1"; Rec."Dispatch From Address 1")
//                 {
//                     ApplicationArea = All;
//                     ToolTip = 'Specifies the value of the Dispatch From Address 1 field.';
//                 }
//                 field("Dispatch From Address 2"; Rec."Dispatch From Address 2")
//                 {
//                     ApplicationArea = All;
//                     ToolTip = 'Specifies the value of the Dispatch From Address 2 field.';
//                 }
//                field("Dispatch From Location"; Rec."Dispatch From Location")
//                 {
//                     ApplicationArea = All;
//                     ToolTip = 'Specifies the value of the Dispatch From Location field.';
//                 }
//                 field("Dispatch From State Code"; Rec."Dispatch From State Code")
//                 {
//                     ApplicationArea = All;
//                     ToolTip = 'Specifies the value of the Dispatch From State Code field.';
//                 }
//                 field("Dispatch From Pincode"; Rec."Dispatch From Pincode")
//                 {
//                     ApplicationArea = All;
//                     ToolTip = 'Specifies the value of the Dispatch From Pincode field.';
//                 }
//             }

//             group("Ship-to")
//             {
//                 //Editable = AllowEdit;
//                 Caption = 'Ship-to';
//                 field("Ship-to Code"; Rec."Ship-to Code")
//                 {
//                     ApplicationArea = All;
//                     Caption = 'Address Code';
//                     Importance = Promoted;
//                     ToolTip = 'Specifies the address on purchase orders shipped with a drop shipment directly from the vendor to a customer.';
//                     Editable = false;
//                 }
//                 field("Ship-to Name"; Rec."Ship-to Name")
//                 {
//                     ApplicationArea = All;
//                     Importance = Promoted;
//                     Caption = 'Name';
//                     ToolTip = 'Specifies the name of the customer that the items were shipped to.';
//                     Editable = false;
//                 }
//                 field("Ship-to Address"; Rec."Ship-to Address")
//                 {
//                     ApplicationArea = All;
//                     Caption = 'Address';
//                     ToolTip = 'Specifies the address that the items on the invoice were shipped to.';
//                     Editable = false;
//                 }
//                 field("Ship-to Address 2"; Rec."Ship-to Address 2")
//                 {
//                     ApplicationArea = All;
//                     Caption = 'Address 2';
//                     ToolTip = 'Specifies additional address information.';
//                     Editable = false;
//                 }
//                 field("Ship-to City"; Rec."Ship-to City")
//                 {
//                     ApplicationArea = All;
//                     Caption = 'City';
//                     ToolTip = 'Specifies the city of the customer on the sales document.';
//                     Editable = false;
//                 }
//                 field("Ship-to County"; Rec."Ship-to County")
//                 {
//                     ApplicationArea = All;
//                     Caption = 'County';
//                     ToolTip = 'Specifies the state, province or county as a part of the address.';
//                     Editable = false;
//                 }

//                 field("Ship-to Country/Region Code"; Rec."Ship-to Country/Region Code")
//                 {
//                     ApplicationArea = All;
//                     Caption = 'Country/Region';
//                     ToolTip = 'Specifies the country or region of the address.';
//                     Editable = false;
//                 }
//                 field("Ship-to Contact"; Rec."Ship-to Contact")
//                 {
//                     ApplicationArea = All;
//                     Caption = 'Contact';
//                     ToolTip = 'Specifies the name of the person you regularly contact at the address that the items were shipped to.';
//                     Editable = false;
//                 }
//                 field("Ship-to GST Customer Type"; Rec."Ship-to GST Customer Type")
//                 {
//                     ApplicationArea = All;
//                     ToolTip = 'Specifies the GST Ship-to Customer Type';
//                     Editable = false;

//                 }
//                 field("GST Ship-to State Code"; Rec."GST Ship-to State Code")
//                 {
//                     ApplicationArea = All;
//                     ToolTip = 'Specifies the GST Ship-to State Code';
//                     Editable = true;

//                 }

//             }
//         }
//     }
// }
