page 85655 apiPostedQCLines
{
    APIGroup = 'API';
    APIPublisher = 'ISPL';
    APIVersion = 'v2.0';
    ApplicationArea = All;
    Caption = 'apiPostedQCLines';
    DelayedInsert = true;
    EntityName = 'apiPostedQCLines';
    EntitySetName = 'apiPostedQCLines';
    PageType = API;
    Description = 'T13919';
    SourceTable = "Posted QC Rcpt. Line";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(posQCno; Rec."No.")
                {
                    Caption = 'No.';
                }
                field(postQClineNo; Rec."Line No.")
                {
                    Caption = 'Line No.';
                }
                field(qualityParameterCode; Rec."Quality Parameter Code")
                {
                    Caption = 'Quality Parameter Code';
                }
                field(vendorCOAValueResult; Rec."Vendor COA Value Result")
                {
                    Caption = 'Vendor COA Value Result';
                }
                field(vendorCOATextResult; Rec."Vendor COA Text Result")
                {
                    Caption = 'Vendor COA Text Result';
                }
                field(actualValue; Rec."Actual Value")
                {
                    Caption = 'Actual Value';
                }
                field(actualText; Rec."Actual Text")
                {
                    Caption = 'Actual Text';
                }
                field(result; Rec.Result)
                {
                    Caption = 'Result';
                }
                field(SampleCollector; SampleCollector_gtxt)
                {

                }
                field(Sampleprovider; Sampleprovider_gtxt)
                {

                }
                field(DateofSample; DateofSample_gDte)
                {

                }
                field(Required; Rec.Required)
                {
                    Caption = 'Required'; //14042025
                }
                field(sampleDateandTime; SampleDateandTime_gDT)
                {

                }
            }
        }
    }
    trigger OnAfterGetRecord()
    var
        PostQcRcptHead_LrEC: Record "Posted QC Rcpt. Header";
    begin
        Clear(SampleCollector_gtxt);
        Clear(Sampleprovider_gtxt);
        Clear(DateofSample_gDte);
        Clear(SampleDateandTime_gDT);
        PostQcRcptHead_LrEC.Reset();
        PostQcRcptHead_LrEC.SetRange("No.", Rec."No.");
        if PostQcRcptHead_LrEC.FindFirst() then begin
            SampleCollector_gtxt := PostQcRcptHead_LrEC."Sample Collector ID";
            Sampleprovider_gtxt := PostQcRcptHead_LrEC."Sample Provider ID";
            DateofSample_gDte := PostQcRcptHead_LrEC."Date of Sample Collection";
            SampleDateandTime_gDT := PostQcRcptHead_LrEC."Sample Date and Time";
        end;
    end;

    var
        SampleCollector_gtxt: Text;
        Sampleprovider_gtxt: Text;
        DateofSample_gDte: date;
        SampleDateandTime_gDT: DateTime;

}
