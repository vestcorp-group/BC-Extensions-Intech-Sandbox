codeunit 74981 OnDeleteCheck_Subscribe_Table
{
    //Table - 110 
    [EventSubscriber(ObjectType::Table, Database::"Sales Shipment Header", 'OnBeforeDeleteEvent', '', true, true)]
    local procedure "Sales Shipment Header_OnBeforeDeleteEvent"
    (
        var Rec: Record "Sales Shipment Header";
        RunTrigger: Boolean
    )
    begin
        If Rec.IsTemporary then
            exit;

        Error('You can not delete the record %1', Rec.TableCaption);
    end;

    //Table - 111
    [EventSubscriber(ObjectType::Table, Database::"Sales Shipment Line", 'OnBeforeDeleteEvent', '', true, true)]
    local procedure "Sales Shipment Line_OnBeforeDeleteEvent"
    (
        var Rec: Record "Sales Shipment Line";
        RunTrigger: Boolean
    )
    begin
        If Rec.IsTemporary then
            exit;

        Error('You can not delete the record %1', Rec.TableCaption);
    end;

    //Table - 112
    [EventSubscriber(ObjectType::Table, Database::"Sales Invoice Header", 'OnBeforeDeleteEvent', '', true, true)]
    local procedure "Sales Invoice Header_OnBeforeDeleteEvent"
    (
        var Rec: Record "Sales Invoice Header";
        RunTrigger: Boolean
    )
    begin
        If Rec.IsTemporary then
            exit;

        Error('You can not delete the record %1', Rec.TableCaption);
    end;

    //Table - 113
    [EventSubscriber(ObjectType::Table, Database::"Sales Invoice Line", 'OnBeforeDeleteEvent', '', true, true)]
    local procedure "Sales Invoice Line_OnBeforeDeleteEvent"
    (
        var Rec: Record "Sales Invoice Line";
        RunTrigger: Boolean
    )
    begin
        If Rec.IsTemporary then
            exit;

        Error('You can not delete the record %1', Rec.TableCaption);
    end;

    //Table - 114
    [EventSubscriber(ObjectType::Table, Database::"Sales Cr.Memo Header", 'OnBeforeDeleteEvent', '', true, true)]
    local procedure "Sales Cr.Memo Header_OnBeforeDeleteEvent"
    (
        var Rec: Record "Sales Cr.Memo Header";
        RunTrigger: Boolean
    )
    begin
        If Rec.IsTemporary then
            exit;

        Error('You can not delete the record %1', Rec.TableCaption);
    end;

    //Table - 115
    [EventSubscriber(ObjectType::Table, Database::"Sales Cr.Memo Line", 'OnBeforeDeleteEvent', '', true, true)]
    local procedure "Sales Cr.Memo Line_OnBeforeDeleteEvent"
    (
        var Rec: Record "Sales Cr.Memo Line";
        RunTrigger: Boolean
    )
    begin
        If Rec.IsTemporary then
            exit;

        Error('You can not delete the record %1', Rec.TableCaption);
    end;

    //Table - 120
    [EventSubscriber(ObjectType::Table, Database::"Purch. Rcpt. Header", 'OnBeforeDeleteEvent', '', true, true)]
    local procedure "Purch. Rcpt. Header_OnBeforeDeleteEvent"
    (
        var Rec: Record "Purch. Rcpt. Header";
        RunTrigger: Boolean
    )
    begin
        If Rec.IsTemporary then
            exit;

        Error('You can not delete the record %1', Rec.TableCaption);
    end;

    //Table - 121
    [EventSubscriber(ObjectType::Table, Database::"Purch. Rcpt. Line", 'OnBeforeDeleteEvent', '', true, true)]
    local procedure "Purch. Rcpt. Line_OnBeforeDeleteEvent"
    (
        var Rec: Record "Purch. Rcpt. Line";
        RunTrigger: Boolean
    )
    begin
        If Rec.IsTemporary then
            exit;

        Error('You can not delete the record %1', Rec.TableCaption);
    end;

    //Table - 122
    [EventSubscriber(ObjectType::Table, Database::"Purch. Inv. Header", 'OnBeforeDeleteEvent', '', true, true)]
    local procedure "Purch. Inv. Header_OnBeforeDeleteEvent"
    (
        var Rec: Record "Purch. Inv. Header";
        RunTrigger: Boolean
    )
    begin
        If Rec.IsTemporary then
            exit;

        Error('You can not delete the record %1', Rec.TableCaption);
    end;

    //Table - 123
    [EventSubscriber(ObjectType::Table, Database::"Purch. Inv. Line", 'OnBeforeDeleteEvent', '', true, true)]
    local procedure "Purch. Inv. Line_OnBeforeDeleteEvent"
    (
        var Rec: Record "Purch. Inv. Line";
        RunTrigger: Boolean
    )
    begin
        If Rec.IsTemporary then
            exit;

        Error('You can not delete the record %1', Rec.TableCaption);
    end;

    //Table - 124
    [EventSubscriber(ObjectType::Table, Database::"Purch. Cr. Memo Hdr.", 'OnBeforeDeleteEvent', '', true, true)]
    local procedure "Purch. Cr. Memo Hdr._OnBeforeDeleteEvent"
    (
        var Rec: Record "Purch. Cr. Memo Hdr.";
        RunTrigger: Boolean
    )
    begin
        If Rec.IsTemporary then
            exit;

        Error('You can not delete the record %1', Rec.TableCaption);
    end;


    //Table - 125
    [EventSubscriber(ObjectType::Table, Database::"Purch. Cr. Memo Line", 'OnBeforeDeleteEvent', '', true, true)]
    local procedure "Purch. Cr. Memo Line_OnBeforeDeleteEvent"
    (
        var Rec: Record "Purch. Cr. Memo Line";
        RunTrigger: Boolean
    )
    begin
        If Rec.IsTemporary then
            exit;

        Error('You can not delete the record %1', Rec.TableCaption);
    end;

    //Table - 5744
    [EventSubscriber(ObjectType::Table, Database::"Transfer Shipment Header", 'OnBeforeDeleteEvent', '', true, true)]
    local procedure "Transfer Shipment Header_OnBeforeDeleteEvent"
    (
        var Rec: Record "Transfer Shipment Header";
        RunTrigger: Boolean
    )
    begin
        If Rec.IsTemporary then
            exit;

        Error('You can not delete the record %1', Rec.TableCaption);
    end;

    //Tablle - 5745
    [EventSubscriber(ObjectType::Table, Database::"Transfer Shipment Line", 'OnBeforeDeleteEvent', '', true, true)]
    local procedure "Transfer Shipment Line_OnBeforeDeleteEvent"
    (
        var Rec: Record "Transfer Shipment Line";
        RunTrigger: Boolean
    )
    begin
        If Rec.IsTemporary then
            exit;

        Error('You can not delete the record %1', Rec.TableCaption);
    end;


    //Table - 5746
    [EventSubscriber(ObjectType::Table, Database::"Transfer Receipt Header", 'OnBeforeDeleteEvent', '', true, true)]
    local procedure "Transfer Receipt Header_OnBeforeDeleteEvent"
    (
        var Rec: Record "Transfer Receipt Header";
        RunTrigger: Boolean
    )
    begin
        If Rec.IsTemporary then
            exit;

        Error('You can not delete the record %1', Rec.TableCaption);
    end;

    //Table - 5747
    [EventSubscriber(ObjectType::Table, Database::"Transfer Receipt Line", 'OnBeforeDeleteEvent', '', true, true)]
    local procedure "Transfer Receipt Line_OnBeforeDeleteEvent"
    (
        var Rec: Record "Transfer Receipt Line";
        RunTrigger: Boolean
    )
    begin
        If Rec.IsTemporary then
            exit;

        Error('You can not delete the record %1', Rec.TableCaption);
    end;

    //Table - 5990
    [EventSubscriber(ObjectType::Table, Database::"Service Shipment Header", 'OnBeforeDeleteEvent', '', true, true)]
    local procedure "Service Shipment Header_OnBeforeDeleteEvent"
    (
        var Rec: Record "Service Shipment Header";
        RunTrigger: Boolean
    )
    begin
        If Rec.IsTemporary then
            exit;

        Error('You can not delete the record %1', Rec.TableCaption);
    end;

    //Table - 5991
    [EventSubscriber(ObjectType::Table, Database::"Service Shipment Line", 'OnBeforeDeleteEvent', '', true, true)]
    local procedure "Service Shipment Line_OnBeforeDeleteEvent"
    (
        var Rec: Record "Service Shipment Line";
        RunTrigger: Boolean
    )
    begin
        If Rec.IsTemporary then
            exit;

        Error('You can not delete the record %1', Rec.TableCaption);
    end;

    //Table - 5992
    [EventSubscriber(ObjectType::Table, Database::"Service Invoice Header", 'OnBeforeDeleteEvent', '', true, true)]
    local procedure "Service Invoice Header_OnBeforeDeleteEvent"
    (
        var Rec: Record "Service Invoice Header";
        RunTrigger: Boolean
    )
    begin
        If Rec.IsTemporary then
            exit;

        Error('You can not delete the record %1', Rec.TableCaption);
    end;

    //Table - 5993
    [EventSubscriber(ObjectType::Table, Database::"Service Invoice Line", 'OnBeforeDeleteEvent', '', true, true)]
    local procedure "Service Invoice Line_OnBeforeDeleteEvent"
    (
        var Rec: Record "Service Invoice Line";
        RunTrigger: Boolean
    )
    begin
        If Rec.IsTemporary then
            exit;

        Error('You can not delete the record %1', Rec.TableCaption);
    end;


    //Table - 5994
    [EventSubscriber(ObjectType::Table, Database::"Service Cr.Memo Header", 'OnBeforeDeleteEvent', '', true, true)]
    local procedure "Service Cr.Memo Header_OnBeforeDeleteEvent"
    (
        var Rec: Record "Service Cr.Memo Header";
        RunTrigger: Boolean
    )
    begin
        If Rec.IsTemporary then
            exit;

        Error('You can not delete the record %1', Rec.TableCaption);
    end;

    //Table - 5995
    [EventSubscriber(ObjectType::Table, Database::"Service Cr.Memo Line", 'OnBeforeDeleteEvent', '', true, true)]
    local procedure "Service Cr.Memo Line_OnBeforeDeleteEvent"
    (
        var Rec: Record "Service Cr.Memo Line";
        RunTrigger: Boolean
    )
    begin
        If Rec.IsTemporary then
            exit;

        Error('You can not delete the record %1', Rec.TableCaption);
    end;

    //Table - 6650
    [EventSubscriber(ObjectType::Table, Database::"Return Shipment Header", 'OnBeforeDeleteEvent', '', true, true)]
    local procedure "Return Shipment Header_OnBeforeDeleteEvent"
    (
        var Rec: Record "Return Shipment Header";
        RunTrigger: Boolean
    )
    begin
        If Rec.IsTemporary then
            exit;

        Error('You can not delete the record %1', Rec.TableCaption);
    end;

    //Table - 6651
    [EventSubscriber(ObjectType::Table, Database::"Return Shipment Line", 'OnBeforeDeleteEvent', '', true, true)]
    local procedure "Return Shipment Line_OnBeforeDeleteEvent"
    (
        var Rec: Record "Return Shipment Line";
        RunTrigger: Boolean
    )
    begin
        If Rec.IsTemporary then
            exit;

        Error('You can not delete the record %1', Rec.TableCaption);
    end;

    //Table - 6660
    [EventSubscriber(ObjectType::Table, Database::"Return Receipt Header", 'OnBeforeDeleteEvent', '', true, true)]
    local procedure "Return Receipt Header_OnBeforeDeleteEvent"
    (
        var Rec: Record "Return Receipt Header";
        RunTrigger: Boolean
    )
    begin
        If Rec.IsTemporary then
            exit;

        Error('You can not delete the record %1', Rec.TableCaption);
    end;

    //Table - 6661
    [EventSubscriber(ObjectType::Table, Database::"Return Receipt Line", 'OnBeforeDeleteEvent', '', true, true)]
    local procedure "Return Receipt Line_OnBeforeDeleteEvent"
    (
        var Rec: Record "Return Receipt Line";
        RunTrigger: Boolean
    )
    begin
        If Rec.IsTemporary then
            exit;

        Error('You can not delete the record %1', Rec.TableCaption);
    end;


    //Table - 7318
    [EventSubscriber(ObjectType::Table, Database::"Posted Whse. Receipt Header", 'OnBeforeDeleteEvent', '', true, true)]
    local procedure "Posted Whse. Receipt Header_OnBeforeDeleteEvent"
    (
        var Rec: Record "Posted Whse. Receipt Header";
        RunTrigger: Boolean
    )
    begin
        If Rec.IsTemporary then
            exit;

        Error('You can not delete the record %1', Rec.TableCaption);
    end;

    //Table - 7319
    [EventSubscriber(ObjectType::Table, Database::"Posted Whse. Receipt Line", 'OnBeforeDeleteEvent', '', true, true)]
    local procedure "Posted Whse. Receipt Line_OnBeforeDeleteEvent"
    (
        var Rec: Record "Posted Whse. Receipt Line";
        RunTrigger: Boolean
    )
    begin
        If Rec.IsTemporary then
            exit;

        Error('You can not delete the record %1', Rec.TableCaption);
    end;

    //Table - 7322
    [EventSubscriber(ObjectType::Table, Database::"Posted Whse. Shipment Header", 'OnBeforeDeleteEvent', '', true, true)]
    local procedure "Posted Whse. Shipment Header_OnBeforeDeleteEvent"
    (
        var Rec: Record "Posted Whse. Shipment Header";
        RunTrigger: Boolean
    )
    begin
        If Rec.IsTemporary then
            exit;

        Error('You can not delete the record %1', Rec.TableCaption);
    end;

    //Table - 7323
    [EventSubscriber(ObjectType::Table, Database::"Posted Whse. Shipment Line", 'OnBeforeDeleteEvent', '', true, true)]
    local procedure "Posted Whse. Shipment Line_OnBeforeDeleteEvent"
    (
        var Rec: Record "Posted Whse. Shipment Line";
        RunTrigger: Boolean
    )
    begin
        If Rec.IsTemporary then
            exit;

        Error('You can not delete the record %1', Rec.TableCaption);
    end;

    //Table - 7340
    [EventSubscriber(ObjectType::Table, Database::"Posted Invt. Put-away Header", 'OnBeforeDeleteEvent', '', true, true)]
    local procedure "Posted Invt. Put-away Header_OnBeforeDeleteEvent"
    (
        var Rec: Record "Posted Invt. Put-away Header";
        RunTrigger: Boolean
    )
    begin
        If Rec.IsTemporary then
            exit;

        Error('You can not delete the record %1', Rec.TableCaption);
    end;

    //Table - 7341
    [EventSubscriber(ObjectType::Table, Database::"Posted Invt. Put-away Line", 'OnBeforeDeleteEvent', '', true, true)]
    local procedure "Posted Invt. Put-away Line_OnBeforeDeleteEvent"
    (
        var Rec: Record "Posted Invt. Put-away Line";
        RunTrigger: Boolean
    )
    begin
        If Rec.IsTemporary then
            exit;

        Error('You can not delete the record %1', Rec.TableCaption);
    end;

    //Table - 7342
    [EventSubscriber(ObjectType::Table, Database::"Posted Invt. Pick Header", 'OnBeforeDeleteEvent', '', true, true)]
    local procedure "Posted Invt. Pick Header_OnBeforeDeleteEvent"
    (
        var Rec: Record "Posted Invt. Pick Header";
        RunTrigger: Boolean
    )
    begin
        If Rec.IsTemporary then
            exit;

        Error('You can not delete the record %1', Rec.TableCaption);
    end;


    //Table - 7343
    [EventSubscriber(ObjectType::Table, Database::"Posted Invt. Pick Line", 'OnBeforeDeleteEvent', '', true, true)]
    local procedure "Posted Invt. Pick Line_OnBeforeDeleteEvent"
    (
        var Rec: Record "Posted Invt. Pick Line";
        RunTrigger: Boolean
    )
    begin
        If Rec.IsTemporary then
            exit;

        Error('You can not delete the record %1', Rec.TableCaption);
    end;

    //Table - 7344
    [EventSubscriber(ObjectType::Table, Database::"Registered Invt. Movement Hdr.", 'OnBeforeDeleteEvent', '', true, true)]
    local procedure "Registered Invt. Movement Hdr._OnBeforeDeleteEvent"
    (
        var Rec: Record "Registered Invt. Movement Hdr.";
        RunTrigger: Boolean
    )
    begin
        If Rec.IsTemporary then
            exit;

        Error('You can not delete the record %1', Rec.TableCaption);
    end;

    //Table - 7345
    [EventSubscriber(ObjectType::Table, Database::"Registered Invt. Movement Line", 'OnBeforeDeleteEvent', '', true, true)]
    local procedure "Registered Invt. Movement Line_OnBeforeDeleteEvent"
    (
        var Rec: Record "Registered Invt. Movement Line";
        RunTrigger: Boolean
    )
    begin
        If Rec.IsTemporary then
            exit;

        Error('You can not delete the record %1', Rec.TableCaption);
    end;

    //Table - 910
    [EventSubscriber(ObjectType::Table, Database::"Posted Assembly Header", 'OnBeforeDeleteEvent', '', true, true)]
    local procedure "Posted Assembly Header_OnBeforeDeleteEvent"
    (
        var Rec: Record "Posted Assembly Header";
        RunTrigger: Boolean
    )
    begin
        If Rec.IsTemporary then
            exit;

        Error('You can not delete the record %1', Rec.TableCaption);
    end;

    //Table - 911
    [EventSubscriber(ObjectType::Table, Database::"Posted Assembly Line", 'OnBeforeDeleteEvent', '', true, true)]
    local procedure "Posted Assembly Line_OnBeforeDeleteEvent"
    (
        var Rec: Record "Posted Assembly Line";
        RunTrigger: Boolean
    )
    begin
        If Rec.IsTemporary then
            exit;

        Error('You can not delete the record %1', Rec.TableCaption);
    end;

    //Table - 1295
    [EventSubscriber(ObjectType::Table, Database::"Posted Payment Recon. Hdr", 'OnBeforeDeleteEvent', '', true, true)]
    local procedure "Posted Payment Recon. Hdr_OnBeforeDeleteEvent"
    (
        var Rec: Record "Posted Payment Recon. Hdr";
        RunTrigger: Boolean
    )
    begin
        If Rec.IsTemporary then
            exit;

        Error('You can not delete the record %1', Rec.TableCaption);
    end;

    //Table - 1296
    [EventSubscriber(ObjectType::Table, Database::"Posted Payment Recon. Line", 'OnBeforeDeleteEvent', '', true, true)]
    local procedure "Posted Payment Recon. Line_OnBeforeDeleteEvent"
    (
        var Rec: Record "Posted Payment Recon. Line";
        RunTrigger: Boolean
    )
    begin
        If Rec.IsTemporary then
            exit;

        Error('You can not delete the record %1', Rec.TableCaption);
    end;

}
