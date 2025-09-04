// query 53038 TeamsWebAPI//T12370-Full Comment
// {
//     QueryType = Normal;

//     Caption = 'BI Teams';

//     elements
//     {
//         dataitem(Team_Salesperson; "Team Salesperson")
//         {
//             column(Team_Code; "Team Code") { }
//             column(Salesperson_Code; "Salesperson Code") { }
//             column(Team_Name; "Team Name") { }
//             column(Salesperson_Name; "Salesperson Name") { }
//             column(Team_Manager; Manager) { }
//             column(E_Email; "E-Email") { }
//             column(Manager_Code; "Manager Code")
//             {

//             }
//             //23-10-2022-start
//             column(Power_BI_Block; "Power BI Block")
//             {

//             }
//             //23-10-2022-end
//             //column(Date_Filter; "Date Filter") { }
//             //column(Contact_Filter; "Contact Filter") { }
//             //column(Contact_Company_Filter; "Contact Company Filter") { }
//             //column(Task_Status_Filter; "Task Status Filter") { }
//             //column(Task_Closed_Filter; "Task Closed Filter") { }
//             //column(Priority_Filter; "Priority Filter") { }
//             //column(Salesperson_Filter; "Salesperson Filter") { }
//             //column(Campaign_Filter; "Campaign Filter") { }
//             //column(Task_Entry_Exists; "Task Entry Exists") { }
//         }
//     }

//     var
//         myInt: Integer;

//     trigger OnBeforeOpen()
//     begin

//     end;
// }