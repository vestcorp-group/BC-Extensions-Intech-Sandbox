tableextension 58008 PostedSalesInvLines extends "Sales Invoice Line"//T12370-Full Comment T12946-Code Uncommented
{
    fields
    {
        //T12946-NS
        field(58035; "Item Incentive Point (IIP)"; Option)
        {
            OptionMembers = ,"1","2","3","4","5";
        }
        //T12946-NE

//         field(53001; "Container Size"; Text[200])
//         {
//             Caption = 'Container Size';
//             DataClassification = ToBeClassified;
//         }
//         field(53002; "Shipping Remarks"; Text[150])
//         {
//             Caption = 'Shipping Remarks';
//             DataClassification = ToBeClassified;
//         }
//         field(53003; "In-Out Instruction"; Text[200])
//         {
//             Caption = 'Material Inbound/Outbound Instruction';
//             DataClassification = ToBeClassified;
//         }
//         field(53004; "Shipping Line"; Text[150])
//         {
//             Caption = 'Shipping Line';
//             DataClassification = ToBeClassified;
//         }
//         field(53005; "BL-AWB No."; Text[150])
//         {
//             Caption = 'BL/AWB Number';
//             DataClassification = ToBeClassified;
//         }
//         field(53006; "Vessel-Voyage No."; Text[150])
//         {
//             Caption = 'Vessel/Voyage Number';
//             DataClassification = ToBeClassified;
//         }
//         field(53007; "Freight Forwarder"; Text[150])
//         {
//             Caption = 'Freight Forwarder';
//             DataClassification = ToBeClassified;
//         }
//         field(53008; "Freight Charge"; Text[150])
//         {
//             Caption = 'Freight Charge';
//             DataClassification = ToBeClassified;
//         }
    }
}
