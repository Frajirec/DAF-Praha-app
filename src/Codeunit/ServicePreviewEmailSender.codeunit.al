
codeunit 80008 "Service Preview Email Sender"
//NOTE: Send Service Preview by e-mail
{
    SingleInstance = true;

    procedure SendServicePreviewEmail(ServiceHdrRec: Record "Service Header"; ToEmail: Text)
    var
        SMTPMail: Codeunit "SMTP Mail";
        FileManagement: Codeunit "File Management";
        CVMSetup: Record "CVM Add-on Setup";
        CompanyInfo: Record "Company Information";
        UserSetup: Record "User Setup";
        DAFCodeunitFunctions: Codeunit "DAF Codeunit Functions";
        GeneratedFilesText: Text;
        FilePathArray: array[10] of Text;
        FileName: Text;
        MailText: Text;
        SenderEmail: Text;
        i: Integer;
        CountFiles: Integer;
        DelimPos: Integer;
        RemainingText: Text;
    begin
        if ToEmail = '' then
            Error('Recipient email address is empty.');

        if not CVMSetup.Get() then
            Error('CVM Add-on Setup not found.');

        if not CompanyInfo.Get() then
            Error('Company Information not found.');

        // Get current user's email address as sender
        if UserSetup.Get(USERID) then
            SenderEmail := UserSetup."E-Mail"
        else
            SenderEmail := '';

        if SenderEmail = '' then
            Error('Sender email address is not configured for current user.');

        GeneratedFilesText := DAFCodeunitFunctions.PrintServPreviewToPDF(ServiceHdrRec);

        if GeneratedFilesText = '' then
            Error('No Service Preview report generated.');

        // Initialize splitting variables
        CountFiles := 0;
        RemainingText := GeneratedFilesText;

        // Split GeneratedFilesText by '|' delimiter into FilePathArray
        repeat
            DelimPos := STRPOS(RemainingText, '|');
            if DelimPos = 0 then
                DelimPos := STRLEN(RemainingText) + 1;

            CountFiles += 1;
            FilePathArray[CountFiles] := COPYSTR(RemainingText, 1, DelimPos - 1);

            if DelimPos > STRLEN(RemainingText) then
                RemainingText := ''
            else
                RemainingText := COPYSTR(RemainingText, DelimPos + 1);
        until (RemainingText = '') or (CountFiles = ARRAYLEN(FilePathArray));

        // Compose email body
        MailText := STRSUBSTNO('Dear Customer,<br /><br />Please find attached the Service Preview report(s) for order %1.<br /><br />Best regards,<br />%2',
            ServiceHdrRec."No.", CompanyInfo.Name);

        SMTPMail.CreateMessage(CompanyInfo.Name, SenderEmail, ToEmail, 'Service Preview Report - ' + ServiceHdrRec."No.", MailText, true);

        // Attach all generated PDF files
        for i := 1 to CountFiles do begin
            FileName := FileManagement.GetFileName(FilePathArray[i]);
            SMTPMail.AddAttachment(FilePathArray[i], FileName);
        end;

        SMTPMail.Send();

        // Delete temp files after sending
        for i := 1 to CountFiles do
            FileManagement.DeleteServerFile(FilePathArray[i]);
    end;
}