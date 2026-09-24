using System;
using iTextSharp.text;
using iTextSharp.text.pdf;
using System.IO;

namespace CAD.DataAccess
{
    public class SscPdfGenerator
    {
        public static byte[] GenerateSscPdf(int drawdownId)
        {
            SSCData data = SscRepository.GetSscData(drawdownId);
            if (data == null) throw new Exception("No record found for drawdown_id " + drawdownId);

            using (var ms = new MemoryStream())
            {
                var doc = new Document(PageSize.A4, 50, 50, 50, 50);
                PdfWriter.GetInstance(doc, ms);
                doc.Open();

                var fontHeader = FontFactory.GetFont(FontFactory.TIMES_BOLD, 14);
                var fontTitle = FontFactory.GetFont(FontFactory.TIMES_BOLD, 15);
                var fontLabel = FontFactory.GetFont(FontFactory.TIMES_BOLD, 11);
                var fontValue = FontFactory.GetFont(FontFactory.TIMES, 11);
                var fontBody = FontFactory.GetFont(FontFactory.TIMES, 11);

                var h1 = new Paragraph("Mercantile Bank PLC.", fontHeader) { Alignment = Element.ALIGN_CENTER };
                var h2 = new Paragraph("Credit Administration Division", fontHeader) { Alignment = Element.ALIGN_CENTER };
                var h3 = new Paragraph("Head Office, Dhaka", fontHeader) { Alignment = Element.ALIGN_CENTER, SpacingAfter = 20 };
                doc.Add(h1);
                doc.Add(h2);
                doc.Add(h3);

                var title = new Paragraph("Security Satisfaction Certificate (SSC)", fontTitle) { Alignment = Element.ALIGN_CENTER, SpacingAfter = 15 };
                doc.Add(title);

                var topTable = new PdfPTable(2) { WidthPercentage = 100 };
                topTable.SetWidths(new float[] { 1f, 1f });

                var sscCell = new PdfPCell(new Phrase("SSC Number: " + drawdownId.ToString("00000"), fontLabel)) { Border = Rectangle.NO_BORDER, PaddingBottom = 15 };
                var dateCell = new PdfPCell(new Phrase("Date: " + DateTime.Now.ToString("dd/MM/yyyy"), fontLabel)) { Border = Rectangle.NO_BORDER, HorizontalAlignment = Element.ALIGN_RIGHT, PaddingBottom = 15 };

                topTable.AddCell(sscCell);
                topTable.AddCell(dateCell);
                doc.Add(topTable);

                var body = new Paragraph(
                    "We certify that all security documentation have been completed, physically checked and are in order. " +
                    "We further confirm compliance with all the terms pertaining to documentation as per approval. " +
                    "Following table contains details of Security Satisfaction Certificate.",
                    fontBody) { SpacingAfter = 15, Alignment = Element.ALIGN_JUSTIFIED };
                doc.Add(body);

                var table = new PdfPTable(3) { WidthPercentage = 100 };
                table.SetWidths(new float[] { 2.2f, 0.2f, 4f });

                AddRow(table, "CFR Number", data.CfrNo, fontLabel, fontValue);
                AddRow(table, "Branch/Uposhakha Name", data.BranchName, fontLabel, fontValue);
                AddRow(table, "RM Name", data.RmName, fontLabel, fontValue);
                AddRow(table, "RM ID", data.RmId, fontLabel, fontValue);
                AddRow(table, "Borrower Name", data.CustomerName, fontLabel, fontValue);
                AddRow(table, "Approval Authority", data.SancAuthority, fontLabel, fontValue);
                AddRow(table, "Sanction Reference", data.SancReferenceNo, fontLabel, fontValue);
                AddRow(table, "Sanction Date", data.SancDate.ToString(), fontLabel, fontValue);
                AddRow(table, "Nature of Facility", data.LoanNatures, fontLabel, fontValue);
                AddRow(table, "Limit asked for", data.LoanAmount, fontLabel, fontValue);
                AddRow(table, "Sanction Expiry", data.ExpDate.ToString(), fontLabel, fontValue);

                doc.Add(table);

                var sigSpacer = new Paragraph(" ") { SpacingAfter = 60 };
                doc.Add(sigSpacer);

                var sigTable = new PdfPTable(2) { WidthPercentage = 100 };
                sigTable.AddCell(new PdfPCell(new Phrase("_______________________\nDocument Manager", fontLabel)) { Border = Rectangle.NO_BORDER });
                var uhCell = new PdfPCell(new Phrase("_______________________\nUnit Head\nDocumentation Unit", fontLabel)) { Border = Rectangle.NO_BORDER, HorizontalAlignment = Element.ALIGN_RIGHT };
                sigTable.AddCell(uhCell);
                doc.Add(sigTable);

                var sigSpacer2 = new Paragraph(" ") { SpacingAfter = 40 };
                doc.Add(sigSpacer2);

                var sigTable2 = new PdfPTable(2) { WidthPercentage = 100 };
                sigTable2.AddCell(new PdfPCell(new Phrase("_______________________\nDeputy Head of CAD", fontLabel)) { Border = Rectangle.NO_BORDER });
                var uhCell2 = new PdfPCell(new Phrase("_______________________\nHead of CAD", fontLabel)) { Border = Rectangle.NO_BORDER, HorizontalAlignment = Element.ALIGN_RIGHT };
                sigTable2.AddCell(uhCell2);
                doc.Add(sigTable2);

                doc.Close();
                return ms.ToArray();
            }
        }

        public static byte[] GenerateSscConditionalPdf(int drawdownId)
        {
            SSCData data = SscRepository.GetSscConditionalData(drawdownId);
            if (data == null) throw new Exception("No record found for drawdown_id " + drawdownId);

            using (var ms = new MemoryStream())
            {
                var doc = new Document(PageSize.A4, 50, 50, 50, 50);
                PdfWriter.GetInstance(doc, ms);
                doc.Open();

                var fontHeader = FontFactory.GetFont(FontFactory.TIMES_BOLD, 14);
                var fontTitle = FontFactory.GetFont(FontFactory.TIMES_BOLD, 15);
                var fontLabel = FontFactory.GetFont(FontFactory.TIMES_BOLD, 11);
                var fontValue = FontFactory.GetFont(FontFactory.TIMES, 11);
                var fontBody = FontFactory.GetFont(FontFactory.TIMES, 11);

                var h1 = new Paragraph("Mercantile Bank PLC.", fontHeader) { Alignment = Element.ALIGN_CENTER };
                var h2 = new Paragraph("Credit Administration Division", fontHeader) { Alignment = Element.ALIGN_CENTER };
                var h3 = new Paragraph("Head Office, Dhaka", fontHeader) { Alignment = Element.ALIGN_CENTER, SpacingAfter = 20 };
                doc.Add(h1);
                doc.Add(h2);
                doc.Add(h3);

                var title = new Paragraph("Security Satisfaction Certificate (SSC)", fontTitle) { Alignment = Element.ALIGN_CENTER, SpacingAfter = 15 };
                doc.Add(title);

                var topTable = new PdfPTable(2) { WidthPercentage = 100 };
                topTable.SetWidths(new float[] { 1f, 1f });

                var sscCell = new PdfPCell(new Phrase("SSC Number: " + drawdownId.ToString("00000"), fontLabel)) { Border = Rectangle.NO_BORDER, PaddingBottom = 15 };
                var dateCell = new PdfPCell(new Phrase("Date: " + DateTime.Now.ToString("dd/MM/yyyy"), fontLabel)) { Border = Rectangle.NO_BORDER, HorizontalAlignment = Element.ALIGN_RIGHT, PaddingBottom = 15 };

                topTable.AddCell(sscCell);
                topTable.AddCell(dateCell);
                doc.Add(topTable);

                var body = new Paragraph(
                    "We certify that all security documentation have been completed, physically checked and are in order. " +
                    "We further confirm compliance with all the terms pertaining to documentation as per approval. " +
                    "Following table contains details of Security Satisfaction Certificate.",
                    fontBody) { SpacingAfter = 15, Alignment = Element.ALIGN_JUSTIFIED };
                doc.Add(body);

                var table = new PdfPTable(3) { WidthPercentage = 100 };
                table.SetWidths(new float[] { 2.2f, 0.2f, 4f });

                AddRow(table, "CFR Number", data.CfrNo, fontLabel, fontValue);
                AddRow(table, "Branch/Uposhakha Name", data.BranchName, fontLabel, fontValue);
                AddRow(table, "RM Name", data.RmName, fontLabel, fontValue);
                AddRow(table, "RM ID", data.RmId, fontLabel, fontValue);
                AddRow(table, "Borrower Name", data.CustomerName, fontLabel, fontValue);
                AddRow(table, "Approval Authority", data.SancAuthority, fontLabel, fontValue);
                AddRow(table, "Sanction Reference", data.SancReferenceNo, fontLabel, fontValue);
                AddRow(table, "Sanction Date", data.SancDate.ToString(), fontLabel, fontValue);
                AddRow(table, "Nature of Facility", data.LoanNatures, fontLabel, fontValue);
                AddRow(table, "Limit asked for", data.LoanAmount, fontLabel, fontValue);
                AddRow(table, "Sanction Expiry", data.ExpDate.ToString(), fontLabel, fontValue);
                AddRow(table, "CAD Office Note Ref. with Date", "CAD/2026/005", fontLabel, fontValue);

                doc.Add(table);

                // Outstanding documents table
                doc.Add(new Paragraph("Outstanding / Pending Documents", fontLabel) { SpacingAfter = 8 });

                var docTable = new PdfPTable(3) { WidthPercentage = 100 };
                docTable.SetWidths(new float[] { 0.6f, 4.8f, 1.5f });

                AddHeaderCell(docTable, "Sl. No.", fontLabel);
                AddHeaderCell(docTable, "Particulars of Exception", fontLabel);
                //AddHeaderCell(docTable, "Status", fontLabel);
                //AddHeaderCell(docTable, "Details", fontLabel);
                AddHeaderCell(docTable, "Expected Date of Regularization", fontLabel);

                if (data.PendingDocuments.Count == 0)
                {
                    var emptyCell = new PdfPCell(new Phrase("No outstanding documents.", fontValue)) { Colspan = 5, Padding = 6, HorizontalAlignment = Element.ALIGN_CENTER };
                    docTable.AddCell(emptyCell);
                }
                else
                {
                    foreach (var pd in data.PendingDocuments)
                    {
                        docTable.AddCell(new PdfPCell(new Phrase(pd.DocSl.ToString(), fontValue)) { Padding = 2 });
                        docTable.AddCell(new PdfPCell(new Phrase(pd.DocName ?? "", fontValue)) { Padding = 2 });
                        //docTable.AddCell(new PdfPCell(new Phrase(pd.Status ?? "", fontValue)) { Padding = 5 });
                        //docTable.AddCell(new PdfPCell(new Phrase(pd.Details ?? "", fontValue)) { Padding = 5 });
                        docTable.AddCell(new PdfPCell(new Phrase(pd.Deadline ?? "", fontValue)) { Padding = 2 });
                    }
                }

                doc.Add(docTable);

                var sigSpacer = new Paragraph(" ") { SpacingAfter = 30 };
                doc.Add(sigSpacer);

                var sigTable = new PdfPTable(2) { WidthPercentage = 100 };
                sigTable.AddCell(new PdfPCell(new Phrase("_______________________\nDocument Manager", fontLabel)) { Border = Rectangle.NO_BORDER });
                var uhCell = new PdfPCell(new Phrase("_______________________\nUnit Head\nDocumentation & Custodian Unit", fontLabel)) { Border = Rectangle.NO_BORDER, HorizontalAlignment = Element.ALIGN_RIGHT };
                sigTable.AddCell(uhCell);
                doc.Add(sigTable);

                var sigSpacer2 = new Paragraph(" ") { SpacingAfter = 20 };
                doc.Add(sigSpacer2);

                var sigTable2 = new PdfPTable(2) { WidthPercentage = 100 };
                sigTable2.AddCell(new PdfPCell(new Phrase("_______________________\nDeputy Head of CAD", fontLabel)) { Border = Rectangle.NO_BORDER });
                var uhCell2 = new PdfPCell(new Phrase("_______________________\nHead of CAD", fontLabel)) { Border = Rectangle.NO_BORDER, HorizontalAlignment = Element.ALIGN_RIGHT };
                sigTable2.AddCell(uhCell2);
                doc.Add(sigTable2);

                doc.Close();
                return ms.ToArray();
            }
        }

        private static void AddHeaderCell(PdfPTable table, string text, Font font)
        {
            table.AddCell(new PdfPCell(new Phrase(text, font))
            {
                Padding = 2,
                BackgroundColor = new BaseColor(230, 230, 230),
                HorizontalAlignment = Element.ALIGN_CENTER
            });
        }

        private static void AddRow(PdfPTable table, string label, string value, Font fontLabel, Font fontValue)
        {
            var cellLabel = new PdfPCell(new Phrase(label, fontLabel)) { Padding = 2 };
            var cellColon = new PdfPCell(new Phrase(":", fontLabel)) { Padding = 2, HorizontalAlignment = Element.ALIGN_CENTER };
            var cellValue = new PdfPCell(new Phrase(value ?? "", fontValue)) { Padding = 2 };
            table.AddCell(cellLabel);
            table.AddCell(cellColon);
            table.AddCell(cellValue);
        }
    }
}