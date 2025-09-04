tableextension 58081 paymentterms extends "Payment Terms"//T12370-Full Comment T12574-N
{
    fields
    {
        field(58021; "Advance Payment"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'T12574';
        }
        field(58023; "Sales Blocked"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(58031; "Management Approval"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        //12-10-2022-start
        field(53000; "DL"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(53001; "LC"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        //12-10-2022-end
    }
    procedure companytransfer(pay_from: Record "Payment Terms")
    var
        masterconfig: Record "Release to Company Setup";
        pay_to: Record "Payment Terms";
        Text001: Label 'Payment Term %1 transfered to %2 Company';
        Text002: Label 'Payment Term %1 modified in %2 Company';
    begin
        masterconfig.reset();
        masterconfig.SetRange(masterconfig."Transfer Customer", true);
        masterconfig.SetFilter(masterconfig."Company Name", '<>%1', CompanyName);
        if masterconfig.FindSet() then
            repeat
                pay_to.ChangeCompany(masterconfig."Company Name");
                pay_to.Reset();
                if not pay_to.Get(pay_from.Code) then begin
                    pay_to.Init();
                    pay_to := pay_from;
                    if pay_to.Insert() then;
                    Message(Text001, pay_to.Code, masterconfig."Company Name");
                end
                else begin
                    pay_to.Description := pay_from.Description;
                    pay_to."Due Date Calculation" := pay_from."Due Date Calculation";
                    pay_to."Discount Date Calculation" := pay_from."Discount Date Calculation";
                    pay_to."Discount %" := pay_from."Discount %";
                    pay_to."Calc. Pmt. Disc. on Cr. Memos" := pay_from."Calc. Pmt. Disc. on Cr. Memos";
                    pay_to."Advance Payment" := pay_from."Advance Payment";
                    pay_to."Sales Blocked" := pay_from."Sales Blocked";
                    if pay_to.Modify() then;
                    Message(Text002, pay_to.Code, masterconfig."Company Name");
                end;
            until masterconfig.Next() = 0;
    end;
}