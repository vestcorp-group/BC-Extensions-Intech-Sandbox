codeunit 50103 SubscribeTable39
{
    Description = 'T50268';
    Permissions = tabledata "Sales Header" = irm;

    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnAfterValidateEvent', 'No.', true, true)]
    local procedure UpdateHSNFromItem(var Rec: Record "Sales Line")
    var
        ItemL: Record Item;
    begin
        if not (Rec.Type = Rec.Type::Item) then
            exit;
        ItemL.Get(Rec."No.");
        Rec.HSNCode := ItemL."Tariff No.";
        Rec.CountryOfOrigin := ItemL."Country/Region of Origin Code";
        REc.LineHSNCode := ItemL."Tariff No.";
        Rec.LineCountryOfOrigin := ItemL."Country/Region of Origin Code";
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnAfterValidateEvent', 'LineHSNCode', true, true)]
    local procedure UpdateLineHSN(var Rec: Record "Sales Line")
    var
        ItemL: Record Item;
        SalesHdr_lRec: Record "Sales Header";
    begin
        if not (Rec.Type = Rec.Type::Item) then
            exit;

        ItemL.Get(Rec."No.");

        if SalesHdr_lRec.Get(Rec."Document Type", Rec."Document No.") then
            if SalesHdr_lRec.Status <> SalesHdr_lRec.Status::Open then
                Error('You can not modify because it is pending for approval');
        // if (Rec.LineHSNCode <> ItemL."Tariff No.") or (Rec.LineCountryOfOrigin <> ItemL."Country/Region of Origin Code") then begin
        //     SalesHdr_lRec."Required approval for Line" := true;
        //     SalesHdr_lRec.Modify();
        // end else begin
        //     SalesHdr_lRec."Required approval for Line" := false;
        //     SalesHdr_lRec.Modify();
        // end;
    End;

    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnAfterValidateEvent', 'LineCountryOfOrigin', true, true)]
    local procedure UpdateLineCountryRegion(var Rec: Record "Sales Line")
    var
        ItemL: Record Item;
        SalesHdr_lRec: Record "Sales Header";
    begin
        if not (Rec.Type = Rec.Type::Item) then
            exit;

        ItemL.Get(Rec."No.");

        if SalesHdr_lRec.Get(Rec."Document Type", Rec."Document No.") then
            if SalesHdr_lRec.Status <> SalesHdr_lRec.Status::Open then
                Error('You can not modify because it is pending for approval');
        // if (Rec.LineCountryOfOrigin <> ItemL."Country/Region of Origin Code") or (Rec.LineHSNCode <> ItemL."Tariff No.") then begin
        //     SalesHdr_lRec."Required approval for Line" := true;
        //     SalesHdr_lRec.Modify();
        // end else begin
        //     SalesHdr_lRec."Required approval for Line" := false;
        //     SalesHdr_lRec.Modify();
        // end;
    End;

    
    var
        myInt: Integer;
}