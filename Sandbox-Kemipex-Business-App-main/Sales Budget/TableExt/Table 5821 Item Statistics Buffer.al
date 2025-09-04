// tableextension 53401 "KFZEItem Statistics Buffer" extends "Item Statistics Buffer"//T12370-Full Comment
// {
//     fields
//     {
//         field(87000; "KFZESales Person Filter"; Code[20])
//         {
//             FieldClass = FlowFilter;
//             TableRelation = "Salesperson/Purchaser";
//         }
//         field(87001; "KFZESales Team Filter"; Code[20])
//         {
//             FieldClass = FlowFilter;
//             TableRelation = Team;
//         }
//         field(87002; KFZEQuantity; Decimal)
//         {
//             CalcFormula = Sum("Item Ledger Entry".Quantity WHERE("Item No." = FIELD("Item Filter"),
//                                                                   "Source Type" = FIELD("Source Type Filter"),
//                                                                   "Source No." = FIELD("Source No. Filter"),
//                                                                   "Posting Date" = FIELD("Date Filter"),
//                                                                   "Entry Type" = FIELD("Item Ledger Entry Type Filter"),
//                                                                   "Location Code" = FIELD("Location Filter"),
//                                                                   "Variant Code" = FIELD("Variant Filter"),
//                                                                   "Global Dimension 1 Code" = FIELD("Global Dimension 1 Filter"),
//                                                                   "Global Dimension 2 Code" = FIELD("Global Dimension 2 Filter")));
//             Caption = 'Quantity';
//             DecimalPlaces = 0 : 5;
//             Editable = false;
//             FieldClass = FlowField;
//         }
//         field(87005; "KFZEBudgeted Quantity"; Decimal)
//         {
//             CalcFormula = Sum("Item Budget Entry".Quantity WHERE("Analysis Area" = FIELD("Analysis Area Filter"),
//                                                                   "Budget Name" = FIELD("Budget Filter"),
//                                                                   "Item No." = FIELD("Item Filter"),
//                                                                   Date = FIELD("Date Filter"),
//                                                                   "Global Dimension 1 Code" = FIELD("Global Dimension 1 Filter"),
//                                                                   "Global Dimension 2 Code" = FIELD("Global Dimension 2 Filter"),
//                                                                   "Budget Dimension 1 Code" = FIELD("Dimension 1 Filter"),
//                                                                   "Budget Dimension 2 Code" = FIELD("Dimension 2 Filter"),
//                                                                   "Budget Dimension 3 Code" = FIELD("Dimension 3 Filter"),
//                                                                   "Source Type" = FIELD("Source Type Filter"),
//                                                                   "Source No." = FIELD("Source No. Filter"),
//                                                                   "Location Code" = FIELD("Location Filter"),
//                                                                   "KFZESalesperson Code" = field("KFZESales Person Filter"),
//                                                                   "KFZESales Team" = field("KFZESales Team Filter")));
//             Caption = 'Budgeted Quantity';
//             DecimalPlaces = 0 : 5;
//             Editable = false;
//             FieldClass = FlowField;
//         }
//         field(87006; "KFZEBudgeted Sales Amount"; Decimal)
//         {
//             AutoFormatType = 1;
//             CalcFormula = Sum("Item Budget Entry"."Sales Amount" WHERE("Analysis Area" = FIELD("Analysis Area Filter"),
//                                                                         "Budget Name" = FIELD("Budget Filter"),
//                                                                         "Item No." = FIELD("Item Filter"),
//                                                                         Date = FIELD("Date Filter"),
//                                                                         "Global Dimension 1 Code" = FIELD("Global Dimension 1 Filter"),
//                                                                         "Global Dimension 2 Code" = FIELD("Global Dimension 2 Filter"),
//                                                                         "Budget Dimension 1 Code" = FIELD("Dimension 1 Filter"),
//                                                                         "Budget Dimension 2 Code" = FIELD("Dimension 2 Filter"),
//                                                                         "Budget Dimension 3 Code" = FIELD("Dimension 3 Filter"),
//                                                                         "Source Type" = FIELD("Source Type Filter"),
//                                                                         "Source No." = FIELD("Source No. Filter"),
//                                                                         "Location Code" = FIELD("Location Filter"),
//                                                                         "KFZESalesperson Code" = field("KFZESales Person Filter"),
//                                                                         "KFZESales Team" = field("KFZESales Team Filter")));
//             Caption = 'Budgeted Sales Amount';
//             Editable = false;
//             FieldClass = FlowField;
//         }
//         field(87007; "KFZEBudgeted Cost Amount"; Decimal)
//         {
//             AutoFormatType = 1;
//             CalcFormula = Sum("Item Budget Entry"."Cost Amount" WHERE("Analysis Area" = FIELD("Analysis Area Filter"),
//                                                                        "Budget Name" = FIELD("Budget Filter"),
//                                                                        "Item No." = FIELD("Item Filter"),
//                                                                        Date = FIELD("Date Filter"),
//                                                                        "Global Dimension 1 Code" = FIELD("Global Dimension 1 Filter"),
//                                                                        "Global Dimension 2 Code" = FIELD("Global Dimension 2 Filter"),
//                                                                        "Budget Dimension 1 Code" = FIELD("Dimension 1 Filter"),
//                                                                        "Budget Dimension 2 Code" = FIELD("Dimension 2 Filter"),
//                                                                        "Budget Dimension 3 Code" = FIELD("Dimension 3 Filter"),
//                                                                        "Source Type" = FIELD("Source Type Filter"),
//                                                                        "Source No." = FIELD("Source No. Filter"),
//                                                                        "Location Code" = FIELD("Location Filter"),
//                                                                         "KFZESalesperson Code" = field("KFZESales Person Filter"),
//                                                                         "KFZESales Team" = field("KFZESales Team Filter")));
//             Caption = 'Budgeted Cost Amount';
//             Editable = false;
//             FieldClass = FlowField;
//         }
//     }

// }