tableextension 50301 KMP_TblExtReturnShipmentHdr extends "Return Shipment Header"
{
    fields
    {
        field(50100; CustomBOENumber; Text[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Custom BOE No.';
        }
        // field(50011; "Seller/Buyer 2"; Boolean)
        // {
        //     DataClassification = ToBeClassified;
        // }

        // //     Moved from Packing list Extension 
        // field(50012; "Bank on Invoice 2"; Code[20])
        // {
        //     DataClassification = ToBeClassified;
        //     TableRelation = "Bank Account";
        // }
        // field(50013; "Inspection Required 2"; Boolean)
        // {
        //     DataClassification = ToBeClassified;
        // }
        // field(50014; "Legalization Required 2"; Boolean)
        // {
        //     DataClassification = ToBeClassified;
        // }
        field(50015; "LC No. 2"; text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50016; "LC Date 2"; Date)
        {
            DataClassification = ToBeClassified;
        }
    }
}