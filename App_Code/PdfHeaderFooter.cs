using iTextSharp.text;
using iTextSharp.text.pdf;
public class PdfHeaderFooter : PdfPageEventHelper
{
    public override void OnEndPage(
        PdfWriter writer, Document document)
    {
        PdfContentByte cb = writer.DirectContent;

        Font headerFont = FontFactory.GetFont(
            FontFactory.HELVETICA_BOLD, 15,
            new BaseColor(30, 60, 100));

        Font subFont = FontFactory.GetFont(
            FontFactory.HELVETICA_BOLD, 10,
            BaseColor.BLACK);

        ColumnText.ShowTextAligned(
            cb,
            Element.ALIGN_CENTER,
            new Phrase("Mercantile Bank PLC", headerFont),
            document.PageSize.Width / 2,
            document.PageSize.Height - 35,
            0
        );

        ColumnText.ShowTextAligned(
            cb,
            Element.ALIGN_CENTER,
            new Phrase("Credit Administration Division", subFont),
            document.PageSize.Width / 2,
            document.PageSize.Height - 52,
            0
        );

        // Header separator
        cb.MoveTo(30, document.PageSize.Height - 62);
        cb.LineTo(document.PageSize.Width - 30,
                  document.PageSize.Height - 62);
        cb.Stroke();

        // Footer page number
        ColumnText.ShowTextAligned(
            cb,
            Element.ALIGN_CENTER,
            new Phrase("Page " + writer.PageNumber,
                FontFactory.GetFont(
                    FontFactory.HELVETICA, 8)),
            document.PageSize.Width / 2,
            20,
            0
        );
    }
}