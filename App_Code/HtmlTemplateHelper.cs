
using System;
using System.IO;
using System.Web;
using System.Collections.Generic;

public class HtmlTemplateHelper
{
    public static string LoadTemplate(string filePath)
    {
        return File.ReadAllText(filePath);
    }

    public static string Encode(object value)
    {
        if (value == null || value == DBNull.Value)
            return "";

        return HttpUtility.HtmlEncode(
            Convert.ToString(value));
    }

    public static string Replace(
        string html, string key, object value)
    {
        return html.Replace(
            "{{" + key + "}}", Encode(value));
    }

    public static string ReplaceHtml(
        string html, string key, string value)
    {
        return html.Replace(
            "{{" + key + "}}", value ?? "");
    }
}
