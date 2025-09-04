pageextension 75063 "AAD Application List_79811" extends "AAD Application List"
{
    //BCAUTH_User_Create-NS
    actions
    {
        addfirst(Processing)
        {
            action("Create Usersetup")
            {
                ApplicationArea = Basic;
                Image = Navigate;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    US_lRec: Record "User Setup";
                    UserName: Text;
                    User: Record User;
                begin
                    Clear(US_lRec);
                    UserName := '';
                    User.Get(Rec."User Id");
                    UserName := USer."User Name";

                    IF NOT US_lRec.GET(UserName) Then begin
                        US_lRec.Init();
                        US_lRec."User ID" := UserName;
                        US_lRec.Insert();
                        Message('USERID %1 created', UserName);
                    end Else
                        Message('USERID %1 already available', UserName);
                end;
            }
        }
    }
    //BCAUTH_User_Create-NE
}
