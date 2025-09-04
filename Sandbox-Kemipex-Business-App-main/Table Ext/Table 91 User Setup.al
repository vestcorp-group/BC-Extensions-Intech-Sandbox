tableextension 58109 usersetuptableext extends "User Setup"//T12370-Full Comment //T12574-N
{
    fields
    {
        // field(58020; "Allow Pre SI Creation"; Boolean)
        // {
        //     Caption = 'Allow Pre Sales Invoice Creation';
        // }
        field(58038; "Allow SO Line Reserve Modify"; Boolean)
        {
            Caption = 'Allow SO Line Reserve Modify';
        }
        // field(58042; "Allow IC Docs Without Relation"; Boolean)
        // {
        //     Caption = 'Allow IC Docs Without Relation';
        // }
        // field(53001; "Allow Edit ETA/ETD"; Boolean)
        // {
        //     DataClassification = CustomerContent;

        //     Caption = 'Allow Edit ETA/ETD';
        // }
        // //06-08-2022-start
        field(53002; "Allow To Edit Items"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        // field(53003; "Modify Posted Sales Inv. Line"; Boolean)
        // {
        //     DataClassification = ToBeClassified;
        // }
        // field(53004; "Modify Posted Sales Shpt Line"; Boolean)
        // {
        //     DataClassification = ToBeClassified;
        // }
        // field(53005; "Modify Posted Sales Invoice"; Boolean)
        // {
        //     DataClassification = ToBeClassified;
        // }
        //06-08-2022-end
        //17-08-2022-start
        field(53006; "Allow to update SO Unit Price"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        //17-08-2022-end

        //T13413-NS
        field(53007; "Show Blocked Variant Inventory"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        //T13413-NE

        // field(53400; "KZFEEdit Allowed for Memb."; Boolean)
        // {
        //     DataClassification = CustomerContent;
        //     Caption = 'Edit Allowed for Team Member Sales Budget';
        // }
        field(53420; "Allow to Delete"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Allow to Delete';
        }
        field(53430; "Allow to view Sales Price"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Allow to view Sales Price Detail';
        }

    }
    // procedure companytransfer(us_from: Record "User Setup")
    // var
    //     masterconfig: Record 50101;
    //     us_to: Record "User Setup";
    //     Text001: Label 'User %1 transfer to %2 Company';
    //     Text002: Label 'User %1 modified in %2 Company';

    // begin
    //     masterconfig.reset();
    //     masterconfig.SetRange(masterconfig."Transfer Customer", true);
    //     masterconfig.SetFilter(masterconfig."Company Name", '<>%1', CompanyName);
    //     if masterconfig.FindSet() then
    //         repeat
    //             us_to.ChangeCompany(masterconfig."Company Name");
    //             us_to.Reset();
    //             if not us_to.Get(us_from."User ID") then begin
    //                 us_to.Init();
    //                 us_to := us_from;
    //                 if us_to.Insert() then;
    //                 Message(Text001, us_from."User ID", masterconfig."Company Name");
    //             end
    //             else begin
    //                 us_to.TransferFields(us_from, false);
    //                 if us_to.Modify() then;
    //                 Message(Text002, us_to."User ID", masterconfig."Company Name");
    //             end;
    //         until masterconfig.Next() = 0;
    // end;
}
/*
                    us_to."Allow Posting From" := us_from."Allow Posting From";
                    us_to."Allow Posting To" := us_from."Allow Posting To";
                    us_to."Register Time" := us_from."Register Time";
                    us_to."Salespers./Purch. Code" := us_from."Salespers./Purch. Code";
                    us_to."Approver ID" := us_from."Approver ID";
                    us_to."Sales Amount Approval Limit" := us_from."Sales Amount Approval Limit";
                    us_to."Purchase Amount Approval Limit" := us_from."Purchase Amount Approval Limit";
                    us_to."Unlimited Sales Approval" := us_from."Unlimited Sales Approval";
                    us_to."Unlimited Purchase Approval" := us_from."Unlimited Purchase Approval";
                    us_to.Substitute := us_from.Substitute;
                    us_to."E-Mail" := us_from."E-Mail";
                    us_to."Phone No." := us_from."Phone No.";
                    us_to."Request Amount Approval Limit" := us_from."Request Amount Approval Limit";
                    us_to."Unlimited Request Approval" := us_from."Unlimited Request Approval";
                    us_to."Approval Administrator" := us_from."Approval Administrator";
                    us_to."License Type" := us_from."License Type";
                    us_to."Time Sheet Admin." := us_from."Time Sheet Admin.";
                    us_to."Allow FA Posting From" := us_from."Allow FA Posting From";
                    us_to."Allow FA Posting To" := us_from."Allow FA Posting To";
                    us_to."Sales Resp. Ctr. Filter" := us_from."Sales Resp. Ctr. Filter";
                    us_to."Purchase Resp. Ctr. Filter" := us_from."Purchase Resp. Ctr. Filter";
                    us_to."Service Resp. Ctr. Filter" := us_from."Service Resp. Ctr. Filter";
                    us_to."Allow Short Close" := us_from."Allow Short Close";
                    us_to."Document Reopen" := us_from."Document Reopen";
                    us_to."Allow Sales Unit of Measure" := us_from."Allow Sales Unit of Measure";
                    us_to."Allow Pre SI Creation" := us_from."Allow Pre SI Creation";
                    us_to."Allow SO LIne Reserve Modify" := us_from."Allow SO LIne Reserve Modify"; */
