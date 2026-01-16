report 80048 "CVM Vehicle Sales CRM overview"
//NOTE: CRM report  
{
    DefaultLayout = RDLC;
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    Caption = 'Vehicle sales CRM overview';
    RDLCLayout = './src/report/CVM_Layout_VehicleSalesCRMoverview.rdl';

    dataset
    {
        dataitem("Excel Buffer"; "Excel Buffer")
        {
            UseTemporary = true;
            column(V_LocationCode; V_LocationCode)
            {
            }
            column(Status; Status)
            {
            }
            column(meenemen; meenemen)
            {
            }
            column(V_Datum; V_Datum)
            {
            }
            column(V_Item; V_Item)
            {
            }
            column(V_RowNo; "Row No.")
            {
            }
            column(V_Titel; V_Titel)
            {
            }
            column(V_Omschrijving; V_Omschrijving)
            {
            }
            column(V_Type; V_Type)
            {
            }
            column(V_Verkoper; V_Verkoper)
            {
            }
            column(V_ContactNummer; V_ContactNummer)
            {
            }
            column(V_ContactNaam; V_ContactNaam)
            {
            }
            column(V_ContactPersoon; V_ContactPersoon)
            {
            }
            column(H_userName; H_userName)
            {
            }
            column(H_datumVan; H_datumVan)
            {
            }
            column(H_datumTot; H_datumTot)
            {
            }
            column(H_Verkoper; H_Verkoper)
            {
            }
            column(H_datumAfdruk; H_datumAfdruk)
            {
            }
            column(H_filter; H_filter)
            {
            }
            column(RP_ToonVerkoperRegel; RP_ToonVerkoperRegel)
            {
            }

            dataitem("Temporary Statistics"; "Temporary Statistics")
            {
                DataItemLink = "Code 01" = Field("Comment"), "Code 02" = Field("Cell Value as Text");
                UseTemporary = true;
                column(Line_LineNo; "Temporary Statistics"."Int 1")
                {
                }
                column(Line_Description; "Temporary Statistics"."Long Text 01")
                {
                }
            }

            trigger OnAfterGetRecord()
            begin

                meenemen := TRUE;
                CLEAR(Status);
                CLEAR(V_Titel);
                CLEAR(V_Omschrijving);
                CLEAR(V_Datum);
                CLEAR(V_Type);
                CLEAR(V_Verkoper);
                CLEAR(V_ContactNummer);
                CLEAR(V_ContactNaam);
                CLEAR(V_ContactPersoon);
                //NOTE: *** INTERACTION LOG ***
                IF ("Excel Buffer".Comment = 'Interaction') THEN BEGIN
                    G_InteractionLogEntry.RESET;
                    V_Item := "Excel Buffer".Comment;
                    G_InteractionLogEntry.SETFILTER("Entry No.", "Excel Buffer"."Cell Value as Text");
                    IF G_InteractionLogEntry.FIND('-') THEN BEGIN
                        V_Titel := G_InteractionLogEntry.Subject;
                        V_Omschrijving := G_InteractionLogEntry.Description;
                        IF (V_Titel = V_Omschrijving) THEN V_Titel := '';
                        V_Datum := G_InteractionLogEntry.Date;
                        V_Type := GetInteractionTemplate(G_InteractionLogEntry."Interaction Template Code");
                        V_Verkoper := GetUserName(G_InteractionLogEntry."User ID");
                        V_ContactNummer := GetCustVendNameNR(G_InteractionLogEntry."Contact No.", G_InteractionLogEntry."Contact Company No.", 'Nummer');
                        V_ContactNaam := GetCustVendNameNR(G_InteractionLogEntry."Contact No.", G_InteractionLogEntry."Contact Company No.", 'Naam');
                        V_ContactPersoon := GetCustVendNameNR(G_InteractionLogEntry."Contact No.", G_InteractionLogEntry."Contact Company No.", 'ContactPersoon');
                    END;
                END;
                //NOTE: *** INTERACTION LOG ***

                //NOTE: *** TASKS ***
                IF ("Excel Buffer".Comment = 'Task') THEN BEGIN
                    G_ToDo.RESET;
                    V_Item := "Excel Buffer".Comment;
                    G_ToDo.SETFILTER("No.", "Excel Buffer"."Cell Value as Text");
                    IF G_ToDo.FIND('-') THEN BEGIN
                        V_Titel := G_ToDo."To-Do Code";
                        V_Omschrijving := G_ToDo.Description;
                        IF (V_Titel = V_Omschrijving) THEN V_Titel := '';
                        V_Datum := G_ToDo.Date;
                        V_Type := GetToDoCode(G_ToDo."To-Do Code");
                        V_Verkoper := GetSalesPName(FORMAT(G_ToDo."Salespers./Purch. Code"));
                        V_ContactNummer := GetCustVendNameNR(G_ToDo."Contact No.", G_ToDo."Contact Company No.", 'Nummer');
                        V_ContactNaam := GetCustVendNameNR(G_ToDo."Contact No.", G_ToDo."Contact Company No.", 'Naam');
                        V_ContactPersoon := GetCustVendNameNR(G_ToDo."Contact No.", G_ToDo."Contact Company No.", 'ContactPersoon');
                    END;
                END;
                //NOTE: *** TASKS ***

                //NOTE: *** Vehicle quote ***
                IF ("Excel Buffer".Comment = 'Vehicle quote') THEN BEGIN
                    G_SalesHeader.RESET;
                    V_Item := "Excel Buffer".Comment;
                    G_SalesHeader.SETFILTER("No.", "Excel Buffer"."Cell Value as Text");
                    IF G_SalesHeader.FIND('-') THEN BEGIN
                        G_SalesLine.RESET;
                        G_SalesLine.SETRANGE("Document No.", G_SalesHeader."No.");
                        G_SalesLine.SETRANGE("Document Type", G_SalesHeader."Document Type");
                        G_SalesLine.SETRANGE(Type, G_SalesLine."Item Type"::Vehicle);
                        IF G_SalesLine.FIND('-') THEN BEGIN
                            V_Titel := G_SalesLine.Description;
                        END;
                        V_Omschrijving := '';
                        IF (V_Titel = V_Omschrijving) THEN V_Titel := '';
                        V_Datum := G_SalesHeader."Order Date";
                        V_Type := '';
                        V_Verkoper := GetSalesPName(FORMAT(G_SalesHeader."Salesperson Code"));
                        V_ContactNummer := GetCustVendNameNR(G_SalesHeader."Bill-to Contact No.", G_SalesHeader."Bill-to Contact No.", 'Nummer');
                        V_ContactNaam := GetCustVendNameNR(G_SalesHeader."Bill-to Contact No.", G_SalesHeader."Bill-to Contact No.", 'Naam');
                        V_ContactPersoon := GetCustVendNameNR(G_SalesHeader."Bill-to Contact No.", G_SalesHeader."Bill-to Contact No.", 'ContactPersoon');
                    END;
                END;
                //NOTE: *** Vehicle quote ***
            end;

            trigger OnPreDataItem()
            begin
                "Excel Buffer".DELETEALL;
                regelnummer := 0;


                IF (STRLEN(FORMAT(RP_DatumVan)) > 0) THEN
                    H_datumVan := FORMAT(RP_DatumVan)
                ELSE
                    H_datumVan := 'leeg';
                IF (STRLEN(FORMAT(RP_DatumTot)) > 0) THEN
                    H_datumTot := FORMAT(RP_DatumTot)
                ELSE
                    H_datumTot := 'leeg';
                IF (STRLEN(RP_Verkoper) > 0) THEN
                    H_Verkoper := FORMAT(RP_Verkoper)
                ELSE
                    H_Verkoper := 'leeg';
                H_datumAfdruk := FORMAT(TODAY);
                H_filter := ' | Filter: ' + H_datumVan + ' tot ' + H_datumTot;
                IF H_Verkoper <> 'leeg' THEN H_filter += ' VerkoperCode:' + H_Verkoper;


                //NOTE: *** INTERACTION LOG [User ID]***
                IF (STRLEN(RP_Verkoper) > 0) THEN BEGIN
                    CLEAR(H_UserNameSalesperon);
                    G_UserSetup.RESET;
                    G_UserSetup.SETRANGE(G_UserSetup."Salespers./Purch. Code", RP_Verkoper);
                    IF G_UserSetup.FIND('-') THEN BEGIN
                        H_UserNameSalesperon := G_UserSetup."User ID";
                    END;
                END;

                G_InteractionLogEntry.RESET;
                G_InteractionLogEntry.SETRANGE(Date, RP_DatumVan, RP_DatumTot);
                IF (STRLEN(H_UserNameSalesperon) > 0) THEN BEGIN
                    G_InteractionLogEntry.SETFILTER("User ID", H_UserNameSalesperon);
                END;
                G_InteractionLogEntry.SETFILTER(Canceled, '0');
                IF G_InteractionLogEntry.FINDSET THEN
                    REPEAT
                        "Excel Buffer".INIT;
                        "Excel Buffer"."Row No." := regelnummer;
                        "Excel Buffer"."Cell Value as Text" := FORMAT(G_InteractionLogEntry."Entry No.");
                        "Excel Buffer".Comment := 'Interaction';
                        "Excel Buffer".INSERT(FALSE);

                        G_InterLogEntryCommentLine.RESET;
                        G_InterLogEntryCommentLine.SETRANGE("Entry No.", G_InteractionLogEntry."Entry No.");
                        IF G_InterLogEntryCommentLine.FINDSET THEN begin
                            repeat
                                "Temporary Statistics".INIT;
                                "Temporary Statistics"."Entry No." := (regelnummer * 1000000) + G_InterLogEntryCommentLine."Line No.";
                                "Temporary Statistics"."Code 01" := 'Interaction';
                                "Temporary Statistics"."Code 02" := FORMAT(G_InterLogEntryCommentLine."Entry No.");
                                "Temporary Statistics"."Int 1" := G_InterLogEntryCommentLine."Line No.";
                                "Temporary Statistics"."Long Text 01" := G_InterLogEntryCommentLine."Comment";
                                "Temporary Statistics".INSERT;
                            until G_InterLogEntryCommentLine.Next = 0;
                        end;
                        regelnummer += 1;
                    UNTIL G_InteractionLogEntry.NEXT = 0;
                //NOTE: *** INTERACTION LOG [Salesperson Code]***


                //NOTE: *** TASKS ***
                G_ToDo.RESET;
                IF (STRLEN(RP_Verkoper) > 0) THEN BEGIN
                    G_ToDo.SETFILTER("Salespers./Purch. Code", RP_Verkoper);
                end else begin
                    G_ToDo.SETFILTER("Salespers./Purch. Code", '<>%1', '');
                END;
                G_ToDo.SETFILTER(Canceled, '0');
                G_ToDo.SETFILTER("System To-do Type", '0');
                IF G_ToDo.FINDSET THEN
                    REPEAT
                        IF (G_ToDo.Date <= RP_DatumTot) AND (G_ToDo."Ending Date" >= RP_DatumVan) AND (STRLEN(G_ToDo."Contact No.") > 0) THEN BEGIN
                            "Excel Buffer".INIT;
                            "Excel Buffer"."Row No." := regelnummer;
                            "Excel Buffer"."Cell Value as Text" := FORMAT(G_ToDo."No.");
                            "Excel Buffer".Comment := 'Task';
                            "Excel Buffer".INSERT(FALSE);
                            regelnummer += 1;
                        END;
                    UNTIL G_ToDo.NEXT = 0;
                //NOTE: *** TASKS ***

                //NOTE: *** Vehicle quote ***
                G_SalesHeader.RESET;
                IF (STRLEN(RP_Verkoper) > 0) THEN BEGIN
                    G_SalesHeader.SETFILTER("Salesperson Code", RP_Verkoper);
                END;
                G_SalesHeader.SETRANGE("Document Type", G_SalesHeader."Document Type"::Quote);
                G_SalesHeader.SETRANGE("Order Type", G_SalesHeader."Order Type"::"Vehicle Sales & Purchases");
                IF G_SalesHeader.FINDSET THEN
                    REPEAT
                        "Excel Buffer".INIT;
                        "Excel Buffer"."Row No." := regelnummer;
                        "Excel Buffer"."Cell Value as Text" := FORMAT(G_SalesHeader."No.");
                        "Excel Buffer".Comment := 'Vehicle quote';
                        "Excel Buffer".INSERT(FALSE);
                        regelnummer += 1;
                    UNTIL G_SalesHeader.NEXT = 0;
                //NOTE: *** Vehicle quote ***

            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(Selectie)
                {
                    Caption = 'Selection';
                    field(RP_DatumVan; RP_DatumVan)
                    {
                        Caption = 'Date From';
                        //DateFormula = true;
                    }
                    field(RP_DatumTot; RP_DatumTot)
                    {
                        Caption = 'Date To';
                    }
                    field(RP_Verkoper; RP_Verkoper)
                    {
                        Caption = 'Salesperson';
                        TableRelation = "Salesperson/Purchaser";
                    }
                    field(RP_ToonVerkoperRegel; RP_ToonVerkoperRegel)
                    {
                        Caption = 'Split per salesperson';
                    }
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnInitReport()
    begin
        RP_DatumVan := CALCDATE('-2W', TODAY());
        RP_DatumTot := CALCDATE('+2W', TODAY());
        //H_userName := G_userSession."User ID";
        G_UserSetup.RESET;
        G_UserSetup.SETRANGE("User ID", USERID);
        IF G_UserSetup.FIND('-') THEN BEGIN
            RP_Verkoper := G_UserSetup."Salespers./Purch. Code";
        END;
        RP_ToonVerkoperRegel := True;
    end;

    var
        RP_DatumVan: Date;
        RP_DatumTot: Date;
        RP_Verkoper: Code[10];
        RP_ToonVerkoperRegel: Boolean;
        regelnummer: Integer;
        V_LocationCode: Text;
        Status: Text;
        meenemen: Boolean;
        G_InteractionLogEntry: Record "Interaction Log Entry";
        G_InterLogEntryCommentLine: Record "Inter. Log Entry Comment Line";
        V_Datum: Date;
        V_Item: Text;
        V_Type: Text;
        V_Titel: Text;
        V_Omschrijving: Text;
        V_Verkoper: Text;
        V_ContactNaam: Text;
        V_ContactNummer: Text;
        V_ContactPersoon: Text;
        G_ToDo: Record "To-Do";
        G_TempContact: Record "Contact";
        G_Salesperson: Record "Salesperson/Purchaser";
        G_ToDoCode: Record "To-Do Code";
        G_InteractionTemplate: Record "Interaction Template";
        H_userName: Text;
        H_UserNameSalesperon: Text;
        H_datumVan: Text;
        H_datumTot: Text;
        H_Verkoper: Text;
        H_datumAfdruk: Text;
        H_filter: Text;
        G_userSession: Record "User Session";
        G_UserSetup: Record "User Setup";
        G_User: Record "User";
        G_SalesHeader: Record "Sales Header";
        G_SalesLine: Record "Sales Line";

    //[Scope('Internal')]
    procedure GetSalesPName(Nummer: Text) Naam: Text
    begin
        G_Salesperson.RESET;
        IF (Nummer <> '') THEN BEGIN
            G_Salesperson.SETFILTER(Code, Nummer);
            IF G_Salesperson.FIND('-') THEN BEGIN
                Naam := G_Salesperson.Name;
            END;
        END
        ELSE BEGIN
            Naam := '';
        END;
        EXIT
    end;

    //[Scope('Internal')]
    procedure GetUserName(UserID: Text) FullName: Text
    begin
        G_User.RESET;
        IF (UserID <> '') THEN BEGIN
            G_User.SETFILTER("User Name", UserID);
            IF G_User.FIND('-') THEN BEGIN
                FullName := G_User."Full Name";
            END;
        END
        ELSE BEGIN
            FullName := '';
        END;
        EXIT
    end;

    //[Scope('Internal')]
    procedure GetCustVendNameNR("Contact No_": Text; "Contact Company No_": Text; Veld: Text) Contact: Text
    begin
        G_TempContact.RESET;
        G_TempContact.SETFILTER("No.", "Contact Company No_");
        Contact := '';

        IF G_TempContact.FIND('-') THEN BEGIN
            IF (Veld = 'Nummer') THEN BEGIN
                IF STRLEN(G_TempContact."Customer No.") > 0 THEN Contact += G_TempContact."Customer No.";
                IF ((STRLEN(Contact) > 0) AND (STRLEN(G_TempContact."Vendor No.") > 0)) THEN Contact += '/';
                Contact += G_TempContact."Vendor No.";
            END
            ELSE
                IF (Veld = 'Naam') THEN BEGIN
                    Contact := G_TempContact.Name;
                END;
        END;
        IF (Veld = 'ContactPersoon') THEN BEGIN
            IF ("Contact No_" <> "Contact Company No_") THEN BEGIN
                G_TempContact.RESET;
                G_TempContact.SETFILTER("No.", "Contact No_");
                IF G_TempContact.FIND('-') THEN Contact := G_TempContact.Name;
            END;
        END;

        EXIT
    end;

    //[Scope('Internal')]
    procedure GetToDoCode("Code": Text) Description: Text
    begin
        G_ToDoCode.RESET;
        Description := '';
        G_ToDoCode.SETFILTER("Code", Code);
        IF G_ToDoCode.FINDFIRST THEN BEGIN
            Description := G_ToDoCode.Description;
        END;
        EXIT
    end;

    //[Scope('Internal')]
    procedure GetInteractionTemplate("code": Text) description: Text
    begin
        G_InteractionTemplate.RESET;
        description := '';
        G_InteractionTemplate.SETFILTER(Code, code);
        IF G_InteractionTemplate.FIND('-') THEN BEGIN
            description := G_InteractionTemplate.Description;
        END;
        EXIT
    end;
}

