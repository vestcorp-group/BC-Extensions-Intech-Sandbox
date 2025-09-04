// report 70102 UpdateRegion//T12370-Full Comment
// {
//     UsageCategory = Administration;
//     ApplicationArea = All;
//     Caption = 'Update Customer Region';
//     ProcessingOnly = true;
//     Permissions = tabledata customer = rm;


//     dataset
//     {
//         dataitem(Customer; Customer)
//         {
//             trigger OnAfterGetRecord()
//             var
//                 CountryRegion: Record "Country/Region";
//             begin
//                 if CountryRegion.get(Customer."Country/Region Code") then
//                     Customer."Global Dimension 2 Code" := CountryRegion."Region Dimension";
//                 if Customer.Modify() then;

//             end;
//         }
//     }






//     var
//         myInt: Integer;
// }