report 80042 "DPG LenGo Parts Purch. Orders"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/Report/LenGoPartsPurchOrders.rdlc';

    dataset
    {
        dataitem("Purchase Line"; "Purchase Line")
        {
            column(PH_DocumentType; "Purchase Line"."Document Type")
            {
            }
            column(PH_No; "Purchase Line"."Document No.")
            {
            }
            column(PL_LineNo; "Purchase Line"."Line No.")
            {
            }
            column(PL_Type; "Purchase Line".Type)
            {
            }
            column(PL_LocationCode; "Purchase Line"."Location Code")
            {
            }
            column(PL_No; "Purchase Line"."No.")
            {
            }
            column(PL_Description; "Purchase Line".Description)
            {
            }
            column(PL_Description2; "Purchase Line"."Description 2")
            {
            }
            column(PL_Quantity; "Purchase Line".Quantity)
            {
            }
            column(PL_QuantityReceived; "Purchase Line"."Quantity Received")
            {
            }
            column(PL_QuantityInvoiced; "Purchase Line"."Quantity Invoiced")
            {
            }
            dataitem("Purchase Header"; "Purchase Header")
            {
                DataItemLink = "Document Type" = FIELD("Document Type"), "No." = FIELD("Document No.");
                column(PH_LocationCode; "Purchase Header"."Location Code")
                {
                }
                column(PH_VendorNo; "Purchase Header"."Buy-from Vendor No.")
                {
                }
                column(PH_VendorName; "Purchase Header"."Buy-from Vendor Name")
                {
                }
                column(PH_OrderDate; "Purchase Header"."Order Date")
                {
                }
                column(PH_StatusCode; "Purchase Header"."Status Code")
                {
                }
                column(PH_OrderType; "Purchase Header"."Purch. Order Type")
                {
                }
            }

            trigger OnPreDataItem()
            begin
                "Purchase Line".RESET;
                "Purchase Line".SETRANGE("Order Type", 0);
                "Purchase Line".SETRANGE("Document Type", 1);
                "Purchase Line".SETRANGE("Location Code", RP_Location);
                IF (STRLEN(RP_Vendor) > 0) THEN BEGIN
                    "Purchase Line".SETRANGE("Buy-from Vendor No.", RP_Vendor);
                END;
                IF (RP_NietGeleverd = TRUE) THEN BEGIN
                    "Purchase Line".SETFILTER("Qty. to Receive", '<>0');
                END ELSE BEGIN
                    IF (RP_NietGefactureerd = TRUE) THEN BEGIN
                        "Purchase Line".SETFILTER("Qty. to Invoice", '<>0');
                    END;
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
                    field(RP_Location; RP_Location)
                    {
                        Caption = 'Vestiging';
                    }
                    field(RP_Vendor; RP_Vendor)
                    {
                        Caption = 'Leveranciersnummer';
                    }
                    field(RP_NietGeleverd; RP_NietGeleverd)
                    {
                        Caption = 'Alleen niet geleverd';
                    }
                    field(RP_NietGefactureerd; RP_NietGefactureerd)
                    {
                        Caption = 'Alleen niet gefactureerd';
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
        RP_Vendor: Text;
        RP_NietGeleverd: Boolean;
        RP_NietGefactureerd: Boolean;
        G_UserSession: Record "User Session";
}

