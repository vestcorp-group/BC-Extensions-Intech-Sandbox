page 50280 KMP_ICSalesOrderList//T12370-Full Comment
{
    PageType = List;
    SourceTable = "Sales Header";
    SourceTableTemporary = true;
    Caption = 'IC Sales Orders';

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("No."; rec."No.")
                {
                    ApplicationArea = All;
                }
                field("Sell-to Customer No."; rec."Sell-to Customer No.")
                {
                    ApplicationArea = All;
                }
                field("Sell-to Customer Name"; rec."Sell-to Customer Name")
                {
                    ApplicationArea = All;
                }
                field("Posting Description"; rec."Posting Description")
                {
                    Caption = 'Company Name';
                    ApplicationArea = All;
                }
                field("Document Date"; rec."Document Date")
                {
                    ApplicationArea = All;
                }
                field(Status; rec.Status)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    procedure InitTempTable(ICPartnerCodeP: Code[20])
    var
        ICPartnersL: Record "IC Partner";
        SalesHeaderL: Record "Sales Header";
    begin
        ICPartnersL.Get(ICPartnerCodeP);
        ICPartnersL.TestField("Inbox Type", ICPartnersL."Inbox Type"::Database);
        SalesHeaderL.ChangeCompany(ICPartnersL."Inbox Details");
        SalesHeaderL.SetRange("Document Type", SalesHeaderL."Document Type"::Order);
        SalesHeaderL.SetFilter("Sell-to Customer No.", '<>%1', '');
        // SalesHeaderL.SetRange("Document Date", WorkDate());
        // SalesHeaderL.SetRange(Status, SalesHeaderL.Status::Open);
        if SalesHeaderL.FindSet() then
            repeat
                Rec := SalesHeaderL;
                Rec."Posting Description" := ICPartnersL."Inbox Details";
                Rec.Insert();
            until SalesHeaderL.Next() = 0;
    end;
}