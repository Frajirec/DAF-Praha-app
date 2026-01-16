report 80041 "DPG LenGo Pakketoverzicht"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/Report/LenGoPakketoverzicht.rdlc';

    dataset
    {
        dataitem(Package; Package)
        {
            column(P_MakeCode; Package."Make Code")
            {
            }
            column(P_No; Package."No.")
            {
            }
            column(P_Description; Package.Description)
            {
            }
            column(RP_Details_Regels; RP_Details_Regels)
            {
            }
            column(RP_Filter_PakketCode; RP_Filter_PakketCode)
            {
            }
            column(P_VehicleMainGroupDescription; P_VehicleMainGroupDescription)
            {
            }
            column(P_VehicleSubgroupDescription; P_VehicleSubgroupDescription)
            {
            }
            dataitem("Package Version"; "Package Version")
            {
                DataItemLink = "Make Code" = FIELD("Make Code"), "Package No." = FIELD("No.");
                column(PV_PackageVersion; "Package Version")
                {
                }
                column(PV_Description; Description)
                {
                }
                dataitem("Package BOM"; "Package BOM")
                {
                    DataItemLink = "Make Code" = FIELD("Make Code"), "Package Version No." = FIELD("Package Version"), "Package No." = FIELD("Package No.");
                    column(PBOM_LineNo; "Package BOM"."Line No.")
                    {
                    }
                    column(PBOM_Type; "Package BOM".Type)
                    {
                    }
                    column(PBOM_No; "Package BOM"."No.")
                    {
                    }
                    column(PBOM_Description; "Package BOM".Description)
                    {
                    }
                    column(PBOM_Quantity; "Package BOM".Quantity)
                    {
                    }
                    column(PBOM_Prijs_Bruto; PBOM_Prijs_Bruto)
                    {
                    }
                    column(PBOM_Prijs_Netto; PBOM_Prijs_Netto)
                    {
                    }
                    column(PBOM_Prijs_Kortingscode; PBOM_Prijs_Kortingscode)
                    {
                    }
                    column(PBOM_Prijs_Kortingspercentage; PBOM_Prijs_Kortingspercentage)
                    {
                    }

                    trigger OnAfterGetRecord()
                    begin

                        PBOM_Prijs_Bruto := 0;
                        PBOM_Prijs_Kortingscode := '';
                        PBOM_Prijs_Kortingspercentage := 0;
                        PBOM_Prijs_Netto := 0;
                        IF (Type = 3) THEN BEGIN
                            IF G_Charging_Group_Unit_Price.GET('STANDAARD', '', '', '', '') THEN BEGIN
                                PBOM_Prijs_Bruto := G_Charging_Group_Unit_Price."Unit Price (Hour)";
                                PBOM_Prijs_Netto := PBOM_Prijs_Bruto;
                            END;
                        END;

                        IF (Type = 2) THEN BEGIN
                            IF G_Item.GET("No.") THEN BEGIN
                                PBOM_Prijs_Bruto := G_Item."Unit Price";
                                PBOM_Prijs_Kortingscode := G_Item."Item Group Code";
                                PBOM_Prijs_Kortingspercentage := 0;
                                PBOM_Prijs_Netto := 0;
                                IF G_Item_File_Price_Calculation.GET(0, G_Item."Make Code", G_Item."Item Group Code", 0) THEN BEGIN
                                    PBOM_Prijs_Kortingspercentage := G_Item_File_Price_Calculation."Factor %";
                                    IF (PBOM_Prijs_Kortingspercentage >= 15) THEN BEGIN
                                        PBOM_Prijs_Netto := (PBOM_Prijs_Bruto * ((100 - PBOM_Prijs_Kortingspercentage) / 100) * 1.15)
                                    END ELSE BEGIN
                                        PBOM_Prijs_Netto := PBOM_Prijs_Bruto;
                                        IF (PBOM_Prijs_Kortingspercentage > 0) THEN BEGIN
                                            PBOM_Prijs_Netto := (PBOM_Prijs_Bruto * ((100 - PBOM_Prijs_Kortingspercentage) / 100))
                                        END ELSE BEGIN
                                            PBOM_Prijs_Netto := PBOM_Prijs_Bruto;
                                        END;
                                    END;
                                END;
                            END ELSE BEGIN
                                Description := 'Onbekend';
                            END;
                        END;

                        PBOM_Prijs_Bruto := Quantity * PBOM_Prijs_Bruto;
                        PBOM_Prijs_Netto := Quantity * PBOM_Prijs_Netto;
                    end;
                }
            }

            trigger OnAfterGetRecord()
            begin
                G_VehicleMainGroup.RESET;
                G_VehicleMainGroup.SETRANGE("Make Code", "Make Code");
                G_VehicleMainGroup.SETRANGE(Code, "Main Group Code");
                IF G_VehicleMainGroup.FIND('-') THEN BEGIN
                    P_VehicleMainGroupDescription := G_VehicleMainGroup.Description;
                END;

                G_VehicleSubgroup.RESET;
                G_VehicleSubgroup.SETRANGE("Make Code", "Make Code");
                G_VehicleSubgroup.SETRANGE(Code, "Subgroup Code");
                IF G_VehicleSubgroup.FIND('-') THEN BEGIN
                    P_VehicleSubgroupDescription := G_VehicleSubgroup.Description;
                END;
            end;

            trigger OnPreDataItem()
            begin
                IF (STRLEN(RP_Filter_PakketCode) > 0) THEN BEGIN
                    Package.RESET;
                    Package.SETFILTER("No.", RP_Filter_PakketCode + '*');
                END;
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(Keuze)
                {
                    Caption = 'Keuze';
                    field(RP_Details_Regels; RP_Details_Regels)
                    {
                        Caption = 'Regels';
                    }
                    field(RP_Filter_PakketCode; RP_Filter_PakketCode)
                    {
                        Caption = 'Pakket code';
                    }
                }
            }
        }

        actions
        {
        }

        trigger OnInit()
        begin
            RP_Details_Regels := TRUE;
        end;
    }

    labels
    {
    }

    var
        RP_Details_Regels: Boolean;
        RP_Filter_PakketCode: Text;
        RP_Afdeling: Option;
        PBOM_Prijs_Bruto: Decimal;
        PBOM_Prijs_Netto: Decimal;
        PBOM_Prijs_Kortingscode: Text;
        PBOM_Prijs_Kortingspercentage: Decimal;
        G_Item: Record Item;
        G_Item_File_Price_Calculation: Record "Item File Price Calculation";
        G_Charging_Group_Unit_Price: Record "Charging Group Unit Price";
        G_VehicleMainGroup: Record "Vehicle Main Group";
        G_VehicleSubgroup: Record "Vehicle Subgroup";
        P_VehicleMainGroupDescription: Text;
        P_VehicleSubgroupDescription: Text;
}

