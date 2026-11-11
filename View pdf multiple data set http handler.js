// Upload View click
$(document).on('click', '.docview', function (e) {

    e.preventDefault();

    var edocId = $(this).attr('data-edocid');
    var anotherId = $(this).attr('data-anotherid');

    $('#documentModal').modal('show');

    $('#documentListSection').show();
    $('#pdfViewerSection').hide();

    $('#pdfFrame').attr('src', '');

    $('#documentList').html(
        '<tr><td colspan="6" class="text-center">Loading...</td></tr>'
    );

    $.ajax({

        type: "POST",
        url: "SanctionListing_V2.aspx/GetUploadedDocuments",

        data: JSON.stringify({
            edocId: edocId,
            anotherId: anotherId
        }),

        contentType: "application/json; charset=utf-8",
        dataType: "json",

        success: function (response) {

            var result = response.d;

            var html = '';

            // First Dataset
            html += '<h4>Document List 1</h4>';
            html += generateDocumentTable(result.Table1, 'table1');

            html += '<hr/>';

            // Second Dataset
            html += '<h4>Document List 2</h4>';
            html += generateDocumentTable(result.Table2, 'table2');

            $('#documentList').html(html);

        },

        error: function (xhr) {

            console.log(xhr.responseText);

            $('#documentList').html(
                '<tr><td colspan="6" class="text-danger text-center">' +
                'Unable to load documents.</td></tr>'
            );

        }

    });

});


// Generate document table
function generateDocumentTable(data, tableName) {

    var html = '';

    html += '<table class="table table-bordered table-striped">';
    html += '<thead>';
    html += '<tr>';
    html += '<th>SL</th>';
    html += '<th>File Type</th>';
    html += '<th>File Name</th>';
    html += '<th>Upload By</th>';
    html += '<th>Upload Time</th>';
    html += '<th>Action</th>';
    html += '</tr>';
    html += '</thead>';

    html += '<tbody>';

    if (!data || data.length === 0) {

        html += '<tr><td colspan="6" class="text-center">No documents found.</td></tr>';

    } else {

        $.each(data, function (i, item) {

            html += '<tr>';

            html += '<td>' + (i + 1) + '</td>';
            html += '<td>' + $('<div>').text(item.FileType || '').html() + '</td>';
            html += '<td>' + $('<div>').text(item.FileName || '').html() + '</td>';
            html += '<td>' + $('<div>').text(item.UploadBy || '').html() + '</td>';
            html += '<td>' + $('<div>').text(item.UploadTime || '').html() + '</td>';

            html += '<td>';

            if (item.FileName &&
                item.FileName.toLowerCase().endsWith('.pdf')) {

                html += '<button type="button" class="btn btn-success btn-xs viewPDF" data-url="' +
                    encodeURIComponent(item.FileUrl || '') +
                    '">View PDF</button>';

            } else {

                html += '<span class="text-muted">Not PDF</span>';

            }

            html += '</td>';
            html += '</tr>';

        });

    }

    html += '</tbody>';
    html += '</table>';

    return html;
}


// View PDF button click
$(document).on('click', '.viewPDF', function () {

    var pdfUrl = decodeURIComponent($(this).attr('data-url'));

    if (!pdfUrl) {
        alert('PDF URL not found.');
        return;
    }

    $('#documentListSection').hide();
    $('#pdfViewerSection').show();

    $('#pdfFrame').attr('src', pdfUrl);

});



#################


[WebMethod]
[ScriptMethod(ResponseFormat = ResponseFormat.Json)]
public static object GetUploadedDocuments(string edocId, string anotherId)
{
    DataTable dt1 = new DataTable();
    DataTable dt2 = new DataTable();

    // First dataset
    using (SqlConnection con = new SqlConnection(
        ConfigurationManager.ConnectionStrings["YourConnectionString"].ConnectionString))
    {
        using (SqlCommand cmd = new SqlCommand("SP_GetUploadedDocuments", con))
        {
            cmd.CommandType = CommandType.StoredProcedure;

            cmd.Parameters.AddWithValue("@edocId", edocId);
            cmd.Parameters.AddWithValue("@anotherId", anotherId);

            using (SqlDataAdapter da = new SqlDataAdapter(cmd))
            {
                DataSet ds = new DataSet();

                da.Fill(ds);

                if (ds.Tables.Count > 0)
                    dt1 = ds.Tables[0];

                if (ds.Tables.Count > 1)
                    dt2 = ds.Tables[1];
            }
        }
    }

    return new
    {
        Table1 = dt1,
        Table2 = dt2
    };
}


#######################


<div id="documentModal" class="modal fade" role="dialog">

    <div class="modal-dialog modal-lg">

        <div class="modal-content">

            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">
                    &times;
                </button>
                <h4 class="modal-title">Uploaded Documents</h4>
            </div>

            <div class="modal-body">

                <!-- Document List -->
                <div id="documentListSection">

                    <div id="documentList"></div>

                </div>

                <!-- PDF Viewer -->
                <div id="pdfViewerSection" style="display:none;">

                    <button type="button"
                            class="btn btn-default"
                            onclick="
                                $('#pdfViewerSection').hide();
                                $('#documentListSection').show();
                                $('#pdfFrame').attr('src','');
                            ">
                        Back to Documents
                    </button>

                    <hr />

                    <iframe id="pdfFrame"
                            style="width:100%; height:600px; border:0;"
                            src="">
                    </iframe>

                </div>

            </div>

        </div>

    </div>

</div>

######################


CREATE PROCEDURE SP_GetUploadedDocuments
(
    @edocId VARCHAR(50),
    @anotherId VARCHAR(50)
)
AS
BEGIN

    -- First Table
    SELECT
        FileType,
        FileName,
        UploadBy,
        UploadTime,
        FileUrl
    FROM UploadedDocuments
    WHERE EdocId = @edocId;


    -- Second Table
    SELECT
        FileType,
        FileName,
        UploadBy,
        UploadTime,
        FileUrl
    FROM OtherUploadedDocuments
    WHERE ReferenceId = @anotherId;

END







