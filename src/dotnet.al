dotnet
{
    assembly("System")
    {
        Version = '4.0.0.0';
        Culture = 'neutral';
        PublicKeyToken = 'b77a5c561934e089';

        type("System.Net.HttpStatusCode"; "DPG HttpStatusCode")
        {
        }

        type("System.Collections.Specialized.NameValueCollection"; "DPG NameValueCollection")
        {
        }
    }

    assembly("System.Xml")
    {
        Version = '4.0.0.0';
        Culture = 'neutral';
        PublicKeyToken = 'b77a5c561934e089';

        type("System.Xml.XmlDocument"; "DPG XmlDocument")
        {
        }
    }

}
