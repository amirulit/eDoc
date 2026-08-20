<%@ Page Language="C#" AutoEventWireup="true" CodeFile="DocUpload.aspx.cs" Inherits="DocUpload" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style type="text/css">
        .tbl td
        {
            padding: 5px;
            border-bottom: 1px solid blue;
        }
    </style>
    <script src="jquery.min.js" type="text/javascript"></script>
    <script type="text/javascript">


        $(document).ready(function () {


            var fileInput = document.getElementById('id_Filename');
            var fileListDisplay = document.getElementById('fileselect');

            var fileList = [];
            var renderFileList, sendFile;

            fileInput.addEventListener('change', function (evnt) {
                fileList = [];
                for (var i = 0; i < fileInput.files.length; i++) {
                    fileList.push(fileInput.files[i]);
                }
                renderFileList();
            });

            renderFileList = function () {
                fileListDisplay.innerHTML = '';
                fileList.forEach(function (file, index) {

                    var fileDisplayEl = document.createElement('p');
                    //below line commented due to template literal
                    //below line must be uncommented to make it active
                    //fileDisplayEl.innerHTML = `${file.name} <button data-index="${index}" class='deletfile'>X</button>`;

                    fileListDisplay.appendChild(fileDisplayEl);
                });
            }


            $(document).on('click', '.deletfile', function () {
                var index = $(this).attr('data-index');
                fileList.splice(parseInt(index, 10), 1);
                $(this).parent().remove();
            });



        });

    </script>
    <script type="text/javascript">

        $(document).ready(function () {


            var total_files = 0;
            var uploaded_files = 0;

            var total_file_cnt = 0;

            function progressHandlingFunction(e) {
                if (e.lengthComputable) {
                    var percentage = Math.floor((e.loaded / e.total) * 100);
                    //update progressbar percent complete
                    statustxt.html(percentage + '%');
                    console.log("Value = " + e.loaded + " :: Max =" + e.total);
                }
            }

            function validate(file) {
                var ext = file.split(".");
                ext = ext[ext.length - 1].toLowerCase();
                var arrayExtensions = ["doc", "docx", "pdf"];

                if (arrayExtensions.lastIndexOf(ext) == -1) {
                    alert("Wrong extension type.");
                    //$("#image").val("");
                }
            }




            $("body").on("click", "#btnUpload", function () {

                var formData = new FormData();
                formData.append("fileName", $("#fileName").val());
                formData.append("file", $("#file")[0].files[0]);

                //alert('tttt');


                $.ajax({
                    url: 'WebService3.asmx/UploadFiles',
                    type: 'POST',
                    data: formData,
                    cache: false,
                    contentType: false,
                    processData: false,
                    success: function (fileName) {

                        $("#fileProgress").hide();
                        $("#lblMessage").html("<b>" + fileName + "</b> has been uploaded.");

                    },
                    xhr: function () {
                        var fileXhr = $.ajaxSettings.xhr();
                        //Check if upload property exists
                        if (fileXhr.upload) {

                            //update progressbar percent complete
                            fileXhr.upload.addEventListener("progress", function (e) {
                                if (e.lengthComputable) {
                                    //$("#statustxt").attr({ value: e.loaded, max: e.total });
                                    console.log("Value = " + e.loaded + " :: Max =" + e.total);
                                    var percentage = Math.floor((e.loaded / e.total) * 100);
                                    console.log(percentage + '%');
                                    $("#statustxt").html(percentage + '%');

                                }
                            }, false);

                        }
                        return fileXhr;


                    }, error: function () {
                        alert("Whoops something went wrong!");
                    }
                });
            });


            var fileList = [];

            $('#fileUploadID2').on('change', function (event) {

                fileList = [];

                // Append files to fileList 
                for (var i = 0; i < this.files.length; i++) {
                    fileList.push(this.files[i]);
                }
            });


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
                filelists = "<table class='tbl'><tr><td>SL</td><td>File Name</td><td>Size</td><td>Upload Status(%)</td></tr>" + filelists + "</table>";
                document.getElementById('r').innerHTML = filelists;

            });





            $("#but_upload").click(function () {
                /*
                var fd = new FormData(); 
                var files = $('#file')[0].files[0]; 
                fd.append('file', files); 
       
                $.ajax({ 
                url: 'upload.php', 
                type: 'post', 
                data: fd, 
                contentType: false, 
                processData: false, 
                success: function(response){ 
                if(response != 0){ 
                alert('file uploaded'); 
                } 
                else{ 
                alert('file not uploaded'); 
                } 
                }, 
                }); 
                */


                //var filelists = '';

                //var fileUploadID = document.getElementById("fileUploadID");
                //var aryFiles = fileUploadID.files;

                //total_file_cnt = aryFiles.length;

                up(0);

                //upload(aryFiles[i], i);

                //for (var i = 0; i < aryFiles.length; i++) {

                /*
                var fileName = aryFiles[i].name.startsWith("1111_");
                if (!fileName)
                alert("Please upload file with name starting with 1111_");
                else
                alert("Done.");
                */

                //alert(aryFiles[i].name);
                //upload(aryFiles[i], i);
                //filelists = filelists + "<tr><td>" + aryFiles[i].name + "</td><td><span id='" + i + "'></span></td></tr>";


                //setTimeout(upload(aryFiles[i], i), 100000);

                //setTimeout(MailSend(file_no, 22), 20000);

                //}

                //filelists = "<table>" + filelists + "</table>";
                /*
                if (total_files == uploaded_files) {
                alert('all files uploaded');
                } else {
                alert('total uploaded files : ' + uploaded_files + '. file not upoaded ' + (total_files - uploaded_files));
                }
                */
            });


            function up(i) {

                var fileUploadID = document.getElementById("fileUploadID");
                var aryFiles = fileUploadID.files;

                //var total_file_cnt = aryFiles.length;

                upload(aryFiles[i], i);

            }



            function upload(f, i) {

                //alert(f.name);



                var formData = new FormData();
                formData.append("fileName", f.name);
                formData.append("file", f);

                //alert('tttt');



                $.ajax({


                    url: 'WebService3.asmx/UploadFiles',
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
                            uploaded_files = 0;
                            alert('ALL Files Uploaded Sequentially');
                        } else {
                            up(i + 1);
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
                                    $("#file_" + i).html(percentage + '%');

                                    //$(this).parent().parent().css('backgroundColor', 'red');

                                    $("#file_" + i).parent().parent().css('backgroundColor', 'yellow');

                                    if (percentage >= 100)
                                        $("#file_" + i).parent().parent().css('backgroundColor', 'green');

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
                    }
                });
            }




            $("#Button1").click(function () {

                var obj = { ID: 1, Status: 'OK' };



                var formData = new FormData();
                formData.append("name", "suman");
                formData.append("roll", 10);

                $.ajax({

                    /*
                    url: 'WebService3.asmx/uplo',
                    type: 'POST',
                    contentType: "application/json; charset=utf-8",
                    data: JSON.stringify(obj),
                    datatype: "json",
                    */


                    url: 'WebService3.asmx/u',
                    type: 'POST',
                    data: formData,
                    cache: false,
                    contentType: false,
                    processData: false,


                    success: function (data) {
                        console.log(data.d);
                        alert(data.d);

                    },
                    error: function (XMLHttpRequest, textStatus, errorThrown) {

                        //$("#file_" + i + "").html('0%');
                        //$("#error_" + i + "").html(XMLHttpRequest.responseText + '-' + textStatus + '-' + errorThrown);
                        //$("#error_" + i + "").html(XMLHttpRequest.status + '-' + XMLHttpRequest.statusText);
                        //alert("Whoops something went wrong!");


                        alert(XMLHttpRequest.status + '-' + XMLHttpRequest.statusText + '-' + textStatus + '-' + errorThrown);
                    }
                });
            });
        });


        function checkFileForValidFilename_2() {

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

                alert(aryFiles[i].name);
                filelists = filelists + aryFiles[i].name + '\n'
            }

            document.getElementById("status").innerHTML = filelists;
        }





    </script>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <table>
            <tr>
                <td>
                    Name:
                </td>
                <td>
                    <input type="text" id="fileName" />
                </td>
            </tr>
            <tr>
                <td>
                    File:
                </td>
                <td>
                    <input type="file" id="file" />
                </td>
            </tr>
            <tr>
                <td>
                </td>
                <td>
                    <input type="button" id="btnUpload" value="Upload" />
                </td>
            </tr>
            <tr>
                <td colspan="2">
                    <div id="statustxt">
                        0%</div>
                    <span id='lblMessage'></span>
                </td>
            </tr>
        </table>
        <br />
        <input id="fileUploadID" type="file" name="files[]" multiple />
        <input type="button" value="Upload" id="but_upload" />
        <span id='status'></span>
        <br />
        <br />
        <div id='r'>
        </div>
        <br />
        <input id="Button1" type="button" value="button" />
    </div>
    </form>
</body>
</html>
