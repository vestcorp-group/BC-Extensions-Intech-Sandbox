pageextension 80111 CompanyInfoPage_Ext extends "Company Information"//T12370-Full Comment
{
    layout
    {
//         modify(Name)
//         {

//             trigger OnAfterValidate()
//             begin
//             end;
//         }

        addlast(General)
        {
            field("Insurance Policy Number"; Rec."Insurance Policy Number")
            {
                ApplicationArea = all;
            }
//             field("Registered in"; Rec."Registered in")
//             {
//                 ApplicationArea = all;
//             }
//             field("License No."; Rec."License No.")
//             {
//                 ApplicationArea = all;
//             }
//             field("Enable GST caption"; Rec."Enable GST caption")
//             {
//                 ApplicationArea = All;
//             }
        }
    }

//     actions
//     {
//         // Add changes to page actions here
//     }

//     var

}