pageextension 1058096 "DAF Rent Card EXT" extends "Rent Card"
{
    layout
    {
        addafter("Salesperson Code")
        {
            field("DAF CDD Date"; RenterCDDG)
            {
                Editable = false;
            }
        }
    }
    actions
    {
    }

    trigger OnAfterGetCurrRecord()
    begin
        RenterCDDG := 0D;
        IF RenterG.GET("Renter No.") THEN
            RenterCDDG := RenterG."Date 1";
    end;

    trigger OnModifyRecord(): Boolean
    begin
        RenterCDDG := 0D;
        IF RenterG.GET("Renter No.") THEN
            RenterCDDG := RenterG."Date 1";
    end;

    var
        RenterCDDG: Date;
        RenterG: Record "Customer";
}