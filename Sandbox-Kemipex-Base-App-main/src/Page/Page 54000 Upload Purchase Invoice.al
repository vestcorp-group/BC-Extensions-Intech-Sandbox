/// <summary> //T12370-Full Comment
/// Page Staging Purchase Invoice (ID 50100).
/// </summary>
page 54000 "Upload Purchase Invoice"    //T13413
{
    Caption = 'Upload Purchase Invoice';
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Staging Purchase Invoice";
    SourceTableView = sorting("Upload Batch No.", "Vendor Refrence", "Line No.") WHERE(Status = FILTER(<> Closed));
    InsertAllowed = false;
    DeleteAllowed = false;
    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Upload Batch No."; Rec."Upload Batch No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                    StyleExpr = LineColorChange;
                }
                field("Vendor Refrence"; Rec."Vendor Refrence")
                {
                    ApplicationArea = All;
                    Editable = false;
                    StyleExpr = LineColorChange;
                }
                field("Line No."; Rec."Line No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                    StyleExpr = LineColorChange;
                }
                field("Vendor No."; Rec."Vendor No.")
                {
                    ApplicationArea = All;
                    Editable = NonEdiTablestatus;
                    StyleExpr = LineColorChange;
                }
                field("Purch. Inv. No."; Rec."Purch. Inv. No.")
                {
                    ApplicationArea = all;
                    Editable = false;
                    StyleExpr = LineColorChange;
                }
                field("Posted Purch. Inv. No."; Rec."Posted Purch. Inv. No.")
                {
                    ApplicationArea = all;
                    Editable = false;
                    StyleExpr = LineColorChange;

                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                    Editable = NonEdiTablestatus;
                    StyleExpr = LineColorChange;
                }
                field("Document Date"; Rec."Document Date")
                {
                    ApplicationArea = All;
                    Editable = NonEdiTablestatus;
                    StyleExpr = LineColorChange;
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    ApplicationArea = All;
                    Editable = NonEdiTablestatus;
                    StyleExpr = LineColorChange;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = all;
                    Visible = false;
                    Editable = false;
                    StyleExpr = LineColorChange;
                }
                field("Header Description"; Rec."Header Description")
                {
                    Caption = 'Descriptions';
                    ApplicationArea = All;
                    Editable = NonEdiTablestatus;
                    StyleExpr = LineColorChange;
                }
                field(Description; Rec.Description)
                {
                    Caption = 'Descriptions 2';
                    ApplicationArea = All;
                    Editable = NonEdiTablestatus;
                    StyleExpr = LineColorChange;
                }
                field("Your Reference/PO Refernce"; Rec."Your Reference/PO Refernce")
                {
                    ApplicationArea = All;
                    Editable = false;
                    StyleExpr = LineColorChange;
                }
                field("Receipt No."; Rec."Receipt No.")
                {
                    ApplicationArea = All;
                    Visible = false;
                    Editable = false;
                    StyleExpr = LineColorChange;
                }
                field(Type; Rec.Type)
                {

                    ApplicationArea = all;
                    Editable = NonEdiTablestatus;
                    StyleExpr = LineColorChange;
                }
                field("Item No."; Rec."Item No.")
                {
                    ApplicationArea = All;
                    Caption = 'No.';
                    Editable = NonEdiTablestatus;
                    StyleExpr = LineColorChange;
                }

                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                    Editable = false;
                    StyleExpr = LineColorChange;
                }
                field("Direct Unit Cost"; Rec."Direct Unit Cost")
                {
                    ApplicationArea = All;
                    Editable = false;
                    StyleExpr = LineColorChange;
                }
                field("Charge Item Types"; Rec."Charge Item Types")
                {
                    ApplicationArea = All;
                    Editable = NonEdiTablestatus;
                    StyleExpr = LineColorChange;
                }
                field("Charge Item Doc1"; Rec."Charge Item Doc1")
                {
                    ApplicationArea = All;
                    Editable = NonEdiTablestatus;
                    StyleExpr = LineColorChange;
                }
                field("Charge Item Doc2"; Rec."Charge Item Doc2")
                {
                    ApplicationArea = All;
                    Editable = NonEdiTablestatus;
                    StyleExpr = LineColorChange;
                }
                field(Alloction; Rec.Alloction)
                {
                    ApplicationArea = All;
                    Editable = NonEdiTablestatus;
                    StyleExpr = LineColorChange;
                }
                field("Error Remarks"; Rec."Error Remarks")
                {
                    ApplicationArea = all;
                    Editable = NonEdiTablestatus;
                    StyleExpr = LineColorChange;
                }

                field(Status; Rec.Status)
                {
                    ApplicationArea = all;
                    Editable = NonEdiTablestatus;
                    StyleExpr = LineColorChange;
                    trigger OnValidate()
                    begin
                        CurrPage.Update();
                    end;
                }
                field("Uploaded By"; Rec."Uploaded By")
                {
                    ApplicationArea = All;
                    Editable = false;
                    StyleExpr = LineColorChange;
                }
                field("Uploaded Date/Time"; Rec."Uploaded Date/Time")
                {
                    ApplicationArea = all;
                    Editable = false;
                    StyleExpr = LineColorChange;
                }
                field("Modify By"; Rec."Modify By")
                {
                    ApplicationArea = all;
                    Editable = false;
                    StyleExpr = LineColorChange;
                }
                field("Modify On"; Rec."Modify On")
                {
                    ApplicationArea = all;
                    Editable = false;
                    StyleExpr = LineColorChange;

                }



            }


        }

        area(Factboxes)
        {

        }

    }


    actions
    {
        area(Processing)
        {
            action("Import From Excel")
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                //T13413-OS
                /* trigger OnAction()
                var
                    ProcessStagingActivities: Codeunit "Process Purch. Inv. Activities";
                begin
                    ProcessStagingActivities.ImportStagingPurchaseInvoice();
                    CurrPage.Update();
                end; */
                //T13413-OE
            }
            action("ProcessPurchaseInvoice")
            {
                Caption = 'Create Purch. Invoice Line';
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = CreateDocument;

                //T13413-OS
                /* trigger OnAction()
                var
                    ProcessStagingActivities: Codeunit "Process Purch. Inv. Activities";
                    StagingPurchInv: Record "Staging Purchase Invoice";
                    StagingPurchInv2: Record "Staging Purchase Invoice";
                    PurchaseInvHeader: Record "Purchase Header";
                    vendorInvNo: code[100];
                    VendorInv: Boolean;
                begin
                    if not Confirm('Do you want to create a purchase Invoice?', true) then
                        exit;
                    clear(StagingPurchInv);
                    vendorInvNo := '';
                    VendorInv := true;
                    CurrPage.SetSelectionFilter(StagingPurchInv2);
                    StagingPurchInv.Copy(StagingPurchInv2);
                    StagingPurchInv.SetCurrentKey("Vendor Refrence");
                    StagingPurchInv.SetFilter(Status, '%1', StagingPurchInv.Status::Open);
                    if StagingPurchInv.FindSet() then begin
                        repeat
                            if StagingPurchInv."Retry Count" > 0 then begin
                                if vendorInvNo <> StagingPurchInv."Vendor Refrence" then begin
                                    PurchaseInvHeader.Reset();
                                    PurchaseInvHeader.SetRange("Vendor Invoice No.", StagingPurchInv."Vendor Refrence");
                                    if PurchaseInvHeader.FindFirst() then begin
                                        if not Confirm('Vendor Invoice No. is alredy exits in purchase invoice No. %1, Do you want to create same Invoice No. ', true, PurchaseInvHeader."No.") then
                                            exit;
                                    end;
                                end;
                            end;
                            if not ProcessStagingActivities.Run(StagingPurchInv) then begin
                                StagingPurchInv.Status := StagingPurchInv.Status::Error;
                                StagingPurchInv."Retry Count" += 1;
                                StagingPurchInv."Error Remarks" := Copystr(GetLastErrorText, 1, 250);
                                StagingPurchInv.Modify(true)
                            end;
                            Commit();

                        until StagingPurchInv.Next() = 0;
                    end;
                    CurrPage.Update();
                end; */
                //T13413-OE

            }
            action("OpenPurchaseInvoice")
            {
                Caption = 'Purch. Invoice';
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = ReOpen;
                trigger OnAction()
                var
                    PurchaseInv: Record "Purchase Header";
                    StagingPurchInv: Record "Staging Purchase Invoice";
                begin
                    PurchaseInv.Reset();
                    PurchaseInv.SetRange("No.", rec."Purch. Inv. No.");
                    if PurchaseInv.FindSet() then
                        Page.Run(51, PurchaseInv);
                end;

            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        NonEdiTablestatus := false;
        if (rec.Status = rec.Status::Error) or (rec.Status = rec.Status::Deleted) then
            NonEdiTablestatus := true;
        LineColorChange := '';
        if rec.Status = rec.Status::Error then
            LineColorChange := 'Unfavorable'

    end;


    var

        NonEdiTablestatus: Boolean;
        ModifiedBy: Text;
        LineColorChange: Text;



}