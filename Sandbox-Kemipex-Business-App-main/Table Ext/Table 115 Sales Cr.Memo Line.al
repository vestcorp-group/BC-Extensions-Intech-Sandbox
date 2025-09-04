tableextension 58004 SalesCrMemoLines extends "Sales Cr.Memo Line"//T12370-Full Comment T12946-Code Uncommented
{
    fields
    {
        //         //GST-22/05/2022
        //         modify("VAT %")
        //         {
        //             CaptionClass = 'GSTORVAT,VAT %';
        //         }
        //         modify("VAT Bus. Posting Group")
        //         {
        //             CaptionClass = 'GSTORVAT,VAT Bus. Posting Group';
        //         }
        //         modify("VAT Clause Code")
        //         {
        //             CaptionClass = 'GSTORVAT,VAT Clause Code';
        //         }
        //         modify("Amount Including VAT")
        //         {
        //             CaptionClass = 'GSTORVAT,Amount Including VAT';
        //         }
        //         modify("VAT Difference")
        //         {
        //             CaptionClass = 'GSTORVAT,VAT Difference';
        //         }
        //         modify("VAT Identifier")
        //         {
        //             CaptionClass = 'GSTORVAT,VAT Identifier';
        //         }
        //         modify("VAT Prod. Posting Group")
        //         {
        //             CaptionClass = 'GSTORVAT,VAT Prod. Posting Group';
        //         }
        //         modify("VAT Base Amount")
        //         {
        //             CaptionClass = 'GSTORVAT,VAT Base Amount';
        //         }
        //08-08-2022-start
        field(58035; "Item Incentive Point (IIP)"; Option)
        {
            OptionMembers = ,"1","2","3","4","5";
        }
        //         //08-08-2022-end
        //         field(53001; "Container Size"; Text[200])
        //         {
        //             Caption = 'Container Size';
        //             DataClassification = ToBeClassified;
        //         }
        //         field(53002; "Shipping Remarks"; Text[150])
        //         {
        //             Caption = 'Shipping Remarks';
        //             DataClassification = ToBeClassified;
        //         }
        //         field(53003; "In-Out Instruction"; Text[200])
        //         {
        //             Caption = 'Material Inbound/Outbound Instruction';
        //             DataClassification = ToBeClassified;
        //         }
        //         field(53004; "Shipping Line"; Text[150])
        //         {
        //             Caption = 'Shipping Line';
        //             DataClassification = ToBeClassified;
        //         }
        //         field(53005; "BL-AWB No."; Text[150])
        //         {
        //             Caption = 'BL/AWB Number';
        //             DataClassification = ToBeClassified;
        //         }
        //         field(53006; "Vessel-Voyage No."; Text[150])
        //         {
        //             Caption = 'Vessel/Voyage Number';
        //             DataClassification = ToBeClassified;
        //         }
        //         field(53007; "Freight Forwarder"; Text[150])
        //         {
        //             Caption = 'Freight Forwarder';
        //             DataClassification = ToBeClassified;
        //         }
        //         field(53008; "Freight Charge"; Text[150])
        //         {
        //             Caption = 'Freight Charge';
        //             DataClassification = ToBeClassified;
        //         }
    }
}
