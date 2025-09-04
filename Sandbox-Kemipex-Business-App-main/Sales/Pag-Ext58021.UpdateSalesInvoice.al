// pageextension 58021 UpdateSalesInvoice extends "Posted Sales Inv. - Update"//T12370-Full Comment
// {
//     layout
//     {
//         addlast(General)
//         {
//             field("Customer Final Destination"; Rec."Customer Final Destination")
//             {
//                 ApplicationArea = All;
//             }
//             field("Transport Method"; Rec."Transport Method")
//             {
//                 ApplicationArea = All;
//             }
//         }
//         /* // Hide by B
//          addlast(content)
//          {
//              group("Ship-to")
//              {
//                  Visible = false;
//                  Editable = AllowEdit;
//                  Caption = 'Ship-to';
//                  field("Ship-to Code"; Rec."Ship-to Code")
//                  {
//                      ApplicationArea = All;
//                      Caption = 'Address Code';
//                      Importance = Promoted;
//                      ToolTip = 'Specifies the address on purchase orders shipped with a drop shipment directly from the vendor to a customer.';
//                  }
//                  field("Ship-to Name"; Rec."Ship-to Name")
//                  {
//                      ApplicationArea = All;
//                      Importance = Promoted;
//                      Caption = 'Name';
//                      ToolTip = 'Specifies the name of the customer that the items were shipped to.';
//                  }
//                  field("Ship-to Address"; Rec."Ship-to Address")
//                  {
//                      ApplicationArea = All;
//                      Caption = 'Address';
//                      ToolTip = 'Specifies the address that the items on the invoice were shipped to.';
//                  }
//                  field("Ship-to Address 2"; Rec."Ship-to Address 2")
//                  {
//                      ApplicationArea = All;
//                      Caption = 'Address 2';
//                      ToolTip = 'Specifies additional address information.';
//                  }
//                  field("Ship-to City"; Rec."Ship-to City")
//                  {
//                      ApplicationArea = All;
//                      Caption = 'City';
//                      ToolTip = 'Specifies the city of the customer on the sales document.';
//                  }
//                  field("Ship-to County"; Rec."Ship-to County")
//                  {
//                      ApplicationArea = All;
//                      Caption = 'County';
//                      ToolTip = 'Specifies the state, province or county as a part of the address.';
//                  }
//                  field("Ship-to Post Code"; Rec."Ship-to Post Code")
//                  {
//                      ApplicationArea = All;
//                      Caption = 'Post Code';
//                      ToolTip = 'Specifies the postal code.';
//                  }
//                  field("Ship-to Country/Region Code"; Rec."Ship-to Country/Region Code")
//                  {
//                      ApplicationArea = All;
//                      Caption = 'Country/Region';
//                      ToolTip = 'Specifies the country or region of the address.';
//                  }
//                  field("Ship-to Contact"; Rec."Ship-to Contact")
//                  {
//                      ApplicationArea = All;
//                      Caption = 'Contact';
//                      ToolTip = 'Specifies the name of the person you regularly contact at the address that the items were shipped to.';
//                  }
//              }

//          } */
//         modify(General)
//         {
//             Editable = AllowEdit;
//         }
//         modify(Payment)
//         {
//             Editable = AllowEdit;
//         }
//     }

//     trigger OnOpenPage()
//     begin
//         SetControl();
//     end;

//     trigger OnAfterGetRecord()
//     begin
//         SetControl();
//     end;

//     local procedure SetControl()
//     var
//         RecuserSetup: Record "User Setup";
//     begin
//         AllowEdit := false;
//         clear(RecuserSetup);
//         if RecuserSetup.GET(UserId) then begin
//             if RecuserSetup."Modify Posted Sales Invoice" then begin
//                 AllowEdit := true;
//             end;
//         end;
//     end;

//     var
//         AllowEdit: Boolean;
// }
