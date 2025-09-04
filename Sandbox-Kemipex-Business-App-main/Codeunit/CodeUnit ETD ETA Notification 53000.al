codeunit 53000 "ETD ETA Notification"//T12370-Full Comment
{
    Permissions = tabledata "Item Ledger Entry" = RIMD;
    [EventSubscriber(ObjectType::Table, Database::"Sales Invoice Header", 'OnAfterValidateEvent', 'BillOfExit', true, true)]
    local procedure fnUpdateBillOfExitonILE(var Rec: Record "Sales Invoice Header"; var xRec: Record "Sales Invoice Header"; CurrFieldNo: Integer)
    var
        SalesInvLine: Record "Sales Invoice Line";
        ILE: Record "Item Ledger Entry";
    begin
        SalesInvLine.Reset();
        SalesInvLine.SetRange("Document No.", Rec."No.");
        if SalesInvLine.FindSet() then
            repeat
                ILE.Reset();
                ILE.SetCurrentKey("Document No.", "Document Line No.");
                ile.SetRange("Document No.", SalesInvLine."Shipment No.");
                ILE.SetRange("Document Line No.", SalesInvLine."Shipment Line No.");
                //ILE.ModifyAll("Document Type", Rec."Declaration Type", false);//05-11-2022
                //ILE.ModifyAll(BillOfExit, Rec.BillOfExit, false);//05-11-2022
                //05-11-2022-start
                if ILE.FindSet() then begin
                    repeat
#Pragma warning disable AL0603
                        ILE."Document Type" := Rec."Declaration Type";
#Pragma warning disable AL0603
                        ILE.BillOfExit := Rec.BillOfExit;
                        ILE.Modify();
                    until ILE.Next() = 0;
                end;
            //05-11-2022-end
            until SalesInvLine.Next() = 0;
    end;

    procedure fnSendETDnotifications(var SalesInvHdr: Record "Sales Invoice Header"; PrevETD: Date)
    var
        EmailMessage: Codeunit "Email Message";
        Email: Codeunit Email;
        Recipients: List of [Text];
        Subject: Text;
        Body: Text;
        SalesPostedTitle: Label 'ETD Change Notification Email - Invoice No. %1';
        SalesPostedMsg: Label 'Hello,<br><br>You are registered to receive notifications related to %1.<br><br>This is a message to notify you that:<br><br>ETD : %2 in Invoice No. %3 is changed to %4.<br>Bill of Lading No.: %5<br>Carrier Name: %6<br><br>Date-Time Sent of notification - %7.';
        SendUser: Record User;
        SalesSetup: Record "Sales & Receivables Setup";
        SP: Record "Salesperson/Purchaser";
    begin
        SalesSetup.Get();
        SalesSetup.TestField("Sales Support Email");
        if sp.Get(SalesInvHdr."Salesperson Code") then;
        Recipients.Add(SP."E-Mail");
        Recipients.Add(SalesSetup."Sales Support Email");
        Subject := StrSubstNo(SalesPostedTitle, SalesInvHdr."No.");
        // Body := StrSubstNo(SalesPostedMsg, SalesInvHdr."No.", format(PrevETD), SalesInvHdr."No.", format(SalesInvHdr.ETD), format(SalesInvHdr."Bill of Lading No."), format(SalesInvHdr."Carrier Name"), CurrentDateTime);
        Body := CreateEmailBody(SalesInvHdr, PrevETD, 'ETD');//07-11-2022
        EmailMessage.Create(Recipients, Subject, Body, true);
        // Email.Send(EmailMessage, Enum::"Email Scenario"::Default);//27-06-2022
        Email.Enqueue(EmailMessage, Enum::"Email Scenario"::Default);//27-06-2022
    end;

    procedure fnSendETAnotifications(var SalesInvHdr: Record "Sales Invoice Header"; PrevETA: Date)
    var
        EmailMessage: Codeunit "Email Message";
        Email: Codeunit Email;
        Recipients: List of [Text];
        Subject: Text;
        Body: Text;
        SalesPostedTitle: Label 'ETA Change Notification Email - Invoice No. %1';
        SalesPostedMsg: Label 'Hello,<br><br>You are registered to receive notifications related to %1.<br><br>This is a message to notify you that:<br><br>ETA : %2 in Invoice No. %3 is changed to %4.<br>Bill of Lading No.: %5<br>Carrier Name: %6<br><br>Date-Time Sent of notification - %7.';
        SendUser: Record User;
        SalesSetup: Record "Sales & Receivables Setup";
        SP: Record "Salesperson/Purchaser";
    begin
        SalesSetup.Get();
        SalesSetup.TestField("Sales Support Email");
        if sp.Get(SalesInvHdr."Salesperson Code") then;
        Recipients.Add(SP."E-Mail");
        Recipients.Add(SalesSetup."Sales Support Email");
        Subject := StrSubstNo(SalesPostedTitle, SalesInvHdr."No.");
        // Body := StrSubstNo(SalesPostedMsg, SalesInvHdr."No.", format(PrevETA), SalesInvHdr."No.", format(SalesInvHdr.ETA), format(SalesInvHdr."Bill of Lading No."), format(SalesInvHdr."Carrier Name"), CurrentDateTime);
        Body := CreateEmailBody(SalesInvHdr, PrevETA, 'ETA');//07-11-2022
        EmailMessage.Create(Recipients, Subject, Body, true);
        // Email.Send(EmailMessage, Enum::"Email Scenario"::Default);//27-06-2022
        Email.Enqueue(EmailMessage, Enum::"Email Scenario"::Default);//27-06-2022
    end;


    local procedure CreateEmailBody(Var RecSIHdr: Record "Sales Invoice Header"; PrevETA: Date; ETDORETA: Text): Text
    var
        BodyText: TextBuilder;
        RecCustomer: Record Customer;
        PageId, J : Integer;
        GLSetup: Record "General Ledger Setup";
        RecPaymentTerms: Record "Payment Terms";
        Recteams: Record Team;
        RecteamSalesPerson: Record "Team Salesperson";
        RecSalesperson: Record "Salesperson/Purchaser";
        RecItem: Record Item;
        TotalAmt, TotalQty, AvailableLimit, UsedLimit, OverDueHistory : Decimal;
        ShortName: Record "Company Short Name";
        PaymentTermsText, ColorText : Text;
        UOMCheck: List of [Text];
        RecLines: Record "Sales Invoice Line";
        RecLines2: Record "Sales Invoice Line";
        RecAre: Record "Area";
        RecEntryExit: Record "Entry/Exit Point";
        TestText: Text;
    begin
        ShortName.GET(CompanyName);
        Clear(RecCustomer);
        RecCustomer.GET(RecSIHdr."Sell-to Customer No.");
        Clear(BodyText);
        BodyText.Append('<style>table { border-collapse: collapse; border: 1px solid black;} table.a { table-layout: auto;  width: 560px; } table.b { table-layout: auto;  width: 300px; } </style>');

        BodyText.Append('Hello, <br><br>You are registered to receive notifications related to Kemipex FZE.');

        if ETDORETA = 'ETA' then
            BodyText.Append('<br><br>This is a message to notify you that:<br><br>' + ETDORETA + ' : ' + Format(PrevETA) + ' in Invoice No. ' + RecSIHdr."No." + ' is changed to ' + FORMAT(RecSIHdr.ETA) + '.')
        else
            BodyText.Append('<br><br>This is a message to notify you that:<br><br>' + ETDORETA + ' : ' + Format(PrevETA) + ' in Invoice No. ' + RecSIHdr."No." + ' is changed to ' + FORMAT(RecSIHdr.ETD) + '.');


        BodyText.Append('<br><br>');

        TestText := RecSIHdr."No." + ' - ' + ShortName."Short Name";
        BodyText.Append('<table class="a">');
        BodyText.Append('<tr>');
        BodyText.Append('<td align="left" Style="padding-left:5px"> <font> Invoice No. </font></td>');
        BodyText.Append('<td align="left"> <font> ' + TestText + '</font></td>');
        BodyText.Append('</tr>');
        BodyText.Append('<tr>');
        BodyText.Append('<td align="left" Style="padding-left:5px"> <font> Customer Name/No. </font></td>');
        if RecCustomer."Search Name" <> '' then
            BodyText.Append('<td align="left"> <font> <b>' + RecCustomer."Search Name" + ' - ' + RecSIHdr."Sell-to Customer No." + '</b> </font></td>')
        else
            BodyText.Append('<td align="left"> <font> <b>' + RecCustomer."Search Name" + ' - ' + RecSIHdr."Sell-to Customer No." + '</b> </font></td>');

        BodyText.Append('</tr>');

        Clear(RecLines);
        RecLines.SetRange("Document No.", RecSIHdr."No.");
        RecLines.SetFilter("Blanket Order No.", '<>%1', '');
        if RecLines.FindFirst() then begin
            BodyText.Append('<tr>');
            BodyText.Append('<td align="left" Style="padding-left:5px"> <font> Blanket Sales Order No. </font></td>');
            BodyText.Append('<td align="left"> <font> ' + RecLines."Blanket Order No." + '</font></td>');
            BodyText.Append('</tr>');
        end;
        if RecSIHdr."Order No." <> '' then begin
            BodyText.Append('<tr>');
            BodyText.Append('<td align="left" Style="padding-left:5px"> <font> Sales Order No. </font></td>');
            BodyText.Append('<td align="left"> <font> ' + RecSIHdr."Order No." + '</font></td>');
            BodyText.Append('</tr>');
        end;
        if RecSIHdr."Salesperson Code" <> '' then begin
            RecSalesperson.GET(RecSIHdr."Salesperson Code");
            BodyText.Append('<tr>');
            BodyText.Append('<td align="left" Style="padding-left:5px"> <font> Sales Person: </font></td>');
            Clear(RecteamSalesPerson);
            RecteamSalesPerson.SetRange("Salesperson Code", RecSIHdr."Salesperson Code");
            if RecteamSalesPerson.FindFirst() then begin
                Clear(Recteams);
                if Recteams.GET(RecteamSalesPerson."Team Code") then
                    BodyText.Append('<td align="left" > <font> ' + RecSalesperson."Name" + ' / ' + Recteams.Name + ' </font></td>')
                else
                    BodyText.Append('<td align="left"> <font> ' + RecSalesperson."Name" + ' </font></td>');
            end else
                BodyText.Append('<td align="left"> <font> ' + RecSalesperson."Name" + ' </font></td>');
            BodyText.Append('</tr>');
        end;

        BodyText.Append('<tr>');
        BodyText.Append('<td align="left" Style="padding-left:5px"> <font> Customer Ref. No. </font></td>');
        BodyText.Append('<td align="left"> <font> ' + RecSIHdr."External Document No." + '</font></td>');
        BodyText.Append('</tr>');
        if RecSIHdr."Exit Point" <> '' then begin
            Clear(RecEntryExit);
            RecEntryExit.GET(RecSIHdr."Exit Point");
            BodyText.Append('<tr>');
            BodyText.Append('<td align="left" Style="padding-left:5px"> <font> Port of Loading </font></td>');
            BodyText.Append('<td align="left"> <font> ' + RecEntryExit.Description + '</font></td>');
            BodyText.Append('</tr>');
        end;

        if RecSIHdr."Area" <> '' then begin
            Clear(RecAre);
            RecAre.GET(RecSIHdr."Area");
            BodyText.Append('<tr>');
            BodyText.Append('<td align="left" Style="padding-left:5px"> <font> Port of Discharge </font></td>');
            BodyText.Append('<td align="left"> <font> ' + RecAre."Text" + '</font></td>');
            BodyText.Append('</tr>');
        end;

        BodyText.Append('<tr>');
        BodyText.Append('<td align="left" Style="padding-left:5px"> <font> ETD </font></td>');
        BodyText.Append('<td align="left"> <font> ' + FORMAT(RecSIHdr.ETD) + '</font></td>');
        BodyText.Append('</tr>');
        BodyText.Append('<tr>');
        BodyText.Append('<td align="left" Style="padding-left:5px"> <font> ETA </font></td>');
        BodyText.Append('<td align="left"> <font> ' + FORMAT(RecSIHdr.ETA) + '</font></td>');
        BodyText.Append('</tr>');
        BodyText.Append('<tr>');
        BodyText.Append('<td align="left" Style="padding-left:5px"> <font> Carrier Name </font></td>');
        BodyText.Append('<td align="left"> <font> ' + FORMAT(RecSIHdr."Carrier Name") + '</font></td>');
        BodyText.Append('</tr>');
        BodyText.Append('<tr>');
        BodyText.Append('<td align="left" Style="padding-left:5px"> <font> Bill of Lading </font></td>');
        BodyText.Append('<td align="left"> <font> ' + FORMAT(RecSIHdr."Bill of Lading No.") + '</font></td>');
        BodyText.Append('</tr>');
        //Date-Time Sent of notification
        BodyText.Append('<tr>');
        BodyText.Append('<td align="left" Style="padding-left:5px"> <font> Date-Time Sent of notification </font></td>');
        BodyText.Append('<td align="left"> <font> ' + FORMAT(CurrentDateTime) + '</font></td>');
        BodyText.Append('</tr>');
        BodyText.Append('</table>');
        BodyText.Append('<br>');

        Clear(RecLines);
        RecLines.SetCurrentKey("Line No.");
        RecLines.SetAscending("Line No.", true);
        RecLines.SetRange("Document No.", RecSIHdr."No.");
        RecLines.SetRange(Type, RecLines.Type::Item);
        if RecLines.FindSet() then begin
            BodyText.Append('<table class="b">');
            Clear(TotalAmt);
            Clear(TotalQty);
            BodyText.Append('<tr>');
            BodyText.Append('<td align="left" Style="width:180px;padding-left:5px"> <font> Product Name </font></td>');
            BodyText.Append('<td align="right" Style="width:110px;padding-right:5px"> <font> Quantity </font></td>');
            BodyText.Append('</tr>');
            repeat

                BodyText.Append('<tr>');
                RecItem.GET(RecLines."No.");
                BodyText.Append('<td align="left" Style="padding-left:5px"> <font> ' + RecItem."Search Description" + ' </font></td>');//, 0, '<Precision,2:2><Standard Format,0>'
                BodyText.Append('<td align="right" Style="padding-right:5px"> <font> ' + RecLines."Base UOM 2" + ' ' + FORMAT(RecLines."Quantity (Base)", 0, '<Precision,3:3><Standard Format,0>') + ' </font></td>');

                TotalQty += RecLines."Quantity (Base)";
                BodyText.Append('</tr>');
            until RecLines.Next() = 0;


            //added to show total for each UOM -start
            J := 1;
            Clear(UOMCheck);
            Clear(RecLines);
            RecLines.SetCurrentKey("Line No.");
            RecLines.SetAscending("Line No.", true);
            RecLines.SetRange("Document No.", RecSIHdr."No.");
            RecLines.SetRange(Type, RecLines.Type::Item);
            if RecLines.FindSet() then begin
                repeat
                    if not UOMCheck.Contains(RecLines."Base UOM 2") then begin
                        UOMCheck.Add(RecLines."Base UOM 2");

                        Clear(RecLines2);
                        RecLines2.SetCurrentKey("Line No.");
                        RecLines2.SetAscending("Line No.", true);
                        RecLines2.SetRange("Document No.", RecSIHdr."No.");
                        RecLines2.SetRange(Type, RecLines2.Type::Item);
                        RecLines2.SetRange("Base UOM 2", RecLines."Base UOM 2");
                        if RecLines2.FindSet() then begin
                            RecLines2.CalcSums("Quantity (Base)");
                            BodyText.Append('<tr>');
                            if J = 1 then
                                BodyText.Append('<td align="left" Style="padding-left:5px"> <font> <b>TOTAL</b> </font></td>')
                            else
                                BodyText.Append('<td align="left"></td>');

                            BodyText.Append('<td align="right"> <font> <b>' + RecLines."Base UOM 2" + ' ' + FORMAT(RecLines2."Quantity (Base)", 0, '<Precision,3:3><Standard Format,0>') + '</b> </font></td>');

                            J += 1;
                        end;
                    end;
                Until RecLines.Next() = 0;
            end;
            //-end
            BodyText.Append('</table>');
            BodyText.Append('<br>');
        end;


        PageId := Page::"Posted Sales Invoice";

        BodyText.Append('<br>');
        BodyText.Append(StrSubstNo('<p> <a href="%1">Open document in Business Central</a> </p>', GetUrl(ClientType::Web, CompanyName, ObjectType::Page, PageId, RecSIHdr, False)));

        exit(BodyText.ToText());
    end;


}