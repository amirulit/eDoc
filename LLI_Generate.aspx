<%@ Page Language="C#" AutoEventWireup="true" CodeFile="LLI_Generate.aspx.cs" Inherits="LLI_Generate" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.4.1/css/bootstrap.min.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/admin-lte/2.4.18/css/AdminLTE.min.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/admin-lte/2.4.18/css/skins/skin-blue.min.css" />


    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.4.1/js/bootstrap.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/admin-lte/2.4.18/js/app.min.js"></script>

    <script>

        /*
        function LoadFacilities() {

            $.ajax({
                type: "POST",


                url: "LLI_Generate.aspx/GetFacilities",


                data: "{}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",

                success: function (response) {

                    var data = response.d;

                    var table = $("#tblFacilities");

                    table.find("thead").empty();
                    table.find("tbody").empty();

                    if (!data || data.length === 0) {
                        table.find("tbody").append(
                            $("<tr>").append(
                                $("<td>", {
                                    colspan: 10,
                                    class: "text-center"
                                }).text("No facility records found")
                            )
                        );

                        $("#facilityModal").modal("show");
                        return;
                    }

                    // Get dynamic column names
                    var columns = Object.keys(data[0]);

                    // Bind table header
                    var header = $("<tr>");

                    $.each(columns, function (i, col) {
                        header.append(
                            $("<th>").text(col)
                        );
                    });

                    table.find("thead").append(header);

                    // Bind table body
                    $.each(data, function (i, row) {

                        var tr = $("<tr>");

                        $.each(columns, function (j, col) {

                            tr.append(
                                $("<td>").text(row[col] == null ? "" : row[col])
                            );

                        });

                        table.find("tbody").append(tr);

                    });

                    // Show Bootstrap modal
                    $("#facilityModal").modal("show");
                },

                error: function (xhr) {
                    alert("Error loading facility details.");
                    console.log(xhr.responseText);
                }
            });
        }
        */


        var facilityData = [];

        function LoadFacilities() {

            $.ajax({
                type: "POST",
                url: "LLI_Generate.aspx/GetFacilities",
                data: "{}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",

                success: function (response) {

                    facilityData = response.d;

                    var table = $("#tblFacilities");

                    table.find("thead").empty();
                    table.find("tbody").empty();

                    if (!facilityData || facilityData.length === 0)
                        return;

                    var columns = Object.keys(facilityData[0]);

                    // Header
                    var header = $("<tr>");

                    $.each(columns, function (i, col) {
                        header.append($("<th>").text(col));
                    });

                    table.find("thead").append(header);

                    // Body with input fields
                    // Body
                    $.each(facilityData, function (i, row) {

                        var tr = $("<tr>");

                        $.each(columns, function (j, col) {

                            // First column: Normal text
                            if (j === 0) {

                                tr.append(
                                    $("<td>")
                                        .text(row[col] == null ? "" : row[col])
                                );

                            }
                                // Remaining columns: Editable textbox
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

                    /*
                    var modal = new bootstrap.Modal(
                        document.getElementById("facilityModal")
                    );

                    modal.show();
                    */


                    $("#facilityModal").modal("show");
                },

                error: function (xhr) {
                    alert(xhr.responseText);
                }
            });
        }


        function SaveFacilities() {

            var updatedData = [];

            $("#tblFacilities tbody tr").each(function (i) {

                var row = {};

                $(this).find(".facility-input").each(function () {

                    var column = $(this).attr("data-column");

                    row[column] = $(this).val();

                });

                updatedData.push(row);

            });

            console.log(updatedData);

            // Send updatedData to another WebMethod using AJAX
        }

    </script>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <button type="button"
                class="btn btn-primary"
                onclick="LoadFacilities()">
                View Facilities
            </button>
            <div class="modal fade" id="facilityModal" tabindex="-1">
                <div class="modal-dialog modal-xl">
                    <div class="modal-content">

                        <div class="modal-header bg-primary text-white">
                            <h5 class="modal-title">Facility Details</h5>
                            <button type="button" class="btn-close btn-close-white"
                                data-bs-dismiss="modal">
                            </button>
                        </div>

                        <div class="modal-body">
                            <div class="table-responsive">
                                <table class="table table-bordered" id="tblFacilities">
                                    <thead class="table-light"></thead>
                                    <tbody></tbody>
                                </table>
                            </div>
                        </div>

                        <div class="modal-footer">
                            <button type="button" class="btn btn-success"
                                onclick="SaveFacilities()">
                                Save
               
                            </button>

                            <button type="button" class="btn btn-secondary"
                                data-bs-dismiss="modal">
                                Close
               
                            </button>
                        </div>

                    </div>
                </div>
            </div>
        </div>
    </form>
</body>
</html>
