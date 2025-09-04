// codeunit 58170 CaptionManagmentExt//T12370-Full Comment
// {
//     trigger OnRun()
//     begin

//     end;

//     [EventSubscriber(ObjectType::Codeunit, Codeunit::"Caption Class", 'OnResolveCaptionClass', '', false, false)]
//     local procedure ResolveCaptionClass(CaptionArea: Text; CaptionExpr: Text; Language: Integer; var Caption: Text; var Resolved: Boolean)

//     var
//         SP: Record "Salesperson/Purchaser";
//         UserSetup: Record "User Setup";
//     begin


//     end;

//     [EventSubscriber(ObjectType::Codeunit, Codeunit::"Caption Class", 'OnResolveCaptionClass', '', false, false)]
//     local procedure OnResolveCaptionClass(CaptionArea: Text; CaptionExpr: Text; Language: Integer; var Caption: Text; var Resolved: Boolean);
//     var
//         CompanyInfo: Record "Company Information";
//     begin
//         CompanyInfo.GET;
//         if not CompanyInfo."Enable GST caption" then begin
//             if CaptionArea = 'GSTORVAT' then begin
//                 Caption := CaptionExpr;
//                 Resolved := true;
//             end;
//         end else begin
//             if CaptionArea = 'GSTORVAT' then begin
//                 Caption := ChangeCaption(CaptionExpr);
//                 Resolved := true;
//             end
//         end;
//     end;

//     local procedure ChangeCaption(caption: Text): Text
//     var
//         CompanyInformation: Record "Company Information";
//     begin
//         CompanyInformation.GET;
//         if CompanyInformation."Enable GST caption" then
//             exit(DelChr(caption.Replace('VAT', 'GST'), '=', '3,'))
//         else
//             exit(caption);
//     end;



// }