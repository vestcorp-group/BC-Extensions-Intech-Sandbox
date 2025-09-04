// codeunit 50602 "Gen. Jnl. Post Subscribers"  //T12370_MIG
// {
//     [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnAfterInitGLEntry', '', false, false)]
//     local procedure OnAfterInitGLEntry(var GLEntry: Record "G/L Entry"; GenJournalLine: Record "Gen. Journal Line")
//     begin
//         GLEntry."IC Elimination" := GenJournalLine."IC Elimination";
//     end;

// }