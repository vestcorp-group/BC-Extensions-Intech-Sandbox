// pageextension 58251 PostedPurchcredpageext extends "Posted Purchase Credit Memo"//T12370-Full Comment
// {
//     trigger OnDeleteRecord(): Boolean
//     begin
//         Error('Not allowed to delete the record!');
//     end;
// }