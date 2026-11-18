
<%@ Page Title="Document Management"
    Language="C#"
    MasterPageFile="~/Site.Master"
    AutoEventWireup="true"
    CodeFile="MasterDetail_V3.aspx.cs"
    Inherits="MasterDetail_V3" %>

<asp:Content ID="Content1"
    ContentPlaceHolderID="PageTitle"
    runat="server">
    Document Management
</asp:Content>

<asp:Content ID="Content2"
    ContentPlaceHolderID="MainContent"
    runat="server">

<style>

    .page-card {
        background: #fff;
        border: 1px solid #e1e7ef;
        border-radius: 6px;
        margin-bottom: 18px;
        box-shadow: 0 2px 5px rgba(0,0,0,.03);
    }

    .page-card-header {
        padding: 15px;
        border-bottom: 1px solid #e8edf3;
        color: #123c67;
        font-size: 16px;
        font-weight: 600;
    }

    .page-card-body {
        padding: 18px;
    }

    #tblMaster thead th,
    #tblDetails thead th {
        background: #eaf2fb;
        color: #123c67;
        white-space: nowrap;
    }

    #tblMaster tbody tr {
        cursor: pointer;
    }

    #tblMaster tbody tr:hover {
        background: #edf6ff !important;
    }

    #tblMaster tbody tr.selected-master {
        background: #dceeff !important;
        border-left: 4px solid #1686c9;
    }

    .info-panel {
        background: #fff;
        border: 1px solid #e1e7ef;
        border-radius: 6px;
        height: 100%;
    }

    .info-panel-header {
        background: #1265a8;
        color: #fff;
        padding: 14px;
        font-weight: 600;
        border-radius: 5px 5px 0 0;
    }

    .info-panel-body {
        padding: 16px;
    }

    .info-item {
        margin-bottom: 15px;
        padding-bottom: 10px;
        border-bottom: 1px solid #edf0f4;
    }

    .info-label {
        color: #8793a1;
        font-size: 11px;
        font-weight: 600;
        text-transform: uppercase;
        display: block;
        margin-bottom: 5px;
    }

    .info-value {
        color: #253c54;
        font-size: 13px;
        font-weight: 600;
        overflow-wrap: anywhere;
    }

    .detail-panel {
        background: #fff;
        border: 1px solid #e1e7ef;
        border-radius: 6px;
        min-height: 420px;
    }

    .detail-panel-header {
        padding: 15px;
        border-bottom: 1px solid #e8edf3;
    }

    .detail-panel-header h4 {
        margin: 0;
        color: #123c67;
        font-weight: 600;
    }

    .status-approved {
        background: #dff3e5;
        color: #237b42;
    }

    .status-pending {
        background: #fff0cf;
        color: #956400;
    }

    .status-rejected {
        background: #fbe2e2;
        color: #b72c2c;
    }

    .empty-selection {
        padding: 100px 20px;
        text-align: center;
        color: #8995a4;
    }

    @media(max-width:767px) {
        .info-panel {
            margin-bottom: 15px;
        }
    }

</style>


<!-- MASTER LIST DATATABLE -->

<div class="page-card">

    <div class="page-card-header">

        <i class="fa fa-folder-open"></i>
        Master Document Listing

        <button type="button"
            class="btn btn-primary btn-sm pull-right"
            onclick="alert('Connect New Document modal here')">

            <i class="fa fa-plus"></i>
            New Document

        </button>

        <div class="clearfix"></div>

    </div>

    <div class="page-card-body table-responsive">

        <table id="tblMaster"
            class="table table-bordered table-hover table-striped">

            <thead>
                <tr>
                    <th>Document No.</th>
                    <th>Reference No.</th>
                    <th>Subject</th>
                    <th>Department</th>
                    <th>Document Date</th>
                    <th>Status</th>
                </tr>
            </thead>

            <tbody></tbody>

        </table>

        <small class="text-muted">
            <i class="fa fa-hand-pointer-o"></i>
            Click a row to view master information and related details.
        </small>

    </div>

</div>


<!-- MASTER BASIC INFO + DETAIL SECTION -->

<div class="row">

    <!-- LEFT: MASTER BASIC INFORMATION -->

    <div class="col-md-3">

        <div class="info-panel">

            <div class="info-panel-header">

                <i class="fa fa-info-circle"></i>
                Basic Information

            </div>

            <div class="info-panel-body"
                id="masterInfo"
                style="display:none;">

                <div class="info-item">

                    <span class="info-label">
                        Document Number
                    </span>

                    <span class="info-value"
                        id="vDocumentNo">-</span>

                </div>


                <div class="info-item">

                    <span class="info-label">
                        Reference Number
                    </span>

                    <span class="info-value"
                        id="vReference">-</span>

                </div>


                <div class="info-item">

                    <span class="info-label">
                        Subject
                    </span>

                    <span class="info-value"
                        id="vSubject">-</span>

                </div>


                <div class="info-item">

                    <span class="info-label">
                        Document Date
                    </span>

                    <span class="info-value"
                        id="vDocumentDate">-</span>

                </div>


                <div class="info-item">

                    <span class="info-label">
                        Department
                    </span>

                    <span class="info-value"
                        id="vDepartment">-</span>

                </div>


                <div class="info-item">

                    <span class="info-label">
                        Created By
                    </span>

                    <span class="info-value"
                        id="vCreatedBy">-</span>

                </div>


                <div class="info-item">

                    <span class="info-label">
                        Created Date
                    </span>

                    <span class="info-value"
                        id="vCreatedDate">-</span>

                </div>


                <div class="info-item">

                    <span class="info-label">
                        Status
                    </span>

                    <span id="vStatus"
                        class="label label-info">
                        -
                    </span>

                </div>


                <div class="info-item">

                    <span class="info-label">
                        Remarks
                    </span>

                    <span class="info-value"
                        id="vRemarks">-</span>

                </div>


                <button type="button"
                    class="btn btn-primary btn-block"
                    id="btnEditMaster">

                    <i class="fa fa-edit"></i>
                    Edit Master

                </button>

            </div>


            <div id="emptyMaster"
                class="empty-selection">

                <i class="fa fa-hand-pointer-o fa-2x"></i>

                <p>Select a document from above.</p>

            </div>

        </div>

    </div>


    <!-- RIGHT: DETAIL INFORMATION -->

    <div class="col-md-9">

        <div class="detail-panel">

            <div class="detail-panel-header">

                <div class="row">

                    <div class="col-sm-8">

                        <h4>
                            <i class="fa fa-list-alt"></i>
                            Detail Information
                        </h4>

                        <small id="lblDetailDocument"
                            class="text-muted">
                            Select a master document to see details.
                        </small>

                    </div>

                    <div class="col-sm-4 text-right">

                        <button type="button"
                            class="btn btn-success btn-sm"
                            id="btnAddDetail"
                            disabled="disabled">

                            <i class="fa fa-plus"></i>
                            Add Detail

                        </button>

                    </div>

                </div>

            </div>


            <div class="page-card-body table-responsive">

                <table id="tblDetails"
                    class="table table-bordered table-striped table-hover">

                    <thead>
                        <tr>
                            <th>SL</th>
                            <th>Detail Type</th>
                            <th>Description</th>
                            <th>Reference No.</th>
                            <th>Remarks</th>
                            <th>Action</th>
                        </tr>
                    </thead>

                    <tbody></tbody>

                </table>

            </div>

        </div>

    </div>

</div>


</asp:Content>


<asp:Content ID="Content3" ContentPlaceHolderID="Scripts"
    runat="server">

    <script>


        var masterTable;
        var detailTable;
        var selectedMaster = null;


        $(document).ready(function () {

            // MASTER DATATABLE

            masterTable = $('#tblMaster').DataTable({

                pageLength: 10,
                ordering: true,
                searching: true,
                autoWidth: false,

                columns: [

            {
                data: 'DocumentNo',
                render: function (data) {
                    return escapeHtml(data);
                }
            },

            {
                data: 'ReferenceNo',
                render: function (data) {
                    return escapeHtml(data);
                }
            },

            {
                data: 'Subject',
                render: function (data) {
                    return escapeHtml(data);
                }
            },

            {
                data: 'Department',
                render: function (data) {
                    return escapeHtml(data);
                }
            },

            {
                data: 'DocumentDate',
                render: function (data) {
                    return escapeHtml(data);
                }
            },

            {
                data: 'Status',
                render: function (data) {

                    var status = (data || '').toLowerCase();

                    var cls = 'label-info';

                    if (status === 'approved')
                        cls = 'label-success';

                    else if (status === 'pending')
                        cls = 'label-warning';

                    else if (status === 'rejected')
                        cls = 'label-danger';

                    return '<span class="label ' + cls + '">' +
                        escapeHtml(data) +
                        '</span>';
                }
            }

        ]

            });


            // DETAIL DATATABLE

            detailTable = $('#tblDetails').DataTable({

                pageLength: 10,
                searching: true,
                ordering: true,
                autoWidth: false,

                columns: [

            { data: null },

            {
                data: 'DetailType',
                render: function (data) {
                    return escapeHtml(data);
                }
            },

            {
                data: 'Description',
                render: function (data) {
                    return escapeHtml(data);
                }
            },

            {
                data: 'ReferenceNo',
                render: function (data) {
                    return escapeHtml(data);
                }
            },

            {
                data: 'Remarks',
                render: function (data) {
                    return escapeHtml(data);
                }
            },

            {
                data: 'DetailID',
                orderable: false,
                searchable: false,

                render: function (id) {

                    return '<button type="button" ' +
                        'class="btn btn-primary btn-xs btnEditDetail" ' +
                        'data-id="' + id + '">' +
                        '<i class="fa fa-edit"></i>' +
                        '</button>';
                }
            }

        ],

                columnDefs: [
            {
                targets: 0,
                render: function (data, type, row, meta) {
                    return meta.row +
                        meta.settings._iDisplayStart + 1;
                }
            }
        ]

            });


            // LOAD MASTER DATA

            loadMasters();


            // MASTER ROW CLICK

            $('#tblMaster tbody').on('click', 'tr', function () {

                var master = masterTable.row(this).data();

                if (!master) return;

                $('#tblMaster tbody tr')
            .removeClass('selected-master');

                $(this).addClass('selected-master');

                selectMaster(master);

            });


            // EDIT MASTER

            $('#btnEditMaster').click(function () {

                if (!selectedMaster) return;

                // Open your master edit modal here.
                // Populate it using selectedMaster.

                console.log(selectedMaster);

            });


            // ADD DETAIL

            $('#btnAddDetail').click(function () {

                if (!selectedMaster) return;

                // Open your detail modal here.
                // Pass selectedMaster.MasterID.

                console.log('Selected Master ID: ' +
            selectedMaster.MasterID);

            });

        });


        // LOAD MASTER RECORDS FROM DATABASE

        function loadMasters() {

            $.ajax({

                type: "POST",

                url: "MasterDetail.aspx/GetMasters",

                data: "{}",

                contentType: "application/json; charset=utf-8",

                dataType: "json",

                success: function (response) {

                    masterTable.clear();

                    masterTable.rows.add(response.d);

                    masterTable.draw();

                    // Automatically select first record

                    if (response.d.length > 0) {

                        var firstRow = masterTable.row(0).node();

                        $(firstRow).trigger('click');

                    } else {

                        clearSelection();

                    }

                },

                error: function (xhr) {

                    console.log(xhr.responseText);

                    alert('Unable to load master records.');

                }

            });

        }


        // SELECT MASTER AND SHOW BASIC INFORMATION

        function selectMaster(master) {

            selectedMaster = master;

            $('#emptyMaster').hide();

            $('#masterInfo').show();


            $('#vDocumentNo').text(master.DocumentNo || '-');

            $('#vReference').text(master.ReferenceNo || '-');

            $('#vSubject').text(master.Subject || '-');

            $('#vDocumentDate').text(master.DocumentDate || '-');

            $('#vDepartment').text(master.Department || '-');

            $('#vCreatedBy').text(master.CreatedBy || '-');

            $('#vCreatedDate').text(master.CreatedDate || '-');

            $('#vRemarks').text(master.Remarks || '-');


            var status = master.Status || '-';

            var statusClass = 'label-info';

            if (status.toLowerCase() === 'approved')
                statusClass = 'label-success';

            else if (status.toLowerCase() === 'pending')
                statusClass = 'label-warning';

            else if (status.toLowerCase() === 'rejected')
                statusClass = 'label-danger';

            $('#vStatus')
        .removeClass('label-info label-success label-warning label-danger')
        .addClass('label ' + statusClass)
        .text(status);


            $('#lblDetailDocument').text(
        master.DocumentNo + ' - ' + master.Subject
    );


            $('#btnAddDetail').prop('disabled', false);


            // Load corresponding detail records

            loadDetails(master.MasterID);

        }


        // LOAD DETAILS FROM DATABASE

        function loadDetails(masterId) {

            detailTable.clear().draw();

            $.ajax({

                type: "POST",

                url: "MasterDetail.aspx/GetDetails",

                data: JSON.stringify({
                    masterId: masterId
                }),

                contentType: "application/json; charset=utf-8",

                dataType: "json",

                success: function (response) {

                    // Avoid showing stale results if the user
                    // selected another master during the request.

                    if (!selectedMaster ||
                selectedMaster.MasterID != masterId) {
                        return;
                    }

                    detailTable.clear();

                    detailTable.rows.add(response.d);

                    detailTable.draw();

                },

                error: function (xhr) {

                    console.log(xhr.responseText);

                    alert('Unable to load detail records.');

                }

            });

        }


        // CLEAR SCREEN

        function clearSelection() {

            selectedMaster = null;

            $('#masterInfo').hide();

            $('#emptyMaster').show();

            $('#btnAddDetail').prop('disabled', true);

            $('#lblDetailDocument').text(
        'Select a master document to see details.'
    );

            detailTable.clear().draw();

        }


        // HTML ENCODING

        function escapeHtml(value) {

            return $('<div/>')
        .text(value == null ? '' : value)
        .html();

        }

    
    </script>

    </asp:Content>