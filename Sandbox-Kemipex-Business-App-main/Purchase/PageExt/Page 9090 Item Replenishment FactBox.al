// pageextension 58142 Item_details_replenishment extends "Item Replenishment FactBox"//T12370-Full Comment
// {
//     layout
//     {
//         addafter("Replenishment System")
//         {
//             field(TotalInv; TotalInv)
//             {
//                 ApplicationArea = all;
//                 Caption = 'Total Inventory';
//                 DecimalPlaces = 3;
//                 Style = Strong;
//             }
//             group("Inventory Details")
//             {
//                 field(KEM; KEM)
//                 {
//                     ApplicationArea = all;
//                     DecimalPlaces = 3;
//                 }
//                 field(KCT; KCT)
//                 {
//                     ApplicationArea = all;
//                     DecimalPlaces = 3;
//                 }
//                 field(CAS; CAS)
//                 {
//                     ApplicationArea = all;
//                     DecimalPlaces = 3;
//                 }
//                 field(CET; CET)
//                 {
//                     ApplicationArea = all;
//                     DecimalPlaces = 3;
//                 }
//                 field(XO; XO)
//                 {
//                     ApplicationArea = all;
//                     DecimalPlaces = 3;
//                 }
//                 field(COR; COR)
//                 {
//                     ApplicationArea = all;
//                     DecimalPlaces = 3;
//                 }
//                 field(CFD; CFD)
//                 {
//                     ApplicationArea = all;
//                     DecimalPlaces = 3;
//                 }
//             }
//         }
//         modify("Replenishment System")
//         {
//             Visible = false;

//         }
//         modify(Purchase)
//         {
//             Visible = false;
//         }
//         modify("Vendor Item No.")
//         {
//             Visible = false;
//         }
//     }


//     trigger OnAfterGetRecord()
//     var
//         company: Record Company;
//         Item: Record item;
//         ILE: Record "Item Ledger Entry";

//     begin

//         ILE.Reset();
//         ILE.ChangeCompany('Kemipex FZE');
//         ile.SetRange("Item No.", rec."No.");
//         ILE.SetFilter("Remaining Quantity", '<>0');
//         ile.CalcSums("Remaining Quantity");
//         KEM := ILE."Remaining Quantity";

//         ILE.Reset();
//         ILE.ChangeCompany('Caspian Chemical FZCO');
//         ile.SetRange("Item No.", rec."No.");
//         ILE.SetFilter("Remaining Quantity", '<>0');
//         ile.CalcSums("Remaining Quantity");
//         CAS := ILE."Remaining Quantity";

//         ILE.Reset();
//         ILE.ChangeCompany('Chemxo Trading FZE');
//         ile.SetRange("Item No.", rec."No.");
//         ILE.SetFilter("Remaining Quantity", '<>0');
//         ile.CalcSums("Remaining Quantity");
//         XO := ILE."Remaining Quantity";

//         ILE.Reset();
//         ILE.ChangeCompany('Kemipex Chemicals Trading LLC');
//         ile.SetRange("Item No.", rec."No.");
//         ILE.SetFilter("Remaining Quantity", '<>0');
//         ile.CalcSums("Remaining Quantity");
//         KCT := ILE."Remaining Quantity";

//         ILE.Reset();
//         ILE.ChangeCompany('Caspian Emirates Trading LLC');
//         ile.SetRange("Item No.", rec."No.");
//         ILE.SetFilter("Remaining Quantity", '<>0');
//         ile.CalcSums("Remaining Quantity");
//         CET := ILE."Remaining Quantity";

//         ILE.Reset();
//         ILE.ChangeCompany('Coraplus PTE LTD');
//         ile.SetRange("Item No.", rec."No.");
//         ILE.SetFilter("Remaining Quantity", '<>0');
//         ile.CalcSums("Remaining Quantity");
//         COR := ILE."Remaining Quantity";

//         ILE.Reset();
//         ILE.ChangeCompany('Chemified FZ-LLC');
//         ile.SetRange("Item No.", rec."No.");
//         ILE.SetFilter("Remaining Quantity", '<>0');
//         ile.CalcSums("Remaining Quantity");
//         CFD := ILE."Remaining Quantity";

//         TotalInv := KEM + KCT + COR + CAS + CET + XO + CFD;

//         Companytext := company.Name;
//         // recoref.Open(Database::"Company Short Name");

//     end;

//     var
//         KEM: Decimal;
//         KCT: Decimal;
//         CAS: Decimal;
//         CET: Decimal;
//         XO: Decimal;
//         COR: Decimal;
//         CFD: Decimal;
//         TotalInv: Decimal;
//         CompanyShortName: Record "Company Short Name";
//         Companytext: Text;
//         // company: Record Company;
//         recoref: RecordRef;

// }