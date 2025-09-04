// pageextension 58149 PostedSalesinvoicelist extends "Posted Sales Invoices"//T12370-Full Comment
// {
//     layout
// {
//         modify(VatAmountG)
//         {
//             Caption = 'VAT Amount';
//         }
//         modify("Payment Discount %")
//         {
//             Visible = false;
//         }
//         modify("Shortcut Dimension 1 Code")
//         {
//             Visible = false;
//         }
//         modify("Shortcut Dimension 2 Code")
//         {
//             Visible = false;
//         }
//         modify("Shipment Date")
//         {
//             Visible = false;
//         }
//         modify("Location Code")
//         {
//             Visible = false;
//         }
//         modify("No. Printed")
//         {
//             Visible = false;
//         }
//         modify("Posting Date")
//         { Visible = true; }

//         addafter("Salesperson Code")
//         {
//             field(SalespersonName; SalespersonName)
//             {
//                 ApplicationArea = all;
//                 Visible = true;
//                 Caption = 'Salesperson Name';
//             }
//         }
//         addafter("Currency Code")
//         {
//             field("Custom Declaration Type"; rec."Declaration Type")
//             {
//                 ApplicationArea = all;
//             }
//             field(BillOfExit; rec.BillOfExit)
//             {
//                 ApplicationArea = all;
//                 Caption = 'Declaration No.';
//             }
//         }
//         addafter("Posting Date")
//         {
//             field("Actual Shipment Date"; rec."Actual Shipment Date")
//             {
//                 ApplicationArea = all;

//             }
//         }

//         addafter("Customer Short Name")
//         {
//             field("Bill-to Country/Region Code1"; rec."Bill-to Country/Region Code")
//             {
//                 Caption = 'Bill-to Country/Region Code';
//                 ApplicationArea = all;
//             }
//             field("Ship-to Country/Region Code1"; rec."Ship-to Country/Region Code")
//             {
//                 Caption = 'Ship-to Country/Region Code';
//                 ApplicationArea = all;
//             }
//             field("Transaction Specification"; rec."Transaction Specification")
//             {
//                 Caption = 'Incoterm';
//                 ApplicationArea = all;
//             }
//             field("Transport Method"; rec."Transport Method")
//             {
//                 ApplicationArea = all;
//             }
//             field("Exit Point"; rec."Exit Point")
//             {
//                 Caption = 'Port of Loading';
//                 ApplicationArea = all;
//             }
//             field("Area"; rec."Area")
//             {
//                 Caption = 'Port of Discharge';
//                 ApplicationArea = all;
//             }
//             field("Transaction Type"; rec."Transaction Type")
//             {
//                 ApplicationArea = all;
//                 Caption = 'Order Type';
//             }
//         }

//         moveafter("Actual Shipment Date"; "Due Date")
//         movebefore(Amount; "Currency Code")
//     }

//     actions
//     {
//         addfirst(Creation)
//         {
//             action("Update Declaration")
//             {
//                 ApplicationArea = all;
//                 RunObject = page Billofexitupdatewindow;
//                 RunPageLink = "No." = field("No.");
//                 RunPageOnRec = true;
//                 Promoted = true;
//                 PromotedIsBig = true;
//                 PromotedCategory = Process;
//                 Image = UpdateDescription;
//                 RunPageMode = Edit;

//             }
//         }
//         addlast(processing)
//         {
//             action("Update Customer Sales Declaration")
//             {
//                 ApplicationArea = all;
//                 RunObject = page "Customer Sales Declaration";
//                 //RunPageLink = "No." = field("No.");
//                 Caption = 'Update ETD & ETA';
//                 RunPageOnRec = true;
//                 Promoted = true;
//                 PromotedIsBig = true;
//                 PromotedCategory = Process;
//                 Image = UpdateDescription;
//                 RunPageMode = Edit;

//             }
//         }
//     }
//     trigger OnAfterGetRecord()
//     var
//         SP: Record "Salesperson/Purchaser";
//     begin
//         Clear(SalespersonName);
//         if rec."Salesperson Code" <> '' then begin
//             sp.get(rec."Salesperson Code");
//             SalespersonName := sp.Name;
//         end;
//     end;

//     trigger OnDeleteRecord(): Boolean
//     begin
//         Error('Not allowed to delete the record!');
//     end;

//     var
//         SalespersonName: Text[100];

// }