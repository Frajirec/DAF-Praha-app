
pageextension 80041 ServicePreviewExt extends "Service Preview"
//NOTE: Send Service Preview by e-mail
{
    actions
    {
        addlast(Processing)
        {
            action(SendServicePreviewEmailAction)
            {
                ApplicationArea = All;
                Caption = 'Send Service Preview Email';
                Image = Email;

                trigger OnAction()
                var
                    ServicePreviewLineRec: Record "Service Preview Line";
                    ServiceHdrRec: Record "Service Header";
                    Customer: Record Customer;
                    ServicePreviewEmailSender: Codeunit "Service Preview Email Sender";
                begin
                    ServicePreviewLineRec := Rec;

                    // Get service header from Service Preview Line
                    if not ServiceHdrRec.Get(ServicePreviewLineRec."Document Type", ServicePreviewLineRec."Document No.") then begin
                        Message('Service Header record not found.');
                        exit;
                    end;

                    // Validate customer email
                    if not Customer.Get(ServiceHdrRec."Bill-to Customer No.") then begin
                        Message('Customer not found.');
                        exit;
                    end;
                    if Customer."E-Mail" = '' then begin
                        Message('Customer does not have an email address.');
                        exit;
                    end;

                    // Send email
                    ServicePreviewEmailSender.SendServicePreviewEmail(ServiceHdrRec, Customer."E-Mail");

                    Message('Service Preview report sent to %1.', Customer."E-Mail");
                end;
            }
        }
    }
}