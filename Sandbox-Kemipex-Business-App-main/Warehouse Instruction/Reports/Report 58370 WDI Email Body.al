report 58370 "WDI Email Body"//T12370-Full Comment
{
    DefaultLayout = Word;
    WordLayout = 'Warehouse Instruction/Layouts/WDI Mail Body.docx';
    ApplicationArea = All;
    dataset
    {
        dataitem(WarehouseDeliveryInstHeader; "Warehouse Delivery Inst Header")
        {
            column(BilltoCustomerCode; "Bill-to Customer Code")
            {
            }
            column(BilltoCustomerName; "Bill-to Customer Name")
            {
            }
            column(BlanketOrderNo; "Blanket Order No.")
            {
            }
            column(CollectionDate; Format("Collection Date"))
            {
            }
            column(CustomerReference; "Blanket Order No.")
            {
            }
            column(LocationCode; "Location Code")
            {
            }
            column(LogisiticsInstructormail; LogisiticsInstructormail) { }
            column(LogisiticsInstructorMobileNo; LogisiticsInstructorMobileNo) { }
            column(LocationEmailAddress; "Location E-mail Address")
            {
            }
            column(LocationName; "Location Name")
            {
            }

            column(OrderNo; "Order No.")
            {
            }
            column(SalesShipmentNo; "Sales Shipment No.")
            {
            }
            column(ShiptoCustomerCode; "Ship-to Customer Code")
            {
            }
            column(WDIDate; "WDI Date")
            {
            }
            column(WDINo; "WDI No")
            {
            }
            column(Collection_Date; "Collection Date")
            { }
            column(Collection_Time; "Collection Time") { }
            column(UserId; user) { }
            column(LocationContact; LocationContact)
            { }
            column(Shipping_Agent_Name; "Shipping Agent Name") { }

            trigger OnAfterGetRecord()
            var
                myInt: Integer;
                location: Record Location;
                UserSetup: Record "User Setup";
            begin
                user := UserId;
                if location.Get("Location Code") then LocationContact := location.Contact;
                UserSetup.get(UserId);
                LogisiticsInstructormail := UserSetup."E-Mail";
                LogisiticsInstructorMobileNo := UserSetup."Phone No.";
            end;
        }

    }
    requestpage
    {
        layout
        {
            area(content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(processing)
            {
            }
        }
    }
    var
        User: Code[50];// User code change from 20 t0 50 //T13356
        LocationContact: Text;
        LogisiticsInstructormail: Text;
        LogisiticsInstructorMobileNo: Text;
        ItemChargeAssignment: page "Item Charge Assignment (Purch)";
}
