page 53011 "Sales Cr. Memo Header Web API"//T12370-Full Comment //T50051 Code Uncommented
{
    ApplicationArea = All;
    Caption = 'BI Sales Credit Memo Web API';
    DataCaptionFields = "No.", "Sell-to Customer Name";
    PageType = List;
    Permissions = TableData "Sales Cr.Memo Header" = r;
    PromotedActionCategories = 'New,Process,Report,Line,Entry,Navigate';
    SourceTable = "Sales Cr.Memo Header";
    SourceTableView = SORTING("No.")
                      ORDER(ascending);
    UsageCategory = History;
    SourceTableTemporary = true;
    DeleteAllowed = false;
    ModifyAllowed = false;
    InsertAllowed = false;
    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;


                field(No_; Rec."No.")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    //StyleExpr = StyleTxt;
                    ToolTip = 'Specifies the entry''s document number.';
                }
                field(Sell_to_Customer_No_; Rec."Sell-to Customer No.")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    ToolTip = 'Specifies the customer account number that the entry is linked to.';
                }
                field("Sell-to Customer Name"; Rec."Sell-to Customer Name")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    //ToolTip = 'Specifies the customer account number that the entry is linked to.';
                }
                field(Sell_to_Address; Rec."Sell-to Address")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field(Sell_to_Address_2; Rec."Sell-to Address 2")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field(Sell_to_City; Rec."Sell-to City")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field(Sell_to_Country_Region_Code; Rec."Sell-to Country/Region Code")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field(Sell_to_Post_Code; Rec."Sell-to Post Code")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }

                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    ToolTip = 'Specifies the posting date that the entry is linked to.';
                    //Visible = CustNameVisible;
                }

                field(Due_Date; Rec."Due Date")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field(Shipment_Date; Rec."Shipment Date")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field(Payment_Terms_Code; Rec."Payment Terms Code")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field(Payment_Method_Code; Rec."Payment Method Code")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field(Ship_to_Code; Rec."Ship-to Code")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field(Ship_to_Name; Rec."Ship-to Name")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field(Ship_to_Address; Rec."Ship-to Address")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field(Ship_to_Address_2; Rec."Ship-to Address 2")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field(Ship_to_City; Rec."Ship-to City")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field(Ship_to_Country_Region_Code; Rec."Ship-to Country/Region Code")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field(Ship_to_Post_Code; Rec."Ship-to Post Code")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field(Location_Code; Rec."Location Code")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field(Currency_Code; Rec."Currency Code")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Currency Factor"; Rec."Currency Factor")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field(Salesperson_Code; Rec."Salesperson Code")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }

                //field(Prices_Including_VAT; "Prices Including VAT") { }
                field(Gen__Bus__Posting_Group; Rec."Gen. Bus. Posting Group")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field(VAT_Bus__Posting_Group; Rec."VAT Bus. Posting Group")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field(Shipping_Agent_Code; Rec."Shipping Agent Code")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field(Amount_Including_VAT; Rec."Amount Including VAT")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field(ICPartner; ICPartner)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Hide_in_Reports_; Hide_in_Reports)
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Customer_Incentive_Point_CIP"; Rec."Customer Incentive Point (CIP)")
                {
                    ApplicationArea = all;
                    Editable = false;
                }

            }
        }

    }
    trigger OnOpenPage()
    begin
        InitTempTable();
    end;

    var
        GlSetup: Record "General Ledger Setup";

    local procedure InitTempTable()
    var
        OpenCLE: Record "Sales Cr.Memo Header";

    begin
        Rec.Reset();
        Rec.DeleteAll();
        Rec.SetCurrentKey("No.");
        GlSetup.get;
        OpenCLE.Reset();
        if OpenCLE.FindSet() then
            repeat
                Rec := OpenCLE;
                if Rec."Currency Code" = '' then
                    Rec."Currency Code" := GlSetup."LCY Code";
                Rec.Insert();
            until OpenCLE.Next() = 0;
        if Rec.FindFirst() then;
    end;

    trigger OnAfterGetRecord()
    var
        RecCustomer: Record Customer;
    begin
        // Note := Rec.GetAttentionNote();
        ICPartner := false;
        Hide_in_Reports := false;
        if Rec."Sell-to Customer No." <> '' then begin
            Clear(RecCustomer);
            RecCustomer.GET(Rec."Sell-to Customer No.");
            if (RecCustomer."IC Company Code" <> '') OR (RecCustomer."IC Partner Code" <> '') then
                ICPartner := true;

            if (RecCustomer."Hide in Reports") then
                Hide_in_Reports := true;
        end
    end;

    var
        ICPartner: Boolean;
        Hide_in_Reports: Boolean;
}
