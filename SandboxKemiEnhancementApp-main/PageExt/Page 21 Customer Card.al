pageextension 80002 CustomerCardPageExt extends "Customer Card"//T12370-Full Comment
{
    layout
    {
        //         addafter("Country/Region Code")
        //         {
        //             field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
        //             {
        //                 ApplicationArea = all;
        //                 Visible = false;
        //             }
        //         }
        //         addafter("Balance Due (LCY)")
        //         {
        //             field("Default Bank Account"; Rec."Default Bank Account")
        //             {
        //                 ApplicationArea = all;
        //             }
        //         }
        //         addlast(General)
        //         {
        //             // field("Customer Registration Code"; "Customer Registration Code")
        //             // {
        //             //     ApplicationArea = All;
        //             //     LookupPageId = 80017;

        //             // }
        //             field("Customer Registration Type"; Rec."Customer Registration Type")
        //             {
        //                 ApplicationArea = all;
        //                 //   LookupPageId = 80017;
        //             }
        //             field("Customer Registration No."; Rec."Customer Registration No.")
        //             {
        //                 ApplicationArea = all;
        //             }
        //         }
        //         addafter("Disable Search by Name")
        //         {
        //             field("seller Bank Detail"; Rec."seller Bank Detail")
        //             {
        //                 ApplicationArea = all;
        //             }
        //         }
        //         addafter("Credit Limit (LCY)")
        //         {
        //             field("Customer Port of Discharge"; Rec."Customer Port of Discharge")
        //             {
        //                 ApplicationArea = All;
        //             }
        //         }
        //         addbefore("VAT Registration No.")
        //         {
        //             field("Tax Type"; Rec."Tax Type")
        //             {
        //                 ApplicationArea = all;
        //                 Visible = true;
        //             }
        //         }
    }

    actions
    {
        addlast(Processing)
        {
            action("Insert Customer Alt. Address")
            {
                ApplicationArea = all;
                // RunObject = page "Customer Alternet Address";
                // RunPageLink = CustomerNo = field("No.");
                Image = ViewPage;
                Promoted = true;
                PromotedCategory = Process;
                trigger OnAction()
                var
                    customerAltAdd: record "Customer Alternet Address";
                    CustomerAltAddpage: Page "Customer Alternet Address";
                begin
                    customerAltAdd.SetRange(CustomerNo, Rec."No.");
                    if customerAltAdd.FindFirst() then begin
                        CustomerAltAddpage.SetTableView(customerAltAdd);
                        CustomerAltAddpage.RUNMODAL;
                    end
                    else
                        if not customerAltAdd.FindFirst() then begin
                            customerAltAdd.Init();
                            customerAltAdd.CustomerNo := Rec."No.";
                            customerAltAdd.Name := Rec.Name;
                            customerAltAdd.Insert(true);
                            Commit();
                            customerAltAdd.Reset();
                            customerAltAdd.SetRange(CustomerNo, Rec."No.");
                            if customerAltAdd.FindFirst() then begin
                                CustomerAltAddpage.SetTableView(customerAltAdd);
                                CustomerAltAddpage.RUNMODAL;
                            end;
                        end;
                end;
            }
        }
    }

    //     var
    //         myInt: Integer;
}