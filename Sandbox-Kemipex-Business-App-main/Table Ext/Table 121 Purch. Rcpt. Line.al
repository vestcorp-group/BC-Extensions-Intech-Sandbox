tableextension 58074 PurchRecLine extends "Purch. Rcpt. Line"//T12370-N
{
    fields
    {
        field(58004; Item_COO; Code[20])
        {
            Caption = 'Item Country Of Origin';
            TableRelation = "Country/Region";
            Editable = false;
        }
        field(58005; Item_Manufacturer_Code; Code[20])
        {
            Caption = 'Item Manufacturer Code';
            // TableRelation = KMP_TblManufacturerName;T12855-O
            TableRelation = Manufacturer;//T12855-N
            Editable = false;
        }
        field(58006; Item_Manufacturer_Description; Text[100])
        {
            Caption = 'Item Manufacturer';
            Editable = false;
        }
        field(58007; Item_short_name; Text[100])
        {
            Caption = 'Item Short Name';
            Editable = false;
        }
        field(58009; "Base UOM"; Code[20])
        {
            Editable = false;
        }
        field(58010; "Unit Price Base UOM"; Decimal)
        {
            Editable = false;
        }
        field(58029; "Item HS Code"; Code[20])
        {
            TableRelation = "Tariff Number";
            DataClassification = ToBeClassified;
        }
        //08-08-2022-start
        field(58035; "Item Incentive Point (IIP)"; Option)
        {
            OptionMembers = ,"1","2","3","4","5";
        }
        //08-08-2022-end
        field(53001; "Container Size"; Text[200])
        {
            Caption = 'Container Size';
            DataClassification = ToBeClassified;
        }
        field(53002; "Shipping Remarks"; Text[150])
        {
            Caption = 'Shipping Remarks';
            DataClassification = ToBeClassified;
        }
        field(53003; "In-Out Instruction"; Text[200])
        {
            Caption = 'Material Inbound/Outbound Instruction';
            DataClassification = ToBeClassified;
        }
        field(53004; "Shipping Line"; Text[150])
        {
            Caption = 'Shipping Line';
            DataClassification = ToBeClassified;
        }
        field(53005; "BL-AWB No."; Text[150])
        {
            Caption = 'BL/AWB Number';
            DataClassification = ToBeClassified;
        }
        field(53006; "Vessel-Voyage No."; Text[150])
        {
            Caption = 'Vessel/Voyage Number';
            DataClassification = ToBeClassified;
        }
        field(53007; "Freight Forwarder"; Text[150])
        {
            Caption = 'Freight Forwarder';
            DataClassification = ToBeClassified;
        }
        field(53008; "Freight Charge"; Text[150])
        {
            Caption = 'Freight Charge';
            DataClassification = ToBeClassified;
        }
    }
}