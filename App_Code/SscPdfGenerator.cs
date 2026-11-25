using System;
using System.Data;
using System.IO;
using iTextSharp.text;
using iTextSharp.text.pdf;
using System.Web;

 
    public class SscPdfGenerator
    {
        public static byte[] GenerateUnconCentralizedSscPdf(int drawdownId)
        {
            SSCData data = SscRepository.GetSscData(drawdownId);
            if (data == null) throw new Exception("No record found for drawdown_id " + drawdownId);

            using (var ms = new MemoryStream())
            {
                var doc = new Document(PageSize.A4, 50, 50, 50, 50);
                PdfWriter.GetInstance(doc, ms);
                doc.Open();

                BaseFont bfReg = LoadFont("cambria.ttc,0", BaseFont.TIMES_ROMAN);

                var fontHeader = FontFactory.GetFont(FontFactory.TIMES_BOLD, 14);
                var fontTitle = FontFactory.GetFont(FontFactory.TIMES_BOLD, 15);
                var fontLabel = FontFactory.GetFont(FontFactory.TIMES_BOLD, 11);
                var fontValue = FontFactory.GetFont(FontFactory.TIMES, 11);
                var fontBody = FontFactory.GetFont(FontFactory.TIMES, 11);

                Font fSign = new Font(bfReg, 10.5f);

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

                //var sigSpacer = new Paragraph(" ") { SpacingAfter = 60 };
                //doc.Add(sigSpacer);

                //var sigTable = new PdfPTable(2) { WidthPercentage = 100 };
                //sigTable.AddCell(new PdfPCell(new Phrase("_______________________\nDocument Manager", fontLabel)) { Border = Rectangle.NO_BORDER });
                //var uhCell = new PdfPCell(new Phrase("_______________________\nUnit Head\nDocumentation Unit", fontLabel)) { Border = Rectangle.NO_BORDER, HorizontalAlignment = Element.ALIGN_RIGHT };
                //sigTable.AddCell(uhCell);
                //doc.Add(sigTable);

                //var sigSpacer2 = new Paragraph(" ") { SpacingAfter = 40 };
                //doc.Add(sigSpacer2);

                //var sigTable2 = new PdfPTable(2) { WidthPercentage = 100 };
                //sigTable2.AddCell(new PdfPCell(new Phrase("_______________________\nDeputy Head of CAD", fontLabel)) { Border = Rectangle.NO_BORDER });
                //var uhCell2 = new PdfPCell(new Phrase("_______________________\nHead of CAD", fontLabel)) { Border = Rectangle.NO_BORDER, HorizontalAlignment = Element.ALIGN_RIGHT };
                //sigTable2.AddCell(uhCell2);
                //doc.Add(sigTable2);

                string sigFolder = HttpContext.Current.Server.MapPath("~/SOD_Signature");
                //DataRow row = (data != null && data.BranchName.Length > 0);// ? data.Rows[0] : null;

                //string docMgrId = Val(row, "DocManagerEmpId");
                //string unitHeadId = Val(row, "UnitHeadEmpId");
                //string depHeadId = Val(row, "DeputyHeadEmpId");
                //string headCadId = Val(row, "HeadCADEmpId");

                string docMgrId = "11";
                string unitHeadId = "12";
                string depHeadId = "13";
                string headCadId = "14";

                PdfPTable sig = new PdfPTable(4);
                sig.WidthPercentage = 100;
                sig.SetWidths(new float[] { 28f, 30f, 27f, 15f });
                sig.SpacingBefore = 35f;

                // Row 1: images, then captions
                sig.AddCell(SignImageCell(sigFolder, docMgrId));
                sig.AddCell(EmptyCell());
                sig.AddCell(SignImageCell(sigFolder, unitHeadId));
                sig.AddCell(EmptyCell());

                sig.AddCell(SignCell("Document Manager", null, fSign, true));
                sig.AddCell(EmptyCell());
                sig.AddCell(SignCell("Unit Head", "Documentation & Custodian Unit", fSign, true));
                sig.AddCell(EmptyCell());

                AddSpacerRow(sig, 4, 15f);

                // Row 2: images, then captions
                sig.AddCell(SignImageCell(sigFolder, depHeadId));
                sig.AddCell(EmptyCell());
                sig.AddCell(SignImageCell(sigFolder, headCadId));
                sig.AddCell(EmptyCell());

                sig.AddCell(SignCell("Deputy Head of CAD", null, fSign, true));
                sig.AddCell(EmptyCell());
                sig.AddCell(SignCell("Head of CAD", null, fSign, true));
                sig.AddCell(EmptyCell());

                doc.Add(sig);

                doc.Close();
                return ms.ToArray();
            }
        }

        public static byte[] GenerateUnconDeCentralizedSscPdf(int drawdownId)
        {
            SSCData data = SscRepository.GetSscData(drawdownId);
            if (data == null) throw new Exception("No record found for drawdown_id " + drawdownId);

            using (var ms = new MemoryStream())
            {
                var doc = new Document(PageSize.A4, 50, 50, 50, 50);
                PdfWriter.GetInstance(doc, ms);
                doc.Open();

                BaseFont bfReg = LoadFont("cambria.ttc,0", BaseFont.TIMES_ROMAN);
                BaseFont bfBold = LoadFont("cambriab.ttf", BaseFont.TIMES_BOLD);
                BaseFont bfBI = LoadFont("cambriaz.ttf", BaseFont.TIMES_BOLDITALIC);

                BaseColor gray = new BaseColor(128, 128, 128);

                var fontHeader = FontFactory.GetFont(FontFactory.TIMES_BOLD, 14);
                var fontTitle = FontFactory.GetFont(FontFactory.TIMES_BOLD, 15);
                var fontLabel = FontFactory.GetFont(FontFactory.TIMES_BOLD, 11);
                var fontValue = FontFactory.GetFont(FontFactory.TIMES, 11);
                var fontBody = FontFactory.GetFont(FontFactory.TIMES, 11);

                Font fTitle = new Font(bfBold, 13);
                Font fHead = new Font(bfBold, 12);
                Font fHeadGry = new Font(bfBold, 12, Font.NORMAL, gray);
                Font fBody = new Font(bfReg, 9.5f);
                Font fBodyBI = new Font(bfBI, 9.5f);
                Font fLabel = new Font(bfBold, 9.5f);
                Font fValue = new Font(bfReg, 9.5f, Font.NORMAL, gray);
                Font fSign = new Font(bfReg, 10.5f);

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

                //var body = new Paragraph(
                //    "We certify that all security documentation have been completed, physically checked and are in order. " +
                //    "We further confirm compliance with all the terms pertaining to documentation as per approval. " +
                //    "Following table contains details of Security Satisfaction Certificate.",
                //    fontBody) { SpacingAfter = 15, Alignment = Element.ALIGN_JUSTIFIED };
                //doc.Add(body);

                //var bodyN = new Paragraph(
                //    "As such we accord you drawdown permission.",
                //    fontBody) { SpacingAfter = 15, Alignment = Element.ALIGN_JUSTIFIED };
                //doc.Add(body);
                Paragraph p1 = new Paragraph(
                "It appears from your Checklist that you have completed the security documentation and other necessary " +
                "formalities in compliance with the terms and conditions as per HO approval mentioned in the below table. " +
                "Please note that virtually we have to depend on your comments on compliance status as singled out in the " +
                "relevant Checklist with respect to security and loan documentation in good faith. Therefore, your fair " +
                "disclosures in all such cases are highly desired by the Management for better safeguard of the interest of the Bank.",
                fBody);
                p1.Alignment = Element.ALIGN_JUSTIFIED;
                p1.Leading = 13.5f;
                doc.Add(p1);

                Chunk bold = new Chunk("As such we accord you drawdown permission.", fBodyBI);
                bold.SetCharacterSpacing(1f);

                Paragraph p2 = new Paragraph();
                p2.Alignment = Element.ALIGN_JUSTIFIED;
                p2.Leading = 13.5f;
                p2.Add(new Chunk(
                    "You are advised to comply with all the sanction terms-conditions, the Circulars/Guidelines of Bangladesh Bank " +
                    "and other Regulatory Authorities, current Credit Policy & relevant Circulars of our Bank and usual banking norms " +
                    "meticulously. Please ensure preserving of all the security documents related to every credit facility under your " +
                    "safe custody having duly recorded in the Safe-in Safe-out Register of your Branch. ", fBody));
                p2.Add(bold);
                p2.SpacingAfter = 18f;
                doc.Add(p2);

                Paragraph intro = new Paragraph("Following table contains details of Security Satisfaction Certificate.", fBody);
                intro.SpacingAfter = 6f;
                doc.Add(intro);

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

                //var sigSpacer = new Paragraph(" ") { SpacingAfter = 60 };
                //doc.Add(sigSpacer);

                //var sigTable = new PdfPTable(2) { WidthPercentage = 100 };
                //sigTable.AddCell(new PdfPCell(new Phrase("_______________________\nDocument Manager", fontLabel)) { Border = Rectangle.NO_BORDER });
                //var uhCell = new PdfPCell(new Phrase("_______________________\nUnit Head\nDocumentation Unit", fontLabel)) { Border = Rectangle.NO_BORDER, HorizontalAlignment = Element.ALIGN_RIGHT };
                //sigTable.AddCell(uhCell);
                //doc.Add(sigTable);

                //var sigSpacer2 = new Paragraph(" ") { SpacingAfter = 40 };
                //doc.Add(sigSpacer2);

                //var sigTable2 = new PdfPTable(2) { WidthPercentage = 100 };
                //sigTable2.AddCell(new PdfPCell(new Phrase("_______________________\nDeputy Head of CAD", fontLabel)) { Border = Rectangle.NO_BORDER });
                //var uhCell2 = new PdfPCell(new Phrase("_______________________\nHead of CAD", fontLabel)) { Border = Rectangle.NO_BORDER, HorizontalAlignment = Element.ALIGN_RIGHT };
                //sigTable2.AddCell(uhCell2);
                //doc.Add(sigTable2);

                // ----- Signature blocks (2 x 2) -----
                //PdfPTable sig = new PdfPTable(4);
                //sig.WidthPercentage = 100;
                //sig.SetWidths(new float[] { 28f, 30f, 27f, 15f });
                //sig.SpacingBefore = 55f;

                //AddSpacerRow(sig, 4, 30f);
                //sig.AddCell(SignCell("Document Manager", null, fSign, true));
                //sig.AddCell(EmptyCell());
                //sig.AddCell(SignCell("Unit Head", "Documentation & Custodian Unit", fSign, true));
                //sig.AddCell(EmptyCell());

                //AddSpacerRow(sig, 4, 45f);
                //sig.AddCell(SignCell("Deputy Head of CAD", null, fSign, true));
                //sig.AddCell(EmptyCell());
                //sig.AddCell(SignCell("Head of CAD", null, fSign, true));
                //sig.AddCell(EmptyCell());

                //doc.Add(sig);

                // ----- Signature blocks (2 x 2) with signature images -----
                string sigFolder = HttpContext.Current.Server.MapPath("~/SOD_Signature");
                //DataRow row = (data != null && data.BranchName.Length > 0);// ? data.Rows[0] : null;

                //string docMgrId = Val(row, "DocManagerEmpId");
                //string unitHeadId = Val(row, "UnitHeadEmpId");
                //string depHeadId = Val(row, "DeputyHeadEmpId");
                //string headCadId = Val(row, "HeadCADEmpId");

                string docMgrId = "11";
                string unitHeadId = "12";
                string depHeadId = "13";
                string headCadId = "14";

                PdfPTable sig = new PdfPTable(4);
                sig.WidthPercentage = 100;
                sig.SetWidths(new float[] { 28f, 30f, 27f, 15f });
                sig.SpacingBefore = 35f;

                // Row 1: images, then captions
                sig.AddCell(SignImageCell(sigFolder, docMgrId));
                sig.AddCell(EmptyCell());
                sig.AddCell(SignImageCell(sigFolder, unitHeadId));
                sig.AddCell(EmptyCell());

                sig.AddCell(SignCell("Document Manager", null, fSign, true));
                sig.AddCell(EmptyCell());
                sig.AddCell(SignCell("Unit Head", "Documentation & Custodian Unit", fSign, true));
                sig.AddCell(EmptyCell());

                AddSpacerRow(sig, 4, 15f);

                // Row 2: images, then captions
                sig.AddCell(SignImageCell(sigFolder, depHeadId));
                sig.AddCell(EmptyCell());
                sig.AddCell(SignImageCell(sigFolder, headCadId));
                sig.AddCell(EmptyCell());

                sig.AddCell(SignCell("Deputy Head of CAD", null, fSign, true));
                sig.AddCell(EmptyCell());
                sig.AddCell(SignCell("Head of CAD", null, fSign, true));
                sig.AddCell(EmptyCell());

                doc.Add(sig);

                doc.Close();
                return ms.ToArray();
            }
        }

        
        public static byte[] GenerateCondCentralizedSSCPdf(int drawdownId)
        {
            SSCData data = SscRepository.GetSscConditionalData(drawdownId);
            if (data == null) throw new Exception("No record found for drawdown_id " + drawdownId);

            using (var ms = new MemoryStream())
            {
                var doc = new Document(PageSize.A4, 50, 50, 50, 50);
                PdfWriter.GetInstance(doc, ms);
                doc.Open();
                
                BaseFont bfReg = LoadFont("cambria.ttc,0", BaseFont.TIMES_ROMAN);

                var fontHeader = FontFactory.GetFont(FontFactory.TIMES_BOLD, 14);
                var fontTitle = FontFactory.GetFont(FontFactory.TIMES_BOLD, 15);
                var fontLabel = FontFactory.GetFont(FontFactory.TIMES_BOLD, 11);
                var fontValue = FontFactory.GetFont(FontFactory.TIMES, 11);
                var fontBody = FontFactory.GetFont(FontFactory.TIMES, 11);

                Font fSign = new Font(bfReg, 10.5f);

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

                //var sigSpacer = new Paragraph(" ") { SpacingAfter = 30 };
                //doc.Add(sigSpacer);

                //var sigTable = new PdfPTable(2) { WidthPercentage = 100 };
                //sigTable.AddCell(new PdfPCell(new Phrase("_______________________\nDocument Manager", fontLabel)) { Border = Rectangle.NO_BORDER });
                //var uhCell = new PdfPCell(new Phrase("_______________________\nUnit Head\nDocumentation & Custodian Unit", fontLabel)) { Border = Rectangle.NO_BORDER, HorizontalAlignment = Element.ALIGN_RIGHT };
                //sigTable.AddCell(uhCell);
                //doc.Add(sigTable);

                //var sigSpacer2 = new Paragraph(" ") { SpacingAfter = 20 };
                //doc.Add(sigSpacer2);

                //var sigTable2 = new PdfPTable(2) { WidthPercentage = 100 };
                //sigTable2.AddCell(new PdfPCell(new Phrase("_______________________\nDeputy Head of CAD", fontLabel)) { Border = Rectangle.NO_BORDER });
                //var uhCell2 = new PdfPCell(new Phrase("_______________________\nHead of CAD", fontLabel)) { Border = Rectangle.NO_BORDER, HorizontalAlignment = Element.ALIGN_RIGHT };
                //sigTable2.AddCell(uhCell2);
                //doc.Add(sigTable2);

                string sigFolder = HttpContext.Current.Server.MapPath("~/SOD_Signature");
                //DataRow row = (data != null && data.BranchName.Length > 0);// ? data.Rows[0] : null;

                //string docMgrId = Val(row, "DocManagerEmpId");
                //string unitHeadId = Val(row, "UnitHeadEmpId");
                //string depHeadId = Val(row, "DeputyHeadEmpId");
                //string headCadId = Val(row, "HeadCADEmpId");

                string docMgrId = "11";
                string unitHeadId = "12";
                string depHeadId = "13";
                string headCadId = "14";

                PdfPTable sig = new PdfPTable(4);
                sig.WidthPercentage = 100;
                sig.SetWidths(new float[] { 28f, 30f, 27f, 15f });
                sig.SpacingBefore = 35f;

                // Row 1: images, then captions
                sig.AddCell(SignImageCell(sigFolder, docMgrId));
                sig.AddCell(EmptyCell());
                sig.AddCell(SignImageCell(sigFolder, unitHeadId));
                sig.AddCell(EmptyCell());

                sig.AddCell(SignCell("Document Manager", null, fSign, true));
                sig.AddCell(EmptyCell());
                sig.AddCell(SignCell("Unit Head", "Documentation & Custodian Unit", fSign, true));
                sig.AddCell(EmptyCell());

                AddSpacerRow(sig, 4, 15f);

                // Row 2: images, then captions
                sig.AddCell(SignImageCell(sigFolder, depHeadId));
                sig.AddCell(EmptyCell());
                sig.AddCell(SignImageCell(sigFolder, headCadId));
                sig.AddCell(EmptyCell());

                sig.AddCell(SignCell("Deputy Head of CAD", null, fSign, true));
                sig.AddCell(EmptyCell());
                sig.AddCell(SignCell("Head of CAD", null, fSign, true));
                sig.AddCell(EmptyCell());

                doc.Add(sig);

                doc.Close();
                return ms.ToArray();
            }
        }

        public static byte[] GenerateCondDeCentralizedSSCPdf(int drawdownId)
        {
            SSCData data = SscRepository.GetSscConditionalData(drawdownId);
            if (data == null) throw new Exception("No record found for drawdown_id " + drawdownId);

            using (var ms = new MemoryStream())
            {
                var doc = new Document(PageSize.A4, 50, 50, 50, 50);
                PdfWriter.GetInstance(doc, ms);
                doc.Open();

                BaseFont bfReg = LoadFont("cambria.ttc,0", BaseFont.TIMES_ROMAN);
                BaseFont bfBold = LoadFont("cambriab.ttf", BaseFont.TIMES_BOLD);
                BaseFont bfBI = LoadFont("cambriaz.ttf", BaseFont.TIMES_BOLDITALIC);

                BaseColor gray = new BaseColor(128, 128, 128);

                var fontHeader = FontFactory.GetFont(FontFactory.TIMES_BOLD, 14);
                var fontTitle = FontFactory.GetFont(FontFactory.TIMES_BOLD, 15);
                var fontLabel = FontFactory.GetFont(FontFactory.TIMES_BOLD, 11);
                var fontValue = FontFactory.GetFont(FontFactory.TIMES, 11);
                var fontBody = FontFactory.GetFont(FontFactory.TIMES, 11);

                Font fTitle = new Font(bfBold, 13);
                Font fHead = new Font(bfBold, 12);
                Font fHeadGry = new Font(bfBold, 12, Font.NORMAL, gray);
                Font fBody = new Font(bfReg, 9.5f);
                Font fBodyBI = new Font(bfBI, 9.5f);
                Font fLabel = new Font(bfBold, 9.5f);
                Font fValue = new Font(bfReg, 9.5f, Font.NORMAL, gray);
                Font fSign = new Font(bfReg, 10.5f);

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

                //var body = new Paragraph(
                //    "We certify that all security documentation have been completed, physically checked and are in order. " +
                //    "We further confirm compliance with all the terms pertaining to documentation as per approval. " +
                //    "Following table contains details of Security Satisfaction Certificate.",
                //    fontBody) { SpacingAfter = 15, Alignment = Element.ALIGN_JUSTIFIED };
                //doc.Add(body);

                Paragraph p1 = new Paragraph(
                "On perusal of the documentation checklist, it appears that you have completed the documentation formalities in compliance " +
                "with the terms and conditions of HO sanction letter except the following, which have been allowed up to your declared " +
                "deadlines by the Managing Director, vide CAD Office under his delegated authority as approved by the Board of Directors of the Bank: ",
                fBody);
                p1.Alignment = Element.ALIGN_JUSTIFIED;
                p1.Leading = 13.5f;
                doc.Add(p1);

                Paragraph p3 = new Paragraph(
                "Please note that virtually we have to depend upon your comments on compliance status as singled out in the relevant checklist " +
                "with respect to security and loan documentation in good faith. So, your fair disclosures in all such cases are highly " +
                "desired by the management to better safeguard the interest of the Bank. ",
                fBody);
                p3.Alignment = Element.ALIGN_JUSTIFIED;
                p3.Leading = 13.5f;
                doc.Add(p3);

                Paragraph p4 = new Paragraph(
                "We would advise you for meticulous compliance of the terms and conditions of Head Office sanction advice, credit policy " +
                "and usual banking norms.",
                fBody);
                p4.Alignment = Element.ALIGN_JUSTIFIED;
                p4.Leading = 13.5f;
                doc.Add(p4);

                Chunk bold = new Chunk("As such we accord you drawdown permission.", fBodyBI);
                bold.SetCharacterSpacing(1f);

                Paragraph p2 = new Paragraph();
                p2.Alignment = Element.ALIGN_JUSTIFIED;
                p2.Leading = 13.5f;
                p2.Add(new Chunk(
                    "Please ensure safe keeping of all the security documents related to this credit facility duly recorded in the safe in safe out " +
                    "register of your branch. ", fBody));
                p2.Add(bold);
                p2.SpacingAfter = 18f;
                doc.Add(p2);

                Paragraph intro = new Paragraph("Following table contains details of Security Satisfaction Certificate.", fBody);
                intro.SpacingAfter = 6f;
                doc.Add(intro);

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

                //var sigSpacer = new Paragraph(" ") { SpacingAfter = 30 };
                //doc.Add(sigSpacer);

                //var sigTable = new PdfPTable(2) { WidthPercentage = 100 };
                //sigTable.AddCell(new PdfPCell(new Phrase("_______________________\nDocument Manager", fontLabel)) { Border = Rectangle.NO_BORDER });
                //var uhCell = new PdfPCell(new Phrase("_______________________\nUnit Head\nDocumentation & Custodian Unit", fontLabel)) { Border = Rectangle.NO_BORDER, HorizontalAlignment = Element.ALIGN_RIGHT };
                //sigTable.AddCell(uhCell);
                //doc.Add(sigTable);

                //var sigSpacer2 = new Paragraph(" ") { SpacingAfter = 20 };
                //doc.Add(sigSpacer2);

                //var sigTable2 = new PdfPTable(2) { WidthPercentage = 100 };
                //sigTable2.AddCell(new PdfPCell(new Phrase("_______________________\nDeputy Head of CAD", fontLabel)) { Border = Rectangle.NO_BORDER });
                //var uhCell2 = new PdfPCell(new Phrase("_______________________\nHead of CAD", fontLabel)) { Border = Rectangle.NO_BORDER, HorizontalAlignment = Element.ALIGN_RIGHT };
                //sigTable2.AddCell(uhCell2);
                //doc.Add(sigTable2);

                // ----- Signature blocks (2 x 2) with signature images -----
                string sigFolder = HttpContext.Current.Server.MapPath("~/SOD_Signature");
                //DataRow row = (data != null && data.BranchName.Length > 0);// ? data.Rows[0] : null;

                //string docMgrId = Val(row, "DocManagerEmpId");
                //string unitHeadId = Val(row, "UnitHeadEmpId");
                //string depHeadId = Val(row, "DeputyHeadEmpId");
                //string headCadId = Val(row, "HeadCADEmpId");

                string docMgrId = "11";
                string unitHeadId = "12";
                string depHeadId = "13";
                string headCadId = "14";

                PdfPTable sig = new PdfPTable(4);
                sig.WidthPercentage = 100;
                sig.SetWidths(new float[] { 28f, 30f, 27f, 15f });
                sig.SpacingBefore = 35f;

                // Row 1: images, then captions
                sig.AddCell(SignImageCell(sigFolder, docMgrId));
                sig.AddCell(EmptyCell());
                sig.AddCell(SignImageCell(sigFolder, unitHeadId));
                sig.AddCell(EmptyCell());

                sig.AddCell(SignCell("Document Manager", null, fSign, true));
                sig.AddCell(EmptyCell());
                sig.AddCell(SignCell("Unit Head", "Documentation & Custodian Unit", fSign, true));
                sig.AddCell(EmptyCell());

                AddSpacerRow(sig, 4, 15f);

                // Row 2: images, then captions
                sig.AddCell(SignImageCell(sigFolder, depHeadId));
                sig.AddCell(EmptyCell());
                sig.AddCell(SignImageCell(sigFolder, headCadId));
                sig.AddCell(EmptyCell());

                sig.AddCell(SignCell("Deputy Head of CAD", null, fSign, true));
                sig.AddCell(EmptyCell());
                sig.AddCell(SignCell("Head of CAD", null, fSign, true));
                sig.AddCell(EmptyCell());

                doc.Add(sig);

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

        // ---------- Fonts ----------
        private static BaseFont LoadFont(string file, string fallback)
        {
            try
            {
                string path = Path.Combine(Environment.GetFolderPath(Environment.SpecialFolder.Fonts), file);
                return BaseFont.CreateFont(path, BaseFont.IDENTITY_H, BaseFont.EMBEDDED);
            }
            catch
            {
                return BaseFont.CreateFont(fallback, BaseFont.CP1252, BaseFont.NOT_EMBEDDED);
            }
        }

        private static PdfPCell MakeCell(string text, Font f, int align)
        {
            PdfPCell c = new PdfPCell(new Phrase(text, f));
            c.HorizontalAlignment = align;
            c.VerticalAlignment = Element.ALIGN_MIDDLE;
            c.BorderWidth = 0.75f;
            c.PaddingTop = 1.5f;
            c.PaddingBottom = 3f;
            c.PaddingLeft = 4f;
            return c;
        }

        private static PdfPCell EmptyCell()
        {
            return new PdfPCell(new Phrase(" ")) { Border = Rectangle.NO_BORDER };
        }

        private static void AddSpacerRow(PdfPTable t, int cols, float height)
        {
            for (int i = 0; i < cols; i++)
            {
                PdfPCell c = new PdfPCell(new Phrase(" "));
                c.Border = Rectangle.NO_BORDER;
                c.FixedHeight = height;
                t.AddCell(c);
            }
        }

        // Cell with a line on top and the signature caption under it
        private static PdfPCell SignCell(string line1, string line2, Font f, bool topLine)
        {
            Paragraph p = new Paragraph(line1, f);
            if (!string.IsNullOrEmpty(line2)) p.Add(new Chunk("\n" + line2, f));

            PdfPCell c = new PdfPCell();
            c.AddElement(p);
            c.Border = topLine ? Rectangle.TOP_BORDER : Rectangle.NO_BORDER;
            c.BorderWidth = 0.75f;
            c.PaddingTop = 4f;
            c.PaddingLeft = 0f;
            return c;
        }

        // Loads images/signature/{empId}.jpg and returns a bottom-aligned image cell.
        // If the employee id is blank or the file is missing, an empty cell of the same height is returned,
        // so the signature line stays in the same place.
        private static PdfPCell SignImageCell(string folder, string empId)
        {
            const float cellHeight = 45f;

            PdfPCell cell = null;

            if (!string.IsNullOrWhiteSpace(empId))
            {
                // Path.GetFileName stops values like "..\..\x" from escaping the folder
                string fileName = Path.GetFileName(empId.Trim()) + ".png";
                string path = Path.Combine(folder, fileName);

                if (File.Exists(path))
                {
                    try
                    {
                        Image img = Image.GetInstance(path);
                        img.ScaleToFit(120f, 40f);          // keeps the aspect ratio
                        cell = new PdfPCell(img, false);
                        cell.HorizontalAlignment = Element.ALIGN_LEFT;
                        cell.VerticalAlignment = Element.ALIGN_BOTTOM;
                    }
                    catch
                    {
                        cell = null;                       // unreadable image -> leave blank
                    }
                }
            }

            if (cell == null) cell = new PdfPCell(new Phrase(" "));

            cell.Border = Rectangle.NO_BORDER;
            cell.FixedHeight = cellHeight;
            cell.Padding = 0f;
            cell.PaddingBottom = 2f;
            return cell;
        }

        private static string Val(DataRow r, string col)
        {
            return Val(r, col, "");
        }

        private static string Val(DataRow r, string col, string def)
        {
            if (r == null || !r.Table.Columns.Contains(col) || r[col] == DBNull.Value) return def;
            return Convert.ToString(r[col]);
        }

    }
