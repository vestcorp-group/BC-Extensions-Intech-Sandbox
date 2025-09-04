// pageextension 53404 "KFZE Teams" extends "Teams"//T12370-Full Comment
// {
//     procedure GetSelectionFilter(): Text
//     var
//         Team: Record "Team";
//         SelectionFilterManagement: Codeunit SelectionFilterManagement;
//         RecRef: RecordRef;
//     begin
//         CurrPage.SetSelectionFilter(Team);
//         RecRef.GetTable(Team);
//         exit(SelectionFilterManagement.GetSelectionFilter(RecRef, Team.FieldNo("Code")));
//     end;
// }