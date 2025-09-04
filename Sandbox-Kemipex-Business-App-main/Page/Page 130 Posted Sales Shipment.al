// pageextension 53002 WarehouseShipExt extends "Warehouse Shipment"
// {
//     actions
//     {
//         addafter("&Print")
//         {

//             action("Packing List")
//             {
//                 ApplicationArea = All;
//                 Description = 'LD-10-01-25';
//                 Promoted = true;
//                 PromotedCategory = Category4;
//                 PromotedIsBig = true;
//                 Image = ListPage;
//                 Caption = 'Packing List';
//                 trigger OnAction()
//                 var
//                     WareHouseShipmentHeader_lRec: Record "Warehouse Shipment Header";
//                 begin
//                     WareHouseShipmentHeader_lRec.Reset();
//                     WareHouseShipmentHeader_lRec.SetRange("No.", Rec."No.");
//                     if WareHouseShipmentHeader_lRec.FindFirst() then
//                         REPORT.RUNMODAL(Report::"3_Kemipex Packing List", TRUE, FALSE, WareHouseShipmentHeader_lRec);
//                 end;
//             }

//         }
//     }
// }
pageextension 53002 PostedSalesShipment_Exnt extends "Posted Sales Shipment"
{
    actions
    {
        modify(PrintCertificateofSupply)
        {
            Visible = false;
        }
        modify("&Print")
        {
            Visible = false;
        }

        addafter("&Print")
        {
            action(Packing_List)
            {
                Caption = 'Packing List';
                Image = Print;
                ApplicationArea = all;
                Promoted = true;
                PromotedCategory = Report;
                PromotedIsBig = true;
                trigger OnAction()
                var
                    SalesShipmentHeader_lRec: Record "Sales Shipment Header";
                begin
                    SalesShipmentHeader_lRec.Reset();
                    SalesShipmentHeader_lRec.SetRange("No.", Rec."No.");
                    if SalesShipmentHeader_lRec.FindFirst() then
                        REPORT.RUNMODAL(Report::"Packing List_New", TRUE, FALSE, SalesShipmentHeader_lRec);
                end;
            }
        }


    }
}


