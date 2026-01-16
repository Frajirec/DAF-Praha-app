report 80044 "DPG LenGo Veh. Srv.Camp Letter"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/Report/LenGoVehSrvCampLetter.rdlc';

    dataset
    {
        dataitem("Serv. Campaign-Affected Veh."; "Serv. Campaign-Affected Veh.")
        {
            DataItemTableView = WHERE(Completed = CONST(false));
            RequestFilterFields = "Make Code", "Serv. Campaign No.";
            column(CAM_MakeCode; "Serv. Campaign-Affected Veh."."Make Code")
            {
            }
            column(CAM_No; "Serv. Campaign-Affected Veh."."Serv. Campaign No.")
            {
            }
            column(CAM_Description; CAM_Description)
            {
            }
            column(CAM_Uitgevoerd; CAM_Uitgevoerd)
            {
            }
            dataitem(Vehicle; Vehicle)
            {
                DataItemLink = VIN = FIELD(VIN);
                column(V_Location_Code; V_Location_Code)
                {
                }
                column(L_Name; L_Name)
                {
                }
                column(L_Address; L_Address)
                {
                }
                column(L_PostCode; L_PostCode)
                {
                }
                column(L_City; L_City)
                {
                }
                column(L_Telephone; L_Telephone)
                {
                }
                column(L_EMail; L_EMail)
                {
                }
                column(L_Logo; Kop_Vestiging_Logo)
                {
                }
                column(V_VIN; Vehicle.VIN)
                {
                }
                column(V_LicenseNo; Vehicle."License No.")
                {
                }
                column(V_MakeCode; Vehicle."Make Code")
                {
                }
                dataitem(Customer; Customer)
                {
                    DataItemLink = "No." = FIELD("Customer No.");
                    column(C_No; Customer."No.")
                    {
                    }
                    column(C_Name; Customer.Name)
                    {
                    }
                    column(C_Address; Customer.Address)
                    {
                    }
                    column(C_PostCode; Customer."Post Code")
                    {
                    }
                    column(C_City; Customer.City)
                    {
                    }
                    column(C_Country; C_Country)
                    {
                    }
                    column(C_BevatCampagnes; C_BevatCampagnes)
                    {
                    }
                }

                trigger OnAfterGetRecord()
                begin




                    V_Location_Code := Vehicle."Location Code";
                    IF STRLEN(V_Location_Code) = 0 THEN BEGIN
                        V_Location_Code := '01';
                    END;

                    IF G_Location.GET(V_Location_Code) THEN BEGIN
                        L_Name := G_Location.Name;
                    END;



                    CASE V_Location_Code OF
                        '07', '08', '09':
                            BEGIN
                                Kop_Vestiging_Logo := 'Logo_VanHooft';
                            END;
                        '60':
                            BEGIN
                                Kop_Vestiging_Logo := 'Logo_MarcoLennardsEindhoven';
                            END;
                        '61':
                            BEGIN
                                Kop_Vestiging_Logo := 'Logo_LennardsBeheer';
                            END;
                        '62':
                            BEGIN
                                Kop_Vestiging_Logo := 'Logo_Hakama';
                            END;
                        '63':
                            BEGIN
                                Kop_Vestiging_Logo := 'Logo_APG';
                            END;
                        '64':
                            BEGIN
                                Kop_Vestiging_Logo := 'Logo_Kacasi';
                            END;
                        '65':
                            BEGIN
                                Kop_Vestiging_Logo := 'Logo_LenGoNederland';
                            END;
                        '66':
                            BEGIN
                                Kop_Vestiging_Logo := 'Logo_LenGoEast';
                            END;

                        ELSE BEGIN
                                Kop_Vestiging_Logo := 'Logo_DeBurgh';
                            END;
                    END;
                end;
            }

            trigger OnAfterGetRecord()
            begin

                IF G_Service_Campaign.GET("Serv. Campaign-Affected Veh."."Make Code", "Serv. Campaign-Affected Veh."."Serv. Campaign No.") THEN BEGIN
                    CAM_Description := G_Service_Campaign.Description;
                END;

                CAM_Uitgevoerd := FALSE;
                G_Vehicle_Ledger_Entry.RESET;
                G_Vehicle_Ledger_Entry.SETRANGE(VIN, "Serv. Campaign-Affected Veh.".VIN);
                G_Vehicle_Ledger_Entry.SETRANGE("Serv. Campaign No.", "Serv. Campaign-Affected Veh."."Serv. Campaign No.");
                IF G_Vehicle_Ledger_Entry.FIND('-') THEN BEGIN
                    CAM_Uitgevoerd := TRUE;
                END ELSE BEGIN
                    IF ("Serv. Campaign-Affected Veh.".Completed = TRUE) AND (STRLEN("Serv. Campaign-Affected Veh."."Service Order") = 0) THEN BEGIN
                        CAM_Uitgevoerd := TRUE;
                    END;
                END;
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        G_Service_Campaign: Record "Service Campaign";
        G_Vehicle_Ledger_Entry: Record "Vehicle Ledger Entry";
        G_Location: Record Location;
        V_Location_Code: Text;
        Kop_Vestiging_Logo: Text;
        C_BevatCampagnes: Boolean;
        C_Country: Text;
        CAM_Description: Text;
        CAM_Uitgevoerd: Boolean;
        L_Name: Text;
        L_Address: Text;
        L_PostCode: Text;
        L_City: Text;
        L_Telephone: Text;
        L_EMail: Text;
}

