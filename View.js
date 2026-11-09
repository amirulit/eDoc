$(document).ready(function () {



            // Upload View click
            $(document).on('click', '.docview', function (e) {

                e.preventDefault();

                var edocId = $(this).attr('data-edocid');

                $('#documentModal').modal('show');

                $('#documentListSection').show();
                $('#pdfViewerSection').hide();

                $('#pdfFrame').attr('src', '');

                $('#documentList').html('<tr><td colspan="6" class="text-center">Loading...</td></tr>');

                $.ajax({
                    type: "POST",
                    url: "SanctionListing_V2.aspx/GetUploadedDocuments",
                    data: JSON.stringify({ edocId: edocId }),
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",

                    success: function (response) {

                        var data = response.d;
                        var html = '';

                        if (data.length === 0) {

                            html = '<tr><td colspan="6" class="text-center">' + 'No documents found.</td></tr>';

                        } else {

                            $.each(data, function (i, item) {

                                html += '<tr>';

                                html += '<td>' + (i + 1) + '</td>';
                                html += '<td>' + $('<div>').text(item.FileType || '').html() + '</td>';
                                html += '<td>' + $('<div>').text(item.FileName || '').html() + '</td>';
                                html += '<td>' + $('<div>').text(item.UploadBy || '').html() + '</td>';
                                html += '<td>' + $('<div>').text(item.UploadTime || '').html() + '</td>';

                                html += '<td>';

                                if (item.FileName && item.FileName.toLowerCase().endsWith('.pdf')) {

                                    html += '<button type="button" ' + 'class="btn btn-success btn-xs viewPDF" ' + 'data-url="' + $('<div>').text(item.FileUrl).html() + '">' + '<i class="fa fa-file-pdf-o"></i> View PDF' + '</button>';

                                } else {

                                    html += '<span class="text-muted">Not PDF</span>';

                                }

                                html += '</td></tr>';

                            });

                        }

                        $('#documentList').html(html);

                    },

                    error: function (xhr) {

                        console.log(xhr.responseText);

                        $('#documentList').html('<tr><td colspan="6" class="text-danger text-center">' + 'Unable to load documents.</td></tr>');

                    }
                });

            });


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