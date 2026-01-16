report 80045 "DPG LenGo Veh. Srv. Camp List"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/Report/LenGoVehSrvCampList.rdlc';

    dataset
    {
        dataitem(Vehicle; Vehicle)
        {
            column(V_VIN; Vehicle.VIN)
            {
            }
            column(V_LicenseNo; Vehicle."License No.")
            {
            }
            column(V_MakeCode; Vehicle."Make Code")
            {
            }
            column(V_Model; Vehicle.Model)
            {
            }
            column(V_LocationCode; Vehicle."Location Code")
            {
            }
            column(C_No; C_No)
            {
            }
            column(C_Name; C_Name)
            {
            }
            column(RP_alleenGereed; RP_alleenGereed)
            {
            }
            dataitem("Serv. Campaign-Affected Veh."; "Serv. Campaign-Affected Veh.")
            {
                DataItemLink = VIN = FIELD(VIN);
                column(CAM_MakeCode; "Serv. Campaign-Affected Veh."."Make Code")
                {
                }
                column(CAM_No; "Serv. Campaign-Affected Veh."."Serv. Campaign No.")
                {
                }
                column(CAM_Description; CAM_Description)
                {
                }
                column(CAM_Description2; CAM_Description2)
                {
                }
                column(CAM_Status; CAM_Status)
                {
                }
                column(CAM_Uitgevoerd; CAM_Uitgevoerd)
                {
                }
                column(CAM_Datum; CAM_Datum)
                {
                }
                column(CAM_Document; CAM_Document)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    IF G_Service_Campaign.GET("Make Code", "Serv. Campaign No.") THEN BEGIN
                        CAM_Description := G_Service_Campaign.Description;
                        CAM_Description2 := G_Service_Campaign."Description 2";
                    END;

                    CAM_Status := 'Niet uitgevoerd';
                    CAM_Uitgevoerd := FALSE;
                    CAM_Datum := 0D;
                    CAM_Document := '';
                    G_Vehicle_Ledger_Entry.RESET;
                    G_Vehicle_Ledger_Entry.SETRANGE(VIN, VIN);
                    G_Vehicle_Ledger_Entry.SETRANGE("Serv. Campaign No.", "Serv. Campaign No.");
                    IF G_Vehicle_Ledger_Entry.FIND('-') THEN BEGIN
                        CAM_Status := 'Uitgevoerd';
                        CAM_Uitgevoerd := TRUE;
                        CAM_Datum := G_Vehicle_Ledger_Entry."Posting Date";
                        CAM_Document := G_Vehicle_Ledger_Entry."Document No.";
                    END ELSE BEGIN
                        IF (Completed = TRUE) AND (STRLEN("Service Order") = 0) THEN BEGIN
                            CAM_Status := 'Uitgevoerd manueel';
                            CAM_Uitgevoerd := TRUE;
                        END;
                        IF (Completed = TRUE) AND (STRLEN("Service Order") > 0) THEN BEGIN
                            CAM_Status := 'In behandeling';
                            CAM_Document := "Service Order";
                        END;
                    END;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                IF G_Customer.GET("Customer No.") THEN BEGIN
                    C_No := G_Customer."No.";
                    C_Name := G_Customer.Name;
                END;
            end;

            trigger OnPreDataItem()
            begin
                Vehicle.RESET;
                Vehicle.SETRANGE(Blocked, FALSE);

                IF STRLEN(RP_Locatie) > 0 THEN BEGIN
                    IF G_Location.GET(RP_Locatie) THEN BEGIN
                        Vehicle.SETRANGE("Location Code", RP_Locatie);
                    END ELSE BEGIN
                        MESSAGE('De gekozen vestiging bestaat niet');
                    END;
                END;

                IF STRLEN(RP_klant) > 0 THEN BEGIN
                    IF G_Customer.GET(RP_klant) THEN BEGIN
                        Vehicle.SETRANGE("Customer No.", RP_klant);
                    END ELSE BEGIN
                        MESSAGE('De gekozen klant bestaat niet');
                    END;
                END;
                Vehicle.SETCURRENTKEY("Customer No.", VIN);
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(Control1000000001)
                {
                    ShowCaption = false;
                    field(RP_alleenGereed; RP_alleenGereed)
                    {
                        Caption = 'Alleen nog uit te voeren';
                    }
                    field(RP_locatie; RP_Locatie)
                    {
                        Caption = 'Vestiging';
                    }
                    field(RP_klant; RP_klant)
                    {
                        Caption = 'Klantnummer';
                    }
                }
            }
        }

        actions
        {
        }

        trigger OnInit()
        begin
            RP_alleenGereed := TRUE;
        end;
    }

    labels
    {
    }

    var
        RP_alleenGereed: Boolean;
        RP_Locatie: Text;
        RP_klant: Text;
        G_Location: Record Location;
        G_Customer: Record Customer;
        G_Service_Campaign: Record "Service Campaign";
        G_Vehicle_Ledger_Entry: Record "Vehicle Ledger Entry";
        C_No: Text;
        C_Name: Text;
        CAM_Description: Text;
        CAM_Description2: Text;
        CAM_Status: Text;
        CAM_Uitgevoerd: Boolean;
        CAM_Datum: Date;
        CAM_Document: Text;
}

