// pageextension 53403 "KFZEItem Budget Entries" extends "Item Budget Entries"//T12370-Full Comment
// {
//     layout
//     {
//         addafter("Source No.")
//         {

//             field("KFZESalesperson Code"; Rec."KFZESalesperson Code")
//             {
//                 ApplicationArea = All;
//                 ToolTip = 'Specifies the value of the Salesperson Code field.';
//             }
//             field("KFZESales Team"; Rec."KFZESales Team")
//             {
//                 ApplicationArea = All;
//                 ToolTip = 'Specifies the value of the Sales Team field.';
//             }
//         }
//         modify("Global Dimension 1 Code")
//         {
//             Visible = false;
//         }
//         modify("Global Dimension 2 Code")
//         {
//             Visible = false;
//         }
//         modify(Date)
//         {
//             Editable = IsEditable;
//         }
//         modify("Item No.")
//         {
//             Editable = IsEditable;
//         }
//         modify(Description)
//         {
//             Editable = IsEditable;
//         }
//         modify("Source No.")
//         {
//             Editable = IsEditable;
//         }
//         modify("Source Type")
//         {
//             Editable = IsEditable;
//         }
//         modify(Quantity)
//         {
//             Editable = IsEditable;
//         }
//         modify("Cost Amount")
//         {
//             Editable = IsEditable;
//         }
//         modify("Sales Amount")
//         {
//             Editable = IsEditable;
//         }
//     }

//     actions
//     {
//         // Add changes to page actions here
//     }
//     var
//         UserSetup: Record "User Setup";
//         SalesPersonFilter, SalesTeamFilter : Text;
//         IsEditable: Boolean;

//     trigger OnOpenPage()
//     var
//         myInt: Integer;
//     begin
//         CheckAndApplySalespersonTeamFilters();
//     end;

//     trigger OnAfterGetRecord()
//     begin
//         IsEditable := SetPageEditable();
//     end;

//     local procedure SetPageEditable(): Boolean
//     var
//         UserSetup: Record "User Setup";
//     begin
//         UserSetup.Get(UserId);
//         exit((UserSetup."KZFEEdit Allowed for Memb." and (UserSetup."Salespers./Purch. Code" <> '')) or
//                         (UserSetup."Salespers./Purch. Code" = Rec."KFZESalesperson Code"));
//     end;

//     local procedure CheckAndApplySalespersonTeamFilters()
//     begin
//         Rec.FilterGroup(2);
//         if Rec.GetFilter("KFZESalesperson Code") = '' then begin
//             SetSalesPersonFilters();
//             if SalesPersonFilter > '' then
//                 Rec.SetFilter("KFZESalesperson Code", SalesPersonFilter);
//         end;
//         if Rec.GetFilter("KFZESales Team") = '' then begin
//             SetSalesTeamFilters();
//             if SalesTeamFilter > '' then
//                 Rec.SetFilter("KFZESales Team", SalesTeamFilter);
//         end;
//         Rec.FilterGroup(0);
//     end;

//     local procedure SetSalesPersonFilters()
//     begin
//         UserSetup.Get(UserId);

//         if UserSetup."Salespers./Purch. Code" > '' then
//             GetSalesPersonFilters(UserSetup, SalesPersonFilter);
//     end;

//     local procedure SetSalesTeamFilters()
//     var
//         TeamSalesperson: Record "Team Salesperson";
//     begin
//         Clear(SalesTeamFilter);
//         UserSetup.Get(UserId);

//         if UserSetup."Salespers./Purch. Code" > '' then begin
//             TeamSalesperson.SetRange("Salesperson Code", UserSetup."Salespers./Purch. Code");
//             if TeamSalesperson.FindFirst() then
//                 SalesTeamFilter := TeamSalesperson."Team Code";
//         end;

//     end;

//     local procedure GetSalesPersonFilters(var UserSetup: Record "User Setup"; var _SalesPersonFilter: Text)
//     var
//         TeamSalesperson: Record "Team Salesperson";
//         TeamSalesperson2: Record "Team Salesperson";
//     begin
//         TeamSalesperson.SetRange("Manager Code", UserSetup."Salespers./Purch. Code");
//         if TeamSalesperson.FindSet() then
//             repeat
//                 TeamSalesperson2.Reset();
//                 TeamSalesperson2.SetRange("Team Code", TeamSalesperson."Team Code");
//                 if TeamSalesperson2.FindSet() then
//                     repeat
//                         if not _SalesPersonFilter.Contains(TeamSalesperson2."Salesperson Code") then
//                             _SalesPersonFilter += TeamSalesperson2."Salesperson Code" + '|';
//                     until TeamSalesperson2.Next() = 0;
//             until TeamSalesperson.Next() = 0
//         else
//             _SalesPersonFilter := UserSetup."Salespers./Purch. Code";
//         if _SalesPersonFilter > '' then
//             _SalesPersonFilter := _SalesPersonFilter.TrimEnd('|');
//     end;
// }