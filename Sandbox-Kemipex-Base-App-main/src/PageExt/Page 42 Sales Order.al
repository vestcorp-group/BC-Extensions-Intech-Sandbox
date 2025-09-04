
pageextension 50144 KMP_PageExtSalesHdr extends "Sales Order"//T12370-Full Comment //T-12855
{
    layout
    {
        addafter(Status)
        {

            //T13919-NS
            field("IC Transaction No."; Rec."IC Transaction No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the IC Transaction No. field.', Comment = '%';
                Editable = false;
            }
            //T13919-NE

            //             field("Reopen Status"; rec."Reopen Status")
            //             {
            //                 ApplicationArea = all; 
            //                 Caption = 'Reopen Status';
            //                 Editable = false;
            //                 Enabled = false;
            //             }
            field("Bank on Invoice 2"; rec."Bank on Invoice 2")
            {
                Caption = 'Bank on Invoice';
                ApplicationArea = All; // //T-12855 
            }
            //             field("Inspection Required 2"; rec."Inspection Required 2")
            //             {
            //                 ApplicationArea = All;
            //                 Caption = 'Inspection Required';
            //                 // Visible = false;
            //             }
            //             field("Legalization Required 2"; rec."Legalization Required 2")
            //             {
            //                 ApplicationArea = All;
            //                 Caption = 'Legalization Required';
            //                 // Visible = false;
            //             }
            //             field("Seller/Buyer 2"; rec."Seller/Buyer 2")
            //             {
            //                 ApplicationArea = all;

            //                 Caption = 'Seller/Buyer';
            //             }
            field("LC No. 2"; rec."LC No. 2")
            {
                ApplicationArea = All;
                Caption = 'LC No.';
            }
            field("LC Date 2"; rec."LC Date 2")
            {
                ApplicationArea = all;
                Caption = 'LC Date';
            }
            //         }
            //         addafter("Work Description")
            //         {
            //             field(WarehouseInstruction; WarehouseInstruction)
            //             {
            //                 ApplicationArea = all;
            //                 Editable = false;
            //                 DrillDown = true;
            //                 Caption = 'Warehouse Instruction';

            //                 trigger OnDrillDown()
            //                 var
            //                     WDI: Record "Warehouse Delivery Inst Header";
            //                 begin
            //                     WDI.Reset();
            //                     WDI.SetRange("Order No.", rec."No.");
            //                     if WDI.FindSet() then
            //                         Page.Run(Page::"Warehouse Delivery Inst List", WDI);
            //                 end;
            //             }
            //             field(SalesShipment; SalesShipment)
            //             {
            //                 ApplicationArea = all;
            //                 Editable = false;
            //                 DrillDown = true;
            //                 Caption = 'Sales Shipment';

            //                 trigger OnDrillDown()
            //                 var
            //                     SalesShipmentLine: Record "Sales Shipment Line";
            //                     SalesShipmentHeader: Record "Sales Shipment Header";
            //                 begin
            //                     SalesShipmentHeader.Reset();
            //                     SalesShipmentHeader.SetRange("Order No.", Rec."No.");
            //                     if SalesShipmentHeader.FindSet() then
            //                         Page.Run(Page::"Posted Sales Shipments", SalesShipmentHeader);
            //                 end;
            //             }
            //         }
            //         // Add changes to page layout here
            //         addafter("External Document No.")
            //         {
            //             field(CustomBOENumber; rec.CustomBOENumber)
            //             {
            //                 ApplicationArea = all;
            //                 Visible = false;
            //             }

            //             // field(BillOfExit; BillOfExit)
            //             // {
            //             //     ApplicationArea = all;
            //             //     Caption = 'Bill Of Exit';
            //             // }

            //         }
            //         addbefore("Work Description")
            //         {
            //             field(CountryOfLoading; rec.CountryOfLoading)
            //             {
            //                 ApplicationArea = All;
            //             }
            //             field("Blanket Sales order No."; rec."Blanket Sales order No.")
            //             {
            //                 ApplicationArea = all;
            //                 Visible = false;
            //             }
            //             field("Maximum Allowed Due days"; rec."Maximum Allowed Due days")
            //             {
            //                 ApplicationArea = all;
            //                 Editable = false;
            //                 Visible = false;
        }
        //T52085-NS
        addfirst(factboxes)
        {
            part("Inventory Details"; "Item Company Wise Inventory")
            {
                ApplicationArea = all;
                Provider = SalesLines;
                SubPageLink = "Item No." = field("No.");
            }
        }
        //T52085-NE
    }

}

//     actions
//     {
//         addbefore(Release)
//         {
//             action("Send Reopen Request")
//             {
//                 ApplicationArea = all;
//                 Caption = 'Send Reopen Request';
//                 Promoted = true;
//                 PromotedCategory = Category5;
//                 PromotedIsBig = true;
//                 PromotedOnly = true;
//                 Enabled = CanSendReopenRequest;
//                 Image = SendApprovalRequest;

//                 trigger OnAction()
//                 var
//                     KMPApprovalCodeunit: Codeunit "Kemipex Approval Codeunit";
//                     KMNotesDiag: Page "Kemipex Approval Diag";

//                     RecLinkRec: Record "Record Link";
//                     RecordLinkManagement: Codeunit "Record Link Management";
//                     ApprovalTypeenum: Enum "Approval Type";
//                     KemipexSetup: Record "Kemipex Setup";
//                 begin
//                     KemipexSetup.Get(rec.CurrentCompany);
//                     if KemipexSetup."Sales Order Reopen Approver" = '' then Error('Sales Order Reopen Approver should have a value in Kemipex Setup');
//                     Rec.TestField(Status, rec.Status::Released);
//                     if rec.ShippedSalesLinesExist() then Error('Reopen request cannot be sent if items already shipped');
//                     if KMPApprovalCodeunit.OpenApprovalExists(Rec.RecordId, ApprovalTypeenum::"Reopen Request") then Error('Reopen Request Sent Already ');
//                     if KMNotesDiag.RunModal() = Action::OK then begin
//                         KMNotesDiag.Getnote(NoteVar);
//                         RecLinkRec.Init();
//                         RecLinkRec."Record ID" := Rec.RecordId;
//                         RecLinkRec."User ID" := UserId;
//                         RecLinkRec.Company := rec.CurrentCompany;
//                         RecLinkRec.Created := CurrentDateTime;
//                         RecLinkRec.Type := RecLinkRec.Type::Note;
//                         RecordLinkManagement.WriteNote(RecLinkRec, NoteVar);
//                         RecLinkRec.Insert();
//                         KMPApprovalCodeunit.SendReopenRequest(Rec, RecLinkRec."Link ID", NoteVar);
//                     end;
//                     CurrPage.Update();
//                 end;
//             }
//             action("Cancel Reopen Request")
//             {
//                 ApplicationArea = all;
//                 Caption = 'Cancel Reopen Request';
//                 Promoted = true;
//                 PromotedCategory = Category5;
//                 PromotedIsBig = true;
//                 PromotedOnly = true;
//                 Enabled = CanCancelReopenrequest;
//                 Image = CancelApprovalRequest;

//                 trigger OnAction()
//                 var
//                     KMPApprovalCodeunit: Codeunit "Kemipex Approval Codeunit";
//                     Sender: Code[50];
//                     ConfirmDialog: Boolean;
//                 begin
//                     Sender := KMPApprovalCodeunit.ApprovalSender(Rec.RecordId);
//                     if Sender = UserId then begin
//                         if Dialog.Confirm('Are you sure you want to cancel Reopen request', true) then
//                             KMPApprovalCodeunit.CancelReopenRequest(Rec)
//                     end
//                     else
//                         Error('Reopen request can only be canceled by %1', Sender);
//                 end;
//             }
//             action("Kemipex Approvals")
//             {
//                 ApplicationArea = all;
//                 Caption = 'Kemipex Approvals';
//                 Promoted = true;
//                 PromotedCategory = Category5;
//                 PromotedIsBig = true;
//                 PromotedOnly = true;
//                 Image = Approvals;

//                 trigger OnAction()
//                 var
//                     KMApprovalEntry: Record "Kemipex Approval Entry";
//                     KMApprovalEntryPage: Page "Kemipex Approval Entry";

//                 begin
//                     KMApprovalEntryPage.Setfilter(rec.RecordId);
//                     KMApprovalEntryPage.Run();

//                 end;
//             }
//         }
//         modify(Post)
//         {
//             trigger OnBeforeAction()
//             var
//                 // ApprovalTypeenum: Enum "Approval Type";
//                 KMPApprovalCodeunit: Codeunit "Kemipex Approval Codeunit";
//             begin
//                 if KMPApprovalCodeunit.OpenApprovalExists(Rec.RecordId, "approval type"::"Reopen Request") then Error('Reopen request are still pending. please approve Reopen request or contact Sales Support to cancel Reopen request');

//             end;
//         }
//         // Add changes to page actions here
//         addafter("&Print")
//         {
//             action("UN Proforma Invoice")
//             {
//                 ApplicationArea = All;
//                 Promoted = true;
//                 PromotedIsBig = true;
//                 trigger OnAction()
//                 var
//                     myInt: Integer;
//                     SalesHdr: Record "Sales Header";
//                 begin
//                     SalesHdr.SetRange("Document Type", rec."Document Type");
//                     SalesHdr.SetRange("No.", rec."No.");
//                     Report.RunModal(Report::KMP_ProformInvoice, true, true, SalesHdr);
//                 end;
//             }
//         }
//         addafter("Create &Warehouse Shipment")
//         {
//             action("Short Close")
//             {
//                 ApplicationArea = Suite;
//                 Image = CloseDocument;
//                 Promoted = true;
//                 PromotedCategory = Process;
//                 PromotedIsBig = true;
//                 Enabled = AllowShortCloseG;
//                 Caption = 'Short Close Order';
//                 ToolTip = 'Send the order to archive even if the order has not been fully shipped.';
//                 trigger OnAction()
//                 var
//                     SalesLineL: Record "Sales Line";
//                     ShortCloseOrdQst: Label 'The Order %1 will be deleted and move to archive.\Do you want to continue?';
//                 begin
//                     rec.TestField(Status, rec.Status::Released);
//                     If not Confirm(StrSubstNo(ShortCloseOrdQst, rec."No.")) then
//                         exit;
//                     rec."Short Close" := true;
//                     rec.Modify();
//                     SalesLineL.SetRange("Document Type", rec."Document Type");
//                     SalesLineL.SetRange("Document No.", rec."No.");
//                     // SalesLineL.ModifyAll("Qty. Shipped Not Invoiced", 0);
//                     rec.Delete(true);
//                 end;
//             }
//         }
//     }
//     trigger OnAfterGetRecord()
//     var
//         WDI: Record "Warehouse Delivery Inst Header";
//         SalesShipmentLine: Record "Sales Shipment Line";
//         SalesShipmentHeader: Record "Sales Shipment Header";
//         ApprovalType: Enum "Approval Type";
//         KMapprovalCodeunit: Codeunit "Kemipex Approval Codeunit";

//     begin
//         WDI.Reset();
//         WDI.SetRange("Order No.", rec."No.");
//         if WDI.FindSet() then
//             WarehouseInstruction := WDI.Count();
//         SalesShipmentHeader.Reset();
//         SalesShipmentHeader.SetRange("Order No.", Rec."No.");
//         if SalesShipmentHeader.FindSet() then
//             SalesShipment := SalesShipmentHeader.Count;
//         CanSendReopenRequest := KMapprovalCodeunit.CanSendKMapproval(Rec.RecordId, ApprovalType::"Reopen Request");
//         CanCancelReopenrequest := KMapprovalCodeunit.CanCancelKMApproval(rec.RecordId, ApprovalType::"Reopen Request")
//     end;

//     trigger OnOpenPage()
//     var
//         UserSetup: Record "User Setup";
//     begin
//         if UserSetup.Get(UserId) then
//             AllowShortCloseG := UserSetup."Allow Short Close";
//     end;

//     var
//         [InDataSet]
//         AllowShortCloseG: Boolean;
//         WarehouseInstruction: Integer;
//         SalesShipment: Integer;
//         SalesInvoice: Integer;
//         CanCancelReopenrequest: Boolean;
//         CanSendReopenRequest: Boolean;
//         NoteVar: Text;
//         Notification: Codeunit "Notification Entry Dispatcher";

// }

