// page 53046 APICountries//T12370-Full Comment
// {
//     ApplicationArea = All;
//     Caption = 'LP - API Countries';
//     PageType = API;
//     SourceTable = "Country/Region";
//     Permissions = tabledata "Country/Region" = R;
//     DataCaptionFields = Code;
//     UsageCategory = History;
//     DeleteAllowed = false;
//     ModifyAllowed = false;
//     InsertAllowed = false;

//     // Powerautomate Category
//     EntityName = 'Country';
//     EntitySetName = 'Countries';
//     EntityCaption = 'Country';
//     EntitySetCaption = 'Countries';
//     // ODataKeyFields = SystemId;
//     Extensible = false;

//     APIPublisher = 'Kemipex';
//     APIGroup = 'LabelPrinting';
//     APIVersion = 'v2.0';


//     layout
//     {
//         area(content)
//         {
//             repeater(General)
//             {
//                 field(Code; rec.Code)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(Name; rec.Name)
//                 {
//                     ApplicationArea = all;
//                 }
//             }
//         }
//     }
// }
