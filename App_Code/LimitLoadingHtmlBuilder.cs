
using System;
using System.Data;
using System.Text;

public class LimitLoadingHtmlBuilder
{
    public static string CustomerRows(DataTable dt)
    {
        StringBuilder sb = new StringBuilder();

        for (int i = 0; i < 3; i++)
        {
            DataRow row = i < dt.Rows.Count
                ? dt.Rows[i] : null;

            sb.Append("<tr>");

            sb.Append("<td>Customer Name (" +
                (i + 1) + ")</td>");

            sb.Append("<td>" +
                Value(row, "CustomerName") + "</td>");

            sb.Append("<td>Customer ID (" +
                (i + 1) + ")</td>");

            sb.Append("<td>" +
                Value(row, "CustomerCode") + "</td>");

            sb.Append("</tr>");
        }

        return sb.ToString();
    }

    public static string FacilityHeaders()
    {
        StringBuilder sb = new StringBuilder();

        for (int i = 1; i <= 5; i++)
        {
            sb.Append("<th>Facility " +
                i.ToString("00") + "</th>");
        }

        return sb.ToString();
    }

    public static string FacilityRows(DataTable dt)
    {
        StringBuilder sb = new StringBuilder();

        string[,] fields =
        {
            { "Existing Limit", "ExistingLimit" },
            { "Sanction Limit", "SanctionLimit" },
            { "Drawdown asked for", "DrawdownAsked" },
            { "Limit Reference", "LimitReference" },
            { "Parent Code", "ParentCode" },
            { "Child Code", "ChildCode" },
            { "Existing Expiry", "ExistingExpiry" },
            { "Validity asked for", "ValidityAsked" }
        };

        for (int r = 0; r < fields.GetLength(0); r++)
        {
            sb.Append("<tr>");

            sb.Append("<td>" + fields[r, 0] + "</td>");

            for (int f = 1; f <= 5; f++)
            {
                DataRow facility = null;

                foreach (DataRow item in dt.Rows)
                {
                    if (Convert.ToInt32(item["FacilityNo"]) == f)
                    {
                        facility = item;
                        break;
                    }
                }

                sb.Append("<td>");
                sb.Append(Value(facility, fields[r, 1]));
                sb.Append("</td>");
            }

            sb.Append("</tr>");
        }

        return sb.ToString();
    }

    public static string RemarksRows(DataTable dt)
    {
        StringBuilder sb = new StringBuilder();

        for (int i = 0; i < 3; i++)
        {
            DataRow row = i < dt.Rows.Count
                ? dt.Rows[i] : null;

            sb.Append("<tr>");

            sb.Append("<td>" + (i + 1) + ".</td>");

            sb.Append("<td>");
            sb.Append(Value(row, "Remarks"));
            sb.Append("</td>");

            sb.Append("</tr>");
        }

        return sb.ToString();
    }

    private static string Value(
        DataRow row, string column)
    {
        if (row == null ||
            !row.Table.Columns.Contains(column))
            return "";

        return HtmlTemplateHelper.Encode(row[column]);
    }
}
