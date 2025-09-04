// report 50101 KMP_RptItemSummary//T12370-Full Comment
// {
//     ObsoleteState = Pending;
//     RDLCLayout = './Layouts/KMP_RptItemSummary.rdl';
//     Caption = 'Inventory Summary Report';

//     dataset
//     {
//         dataitem(DataItem1; "Item Ledger Entry")
//         {
//             UseTemporary = true;
//             column(Company_Name_; Description)
//             { }
//             column(Item_No_; "Item No.")
//             { }
//             column(Quantity; Quantity)
//             { }
//             column(Reserved_Quantity; ItemLedEntryG."Reserved Quantity")
//             { }
//             column(Unit_of_Measure_Code; "Unit of Measure Code")
//             { }
//             column(Entry_No_; SlNoG)
//             { }

//             dataitem(DataItem2; Item)
//             {
//                 DataItemLink = "No." = field("Item No.");
//                 CalcFields = "Qty. on Purch. Order";
//                 column(Description; Description)
//                 { }
//                 column(Search_Description; "Search Description")
//                 { }
//                 column(Qty__on_Purch__Order; "Qty. on Purch. Order")
//                 { }
//                 column(Safety_Stock_Quantity; "Safety Stock Quantity")
//                 { }
//                 column(Inventory_Posting_Group; "Inventory Posting Group")
//                 { }
//                 trigger OnPreDataItem()
//                 var
//                     myInt: Integer;
//                 begin
//                     DataItem2.ChangeCompany(DataItem1.Description);
//                 end;

//                 trigger OnAfterGetRecord()
//                 var
//                     myInt: Integer;
//                 begin
//                     SlNoG += 1;
//                 end;
//             }
//             column(CompanyNameValue; CompanyNameValue)
//             { }
//             column(CompanyInfoVatRegNoValue; CompanyInfoVatRegNoValue)
//             { }
//             column(CompanyAddr1Value; CompanyAddr1Value)
//             { }
//             column(CompanyAddr2Value; CompanyAddr2Value)
//             { }
//             column(AsOfDateParameterValue; AsOfDateParameterValue)
//             { }
//             column(QuantityOption; QuantityG)
//             { }
//             trigger OnPreDataItem()
//             var
//                 myInt: Integer;
//             begin
//                 DataItem1.ChangeCompany(DataItem1.Description);
//             end;

//             trigger OnAfterGetRecord()
//             var
//                 myInt: Integer;
//             begin
//                 ItemLedEntryG.ChangeCompany(DataItem1.Description);
//                 ItemLedEntryG.Get(DataItem1."Applies-to Entry");
//                 ItemLedEntryG.CalcFields("Reserved Quantity");
//             end;
//         }
//     }

//     requestpage
//     {
//         layout
//         {
//             area(Content)
//             {
//                 field(AsOfDate; AsOfDate)
//                 {
//                     ApplicationArea = All;
//                     Caption = 'As of';
//                 }

//                 field(ItemNo; ItemNo)
//                 {
//                     ApplicationArea = All;
//                     Caption = 'Item No.';
//                     TableRelation = Item;
//                     // trigger OnDrillDown()
//                     // var
//                     //     myInt: Integer;
//                     //     selectedItemNo: Record Item;
//                     //     ItemList: Page KMP_ItemLit;
//                     // begin
//                     //     //Message(Rec.TransactionNumber);
//                     //     ItemList.LookupMode(true);
//                     //     if ItemList.RUNMODAL = ACTION::LookupOK then begin
//                     //         ItemList.GETRECORD(selectedItemNo);
//                     //         ItemNo := selectedItemNo."No.";
//                     //     end;
//                     // end;
//                 }
//                 field("Exclude Item With Quantity 0"; QuantityG)
//                 {
//                     ApplicationArea = All;
//                 }
//                 field("Company Name"; CompanyNameG)
//                 {
//                     ApplicationArea = all;
//                     TableRelation = Company;
//                     // trigger OnDrillDown()
//                     // var
//                     //     CompaniesL: Page Companies;
//                     // begin
//                     //     CompanyG.findfirst();
//                     //     CompaniesL.LookupMode(true);
//                     //     CompaniesL.SetRecord(CompanyG);
//                     //     if CompaniesL.RunModal() = Action::LookupOK then
//                     //         CompaniesL.SetSelectionFilter(CompanyG);
//                     // end;
//                 }
//             }
//         }


//     }

//     var
//         ItemLedEntryG: Record "Item Ledger Entry";
//         AsOfDate: Date;
//         AsOfDateParameterValue: Date;
//         ItemNo: Text[20];
//         CompanyInfo: Record 79;
//         CompanyNameValue: Text[50];
//         CompanyInfoVatRegNoValue: Text[20];
//         CompanyAddr1Value: Text[50];
//         CompanyAddr2Value: Text[50];
//         CompanyNameG: Text;

//         QuantityG: Boolean;
//         CompanyG: Record Company;
//         EntryNoG: Integer;
//         SlNoG: Integer;
//     //Added on 8-Jul-2019
//     local procedure InsertTempRecord(var ItemLedEntryP: Record "Item Ledger Entry")
//     var
//         myInt: Integer;
//     begin
//         EntryNoG += 1;
//         DataItem1.Init();
//         DataItem1 := ItemLedEntryP;
//         DataItem1."Entry No." := EntryNoG;
//         DataItem1.Description := ItemLedEntryP.CurrentCompany();
//         DataItem1."Applies-to Entry" := ItemLedEntryP."Entry No.";
//         DataItem1.Insert();
//     end;

//     trigger OnPreReport()
//     var
//         myInt: Integer;
//         CompanyInfoRec: Record "Company Information";
//         ItemL: Record item;

//     begin
//         Clear(DataItem1);
//         Clear(EntryNoG);
//         Clear(SlNoG);
//         if CompanyNameG > '' then
//             CompanyG.SetRange(Name, CompanyNameG);
//         CompanyG.FindSet();
//         repeat
//             ItemLedEntryG.ChangeCompany(CompanyG.Name);
//             ItemLedEntryG.SetCurrentKey("Posting Date", "Item No.");
//             ItemLedEntryG.SetFilter("Posting Date", '<=' + Format(AsOfDate));

//             // if QuantityG = true then
//             //     ItemLedEntryG.SetFilter(Quantity, '<>', 0);

//             AsOfDateParameterValue := AsOfDate;

//             if ItemNo > '' then
//                 ItemLedEntryG.SetRange("Item No.", ItemNo);
//             if ItemLedEntryG.FindSet() then
//                 repeat
//                     if ItemL.Get(ItemLedEntryG."Item No.") and (Uppercase(ItemL."Inventory Posting Group") <> 'SAMPLE') then
//                         InsertTempRecord(ItemLedEntryG);
//                 until ItemLedEntryG.Next() = 0;
//         until CompanyG.Next() = 0;
//         //CurrReport.SetTableView(ItemLedEntryG);

//         // RecordName.SetFilter("Posting Date", '<=' + Format(AsOfDate));
//         // RecordName.SetFilter("Item No.", ItemNo);
//         // AsOfDateParameterValue := AsOfDate;
//         // CurrReport.SetTableView(RecordName);

//         // CompanyInfoRec.SetFilter(Name, CompanyInfo.CurrentCompany);
//         // if CompanyInfoRec.FindFirst() then begin
//         //     CompanyNameValue := CompanyInfoRec.Name;
//         //     CompanyInfoVatRegNoValue := CompanyInfoRec."VAT Registration No.";
//         //     CompanyAddr1Value := CompanyInfoRec.Address;
//         //     CompanyAddr2Value := CompanyInfoRec."Address 2";
//         // end;

//         if CompanyNameG > '' then
//             CompanyNameValue := CompanyNameG
//         else
//             CompanyNameValue := 'Group of Companies';

//     end;

//     trigger OnInitReport()
//     var
//         myInt: Integer;
//     begin
//         AsOfDate := WorkDate();
//     end;
// }

