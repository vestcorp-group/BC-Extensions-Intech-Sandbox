pageextension 58048 Purchaseline extends "Purchase Lines"//T12370-Full Comment //T13620-N
{
    layout
    {
        /* modify(Description)
        {
            Caption = 'Item Commercial Name';
        }
        modify("Unit of Measure Code")
        {
            Caption = 'UOM';
            trigger OnBeforeValidate()
            begin
                if Rec.Type = Rec.Type::Item then
                    ItemDescription := Rec.Description;
            end;

            trigger OnAfterValidate()
            begin
                if Rec.Type = Rec.Type::Item then
                    Rec.Description := ItemDescription;
            end;
        } */
        addafter("Line Amount")
        {
            field(CustomETD; rec.CustomETD)
            {
                Caption = 'ETD';
                ApplicationArea = all;
            }
            field(CustomETA; rec.CustomETA)
            {
                Caption = 'ETA';
                ApplicationArea = all;
            }
            field(CustomR_ETD; rec.CustomR_ETD)
            {
                Caption = 'R-ETD';
                ApplicationArea = all;
            }
            field(CustomR_ETA; rec.CustomR_ETA)
            {
                Caption = 'R-ETA';
                ApplicationArea = all;
            }
            // field("Transaction Type"; rec."Transaction Type")
            // {
            //     ApplicationArea = all;
            //     Caption = 'Order Type';
            // }
        }
        // addbefore("Direct Unit Cost")
        // {
        //     field("Currency Code"; rec."Currency Code")
        //     {
        //         ApplicationArea = all;
        //     }
        // }

        // modify("Location Code")
        // {
        //     trigger OnBeforeValidate()
        //     begin
        //         if Rec.Type = Rec.Type::Item then
        //             ItemDescription := Rec.Description;
        //     end;

        //     trigger OnAfterValidate()
        //     begin
        //         if Rec.Type = Rec.Type::Item then
        //             Rec.Description := ItemDescription;
        //     end;
        // }
    }
    // var
    //     ItemDescription: Text[100];

}