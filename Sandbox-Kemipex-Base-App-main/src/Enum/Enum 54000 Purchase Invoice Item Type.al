
/// <summary>
/// Enum Purchase Invoice Item Type (ID 60100).
/// </summary>
enum 54000 "Purchase Invoice Item Type"
{
    Extensible = true;
    AssignmentCompatibility = true;

    value(0; "Comment") { Caption = 'Comment'; }
    value(1; "G/L Account") { Caption = 'G/L Account'; }
    value(2; "Item") { Caption = 'Item'; }
    value(3; "Resource") { Caption = 'Resource'; }
    value(4; "Fixed Asset") { Caption = 'Fixed Asset'; }
    value(5; "Charge (Item)") { Caption = 'Charge (Item)'; }
}