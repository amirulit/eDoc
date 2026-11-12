
<%@ Page Title="Master Detail" Language="C#"
    MasterPageFile="~/Site.Master"
    AutoEventWireup="true"
    CodeFile="MasterDetail.aspx.cs"
    Inherits="MasterDetail" %>

<asp:Content ID="Content1"
    ContentPlaceHolderID="PageTitle"
    runat="server">
    Master Detail Management
</asp:Content>

<asp:Content ID="Content2"
    ContentPlaceHolderID="MainContent"
    runat="server">

<style>
    .master-box {
        border-radius: 6px;
        overflow: hidden;
    }

    .master-header {
        color: #123c67;
        font-weight: 600;
    }

    .section-title {
        font-size: 16px;
        font-weight: 600;
        color: #123c67;
    }

    .table thead th {
        background: #eaf2fb;
        color: #123c67;
    }

    .modal-header-custom {
        background: #1265a8;
        color: white;
    }

    .modal-header-custom .close {
        color: white;
        opacity: 1;
    }

    .form-control {
        border-radius: 5px;
    }
</style>

<!-- MASTER SECTION -->

<div class="box box-primary master-box">

    <div class="box-header with-border">

        <h3 class="box-title master-header">
            <i class="fa fa-folder-open"></i>
            Master Information
        </h3>

        <div class="box-tools pull-right">

            <button type="button"
                class="btn btn-primary btn-sm"
                onclick="openMasterModal()">

                <i class="fa fa-plus"></i>
                Add Master

            </button>

        </div>

    </div>

    <div class="box-body table-responsive">

        <table id="tblMaster"
            class="table table-bordered table-hover">

            <thead>
                <tr>
                    <th>SL</th>
                    <th>Document ID</th>
                    <th>Reference</th>
                    <th>Subject</th>
                    <th>Department</th>
                    <th>Date</th>
                    <th>Status</th>
                    <th>Action</th>
                </tr>
            </thead>

            <tbody>

                <tr>
                    <td>1</td>
                    <td>DMS-001</td>
                    <td>REF-001</td>
                    <td>Loan Proposal</td>
                    <td>Credit SME</td>
                    <td>12-11-2026</td>
                    <td>
                        <span class="label label-success">
                            Approved
                        </span>
                    </td>
                    <td>
                        <button type="button"
                            class="btn btn-info btn-xs"
                            onclick="viewDetails(1)">
                            <i class="fa fa-list"></i>
                            Details
                        </button>

                        <button type="button"
                            class="btn btn-primary btn-xs"
                            onclick="editMaster(1)">
                            <i class="fa fa-edit"></i>
                        </button>
                    </td>
                </tr>

                <tr>
                    <td>2</td>
                    <td>DMS-002</td>
                    <td>REF-002</td>
                    <td>Office Memo</td>
                    <td>CAD</td>
                    <td>11-11-2026</td>
                    <td>
                        <span class="label label-warning">
                            Pending
                        </span>
                    </td>
                    <td>
                        <button type="button"
                            class="btn btn-info btn-xs"
                            onclick="viewDetails(2)">
                            <i class="fa fa-list"></i>
                            Details
                        </button>

                        <button type="button"
                            class="btn btn-primary btn-xs"
                            onclick="editMaster(2)">
                            <i class="fa fa-edit"></i>
                        </button>
                    </td>
                </tr>

            </tbody>

        </table>

    </div>

</div>


<!-- DETAIL SECTION -->

<div class="box box-success master-box"
    id="detailSection"
    style="display:none;">

    <div class="box-header with-border">

        <h3 class="box-title master-header">
            <i class="fa fa-list-alt"></i>
            Master Details
            <small id="selectedMaster"></small>
        </h3>

        <div class="box-tools pull-right">

            <button type="button"
                class="btn btn-success btn-sm"
                onclick="openDetailModal()">

                <i class="fa fa-plus"></i>
                Add Detail

            </button>

        </div>

    </div>

    <div class="box-body table-responsive">

        <table id="tblDetails"
            class="table table-bordered table-hover">

            <thead>
                <tr>
                    <th>SL</th>
                    <th>Detail Type</th>
                    <th>Description</th>
                    <th>Reference</th>
                    <th>Remarks</th>
                    <th>Action</th>
                </tr>
            </thead>

            <tbody></tbody>

        </table>

    </div>

</div>


<!-- MASTER MODAL -->

<div class="modal fade" id="masterModal"
    tabindex="-1" role="dialog">

    <div class="modal-dialog modal-lg">

        <div class="modal-content">

            <div class="modal-header modal-header-custom">

                <button type="button" class="close"
                    data-dismiss="modal">&times;</button>

                <h4 class="modal-title">
                    <i class="fa fa-folder-open"></i>
                    Add / Edit Master Information
                </h4>

            </div>

            <div class="modal-body">

                <input type="hidden" id="masterId"/>

                <div class="row">

                    <div class="col-md-6">
                        <div class="form-group">
                            <label>Document Type *</label>
                            <select id="mType" class="form-control">
                                <option value="">Select Type</option>
                                <option>Office Memo</option>
                                <option>Loan Proposal</option>
                                <option>Credit Proposal</option>
                                <option>Agreement</option>
                            </select>
                        </div>
                    </div>

                    <div class="col-md-6">
                        <div class="form-group">
                            <label>Reference Number *</label>
                            <input type="text" id="mReference"
                                class="form-control"/>
                        </div>
                    </div>

                </div>

                <div class="row">

                    <div class="col-md-6">
                        <div class="form-group">
                            <label>Document Date *</label>
                            <input type="date" id="mDate"
                                class="form-control"/>
                        </div>
                    </div>

                    <div class="col-md-6">
                        <div class="form-group">
                            <label>Department</label>
                            <select id="mDepartment"
                                class="form-control">
                                <option value="">Select Department</option>
                                <option>CAD</option>
                                <option>Credit SME</option>
                                <option>Credit Corporate</option>
                                <option>Credit Retail</option>
                            </select>
                        </div>
                    </div>

                </div>

                <div class="form-group">
                    <label>Subject *</label>
                    <input type="text" id="mSubject"
                        class="form-control"/>
                </div>

                <div class="form-group">
                    <label>Remarks</label>
                    <textarea id="mRemarks"
                        class="form-control" rows="3"></textarea>
                </div>

            </div>

            <div class="modal-footer">

                <button type="button"
                    class="btn btn-default"
                    data-dismiss="modal">
                    Cancel
                </button>

                <button type="button"
                    class="btn btn-primary"
                    onclick="saveMaster()">
                    <i class="fa fa-save"></i>
                    Save Master
                </button>

            </div>

        </div>

    </div>

</div>


<!-- DETAIL MODAL -->

<div class="modal fade" id="detailModal"
    tabindex="-1" role="dialog">

    <div class="modal-dialog modal-lg">

        <div class="modal-content">

            <div class="modal-header modal-header-custom">

                <button type="button" class="close"
                    data-dismiss="modal">&times;</button>

                <h4 class="modal-title">
                    <i class="fa fa-list"></i>
                    Add / Edit Detail Information
                </h4>

            </div>

            <div class="modal-body">

                <input type="hidden" id="detailId"/>

                <input type="hidden" id="detailMasterId"/>

                <div class="form-group">
                    <label>Detail Type *</label>

                    <select id="dType" class="form-control">
                        <option value="">Select Type</option>
                        <option>Application</option>
                        <option>Supporting Document</option>
                        <option>Correspondence</option>
                        <option>Other</option>
                    </select>
                </div>

                <div class="form-group">
                    <label>Description *</label>

                    <input type="text" id="dDescription"
                        class="form-control"
                        placeholder="Enter Description"/>
                </div>

                <div class="form-group">
                    <label>Reference Number</label>

                    <input type="text" id="dReference"
                        class="form-control"/>
                </div>

                <div class="form-group">
                    <label>Remarks</label>

                    <textarea id="dRemarks"
                        class="form-control" rows="3"></textarea>
                </div>

            </div>

            <div class="modal-footer">

                <button type="button"
                    class="btn btn-default"
                    data-dismiss="modal">
                    Cancel
                </button>

                <button type="button"
                    class="btn btn-success"
                    onclick="saveDetail()">
                    <i class="fa fa-save"></i>
                    Save Detail
                </button>

            </div>

        </div>

    </div>

</div>

</asp:Content>


<asp:Content ID="Content3" ContentPlaceHolderID="Scripts"
    runat="server">

<script type="text/javascript">


var masters = [
    {
        id: 1,
        type: 'Loan Proposal',
        reference: 'REF-001',
        date: '2026-11-12',
        department: 'Credit SME',
        subject: 'Loan Proposal',
        remarks: 'Initial proposal'
    },
    {
        id: 2,
        type: 'Office Memo',
        reference: 'REF-002',
        date: '2026-11-11',
        department: 'CAD',
        subject: 'Office Memo',
        remarks: 'Office correspondence'
    }
];

var details = [
    {
        id: 1,
        masterId: 1,
        type: 'Application',
        description: 'Loan Application',
        reference: 'APP-001',
        remarks: 'Original application'
    },
    {
        id: 2,
        masterId: 1,
        type: 'Supporting Document',
        description: 'Supporting Papers',
        reference: 'DOC-001',
        remarks: 'Attached papers'
    }
];

var selectedMasterId = 0;

function openMasterModal() {

    $('#masterId').val('');
    $('#mType,#mDepartment').val('');
    $('#mReference,#mDate,#mSubject,#mRemarks').val('');

    $('#masterModal').modal('show');
}



function viewDetails(id) {

    //selectedMasterId = id;

    //var master = masters.find(x => x.id == id);

    //$('#selectedMaster').text(
        //master ? '- ' + master.subject : ''
    //);

    $('#detailSection').show();

    //renderDetails();

    //$('html, body').animate({
        //scrollTop: $('#detailSection').offset().top - 80
    //}, 400);
}

function openDetailModal() {

    $('#detailId').val('');
    $('#detailMasterId').val(selectedMasterId);

    $('#dType').val('');
    $('#dDescription,#dReference,#dRemarks').val('');

    $('#detailModal').modal('show');
}
/*
function editMaster(id) {

    var m = masters.find(x => x.id == id);

    if (!m) return;

    $('#masterId').val(m.id);
    $('#mType').val(m.type);
    $('#mReference').val(m.reference);
    $('#mDate').val(m.date);
    $('#mDepartment').val(m.department);
    $('#mSubject').val(m.subject);
    $('#mRemarks').val(m.remarks);

    $('#masterModal').modal('show');
}

function saveMaster() {

    var id = $('#masterId').val();

    var m = {
        id: id ? parseInt(id) :
            Math.max(0, ...masters.map(x => x.id)) + 1,

        type: $('#mType').val(),
        reference: $('#mReference').val(),
        date: $('#mDate').val(),
        department: $('#mDepartment').val(),
        subject: $('#mSubject').val(),
        remarks: $('#mRemarks').val()
    };

    if (!m.type || !m.reference || !m.date || !m.subject) {
        alert('Please fill all required master fields.');
        return;
    }

    if (id) {
        var index = masters.findIndex(x => x.id == id);
        if (index >= 0) masters[index] = m;
    } else {
        masters.push(m);
    }

    renderMasters();

    $('#masterModal').modal('hide');
}


function saveDetail() {

    var id = $('#detailId').val();

    var d = {
        id: id ? parseInt(id) :
            Math.max(0, ...details.map(x => x.id)) + 1,

        masterId: parseInt($('#detailMasterId').val()),
        type: $('#dType').val(),
        description: $('#dDescription').val(),
        reference: $('#dReference').val(),
        remarks: $('#dRemarks').val()
    };

    if (!d.type || !d.description) {
        alert('Please enter Detail Type and Description.');
        return;
    }

    if (id) {
        var index = details.findIndex(x => x.id == id);
        if (index >= 0) details[index] = d;
    } else {
        details.push(d);
    }

    renderDetails();

    $('#detailModal').modal('hide');
}

function editDetail(id) {

    var d = details.find(x => x.id == id);

    if (!d) return;

    $('#detailId').val(d.id);
    $('#detailMasterId').val(d.masterId);
    $('#dType').val(d.type);
    $('#dDescription').val(d.description);
    $('#dReference').val(d.reference);
    $('#dRemarks').val(d.remarks);

    $('#detailModal').modal('show');
}

function renderMasters() {

    var html = '';

    masters.forEach(function(m, i) {

        html += '<tr>' +
            '<td>' + (i + 1) + '</td>' +
            '<td>DMS-' + String(m.id).padStart(3, '0') + '</td>' +
            '<td>' + escapeHtml(m.reference) + '</td>' +
            '<td>' + escapeHtml(m.subject) + '</td>' +
            '<td>' + escapeHtml(m.department) + '</td>' +
            '<td>' + escapeHtml(m.date) + '</td>' +
            '<td><span class="label label-warning">Pending</span></td>' +
            '<td>' +
            '<button class="btn btn-info btn-xs" onclick="viewDetails(' + m.id + ')">Details</button> ' +
            '<button class="btn btn-primary btn-xs" onclick="editMaster(' + m.id + ')"><i class="fa fa-edit"></i></button>' +
            '</td></tr>';
    });

    $('#tblMaster').DataTable().clear().destroy();

    $('#tblMaster tbody').html(html);

    $('#tblMaster').DataTable({
        pageLength: 10,
        autoWidth: false
    });
}

function renderDetails() {

    var html = '';

    details.filter(x => x.masterId == selectedMasterId)
        .forEach(function(d, i) {

            html += '<tr>' +
                '<td>' + (i + 1) + '</td>' +
                '<td>' + escapeHtml(d.type) + '</td>' +
                '<td>' + escapeHtml(d.description) + '</td>' +
                '<td>' + escapeHtml(d.reference) + '</td>' +
                '<td>' + escapeHtml(d.remarks) + '</td>' +
                '<td>' +
                '<button class="btn btn-primary btn-xs" onclick="editDetail(' + d.id + ')">' +
                '<i class="fa fa-edit"></i></button>' +
                '</td></tr>';
        });

    $('#tblDetails').DataTable().clear().destroy();

    $('#tblDetails tbody').html(html);

    $('#tblDetails').DataTable({
        pageLength: 5,
        autoWidth: false
    });
}

function escapeHtml(value) {
    return $('<div>').text(value || '').html();
}

$(document).ready(function() {

    renderMasters();

    $('#tblDetails').DataTable({
        pageLength: 5,
        autoWidth: false
    });

});

*/






</script>

</asp:Content>