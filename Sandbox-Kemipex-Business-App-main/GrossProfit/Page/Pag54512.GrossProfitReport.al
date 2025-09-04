page 53007 "Gross Profit Report"//T12370-Full Comment T12946-Code Uncommented
{
    //ApplicationArea = All;
    Caption = 'Gross Profit Report';
    PageType = List;
    SourceTable = "Gross Profit Report";
    //UsageCategory = Lists;
    Editable = false;
    ApplicationArea = All;
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Entry No."; Rec."Entry No.")
                {
                    ToolTip = 'Specifies the value of the Entry No. field.';
                    ApplicationArea = All;
                }
                field("Group Co."; Rec."Group Co.")
                {
                    ToolTip = 'Specifies the value of the Group Co. field.';
                    ApplicationArea = All;
                }

                field("Document Type"; Rec."Document Type")
                {
                    ApplicationArea = All;
                }
                field("SO Date"; Rec."SO Date")
                {
                    ToolTip = 'Specifies the value of the SO Date field.';
                    ApplicationArea = All;
                }
                field("SO No."; Rec."SO No.")
                {
                    ToolTip = 'Specifies the value of the SO No. field.';
                    ApplicationArea = All;
                }


                field("SI Date"; Rec."SI Date")
                {
                    ToolTip = 'Specifies the value of the SI Date field.';
                    ApplicationArea = All;
                }
                field("SI No."; Rec."SI No.")
                {
                    ToolTip = 'Specifies the value of the SI No. field.';
                    ApplicationArea = All;
                }

                field("Customer Code"; Rec."Customer Code")
                {
                    ToolTip = 'Specifies the value of the Customer Code field.';
                    ApplicationArea = All;
                }
                field("Customer Short Name"; Rec."Customer Short Name")
                {
                    ToolTip = 'Specifies the value of the Customer Short Name field.';
                    ApplicationArea = All;
                }
                field("Customer Name"; Rec."Customer Name")
                {
                    ApplicationArea = All;
                }
                field(Incoterm; Rec.Incoterm)
                {
                    ToolTip = 'Specifies the value of the Incoterm field.';
                    ApplicationArea = All;
                }
                field(POL; Rec.POL)
                {
                    ToolTip = 'Specifies the value of the POL field.';
                    ApplicationArea = All;
                }
                field(POD; Rec.POD)
                {
                    ToolTip = 'Specifies the value of the POD field.';
                    ApplicationArea = All;
                }
                field(Teams; Rec.Teams)
                {
                    ToolTip = 'Specifies the value of the Teams field.';
                    ApplicationArea = All;
                }
                field("Salesperson Name"; Rec."Salesperson Name")
                {
                    ToolTip = 'Specifies the value of the Salesperson Name field.';
                    ApplicationArea = All;
                }
                field("Item Code"; Rec."Item Code")
                {
                    ToolTip = 'Specifies the value of the Item Code field.';
                    ApplicationArea = All;
                }
                field("Item Short Name"; Rec."Item Short Name")
                {
                    ToolTip = 'Specifies the value of the Item Short Name field.';
                    ApplicationArea = All;
                }
                field("Item Category"; Rec."Item Category")
                {
                    ToolTip = 'Specifies the value of the Item Category field.';
                    ApplicationArea = All;
                }
                field("Item Market Industry"; Rec."Item Market Industry")
                {
                    ToolTip = 'Specifies the value of the Item Market Industry field.';
                    ApplicationArea = All;
                }
                field("Custom LOT No."; Rec."Custom LOT No.")
                {
                    ApplicationArea = All;
                }
                field("Item Incentive Point"; Rec."Item Incentive Point (IIP)")
                {
                    ApplicationArea = all;
                }
                field("Customer Incentive Point (CIP)"; Rec."Customer Incentive Point (CIP)")
                {
                    ApplicationArea = all;
                }
                field("Base UOM"; Rec."Base UOM")
                {
                    ToolTip = 'Specifies the value of the Base UOM field.';
                    ApplicationArea = All;
                }
                field(QTY; Rec.QTY)
                {
                    ToolTip = 'Specifies the value of the QTY field.';
                    ApplicationArea = All;
                }
                field(CUR; Rec.CUR)
                {
                    ToolTip = 'Specifies the value of the CUR field.';
                    ApplicationArea = All;
                }
                field("Base UOM Price"; Rec."Base UOM Price")
                {
                    ToolTip = 'Specifies the value of the Base UOM Price field.';
                    ApplicationArea = All;
                }
                field("Total Amount"; Rec."Total Amount")
                {
                    ToolTip = 'Specifies the value of the Total Amount field.';
                    ApplicationArea = All;
                }
                field("Cogs (LCY)"; Rec."Cogs (LCY)")
                {
                    ToolTip = 'Specifies the value of the Cogs (LCY) field.';
                    ApplicationArea = All;
                }
                field("Other Revenue (LCY)"; Rec."Other Revenue (LCY)")
                {
                    ToolTip = 'Specifies the value of the Other Revenue (LCY) field.';
                    ApplicationArea = All;
                }
                field("Total Amount (LCY)"; Rec."Total Amount (LCY)")
                {
                    ToolTip = 'Specifies the value of the Total Amount (LCY) field.';
                    ApplicationArea = All;
                }
                field("EXP-FRT"; Rec."EXP-FRT")
                {
                    ToolTip = 'Specifies the value of the EXP-FRT field.';
                    ApplicationArea = All;
                }
                field("EXP-THC"; Rec."EXP-THC")
                {
                    ToolTip = 'Specifies the value of the EXP-THC field.';
                    ApplicationArea = All;
                }
                field("EXP-CDT"; Rec."EXP-CDT")
                {
                    ToolTip = 'Specifies the value of the EXP-CDT field.';
                    ApplicationArea = All;
                }
                field("EXP-TRC"; Rec."EXP-TRC")
                {
                    ToolTip = 'Specifies the value of the EXP-TRC field.';
                    ApplicationArea = All;
                }
                field("EXP-OTHER"; Rec."EXP-OTHER")
                {
                    ToolTip = 'Specifies the value of the EXP-OTHER field.';
                    ApplicationArea = All;
                }
                field("EXP-INS"; Rec."EXP-INS")
                {
                    ToolTip = 'Specifies the value of the EXP-INS field.';
                    ApplicationArea = All;
                }
                field("EXP-SERV"; Rec."EXP-SERV")
                {
                    ToolTip = 'Specifies the value of the EXP-SERV field.';
                    ApplicationArea = All;
                }
                field("EXP-INPC"; Rec."EXP-INPC")
                {
                    ToolTip = 'Specifies the value of the EXP-INPC field.';
                    ApplicationArea = All;
                }

                field("EXP-WH PACK"; Rec."EXP-WH PACK")
                {
                    ToolTip = 'Specifies the value of the EXP-WH PACK field.';
                    ApplicationArea = All;
                }
                field("EXP-WH HNDL"; Rec."EXP-WH HNDL")
                {
                    ToolTip = 'Specifies the value of the EXP-WH HNDL field.';
                    ApplicationArea = All;
                }

                field("EXP-LEGAL"; Rec."EXP-LEGAL")
                {
                    ToolTip = 'Specifies the value of the EXP-LEGAL field.';
                    ApplicationArea = All;
                }
                field("EXP-COO"; Rec."EXP-COO")
                {
                    ToolTip = 'Specifies the value of the EXP-COO field.';
                    ApplicationArea = All;
                }
                field("REBATE TO CUSTOMER "; Rec."REBATE TO CUSTOMER")
                {
                    ToolTip = 'Specifies the value of the REBATE TO CUSTOMER  field.';
                    ApplicationArea = All;
                }
                field("DEMURRAGE CHARGES"; Rec."DEMURRAGE CHARGES")
                {
                    ToolTip = 'Specifies the value of the DEMURRAGE CHARGES field.';
                    ApplicationArea = All;
                }
                field("Other Charges"; Rec."Other Charges")
                {
                    ApplicationArea = All;
                }

                field("Total Sales Discount"; Rec."Total Sales Discount")
                {
                    ToolTip = 'Specifies the value of the Total Sales Discount field.';
                    ApplicationArea = All;
                }
                field("Total Sales Expenses (LCY)"; Rec."Total Sales Expenses (LCY)")
                {
                    ToolTip = 'Specifies the value of the Total Sales Expenses (LCY) field.';
                    ApplicationArea = All;
                }
                field("COS (LCY)"; Rec."COS (LCY)")
                {
                    ToolTip = 'Specifies the value of the COS (LCY) field.';
                    ApplicationArea = All;
                }
                field("Eff GP (LCY)"; Rec."Eff GP (LCY)")
                {
                    ToolTip = 'Specifies the value of the Eff GP (LCY) field.';
                    ApplicationArea = All;
                }

                field("Eff GP %"; Rec."Eff GP %")
                {
                    ToolTip = 'Specifies the value of the Eff GP % field.';
                    ApplicationArea = All;
                }
                field("IC Company Code"; Rec."IC Company Code")
                {
                    ApplicationArea = All;
                }
                field("Vendor Invoice No."; Rec."Vendor Invoice No.")
                {
                    ApplicationArea = All;
                }

            }
        }
    }


}
