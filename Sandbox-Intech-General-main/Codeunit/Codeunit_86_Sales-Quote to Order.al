codeunit 75025 subscribe_Codeunit_86
{

    //I-C0059-1005707-01-NS
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Quote to Order", OnAfterCreateSalesHeader, '', false, false)]
    local procedure OnAfterCreateSalesHeader(var SalesOrderHeader: Record "Sales Header"; SalesHeader: Record "Sales Header");
    var
        SalesSetup: Record "Sales & Receivables Setup";
        NoSeriesMgt_lCdu: Codeunit NoSeriesManagement;
    begin

        SalesSetup.GET;
        IF SalesSetup."No. Series Sele. -Quo. To Ord." THEN BEGIN
            SalesSetup.TESTFIELD("Order Nos.");
            IF NoSeriesMgt_lCdu.SelectSeries(SalesSetup."Order Nos.", SalesOrderHeader."No. Series", SalesOrderHeader."No. Series") THEN BEGIN
                NoSeriesMgt_lCdu.SetSeries(SalesOrderHeader."No.");
            END ELSE
                ERROR('');
            COMMIT;
        END;
        //I-C0059-1005707-01-NE
    end;

}
