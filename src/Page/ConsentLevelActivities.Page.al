page 80009 "DPG Consent Level Activities"
{
    // --- API Customization ---
    // 79027073    27.08.20 RK DAFCZ.1 new object

    PageType = CardPart;
    SourceTable = "DPG Consent Level Cue";

    layout
    {
        area(content)
        {
            cuegroup("Souhlas s GDPR")
            {
                Caption = 'Agreed Consent';
                field("Business Agreed"; "Business Agreed")
                {
                    Caption = 'Business';
                }
                field("Marketing Agreed"; "Marketing Agreed")
                {
                    Caption = 'Marketing';
                }
                field("MAX Agreed"; "MAX Agreed")
                {
                    Caption = 'MAX';
                }
            }
            cuegroup("Expirovaný souhlas s GDPR")
            {
                Caption = 'Expired Consent';
                field("Business Expired"; "Business Expired")
                {
                    Caption = 'Business';
                }
                field("Marketing Expired"; "Marketing Expired")
                {
                    Caption = 'Marketing';
                }
                field("MAX Expired"; "MAX Expired")
                {
                    Caption = 'MAX';
                }
            }
            cuegroup("Nevyplnený souhlas s GDPR")
            {
                Caption = 'No Consent';
                field(NoBusinessConsentG; NoBusinessConsentG)
                {
                    Caption = 'Business';

                    trigger OnDrillDown()
                    begin
                        CLEAR(CustomerListGDPRG);
                        CustomerListGDPRG.InitRec(BusinessCustomerTG);
                        CustomerListGDPRG.RUNMODAL;
                    end;
                }
                field(NoMarketingConsentG; NoMarketingConsentG)
                {
                    Caption = 'Marketing';

                    trigger OnDrillDown()
                    begin
                        CLEAR(CustomerListGDPRG);
                        CustomerListGDPRG.InitRec(MarketingCustomerTG);
                        CustomerListGDPRG.RUNMODAL;
                    end;
                }
                field(NoMAXConsent; NoMAXConsent)
                {
                    Caption = 'MAX';

                    trigger OnDrillDown()
                    begin
                        CLEAR(CustomerListGDPRG);
                        CustomerListGDPRG.InitRec(MAXCustomerTG);
                        CustomerListGDPRG.RUNMODAL;
                    end;
                }
            }
            cuegroup("Expirovaný souhlas s GDPR v prúbehu dnú")
            {
                Caption = 'Expired Consent within Days';
                field("Business Expire within X Days"; "Business Expire within X Days")
                {
                    Caption = 'Business';
                }
                field("Marketing Expire within X Days"; "Marketing Expire within X Days")
                {
                    Caption = 'Marketing';
                }
                field("MAX Expire within X Days"; "MAX Expire within X Days")
                {
                    Caption = 'MAX';
                }
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    begin
        RESET;
        IF NOT GET THEN BEGIN
            INIT;
            INSERT;
        END;

        ApplyFilters();
    end;

    var
        NoBusinessConsentG: Integer;
        NoMarketingConsentG: Integer;
        NoMAXConsent: Integer;
        BusinessCustomerTG: Record Customer temporary;
        MarketingCustomerTG: Record Customer temporary;
        MAXCustomerTG: Record Customer temporary;
        CustomerListGDPRG: Page "DPG Customer List GDPR";

    local procedure ApplyFilters()
    var
        CustomerL: Record Customer;
        InternatDataPrivacyQueryL: Record "Internat. Data Privacy Query";
        InternatDataPrivacySetupL: Record "Internat. Data Privacy Setup";
    begin
        InternatDataPrivacySetupL.GET;
        InternatDataPrivacySetupL.TESTFIELD("DPG Consent Expiration Calc.");

        SETFILTER("Date Filter", '%1..', TODAY);
        SETFILTER("Expired Date Filter", '..%1', CALCDATE('<-1D>', TODAY));
        SETFILTER("Expired X Date Filter", '%1..%2', TODAY, CALCDATE(InternatDataPrivacySetupL."DPG Consent Expiration Calc.", TODAY));

        CLEAR(NoBusinessConsentG);
        CLEAR(NoMarketingConsentG);
        CLEAR(NoMAXConsent);
        BusinessCustomerTG.RESET;
        BusinessCustomerTG.DELETEALL;
        MarketingCustomerTG.RESET;
        MarketingCustomerTG.DELETEALL;
        MAXCustomerTG.RESET;
        MAXCustomerTG.DELETEALL;

        CustomerL.RESET;
        IF CustomerL.FINDSET THEN
            REPEAT
                InternatDataPrivacyQueryL.RESET;
                InternatDataPrivacyQueryL.SETRANGE("Customer No.", CustomerL."No.");
                // BUSINESS
                InternatDataPrivacyQueryL.SETRANGE("Consent Level Code", 'BUSINESS');
                IF InternatDataPrivacyQueryL.ISEMPTY THEN BEGIN
                    NoBusinessConsentG += 1;
                    BusinessCustomerTG := CustomerL;
                    BusinessCustomerTG.INSERT;
                END;
                // MARKETING
                InternatDataPrivacyQueryL.SETRANGE("Consent Level Code", 'MARKETING');
                IF InternatDataPrivacyQueryL.ISEMPTY THEN BEGIN
                    NoMarketingConsentG += 1;
                    MarketingCustomerTG := CustomerL;
                    MarketingCustomerTG.INSERT;
                END;
                // MAX
                InternatDataPrivacyQueryL.SETRANGE("Consent Level Code", 'MAX');
                IF InternatDataPrivacyQueryL.ISEMPTY THEN BEGIN
                    NoMAXConsent += 1;
                    MAXCustomerTG := CustomerL;
                    MAXCustomerTG.INSERT;
                END;
            UNTIL CustomerL.NEXT = 0;
    end;
}

