DECLARE @cols NVARCHAR(MAX);
DECLARE @sql NVARCHAR(MAX);

-- Generate dynamic columns without STRING_AGG
SELECT @cols = STUFF((
    SELECT DISTINCT
        ',' + QUOTENAME('Facility' + CAST(FacilityNo AS VARCHAR(10)))
    FROM
    (
        SELECT
            ROW_NUMBER() OVER (ORDER BY id) AS FacilityNo
        FROM dbo.t_Sanction_Master_Details where edoc_id=567
    ) A
    FOR XML PATH(''), TYPE
).value('.', 'NVARCHAR(MAX)'), 1, 1, '');

SET @sql = '
SELECT *
FROM
(
    SELECT
        ''loan_nature'' AS FieldName,
        ''Facility'' + CAST(ROW_NUMBER() OVER (ORDER BY id) AS VARCHAR(10)) AS FacilityNo,
        CAST(loan_nature AS NVARCHAR(MAX)) AS Value
    FROM dbo.t_Sanction_Master_Details

    UNION ALL

    SELECT
        ''amount'',
        ''Facility'' + CAST(ROW_NUMBER() OVER (ORDER BY id) AS VARCHAR(10)),
        CAST(amount AS NVARCHAR(MAX))
    FROM dbo.t_Sanction_Master_Details

    UNION ALL

    SELECT
        ''validity'',
        ''Facility'' + CAST(ROW_NUMBER() OVER (ORDER BY id) AS VARCHAR(10)),
        CAST(validity AS NVARCHAR(MAX))
    FROM dbo.t_Sanction_Master_Details

    UNION ALL

    SELECT
        ''customer_name'',
        ''Facility'' + CAST(ROW_NUMBER() OVER (ORDER BY id) AS VARCHAR(10)),
        CAST(customer_name AS NVARCHAR(MAX))
    FROM dbo.t_Sanction_Master_Details
) AS SourceData
PIVOT
(
    MAX(Value)
    FOR FacilityNo IN (' + @cols + ')
) AS PivotTable;
';

EXEC sp_executesql @sql;




[WebMethod]
public static object GetFacilities()
{
    string conStr = ConfigurationManager
        .ConnectionStrings["dbconn"].ConnectionString;

    Dictionary<string, object> result =
        new Dictionary<string, object>();

    using (SqlConnection con = new SqlConnection(conStr))
    {
        con.Open();

        // TABLE 1: Sanction Master Details
        string sql1 = @" 
            -- Your existing dynamic SQL query here
        ";

        List<Dictionary<string, object>> table1 =
            GetTableData(con, sql1);

        // TABLE 2: Second Table
        string sql2 = @"
            SELECT *
            FROM dbo.Your_Second_Table
        ";

        List<Dictionary<string, object>> table2 =
            GetTableData(con, sql2);

        // TABLE 3: Third Table
        string sql3 = @"
            SELECT *
            FROM dbo.Your_Third_Table
        ";

        List<Dictionary<string, object>> table3 =
            GetTableData(con, sql3);

        result.Add("Facilities", table1);
        result.Add("OtherDetails", table2);
        result.Add("AdditionalDetails", table3);
    }

    return result;
}

function BindDynamicTable(tableId, data) {

    var table = $("#" + tableId);

    table.find("thead").empty();
    table.find("tbody").empty();

    if (!data || data.length === 0)
        return;

    var columns = Object.keys(data[0]);

    // Header
    var header = $("<tr>");

    $.each(columns, function (i, col) {
        header.append($("<th>").text(col));
    });

    table.find("thead").append(header);

    // Body
    $.each(data, function (i, row) {

        var tr = $("<tr>");

        $.each(columns, function (j, col) {

            if (j === 0) {
                tr.append(
                    $("<td>").text(row[col] == null ? "" : row[col])
                );
            }
            else {

                var input = $("<input>", {
                    type: "text",
                    class: "form-control facility-input",
                    "data-row": i,
                    "data-column": col
                });

                input.val(row[col] == null ? "" : row[col]);

                tr.append(
                    $("<td>").append(input)
                );
            }

        });

        table.find("tbody").append(tr);
    });
}

function BindDynamicTable(tableId, data) {

    var table = $("#" + tableId);

    table.find("thead").empty();
    table.find("tbody").empty();

    if (!data || data.length === 0)
        return;

    var columns = Object.keys(data[0]);

    // Header
    var header = $("<tr>");

    $.each(columns, function (i, col) {
        header.append($("<th>").text(col));
    });

    table.find("thead").append(header);

    // Body
    $.each(data, function (i, row) {

        var tr = $("<tr>");

        $.each(columns, function (j, col) {

            if (j === 0) {
                tr.append(
                    $("<td>").text(row[col] == null ? "" : row[col])
                );
            }
            else {

                var input = $("<input>", {
                    type: "text",
                    class: "form-control facility-input",
                    "data-row": i,
                    "data-column": col
                });

                input.val(row[col] == null ? "" : row[col]);

                tr.append(
                    $("<td>").append(input)
                );
            }

        });

        table.find("tbody").append(tr);
    });
}



function LoadFacilities() {

    $.ajax({
        type: "POST",
        url: "YourPage.aspx/GetFacilities",
        data: "{}",
        contentType: "application/json; charset=utf-8",
        dataType: "json",

        success: function (response) {

            var data = response.d;

            BindDynamicTable("tblFacilities", data.Facilities);

            BindDynamicTable("tblOtherDetails", data.OtherDetails);

            BindDynamicTable("tblAdditionalDetails", data.AdditionalDetails);

            var modal = new bootstrap.Modal(
                document.getElementById("facilityModal")
            );

            modal.show();
        },

        error: function (xhr) {
            console.log(xhr.responseText);
            alert("Error loading data");
        }
    });
}

