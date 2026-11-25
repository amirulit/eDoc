using iTextSharp.text;
using iTextSharp.text.pdf;
using Newtonsoft.Json.Linq;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class PDF_Gen : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void Button1_Click(object sender, EventArgs e)
    {

        String masterHtml = "";
        String facilitiesHtml = "";
        String remarksHtml = "";

        String cs = ConfigurationManager.ConnectionStrings["dbconn"].ConnectionString;

        // 1. Get saved HTML from database
        using (SqlConnection con = new SqlConnection(cs))
        {
            String sql = @"
                SELECT MasterJson, FacilitiesJson, RemarksJson
                FROM t_LLI_Submissions
                WHERE DrawdownId = @DrawdownId";

            using (SqlCommand cmd = new SqlCommand(sql, con))
            {
                cmd.Parameters.Add("@DrawdownId", SqlDbType.Int).Value = 481;

                con.Open();

                using (SqlDataReader dr = cmd.ExecuteReader())
                {
                    if (!dr.Read())
                    {
                    //    return new
                    //    {
                    //        Success = false,
                    //        Message = "Record not found."
                    //    };
                    }

                    masterHtml = dr["MasterJson"] == DBNull.Value ? "" : dr["MasterJson"].ToString();

                    //facilitiesHtml = dr["FacilitiesJson"] == DBNull.Value ? "" : dr["FacilitiesJson"].ToString();

                    facilitiesHtml = dr["facilitiesHtml"] == DBNull.Value ? "" : dr["facilitiesHtml"].ToString();

                    remarksHtml = dr["RemarksJson"] == DBNull.Value ? "" : dr["RemarksJson"].ToString();


                }
            }
        }



        string masterJson = masterHtml;
        string facilitiesJson = facilitiesHtml;
        string remarksJson = remarksHtml;

        JObject master = JObject.Parse(masterJson);
        JArray facilities = JArray.Parse(facilitiesJson);
        JArray remarks = JArray.Parse(remarksJson);

        MemoryStream ms = new MemoryStream();

        Document doc = new Document(
            PageSize.A4.Rotate(),
            30, 30, 80, 50
        );

        PdfWriter writer = PdfWriter.GetInstance(doc, ms);

        // Repeated page header and footer
        writer.PageEvent = new PdfHeaderFooter();

        doc.Open();

        Font headingFont = FontFactory.GetFont(
            FontFactory.HELVETICA_BOLD, 11);

        Font labelFont = FontFactory.GetFont(
            FontFactory.HELVETICA_BOLD, 9);

        Font normalFont = FontFactory.GetFont(
            FontFactory.HELVETICA, 9);

        Font sectionFont = FontFactory.GetFont(
            FontFactory.HELVETICA_BOLD, 10);

        // =====================================
        // MASTER INFORMATION
        // =====================================

        Paragraph title = new Paragraph(
            "eDoc Submission Details", headingFont);

        title.Alignment = Element.ALIGN_CENTER;
        title.SpacingAfter = 12;

        doc.Add(title);

        PdfPTable masterTable = new PdfPTable(2);
        masterTable.WidthPercentage = 100;
        masterTable.SetWidths(new float[] { 50,50 });

        AddMasterCell(masterTable, "eDoc ID", labelFont);
        AddMasterValue(masterTable, GetValue(master, "edoc_id"), normalFont);

        AddMasterCell(masterTable, "Reference No.", labelFont);
        AddMasterValue(masterTable, GetValue(master, "edoc_refno"), normalFont);

        AddMasterCell(masterTable, "Booking Branch", labelFont);
        AddMasterValue(masterTable, GetValue(master, "booking_branch"), normalFont);

        AddMasterCell(masterTable, "Sanction Reference", labelFont);
        AddMasterValue(masterTable, GetValue(master, "sanction_reference"), normalFont);

        AddMasterCell(masterTable, "Sanction Date", labelFont);
        AddMasterValue(masterTable,
            FormatJsonDate(GetValue(master, "sanction_date")), normalFont);

        doc.Add(masterTable);

        doc.Add(new Paragraph(" "));

        // =====================================
        // FACILITIES
        // =====================================

        Paragraph facilityTitle =
            new Paragraph("Facilities Details", sectionFont);

        facilityTitle.SpacingBefore = 8;
        facilityTitle.SpacingAfter = 8;

        doc.Add(facilityTitle);

        PdfPTable facilityTable = new PdfPTable(8);
        facilityTable.WidthPercentage = 100;

        facilityTable.SetWidths(new float[]
    {
        9, 11, 11, 19, 13, 13, 11, 13
    });

        facilityTable.HeaderRows = 1;

        AddTableHeader(facilityTable, "Loan Nature");
        AddTableHeader(facilityTable, "Amount");
        AddTableHeader(facilityTable, "Validity");
        AddTableHeader(facilityTable, "Customer Name");
        AddTableHeader(facilityTable, "Drawdown Asked For");
        AddTableHeader(facilityTable, "Limit Reference");
        AddTableHeader(facilityTable, "Child Code");
        AddTableHeader(facilityTable, "Parent Code");

        foreach (JObject item in facilities)
        {
            AddTableCell(facilityTable, GetValue(item, "loan_nature"), normalFont);
            AddTableCell(facilityTable, GetValue(item, "amount"), normalFont);
            AddTableCell(facilityTable, GetValue(item, "validity"), normalFont);
            AddTableCell(facilityTable, GetValue(item, "customer_name"), normalFont);
            AddTableCell(facilityTable, GetValue(item, "drawdown_asked_for"), normalFont);
            AddTableCell(facilityTable, GetValue(item, "limit_reference"), normalFont);
            AddTableCell(facilityTable, GetValue(item, "child_code"), normalFont);
            AddTableCell(facilityTable, GetValue(item, "parent_code"), normalFont);
        }

        doc.Add(facilityTable);

        // =====================================
        // REMARKS
        // =====================================

        Paragraph remarksTitle =
            new Paragraph("Remarks", sectionFont);

        remarksTitle.SpacingBefore = 15;
        remarksTitle.SpacingAfter = 8;

        doc.Add(remarksTitle);

        PdfPTable remarksTable = new PdfPTable(2);
        remarksTable.WidthPercentage = 100;

        remarksTable.SetWidths(new float[] { 12, 88 });
        remarksTable.HeaderRows = 1;

        AddTableHeader(remarksTable, "SL");
        AddTableHeader(remarksTable, "Remarks");

        foreach (JObject item in remarks)
        {
            AddTableCell(remarksTable, GetValue(item, "SL"), normalFont);
            AddTableCell(remarksTable, GetValue(item, "Remarks"), normalFont);
        }

        doc.Add(remarksTable);

        doc.Close();

        Response.Clear();
        Response.ContentType = "application/pdf";
        Response.AddHeader(
            "Content-Disposition",
            "inline;filename=EDocSubmission.pdf"
        );

        Response.BinaryWrite(ms.ToArray());
        Response.Flush();

        ms.Dispose();

        HttpContext.Current.ApplicationInstance.CompleteRequest();
    }
    private string GetValue(JObject obj, string key)
    {
        JToken value = obj[key];

        if (value == null || value.Type == JTokenType.Null)
            return "";

        return value.ToString();
    }

    private void AddMasterCell(
        PdfPTable table, string text, Font font)
    {
        PdfPCell cell = new PdfPCell(
            new Phrase(text, font));

        cell.Padding = 6;
        cell.BackgroundColor = new BaseColor(235, 240, 245);

        table.AddCell(cell);
    }

    private void AddMasterValue(
        PdfPTable table, string text, Font font)
    {
        PdfPCell cell = new PdfPCell(
            new Phrase(text, font));

        cell.Padding = 6;

        table.AddCell(cell);
    }

    private void AddTableHeader(
        PdfPTable table, string text)
    {
        Font font = FontFactory.GetFont(
            FontFactory.HELVETICA_BOLD, 8, BaseColor.WHITE);

        PdfPCell cell = new PdfPCell(new Phrase(text, font));

        cell.BackgroundColor = new BaseColor(40, 75, 115);
        cell.HorizontalAlignment = Element.ALIGN_CENTER;
        cell.VerticalAlignment = Element.ALIGN_MIDDLE;
        cell.Padding = 6;

        table.AddCell(cell);
    }

    private void AddTableCell(
        PdfPTable table, string text, Font font)
    {
        PdfPCell cell = new PdfPCell(
            new Phrase(text ?? "", font));

        cell.Padding = 5;
        cell.VerticalAlignment = Element.ALIGN_MIDDLE;

        table.AddCell(cell);
    }

    private string FormatJsonDate(string value)
    {
        if (string.IsNullOrEmpty(value))
            return "";

        try
        {
            // Format: /Date(1793469600000)/
            int start = value.IndexOf('(');
            int end = value.IndexOf(')');

            if (start >= 0 && end > start)
            {
                long milliseconds = Convert.ToInt64(
                    value.Substring(start + 1, end - start - 1));

                DateTime date = new DateTime(
                    1970, 1, 1, 0, 0, 0, DateTimeKind.Utc
                ).AddMilliseconds(milliseconds);

                return date.ToLocalTime().ToString("dd-MMM-yyyy");
            }

            return Convert.ToDateTime(value).ToString("dd-MMM-yyyy");
        }
        catch
        {
            return value;
        }
    }
}