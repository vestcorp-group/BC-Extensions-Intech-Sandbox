pageextension 58004 Pre_invoice extends "Sales Invoice"//T12370-Full Comment
{
    layout
    {
        //         //27-07-2022-start
        addlast(General)
        {
            //             field("Release Of Shipping Document"; Rec."Release Of Shipping Document")
            //             {
            //                 ApplicationArea = All;
            //             }
            //             field("Courier Details"; Rec."Courier Details")
            //             {
            //                 ApplicationArea = All;
            //                 MultiLine = true;
            //             }
            //             field("Free Time Requested"; Rec."Free Time Requested")
            //             {
            //                 ApplicationArea = All;
            //                 MultiLine = true;
            //             }
            field("Customer Incentive Point (CIP)"; Rec."Customer Incentive Point (CIP)")//Hypercare 07-03-2025
            {
                ApplicationArea = All;
                Editable = false;
            }
        }
        addafter("Shipping and Billing")
        {
            group("Agent Representative")
            {
                Caption = 'Agent Representative';

                field("Agent Rep. Code"; Rec."Agent Rep. Code")
                {
                    ApplicationArea = All;
                    Caption = 'Agent Rep. Code';
                    ToolTip = 'Specifies a link to select Agent Representative.';
                }
                field("Agent Rep. Name"; Rec."Agent Rep. Name")
                {
                    ApplicationArea = All;
                }
                field("Agent Rep. Address"; Rec."Agent Rep. Address")
                {
                    ApplicationArea = All;
                }
                field("Agent Rep. Address 2"; Rec."Agent Rep. Address 2")
                {
                    ApplicationArea = All;
                }
                field("Agent Rep. City"; Rec."Agent Rep. City")
                {
                    ApplicationArea = All;
                }
                field("Agent Rep. Post Code"; Rec."Agent Rep. Post Code")
                {
                    ApplicationArea = All;
                }
                field("Agent Rep. Country/Region Code"; Rec."Agent Rep. Country/Region Code")
                {
                    ApplicationArea = All;
                }
            }
        }
        //         //27-07-2022-end
        //         modify("Transaction Specification")
        //         {
        //             Caption = 'Incoterm';
        //         }
        modify("Area")
        {
            Caption = 'Port of Discharge';
        }
        modify("Exit Point")
        {
            Caption = 'Port of Loading';
        }
        //         modify("Sell-to Customer No.")
        //         {
        //             Visible = true;
        //         }
        //         modify("External Document No.")
        //         {
        //             Caption = 'Customer Purchase Ref';
        //         }
        //         modify("Transaction Type")
        //         {
        //             Visible = true;
        //             Caption = 'Order Type';
        //         }
        //         addlast(General)
        //         {
        //             field("Salesperson Name"; Rec."Salesperson Name")
        //             {
        //                 ApplicationArea = All;
        //                 Editable = false;
        //             }
        //             field("Sub Status"; Rec."Sub Status")
        //             {
        //                 ApplicationArea = All;
        //                 Editable = false;
        //             }
        //         }
        //         moveafter(Status; "Transaction Type")
        //     }

        //     actions
        //     {
        //         // moveafter(DocAttach; "Delivery Advice")

        //         /*  addbefore("Delivery Advice")
        //           {
        //               action("Print Pre Sales Invoice")
        //               {
        //                   Image = PrintVoucher;
        //                   Promoted = true;
        //                   PromotedCategory = Process;
        //                   PromotedIsBig = true;
        //                   ApplicationArea = all;
        //                   trigger OnAction()
        //                   var
        //                       SalesInvRec: Record "Sales Header";
        //                   begin
        //                       SalesInvRec.Reset();
        //                       CurrPage.SetSelectionFilter(SalesInvRec);

        //                       if SalesInvRec.FindFirst then
        //                           Report.RunModal(Report::KMP_PreSalesInvReport_New2, true, true, SalesInvRec);
        //                   end;
        //               }

        //           }
        //           */
        //         modify("Print Pre Sales Inv.")
        //         {
        //             Enabled = false;
        //             Visible = false;
        //         }
        //         modify("Pre-Sale Invoice")
        //         {
        //             Enabled = false;
        //             Visible = false;
        //         }
        //         modify(Post)
        //         {
        //             trigger OnBeforeAction()
        //             var
        //                 myInt: Integer;
        //             begin
        //                 rec."Document Date" := rec."Posting Date";
        //                 rec.Validate("Payment Terms Code");
        //             end;
        //         }
        //         /*  modify("Delivery Advice")
        //           {
        //               trigger OnBeforeAction()
        //               var
        //                   myInt: Integer;
        //               begin

        //               end;
        //               // Enabled = false;
        //               //Visible = false;
        //           }
        //   */
    }

}