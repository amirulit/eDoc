$(document).ready(function () {




    $('#fileUploadID').on("change", function () {

        //uploadFile();

        var f_name = '';
        var f_size = '';

        document.getElementById('r').innerHTML = '';
        var filelists = '';

        var fileUploadID = document.getElementById("fileUploadID");
        var aryFiles = fileUploadID.files;
        total_files = aryFiles.length;
        for (var i = 0; i < aryFiles.length; i++) {

            f_name = aryFiles[i].name;
            f_size = (aryFiles[i].size / (1024 * 1024)).toFixed(2);


            filelists = filelists + "<tr><td>" + (i + 1) + "</td><td>" + f_name + "</td><td>" + f_size + "</td><td><span id='file_" + i + "'>0%</span><span id='error_" + i + "'></span></td></tr>";
            //filelists = filelists + "<tr><td>" + (i + 1) + "</td><td>" + aryFiles[i].name + "</td><td>" + aryFiles[i].size + "</td><td><span id='file_" + i + "'>0%</span></td></tr>";
            //alert(aryFiles[i].name);
        }
        filelists = "<table class='table'><thead><tr><th>SL</th><th>File Name</th><th>Size</th><th>Upload Status(%)</th></tr></thead>" + filelists + "</table>";
        document.getElementById('r').innerHTML = filelists;

    });




    $("#btnSubmit").click(function () {

        //var dd_id = $(this).attr("dd-id");

        //var edoc_id = $("#ContentPlaceHolder1_txtEdocId").val();

        var edoc_id = $("#lblID").text();
        

        alert(edoc_id);

        upload_sanction_letter(edoc_id);



    });






    function upload_sanction_letter(edoc_id) {

        var filelists = '';
        var fileUploadID = document.getElementById("fileUploadID");
        var aryFiles = fileUploadID.files;
        for (var i = 0; i < aryFiles.length; i++) {

            /*
            var fileName = aryFiles[i].name.startsWith("1111_");
            if (!fileName)
            alert("Please upload file with name starting with 1111_");
            else
            alert("Done.");
            */

            //alert(aryFiles[i].name);
            upload(aryFiles[i], i, edoc_id);
            //filelists = filelists + "<tr><td>" + aryFiles[i].name + "</td><td><span id='" + i + "'></span></td></tr>";

        }


        //return "OK";

        //MailSend(file_no, 22)

        //setTimeout(MailSend(file_no, 22), 20000);


    }






    function upload(f, i, edoc_id) {

        //alert(f.name);

        //var doc_type = $('#ContentPlaceHolder1_select8').val()


        var doc_type = $('#select8').val()


        var formData = new FormData();

        formData.append("edoc_id", edoc_id);

        formData.append("doc_type", doc_type);

        formData.append("file", f);

        //alert('tttt'); 

        $.ajax({


            url: 'WebService3.asmx/UploadFiles_CD',
            type: 'POST',
            data: formData,
            cache: false,
            contentType: false,
            processData: false,
            success: function (fileName) {

                $("#fileProgress").hide();

                $("#lblMessage").html("<b>" + fileName + "</b> has been uploaded.");

                uploaded_files = uploaded_files + 1;

                if (uploaded_files == total_files) {

                    alert(doc_type + ' Uploaded');

                    uploaded_files = 0;
                    //MailSend(file_no, 22);

                    alert('Uploaded sucessfully');

                }
            },
            xhr: function () {
                var fileXhr = $.ajaxSettings.xhr();
                //Check if upload property exists
                if (fileXhr.upload) {
                    //update progressbar percent complete
                    fileXhr.upload.addEventListener("progress", function (e) {
                        if (e.lengthComputable) {
                            //$("#statustxt").attr({ value: e.loaded, max: e.total });
                            //console.log("Value = " + e.loaded + " :: Max =" + e.total);
                            var percentage = Math.floor((e.loaded / e.total) * 100);
                            console.log(f.name + ' : ' + percentage + '%');
                            $("#statustxt").html(percentage + '%');
                            $("#file_" + i + "").html(percentage + '%');
                        }
                    }, false);
                }
                return fileXhr;
            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                $("#file_" + i + "").html('0%');
                //$("#error_" + i + "").html(XMLHttpRequest.responseText + '-' + textStatus + '-' + errorThrown);
                $("#error_" + i + "").html(XMLHttpRequest.status + '-' + XMLHttpRequest.statusText);
                //alert("Whoops something went wrong!");

                alert("Upload failed for file: " + dd_id + "\n\nUploading has been stopped.");


            }
        });



    }









});