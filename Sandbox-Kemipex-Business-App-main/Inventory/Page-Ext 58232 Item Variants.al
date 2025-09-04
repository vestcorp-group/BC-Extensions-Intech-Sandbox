pageextension 58232 ItemVariants extends "Item Variants"//T12370-Full Comment, T12855
{
    layout
    {
        addafter(Description)
        {
            field("Description 21"; rec."Description 2")
            {
                ApplicationArea = all;
                Caption = 'Variant Short Name';
            }
            field(HSNCode; rec.HSNCode)
            {
                ApplicationArea = all;
                Caption = 'Item HSN Code';
                Description = 'T12855';
            }
            field(CountryOfOrigin; rec.CountryOfOrigin)
            {
                ApplicationArea = all;
                Caption = 'Item Country of Origin';
                Description = 'T12855';
            }
            field("Packing Code"; Rec."Packing Code")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Packing Code field.', Comment = '%';
            }
            field("Packing Description"; rec."Packing Description")
            {
                ApplicationArea = all;
                Caption = 'Packing Description';
                Description = 'T12855';
            }
            field(Remarks; Rec.Remarks)
            {
                ApplicationArea = all;
                Description = 'T12855';
            }
            field(Blocked1; rec.Blocked1)
            {
                ApplicationArea = all;
                Caption = 'Blocked';
            }
            field("Variant Details"; rec."Variant Details")
            {
                ApplicationArea = all;
                Description = 'T12855';
            }
        }

    }
    /*//T12855 actions
    {
        addfirst(Creation)
        {
            action(TPVarRelease)
            {
                Caption = 'Release Variant TP to Companies';
                ApplicationArea = all;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                trigger OnAction()
                var
                    myInt: Integer;
                begin
                    rec.TPVarcompanytransfer(xRec, true);
                end;
            }
        }
        // Add changes to page actions here
    } */
}
