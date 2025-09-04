// page 50281 "Blanket Assembly Orders Cust." //T12370-Full Comment
// {
//     Caption = 'Blanket Assembly Order List';
//     CardPageID = "Blanket Assembly Order Cust.";
//     DataCaptionFields = "No.";
//     PageType = List;
//     SourceTable = "Assembly Header";
//     SourceTableView = WHERE("Document Type" = FILTER("Blanket Order"));
//     UsageCategory = Administration;
//     ApplicationArea = all;
//     Editable = false;
//     AdditionalSearchTerms = 'Blanket Assembly Order';

//     layout
//     {
//         area(content)
//         {
//             repeater(General)
//             {
//                 field("Document Type"; rec."Document Type")
//                 {
//                     ApplicationArea = Assembly;
//                     ToolTip = 'Specifies the type of assembly document the record represents in assemble-to-order scenarios.';
//                 }
//                 field("No."; rec."No.")
//                 {
//                     ApplicationArea = Assembly;
//                     ToolTip = 'Specifies the number of the involved entry or record, according to the specified number series.';
//                 }
//                 field(Description; rec.Description)
//                 {
//                     ApplicationArea = Assembly;
//                     ToolTip = 'Specifies the description of the assembly item.';
//                 }
//                 field("Due Date"; rec."Due Date")
//                 {
//                     ApplicationArea = Assembly;
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
//                 }
//                 field("Item No."; rec."Item No.")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     ToolTip = 'Specifies the number of the item that is being assembled with the assembly order.';
//                 }
//                 field(Quantity; rec.Quantity)
//                 {
//                     ApplicationArea = Assembly;
//                     ToolTip = 'Specifies how many units of the assembly item that you expect to assemble with the assembly order.';
//                 }
//                 field("Quantity Ordered"; rec."Quantity Ordered")
//                 {
//                     ApplicationArea = Assembly;
//                     Editable = false;
//                     Caption = 'Quantity Processed';
//                     ToolTip = 'Specifies how many units already converted to order.';
//                 }
//                 field("Unit Cost"; rec."Unit Cost")
//                 {
//                     ApplicationArea = Assembly;
//                     ToolTip = 'Specifies the cost of one unit of the item or resource on the line.';
//                 }
//                 field("Location Code"; rec."Location Code")
//                 {
//                     ApplicationArea = Location;
//                     ToolTip = 'Specifies the location to which you want to post output of the assembly item.';
//                 }
//                 field("Variant Code"; rec."Variant Code")
//                 {
//                     ApplicationArea = Planning;
//                     ToolTip = 'Specifies the variant of the item on the line.';
//                 }
//                 field("Bin Code"; rec."Bin Code")
//                 {
//                     ApplicationArea = Warehouse;
//                     ToolTip = 'Specifies the bin the assembly item is posted to as output and from where it is taken to storage or shipped if it is assembled to a sales order.';
//                 }
//                 field("Remaining Quantity"; rec."Remaining Quantity")
//                 {
//                     ApplicationArea = Assembly;
//                     ToolTip = 'Specifies how many units of the assembly item remain to be posted as assembled output.';
//                 }
//             }
//         }
//         area(factboxes)
//         {
//             systempart(RecordLinks; Links)
//             {
//                 ApplicationArea = RecordLinks;
//                 Caption = 'RecordLinks';
//                 Visible = false;
//             }
//             systempart(Notes; Notes)
//             {
//                 ApplicationArea = Notes;
//                 Visible = false;
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
//                 RunObject = Page "Assembly Comment Sheet";
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
//             }
//         }
//     }

//     trigger OnAfterGetRecord()
//     begin
//         IsUnitCostEditable := NOT rec.IsStandardCostItem;
//     end;

//     trigger OnOpenPage()
//     begin
//         IsUnitCostEditable := TRUE;
//     end;



//     var
//         IsUnitCostEditable: Boolean;
// }

