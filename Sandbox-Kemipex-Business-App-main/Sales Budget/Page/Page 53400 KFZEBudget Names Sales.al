// page 53400 "KFZEBudget Names Sales"//T12370-Full Comment
// {
//     ApplicationArea = All;
//     Caption = 'Sales Budgets - Custom';
//     PageType = List;
//     SourceTable = "Item Budget Name";
//     SourceTableView = WHERE("Analysis Area" = CONST(Sales));
//     UsageCategory = Lists;

//     layout
//     {
//         area(content)
//         {
//             repeater(Control1)
//             {
//                 ShowCaption = false;
//                 field(Name; Rec.Name)
//                 {
//                     ApplicationArea = SalesBudget;
//                     ToolTip = 'Specifies the name of the item budget.';
//                 }
//                 field(Description; Rec.Description)
//                 {
//                     ApplicationArea = SalesBudget;
//                     ToolTip = 'Specifies a description of the item budget.';
//                 }
//                 field(Blocked; Rec.Blocked)
//                 {
//                     ApplicationArea = SalesBudget;
//                     ToolTip = 'Specifies that the related record is blocked from being posted in transactions, for example a customer that is declared insolvent or an item that is placed in quarantine.';
//                 }
//                 field(KFZEParameter; Rec.KFZEParameter)
//                 {
//                     ToolTip = 'Specifies the value of the Parameter field.';
//                 }
//                 field("KFZE Year"; Rec."KFZE Year")
//                 {
//                     ToolTip = 'Specifies the value of the Year field.';
//                 }
//                 field("KFZESales Person Code"; Rec."KFZESales Person Code")
//                 {
//                     ToolTip = 'Specifies the value of the Sales Person Code field.';
//                     Editable = false;
//                     Visible = false;
//                 }
//                 field("Budget Dimension 1 Code"; Rec."Budget Dimension 1 Code")
//                 {
//                     ApplicationArea = Dimensions;
//                     ToolTip = 'Specifies a dimension code for Item Budget Dimension 1.';
//                     Visible = false;
//                 }
//                 field("Budget Dimension 2 Code"; Rec."Budget Dimension 2 Code")
//                 {
//                     ApplicationArea = Dimensions;
//                     ToolTip = 'Specifies a dimension code for Item Budget Dimension 2.';
//                     Visible = false;
//                 }
//                 field("Budget Dimension 3 Code"; Rec."Budget Dimension 3 Code")
//                 {
//                     ApplicationArea = Dimensions;
//                     ToolTip = 'Specifies a dimension code for Item Budget Dimension 3.';
//                     Visible = false;
//                 }
//             }
//         }
//         area(factboxes)
//         {
//             systempart(Control1900383207; Links)
//             {
//                 ApplicationArea = RecordLinks;
//                 Visible = false;
//             }
//             systempart(Control1905767507; Notes)
//             {
//                 ApplicationArea = Notes;
//                 Visible = false;
//             }
//         }
//     }

//     actions
//     {
//         area(processing)
//         {
//             action(EditBudget)
//             {
//                 ApplicationArea = SalesBudget;
//                 Caption = 'Edit Budget';
//                 Image = EditLines;
//                 ShortCutKey = 'Return';
//                 ToolTip = 'Specify budgets that you can create in the general ledger application area. If you need several different budgets, you can create several budget names.';

//                 trigger OnAction()
//                 var
//                     SalesBudgetOverview: Page "KFZESales Budget Overview";
//                 begin
//                     SalesBudgetOverview.SetNewBudgetName(Rec);
//                     SalesBudgetOverview.Run();
//                 end;
//             }
//         }
//         area(Promoted)
//         {
//             group(Category_Process)
//             {
//                 Caption = 'Process';

//                 actionref(EditBudget_Promoted; EditBudget)
//                 {
//                 }
//             }
//         }
//     }
// }

