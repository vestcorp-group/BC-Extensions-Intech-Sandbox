TableExtension 74995 Location_74995 extends Location
{
    fields
    {
        //ReturnTO-NS
        field(74981; "Returnable"; Boolean)
        {
            Caption = 'Returnable';
            DataClassification = ToBeClassified;
        }
        //ReturnTO-NE

        //InvShipRec-NS
        field(98756; "Bkp_ShipmentRequire"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(98757; "Bkp_ReceiptRequire"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        //InvShipRec-NE
    }

}

