tableextension 53005 "Sales Setup Ext" extends "Sales & Receivables Setup"//T12370-Full Comment T12574-N
{
    fields
    {
        // // Add changes to table fields here
        field(53001; "Sales Support Email"; Text[250])
        {
            Caption = 'Sales Support Email';
            DataClassification = CustomerContent;

        }
        // field(60050; "Validate Shipped Qty. DropShip"; Boolean)
        // {
        //     Caption = 'Validate Shipped Qty. Drop Shipment';
        //     DataClassification = ToBeClassified;
        // }


        // //+
        // field(53010; "Notification Entry Nos."; code[20])
        // {
        //     DataClassification = ToBeClassified;
        //     TableRelation = "No. Series";
        // }

        field(53011; "Credit Limit 1st From Range"; Decimal)
        {
            DataClassification = ToBeClassified;
            MaxValue = 100;
            DecimalPlaces = 0 : 2;
            Description = 'T12574';
        }
        field(53012; "Credit Limit 1st To Range"; Decimal)
        {
            DataClassification = ToBeClassified;
            MaxValue = 100;
            DecimalPlaces = 0 : 2;
            Description = 'T12574';
        }

        field(53013; "Credit Limit 2nd From Range"; Decimal)
        {
            DataClassification = ToBeClassified;
            MaxValue = 100;
            DecimalPlaces = 0 : 2;
            Description = 'T12574';
        }
        field(53014; "Credit Limit 2nd To Range"; Decimal)
        {
            DataClassification = ToBeClassified;
            MaxValue = 100;
            DecimalPlaces = 0 : 2;
            Description = 'T12574';
        }

        field(53015; "Credit Limit 3rd From Range"; Decimal)
        {
            DataClassification = ToBeClassified;
            MaxValue = 100;
            DecimalPlaces = 0 : 2;
            Description = 'T12574';
        }
        field(53016; "Credit Limit 3rd To Range"; Decimal)
        {
            DataClassification = ToBeClassified;
            MaxValue = 100;
            DecimalPlaces = 0 : 2;
            Description = 'T12574';
        }

        field(53017; "Price Change % 1st From Range"; Decimal)
        {
            DataClassification = ToBeClassified;
            MaxValue = 100;
            DecimalPlaces = 0 : 2;
            Description = 'T12574';
        }
        field(53018; "Price Change % 1st To Range"; Decimal)
        {
            DataClassification = ToBeClassified;
            MaxValue = 100;
            DecimalPlaces = 0 : 2;
            Description = 'T12574';
        }
        field(53019; "Price Change % 2nd From Range"; Decimal)
        {
            DataClassification = ToBeClassified;
            MaxValue = 100;
            DecimalPlaces = 0 : 2;
            Description = 'T12574';
        }
        field(53020; "Price Change % 2nd To Range"; Decimal)
        {
            DataClassification = ToBeClassified;
            MaxValue = 100;
            DecimalPlaces = 0 : 2;
            Description = 'T12574';
        }
        field(53021; "Price Change % 3rd From Range"; Decimal)
        {
            DataClassification = ToBeClassified;
            MaxValue = 100;
            DecimalPlaces = 0 : 2;
            Description = 'T12574';
        }
        field(53022; "Price Change % 3rd To Range"; Decimal)
        {
            DataClassification = ToBeClassified;
            MaxValue = 100;
            DecimalPlaces = 0 : 2;
            Description = 'T12574';
        }

        //-

        //22-10-2022-start
        field(53023; "Block Non IC Vendor in PO"; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Block Non-IC Vendor Creation on PO';
            Description = 'T12574';
        }
        // //22-10-2022-end

        // field(53221; "Rel. Mand. for posting orders"; Boolean)
        // {
        //     DataClassification = SystemMetadata;
        //     Caption = 'Release Mandatory for posting All Sales Orders';
        // }

    }

    var
        myInt: Integer;
}