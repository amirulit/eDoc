using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Text;
using System.Web;

/// <summary>
/// Summary description for CertificateHtmlGenerator
/// </summary>



public class CertificateHtmlGenerator
{
    private static string Encode(string value)
    {
        return WebUtility.HtmlEncode(value ?? "");
    }

    private static string FormatDate(DateTime? date)
    {
        return date.HasValue
            ? date.Value.ToString("dd/MM/yyyy")
            : "";
    }

    public static string Generate(SecuritySatisfactionCertificate data)
    {
        StringBuilder html = new StringBuilder();

        html.Append(@"
<!DOCTYPE html>
<html>
<head>
<meta charset='UTF-8' />

<style>

    @page {
        size: legal portrait;
        margin: 15mm 20mm;
    }

    * {
        box-sizing: border-box;
    }

    body {
        font-family: 'Times New Roman', serif;
        font-size: 13px;
        color: #000000;
        margin: 0;
        padding: 0;
    }

    .annexure {
        font-size: 13px;
        font-weight: bold;
        margin-top: 28px;
        margin-bottom: 42px;
    }

    .bank-header {
        text-align: center;
        font-size: 16px;
        font-weight: bold;
        line-height: 1.35;
    }

    .certificate-title {
        text-align: center;
        font-size: 16px;
        font-weight: bold;
        margin-top: 42px;
        margin-bottom: 22px;
    }

    .info-table {
        width: 100%;
        border-collapse: collapse;
        margin-bottom: 40px;
    }

    .info-table td {
        border: none;
        padding: 2px 0;
        font-size: 15px;
        font-weight: bold;
    }

    .info-left {
        text-align: left;
    }

    .info-right {
        text-align: right;
    }

    .description {
        font-size: 13px;
        line-height: 1.4;
        text-align: justify;
        margin-bottom: 18px;
    }

    .details-table {
        width: 100%;
        border-collapse: collapse;
        table-layout: fixed;
    }

    .details-table td {
        border: 1px solid #000000;
        padding: 2px 7px;
        height: 17px;
        vertical-align: middle;
        font-size: 13px;
    }

    .field-name {
        width: 35%;
        font-weight: bold;
    }

    .field-separator {
        width: 3%;
        text-align: center;
        font-weight: bold;
    }

    .field-value {
        width: 62%;
        color: #666666;
    }

    .signature-table {
        width: 100%;
        border-collapse: collapse;
        margin-top: 75px;
    }

    .signature-table td {
        width: 50%;
        border: none;
        vertical-align: top;
        font-size: 13px;
    }

    .signature-line {
        width: 135px;
        border-top: 1px solid #000000;
        margin-bottom: 5px;
    }

    .signature-right {
        padding-left: 30px;
    }

</style>
</head>

<body>

<div class='annexure'>
    Annexure 03: Security Satisfaction Certificate
    (Unconditional SSC-01)
</div>

<div class='bank-header'>
    Mercantile Bank PLC<br/>
    Credit Administration Division<br/>
    Head Office, Dhaka
</div>

<div class='certificate-title'>
    Security Satisfaction Certificate (SSC)
</div>
");

        // SSC Number and Certificate Date
        html.Append(@"
<table class='info-table'>
    <tr>
        <td class='info-left'>
            SSC Number:
            <span style='color:#666666;'>");

        html.Append(Encode(data.SSCNumber));

        html.Append(@"
            </span>
        </td>

        <td class='info-right'>
            Date:
            <span style='color:#666666;'>");

        html.Append(FormatDate(data.CertificateDate));

        html.Append(@"
            </span>
        </td>
    </tr>
</table>
");

        // Certificate declaration
        html.Append(@"
<div class='description'>
    We certify that all security documentation have been completed,
    physically checked and are in order. We further confirm
    compliance with all the terms pertaining to documentation
    as per approval. Following table contains details of
    Security Satisfaction Certificate.
</div>
");

        // Details table
        html.Append(@"
<table class='details-table'>
");

        AddRow(html, "CFR Number", data.CFRNumber);

        AddRow(html, "Branch/Uposhakha Name", data.BranchName);

        AddRow(html, "RM Name", data.RMName);

        AddRow(html, "RM ID", data.RMID);

        AddRow(html, "Borrower Name", data.BorrowerName);

        AddRow(html, "Approval Authority",
            data.ApprovalAuthority);

        AddRow(html, "Sanction Reference",
            data.SanctionReference);

        AddRow(html, "Sanction Date",
            FormatDate(data.SanctionDate));

        AddRow(html, "Nature of Facility",
            data.NatureOfFacility);

        AddRow(html, "Limit asked for",
            data.LimitAsked.HasValue
                ? data.LimitAsked.Value.ToString("N2")
                : "");

        AddRow(html, "Sanction Expiry",
            FormatDate(data.SanctionExpiry));

        html.Append(@"
</table>
");

        // Signature section
        html.Append(@"
<table class='signature-table'>
    <tr>
        <td>
            <div class='signature-line'></div>
            Document Manager
        </td>

        <td class='signature-right'>
            <div class='signature-line'></div>
            Unit Head<br/>
            Documentation Unit
        </td>
    </tr>
</table>

</body>
</html>
");

        return html.ToString();
    }

    private static void AddRow(
        StringBuilder html,
        string label,
        string value)
    {
        html.Append("<tr>");

        html.Append("<td class='field-name'>");
        html.Append(Encode(label));
        html.Append("</td>");

        html.Append("<td class='field-separator'>:</td>");

        html.Append("<td class='field-value'>");
        html.Append(Encode(value));
        html.Append("</td>");

        html.Append("</tr>");
    }
}