// page 50282 "Blanket Assembly Order Cust." //T12370-Full Comment
// {
//     Caption = 'Blanket Assembly Order';
//     PageType = Document;
//     SourceTable = "Assembly Header";
//     SourceTableView = SORTING("Document Type", "No.")
//                       ORDER(Ascending)
//                       WHERE("Document Type" = CONST("Blanket Order"));

//     layout
//     {
//         area(content)
//         {
//             group(General)
//             {
//                 Caption = 'General';
//                 field("No."; rec."No.")
//                 {
//                     ApplicationArea = Assembly;
//                     AssistEdit = true;
//                     Visible = DocNoVisible;
//                     ToolTip = 'Specifies the number of the involved entry or record, according to the specified number series.';

//                     trigger OnAssistEdit()
//                     begin
//                         IF rec.AssistEdit(xRec) THEN
//                             CurrPage.UPDATE;
//                     end;
//                 }
//                 field("Item No."; rec."Item No.")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Editable = IsAsmToOrderEditable;
//                     Importance = Promoted;
//                     TableRelation = Item."No." WHERE("Assembly BOM" = CONST(true));
//                     ToolTip = 'Specifies the number of the item that is being assembled with the assembly order.';
//                 }
//                 field(Description; rec.Description)
//                 {
//                     ApplicationArea = Assembly;
//                     ToolTip = 'Specifies the description of the assembly item.';
//                 }
//                 group(Details)
//                 {
//                     field(Quantity; rec.Quantity)
//                     {
//                         ApplicationArea = Assembly;
//                         Editable = IsAsmToOrderEditable;
//                         Importance = Promoted;
//                         ToolTip = 'Specifies how many units of the assembly item that you expect to assemble with the assembly order.';
//                     }
//                     field(Vessel; rec.Vessel)
//                     {
//                         ApplicationArea = All;
//                         Importance = Promoted;
//                         ToolTip = 'Specifies the vessel code and determines the quantity to order.';
//                     }
//                     field("Quantity to Order"; rec."Quantity to Order")
//                     {
//                         ApplicationArea = Assembly;
//                         ToolTip = 'Specifies how many units of the assembly item that you expect to convert into assembly order.';
//                     }
//                     field("Quantity Ordered"; rec."Quantity Ordered")
//                     {
//                         ApplicationArea = all;
//                         Editable = false;
//                         Caption = 'Quantity Processed';
//                         ToolTip = 'Specifies how many units already converted to order.';
//                     }
//                     field("Unit of Measure Code"; rec."Unit of Measure Code")
//                     {
//                         ApplicationArea = Assembly;
//                         Editable = IsAsmToOrderEditable;
//                         ToolTip = 'Specifies how each unit of the item or resource is measured, such as in pieces or hours. By default, the value in the Base Unit of Measure field on the item or resource card is inserted.';
//                     }
//                 }
//                 field("Posting Date"; rec."Posting Date")
//                 {
//                     ApplicationArea = Assembly;
//                     Importance = Promoted;
//                     ToolTip = 'Specifies the date on which the assembly order is posted.';
//                 }
//                 field("Due Date"; rec."Due Date")
//                 {
//                     ApplicationArea = Assembly;
//                     Editable = IsAsmToOrderEditable;
//                     Importance = Promoted;
//                     ToolTip = 'Specifies the date when the assembled item is due to be available for use.';
//                 }
//                 field("Starting Date"; rec."Starting Date")
//                 {
//                     ApplicationArea = Assembly;
//                     ToolTip = 'Specifies the date when the assembly order is expected to start.';
//                 }
//                 field("Ending Date"; rec."Ending Date")
//                 {
//                     ApplicationArea = Assembly;
//                     ToolTip = 'Specifies the date when the assembly order is expected to finish.';
//                 }
//                 field("Assemble to Order"; rec."Assemble to Order")
//                 {
//                     ApplicationArea = Assembly;
//                     ToolTip = 'Specifies if the assembly order is linked to a sales order, which indicates that the item is assembled to order.';

//                     trigger OnDrillDown()
//                     begin
//                         rec.ShowAsmToOrder;
//                     end;
//                 }
//                 field(Status; rec.Status)
//                 {
//                     ApplicationArea = Assembly;
//                     ToolTip = 'Specifies if the document is open, waiting to be approved, invoiced for prepayment, or released to the next stage of processing.';
//                 }
//             }
//             part(Lines; "Blanket Assembly Order Subform")
//             {
//                 ApplicationArea = Assembly;
//                 Caption = 'Lines';
//                 SubPageLink = "Document Type" = FIELD("Document Type"),
//                               "Document No." = FIELD("No.");
//             }
//             group(Posting)
//             {
//                 Caption = 'Posting';
//                 field("Variant Code"; rec."Variant Code")
//                 {
//                     ApplicationArea = Planning;
//                     Editable = IsAsmToOrderEditable;
//                     Importance = Promoted;
//                     ToolTip = 'Specifies the variant of the item on the line.';
//                 }
//                 field("Location Code"; rec."Location Code")
//                 {
//                     ApplicationArea = Location;
//                     Editable = IsAsmToOrderEditable;
//                     Importance = Promoted;
//                     ToolTip = 'Specifies the location to which you want to post output of the assembly item.';
//                 }
//                 field("Bin Code"; rec."Bin Code")
//                 {
//                     ApplicationArea = Warehouse;
//                     Editable = IsAsmToOrderEditable;
//                     ToolTip = 'Specifies the bin the assembly item is posted to as output and from where it is taken to storage or shipped if it is assembled to a sales order.';
//                 }
//                 field("Unit Cost"; rec."Unit Cost")
//                 {
//                     ApplicationArea = Assembly;
//                     Editable = IsUnitCostEditable;
//                     ToolTip = 'Specifies the cost of one unit of the item or resource on the line.';
//                 }
//                 field("Cost Amount"; rec."Cost Amount")
//                 {
//                     ApplicationArea = Assembly;
//                     Editable = IsUnitCostEditable;
//                     ToolTip = 'Specifies the total unit cost of the assembly order.';
//                 }
//                 field("Assigned User ID"; rec."Assigned User ID")
//                 {
//                     ApplicationArea = Assembly;
//                     ToolTip = 'Specifies the ID of the user who is responsible for the document.';
//                     Visible = false;
//                 }
//             }
//         }
//         area(factboxes)
//         {
//             part("Assembly Item - Details"; "Assembly Item - Details")
//             {
//                 ApplicationArea = Assembly;
//                 SubPageLink = "No." = FIELD("Item No.");
//             }
//             part("Component - Item Details"; "Component - Item Details")
//             {
//                 ApplicationArea = Assembly;
//                 Provider = Lines;
//                 SubPageLink = "No." = FIELD("No.");
//             }
//             part("Component - Resource Details"; "Component - Resource Details")
//             {
//                 ApplicationArea = Assembly;
//                 Provider = Lines;
//                 SubPageLink = "No." = FIELD("No.");
//             }
//             systempart(Links; Links)
//             {
//                 ApplicationArea = RecordLinks;
//             }
//             systempart(Notes; Notes)
//             {
//                 ApplicationArea = Notes;
//             }
//         }
//     }

//     actions
//     {
//         area(navigation)
//         {
//             action(Statistics)
//             {
//                 ApplicationArea = Assembly;
//                 Caption = 'Statistics';
//                 Image = Statistics;
//                 RunPageOnRec = true;
//                 ShortCutKey = 'F7';
//                 ToolTip = 'View statistical information, such as the value of posted entries, for the record.';

//                 trigger OnAction()
//                 begin
//                     rec.ShowStatistics;
//                 end;
//             }
//             action(Dimensions)
//             {
//                 AccessByPermission = TableData 348 = R;
//                 ApplicationArea = Dimensions;
//                 Caption = 'Dimensions';
//                 Enabled = rec."No." <> '';
//                 Image = Dimensions;
//                 ShortCutKey = 'Shift+Ctrl+D';
//                 ToolTip = 'View or edit dimensions, such as area, project, or department, that you can assign to sales and purchase documents to distribute costs and analyze transaction history.';

//                 trigger OnAction()
//                 begin
//                     rec.ShowDimensionsDuplicate;
//                 end;
//             }
//             action("Assembly BOM")
//             {
//                 ApplicationArea = Assembly;
//                 Caption = 'Assembly BOM';
//                 Image = AssemblyBOM;
//                 ToolTip = 'View or edit the bill of material that specifies which items and resources are required to assemble the assembly item.';

//                 trigger OnAction()
//                 begin
//                     rec.ShowAssemblyList;
//                 end;
//             }
//             action(Comments)
//             {
//                 ApplicationArea = Comments;
//                 Caption = 'Comments';
//                 Image = ViewComments;
//                 RunObject = Page 907;
//                 RunPageLink = "Document Type" = FIELD("Document Type"),
//                               "Document No." = FIELD("No."),
//                               "Document Line No." = CONST(0);
//                 ToolTip = 'View or add comments for the record.';
//             }
//         }
//         area(processing)
//         {
//             group("F&unctions")
//             {
//                 Caption = 'F&unctions';
//                 Image = "Action";
//                 action("Update Unit Cost")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Caption = 'Update Unit Cost';
//                     Enabled = IsUnitCostEditable;
//                     Image = UpdateUnitCost;
//                     ToolTip = 'Update the cost of the parent item per changes to the assembly BOM.';

//                     trigger OnAction()
//                     begin
//                         rec.UpdateUnitCost;
//                     end;
//                 }
//                 action("Refresh Lines")
//                 {
//                     ApplicationArea = Assembly;
//                     Caption = 'Refresh Lines';
//                     Image = RefreshLines;
//                     ToolTip = 'Update information on the lines according to changes that you made on the header.';

//                     trigger OnAction()
//                     begin
//                         rec.RefreshBOMDuplicate;
//                         CurrPage.UPDATE;
//                     end;
//                 }
//                 action("Show Availability")
//                 {
//                     ApplicationArea = Assembly;
//                     Caption = 'Show Availability';
//                     Image = ItemAvailbyLoc;
//                     ToolTip = 'View how many of the assembly order quantity can be assembled by the due date based on availability of the required components. This is shown in the Able to Assemble field. ';

//                     trigger OnAction()
//                     begin
//                         rec.ShowAvailabilityDuplicate;
//                     end;
//                 }
//                 action("Make Order")
//                 {
//                     ApplicationArea = All;
//                     Caption = 'Make Order';
//                     Image = MakeOrder;
//                     ToolTip = 'An action that converts the blanket assembly order into assembly order.';

//                     trigger OnAction()
//                     begin
//                         MakeOrder()
//                     end;

//                 }
//             }
//             group("Assembly")
//             {

//                 Image = "Action";
//                 action("Assembly Orders List")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Image = AssemblyOrder;

//                     trigger OnAction()
//                     var
//                         AssHedaerRec: Record "Assembly Header";
//                         AssOrders: Page "Assembly Orders";
//                     begin
//                         AssHedaerRec.Reset();
//                         AssHedaerRec.SetRange("Blanket Assembly Order No.", rec."No.");
//                         Page.RunModal(902, AssHedaerRec)

//                     end;
//                 }
//             }
//         }
//     }

//     trigger OnAfterGetRecord()
//     begin
//         IsUnitCostEditable := NOT rec.IsStandardCostItem;
//         IsAsmToOrderEditable := NOT rec.IsAsmToOrder;
//     end;

//     trigger OnOpenPage()
//     begin
//         IsUnitCostEditable := TRUE;
//         IsAsmToOrderEditable := TRUE;
//         DocNoVisible := SetDocNoVisible();

//         rec.UpdateWarningOnLines;
//     end;

//     local procedure MakeOrder()
//     var
//         CopyDocumentMgt: Codeunit "Copy Document Mgt.";
//         AssemblyHdr: Record "Assembly Header";
//         EventSubsciberUnit: Codeunit KMP_EventSubscriberUnit;
//         AssemblyOrderNo: Code[20];
//         ActualQuantity: Decimal;
//         OpenAssemblyOrderQst: Label 'The Assembly Order %1 is created. Do you want to open assembly order?';
//         QtytoOrderMoreErr: Label 'The %1 can''t be more than %2';
//         AssemblyLineL: Record "Assembly Line";
//     begin
//         rec.TestField("Quantity to Order");
//         //CalcFields("Quantity Ordered");PSP_02-01-2020
//         if rec.Quantity < (rec."Quantity Ordered" + rec."Quantity to Order") then
//             Error(QtytoOrderMoreErr, rec.FieldCaption("Quantity to Order"), (rec.Quantity - rec."Quantity Ordered"));
//         AssemblyHdr.Init();
//         AssemblyHdr."Document Type" := AssemblyHdr."Document Type"::Order;
//         AssemblyHdr.Vessel := rec.Vessel;
//         AssemblyHdr.Insert(true);
//         AssemblyOrderNo := AssemblyHdr."No.";
//         Commit();
//         ActualQuantity := Rec.Quantity;
//         Rec.Quantity := Rec."Quantity to Order";
//         CopyDocumentMgt.CopyAsmHeaderToAsmHeader(Rec, AssemblyHdr, true);
//         AssemblyHdr.Get(rec."Document Type"::Order, AssemblyOrderNo);
//         EventSubsciberUnit.AssemblyHeader_OnAfterQtyValidate(AssemblyHdr, rec.FieldNo(Quantity));
//         AssemblyHdr.Get(rec."Document Type"::Order, AssemblyOrderNo);
//         AssemblyHdr."Blanket Assembly Order No." := Rec."No.";
//         AssemblyHdr."Starting Date" := Rec."Starting Date";
//         AssemblyHdr."Ending Date" := Rec."Ending Date";
//         AssemblyHdr."Due Date" := rec."Due Date";
//         AssemblyHdr.Modify();
//         //PSP 07-05-20
//         AssemblyLineL.SetRange("Document Type", AssemblyHdr."Document Type");
//         AssemblyLineL.SetRange("Document No.", AssemblyHdr."No.");
//         if AssemblyLineL.FindSet() then
//             repeat
//                 AssemblyLineL."Blanket Assembly Order No." := AssemblyHdr."Blanket Assembly Order No.";
//                 AssemblyLineL."Blanket Ass. Order Line No." := AssemblyLineL."Line No.";
//                 AssemblyLineL.Modify();
//             until AssemblyLineL.Next() = 0;
//         //PSP 07-05-20
//         Rec.Quantity := ActualQuantity;
//         //Rec.calcfields("Quantity Ordered");PSP_02-01-2020
//         Rec."Quantity Ordered" := Rec."Quantity Ordered" + Rec."Quantity to Order"; //PSP_02-01-2020
//         // Rec.Vessel := ''; // hide by baya
//         Rec."Quantity to Order" := 0;
//         // Rec."Quantity to Order" := Rec.Quantity - Rec."Quantity Ordered";
//         Rec.Modify();
//         CurrPage.Update(false);
//         if Confirm(StrSubstNo(OpenAssemblyOrderQst, AssemblyOrderNo), false) then begin
//             AssemblyHdr.SetRange("Document Type", rec."Document Type"::Order);
//             AssemblyHdr.SetRange("No.", AssemblyOrderNo);
//             Page.Run(page::"Assembly Order", AssemblyHdr);
//         end;
//     end;

//     local procedure SetDocNoVisible(): Boolean
//     var
//         AsmSetupL: Record "Assembly Setup";
//         NoSeriesL: Record "No. Series";
//         NoSeriesRelationshipL: Record "No. Series Relationship";
//         NoSeriesMgtL: Codeunit NoSeriesManagement;
//     begin
//         if rec."No." <> '' then
//             Exit(false);
//         AsmSetupL.Get();
//         AsmSetupL.TestField("Blanket Assembly Order Nos.");
//         if not NoSeriesL.Get(AsmSetupL."Blanket Assembly Order Nos.") then
//             exit(false);
//         NoSeriesRelationshipL.SETRANGE(Code, NoSeriesL.Code);
//         IF NOT NoSeriesRelationshipL.ISEMPTY THEN
//             EXIT(TRUE);
//         IF NoSeriesL."Manual Nos." OR (NoSeriesL."Default Nos." = FALSE) THEN
//             EXIT(TRUE);
//         EXIT(NoSeriesMgtL.DoGetNextNo(NoSeriesL.Code, WorkDate(), FALSE, TRUE) = '');
//     end;

//     var
//         [InDataSet]
//         IsUnitCostEditable: Boolean;
//         [InDataSet]
//         IsAsmToOrderEditable: Boolean;
//         DocNoVisible: Boolean;
// }

