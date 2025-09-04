table 50146 KMP_TblReports//T12370-N
{
    DataClassification = ToBeClassified;
    Caption = 'TABLE KMP Reports';
    Permissions = tabledata KMP_TblReports = RIMD;

    fields
    {

        field(10; Name; Text[25])
        {
            DataClassification = ToBeClassified;

        }

        field(20; Description; Text[50])
        {
            DataClassification = ToBeClassified;
        }

        field(30; SortOrder; Integer)
        {
            DataClassification = ToBeClassified;
        }

    }

    keys
    {
        key(PK; Name, SortOrder)
        {
            Clustered = true;
        }

    }

    var
        myInt: Integer;

    trigger OnInsert()
    begin

    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

    procedure CreateReportsList()
    var
        ProductTrackingRec: Record KMP_TblReports;
    begin
        //CreateNewRecord('Item Summary Report', 'Item Summary Report', 1);
        //CreateNewRecord('Inventory Summary Report', 'Inventory Summary Report', 1);
        CreateNewRecord('Product Tracking Report', 'Product Tracking Report', 2);
        //CreateNewRecord('Warehouse Inventory', 'Warehouse Inventory Report', 3);
        // CreateNewRecord('Sales Analysis', 'Sales Analysis Report', 4);
        // CreateNewRecord('BPO Summary', 'BPO Summary Report', 5);
        CreateNewRecord('PO Summary', 'PO Summary Report', 6);
        // CreateNewRecord('Purchase Receipt Report', 'Purchase Receipt Report', 7);
        //CreateNewRecord('Inventory Valuation Rpt', 'Inventory Valuation Report', 8);
        CreateNewRecord('Stock Reservation', 'Stock Reservation Report', 9);
        CreateNewRecord('Customer Outstanding', 'Customer Outstanding Report', 10);
    end;

    local procedure CreateNewRecord(NameP: text; DescP: Text; SortingP: Integer)
    var
        myInt: Integer;
    begin
        if Get(NameP, SortingP) then
            exit;
        Init();
        Name := NameP;
        Description := DescP;
        SortOrder := SortingP;
        Insert();
    end;
}
