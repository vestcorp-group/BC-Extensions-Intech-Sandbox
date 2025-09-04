pageextension 58024 SalesCrMemo50222 extends "Sales Credit Memo"//T12370-Full Comment
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

        addafter("Foreign Trade")
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
        modify("Area")
        {
            Caption = 'Port of Discharge';
        }
        modify("Exit Point")
        {
            Caption = 'Port of Loading';
        }
        //         modify("Transaction Specification")
        //         {
        //             Caption = 'Incoterm';
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
        //         }
        //         moveafter(Status; "Transaction Type")
        //     }
        //     actions
        //     {
        //         modify(Post)
        //         {
        //             trigger OnBeforeAction()
        //             var

        //             begin
        //                 rec.TestField("Salesperson Code");
        //             end;
        //         }

        //         modify(PostAndSend)
        //         {
        //             trigger OnBeforeAction()
        //             var

        //             begin
        //                 rec.TestField("Salesperson Code");
        //             end;
        //         }
    }
}
