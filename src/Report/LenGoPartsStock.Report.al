report 80043 "DPG LenGo Parts Stock"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/Report/LenGoPartsStock.rdlc';

    dataset
    {
        dataitem("Item Bin"; "Item Bin")
        {
            column(RP_Soort; RP_Soort)
            {
            }
            column(IB_ItemNo; "Item Bin"."Item No.")
            {
            }
            column(IB_LocationCode; "Item Bin"."Location Code")
            {
            }
            column(IB_BinCode; "Item Bin"."Bin Code")
            {
            }
            column(IB_Inventory; "Item Bin".Inventory)
            {
            }
            column(IB_RijTonen; IB_RijTonen)
            {
            }
            column(IB_LaatsteInkoop; IB_LaatsteInkoop)
            {
            }
            column(IB_LaatsteVerkoop; IB_LaatsteVerkoop)
            {
            }
            column(I_Description; I_Description)
            {
            }
            column(I_Showline; I_Showline)
            {
            }
            dataitem("Item Location"; "Item Location")
            {
                DataItemLink = "Item No." = FIELD("Item No."), "Location Code" = FIELD("Location Code");
                column(IL_LastDirectCost; "Item Location"."Last Direct Cost")
                {
                }
            }

            trigger OnAfterGetRecord()
            begin

                I_Showline := TRUE;

                G_Item.RESET;
                G_Item.SETRANGE("No.", "Item No.");
                IF G_Item.FIND('-') THEN BEGIN
                    I_Description := G_Item.Description;
                    IF (G_Item."Item Type" <> G_Item."Item Type"::Item) THEN BEGIN
                        I_Showline := FALSE;
                    END
                END;

                IB_LaatsteInkoop := 0D;
                G_Item_Ledger_Entry.RESET;
                G_Item_Ledger_Entry.SETRANGE("Item No.", "Item No.");
                G_Item_Ledger_Entry.SETRANGE("Location Code", "Location Code");
                G_Item_Ledger_Entry.SETRANGE("Entry Type", 0);
                IF G_Item_Ledger_Entry.FINDLAST THEN BEGIN
                    IB_LaatsteInkoop := G_Item_Ledger_Entry."Posting Date";
                END;

                IB_LaatsteVerkoop := 0D;
                G_Item_Ledger_Entry.RESET;
                G_Item_Ledger_Entry.SETRANGE("Item No.", "Item No.");
                G_Item_Ledger_Entry.SETRANGE("Location Code", "Location Code");
                G_Item_Ledger_Entry.SETRANGE("Entry Type", 1);
                IF G_Item_Ledger_Entry.FINDLAST THEN BEGIN
                    IB_LaatsteVerkoop := G_Item_Ledger_Entry."Posting Date";
                END;

                IB_RijTonen := FALSE;
                IF
                (RP_Soort = RP_Soort::"Voorraad zonder locatie") AND (("Bin Code" = 'T') OR ("Bin Code" = ''))
                OR (RP_Soort = RP_Soort::"Locatie zonder voorraad") AND (("Bin Code" <> 'T') AND ("Bin Code" <> '') AND ((IB_LaatsteInkoop < CALCDATE('<-6M>', WORKDATE)) OR (IB_LaatsteInkoop = 0D)))
                OR (RP_Soort = RP_Soort::"Totale voorraad")
                THEN BEGIN
                    IB_RijTonen := TRUE;
                END;
            end;

            trigger OnPreDataItem()
            begin
                "Item Bin".RESET;
                "Item Bin".SETRANGE("Location Code", RP_Location);
                IF (RP_Soort = RP_Soort::"Voorraad zonder locatie") THEN BEGIN
                    "Item Bin".SETFILTER(Inventory, '<>0')
                END;
                IF (RP_Soort = RP_Soort::"Locatie zonder voorraad") THEN BEGIN
                    "Item Bin".SETFILTER(Inventory, '=0')
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
                group(Control1000000001)
                {
                    ShowCaption = false;
                    field(RP_soort; RP_Soort)
                    {
                        Caption = 'Soort';
                    }
                    field(RP_Location; RP_Location)
                    {
                        Caption = 'Vestiging';
                    }
                }
            }
        }

        actions
        {
        }

        trigger OnInit()
        begin
            RP_Location := G_UserSession.GetLocation;
        end;
    }

    labels
    {
    }

    var
        RP_Location: Text;
        RP_Soort: Option "Voorraad zonder locatie","Locatie zonder voorraad","Totale voorraad";
        G_Item: Record Item;
        G_Item_Ledger_Entry: Record "Item Ledger Entry";
        G_UserSession: Record "User Session";
        IB_RijTonen: Boolean;
        IB_LaatsteInkoop: Date;
        IB_LaatsteVerkoop: Date;
        I_Description: Text;
        I_Showline: Boolean;
}

