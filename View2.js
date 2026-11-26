$(document).ready(function () {

    //Upload View click
    $(document).on('click', '.docview', function (e) {

        e.preventDefault();

        var sanctionids = $(this).attr('sanction-ids');

        var drawdownid = $(this).attr('drawdown-id');


        //alert('sanctionids:'+sanctionids);

        //alert('drawdownid:' + drawdownid);



        $('#documentModal').modal('show');

        $('#documentListSection').show();

        $('#pdfViewerSection').hide();

        $('#pdfFrame').attr('src', '');

        $('#documentList').html('<tr><td colspan="6" class="text-center">Loading...</td></tr>');

        $.ajax({

            type: "POST",
            url: "DrawdownListing_V2.aspx/GetUploadedDocuments",
            data: JSON.stringify({ sanctionids: sanctionids, drawdownid: drawdownid }),
            contentType: "application/json; charset=utf-8",
            dataType: "json",

            success: function (response) {

                var result = response.d;

                var html = '';

                html += '<h4>Sanction Upload</h4>';
                html += generateDocumentTable(result.Table1, 'table1');

                html += '<hr/>';

                html += '<h4>Documentiton Upload</h4>';
                html += generateDocumentTable(result.Table2, 'table2');

                $('#documentList').html(html);

            },

            error: function (xhr) {

                console.log(xhr.responseText);

                $('#documentList').html('<tr><td colspan="6" class="text-danger text-center">' + 'Unable to load documents.</td></tr>');

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

                    //html += '<button type="button" class="btn btn-success btn-xs viewPDF"    data-url="' + encodeURIComponent(item.FileUrl || '') + '">View PDF</button>';


                    html += '<button type="button" class="btn btn-success btn-xs viewPDF"    data-url="' + item.FileUrl + '">View PDF</button>';

                    //html += '<button type="button" class="btn btn-success btn-xs viewPDF" data-url="' + $('<div>').text(item.FileUrl || '').html() + '">View PDF</button>';

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

    // View PDF inside modal
    $(document).on('click', '.viewPDF', function () {

        var fileUrl = $(this).attr('data-url');

        $('#pdfFrame').attr('src', fileUrl);

        $('#documentListSection').hide();
        $('#pdfViewerSection').show();

    });


    // Back to document list
    $(document).on('click', '#btnBackDocuments', function () {

        $('#pdfFrame').attr('src', '');

        $('#pdfViewerSection').hide();
        $('#documentListSection').show();

    });


    // Clear PDF when modal closes
    $(document).on('hidden.bs.modal', '#documentModal', function () {

        $('#pdfFrame').attr('src', '');

        $('#pdfViewerSection').hide();
        $('#documentListSection').show();

    });
});