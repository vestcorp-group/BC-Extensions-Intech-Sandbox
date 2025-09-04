pageextension 70016 "Posted Return Receipt Ext." extends "Posted Return Receipt"//T12370-Full Comment
{
    layout
    {
        // Add changes to page layout here
        addafter("Posting Date")
        {
//             field("Posting Date Time"; Rec."Posting Date Time")
//             {
//                 ApplicationArea = All;
//                 Caption = 'Posting Date Time';
//                 Editable = false;
//             }
//             field("Shipment Term"; Rec."Shipment Term")
//             {
//                 ApplicationArea = All;
//                 Editable = false;

//             }
            field("Insurance Policy No."; Rec."Insurance Policy No.")
            {
                ApplicationArea = All;
                Editable = false;
            }
//             field("Customer Port of Discharge"; Rec."Customer Port of Discharge")
//             {
//                 ApplicationArea = All;
//                 Editable = false;
//             }
        }
    }

//     actions
//     {
//         // Add changes to page actions here
//     }

//     var
//         myInt: Integer;
}