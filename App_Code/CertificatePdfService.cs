using NReco.PdfGenerator;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for CertificatePdfService
/// </summary>

public class CertificatePdfService
{
    public byte[] GeneratePdf(
        SecuritySatisfactionCertificate data)
    {
        // Generate HTML
        string html =
            CertificateHtmlGenerator.Generate(data);

        // Initialize PDF converter
        HtmlToPdfConverter converter =
            new HtmlToPdfConverter();

        // Page configuration
        converter.Size = PageSize.Legal;

        converter.Orientation =
            PageOrientation.Portrait;

        converter.Margins = new PageMargins
        {
            Top = 15,
            Bottom = 15,
            Left = 20,
            Right = 20
        };

        converter.Zoom = 1.0f;

        converter.Quiet = true;

        // Generate PDF byte array
        byte[] pdfBytes = converter.GeneratePdf(html);

        return pdfBytes;
    }
}