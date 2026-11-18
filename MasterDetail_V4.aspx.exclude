
<%@ Page Title="Master Detail"
    Language="C#"
    MasterPageFile="~/Site.Master"
    AutoEventWireup="true"
    CodeFile="MasterDetail_V4.aspx.cs"
    Inherits="MasterDetail_V4" %>


<asp:Content ID="Content1"
    ContentPlaceHolderID="head"
    runat="server">

<style>

    .master-detail-page {
        padding: 10px;
    }

    .box-primary {
        border-top-color: #1686c9 !important;
    }

    #tblMaster thead th,
    #tblDetails thead th {
        background: #eaf2fb;
        color: #173b61;
        white-space: nowrap;
    }

    #tblMaster tbody tr {
        cursor: pointer;
    }

    .master-info-box {
        border: 1px solid #e0e7ef;
        border-radius: 4px;
        background: #fff;
        margin-bottom: 10px;
    }

    .master-info-title {
        background: #eaf3fc;
        padding: 12px;
        color: #173b61;
        font-weight: bold;
        border-bottom: 1px solid #ddd;
    }

    .master-info-body {
        padding: 15px;
    }

    .info-item {
        padding-bottom: 10px;
        margin-bottom: 10px;
        border-bottom: 1px solid #eee;
    }

    .info-label {
        display: block;
        color: #999;
        font-size: 11px;
        text-transform: uppercase;
        font-weight: bold;
    }

    .info-value {
        color: #263d55;
        font-size: 13px;
        font-weight: 600;
        overflow-wrap: anywhere;
    }

    .modal-header-custom {
        background: #1265a8;
        color: white;
    }

    .modal-header-custom .close {
        color: white;
        opacity: 1;
    }

    .modal-dialog-large {
        width: 95%;
        max-width: 1450px;
    }

    .detail-modal {
        z-index: 1060;
    }

    @media(max-width:767px) {
        .modal-dialog-large {
            width: 96%;
            margin: 10px auto;
        }
    }

</style>

</asp:Content>


<asp:Content ID="Content2"
    ContentPlaceHolderID="MainContent"
    runat="server">


<div class="master-detail-page">

    <!-- PAGE HEADER -->

    <section class="content-header">

        <h1>
            Master Detail Management
            <small>Document Information</small>
        </h1>

    </section>


    <!-- MAIN CONTENT -->

    <section class="content">

        <div class="box box-primary">

            <div class="box-header with-border">

                <h3 class="box-title">
                    <i class="fa fa-folder-open"></i>
                    Master Document Listing
                </h3>

            </div>


            <div class="box-body table-responsive">

                <table id="tblMaster"
                    class="table table-bordered table-striped table-hover">

                    <thead>
                        <tr>
                            <th>Document No</th>
                            <th>Reference No</th>
                            <th>Subject</th>
                            <th>Department</th>
                            <th>Document Date</th>
                            <th>Status</th>
                            <th>Action</th>
                        </tr>
                    </thead>

                    <tbody></tbody>

                </table>

            </div>

        </div>

    </section>

</div>



<!-- MASTER DETAIL MODAL -->

<div class="modal fade"
    id="masterDetailModal"
    tabindex="-1"
    role="dialog">

    <div class="modal-dialog modal-dialog-large">

        <div class="modal-content">

            <div class="modal-header modal-header-custom">

                <button type="button"
                    class="close"
                    data-dismiss="modal">
                    &times;
                </button>

                <h4 class="modal-title">
                    <i class="fa fa-folder-open"></i>
                    Master & Detail Information
                </h4>

            </div>


            <div class="modal-body">

                <div class="row">

                    <!-- MASTER LEFT -->

                    <div class="col-md-3">

                        <div class="master-info-box">

                            <div class="master-info-title">
                                <i class="fa fa-info-circle"></i>
                                Basic Information
                            </div>

                            <div class="master-info-body">

                                <div class="info-item">
                                    <span class="info-label">Document No</span>
                                    <span id="vDocumentNo" class="info-value">-</span>
                                </div>

                                <div class="info-item">
                                    <span class="info-label">Reference No</span>
                                    <span id="vReference" class="info-value">-</span>
                                </div>

                                <div class="info-item">
                                    <span class="info-label">Subject</span>
                                    <span id="vSubject" class="info-value">-</span>
                                </div>

                                <div class="info-item">
                                    <span class="info-label">Document Date</span>
                                    <span id="vDocumentDate" class="info-value">-</span>
                                </div>

                                <div class="info-item">
                                    <span class="info-label">Department</span>
                                    <span id="vDepartment" class="info-value">-</span>
                                </div>

                                <div class="info-item">
                                    <span class="info-label">Created By</span>
                                    <span id="vCreatedBy" class="info-value">-</span>
                                </div>

                                <div class="info-item">
                                    <span class="info-label">Created Date</span>
                                    <span id="vCreatedDate" class="info-value">-</span>
                                </div>

                                <div class="info-item">
                                    <span class="info-label">Status</span>
                                    <span id="vStatus" class="label label-info">-</span>
                                </div>

                                <div class="info-item">
                                    <span class="info-label">Remarks</span>
                                    <span id="vRemarks" class="info-value">-</span>
                                </div>

                            </div>

                        </div>

                        <button type="button"
                            id="btnEditMaster"
                            class="btn btn-primary btn-block">

                            <i class="fa fa-edit"></i>
                            Edit Master

                        </button>

                    </div>


                    <!-- DETAILS RIGHT -->

                    <div class="col-md-9">

                        <div class="box box-info">

                            <div class="box-header with-border">

                                <h3 class="box-title">
                                    <i class="fa fa-list-alt"></i>
                                    Detail Records
                                </h3>

                                <button type="button"
                                    id="btnAddDetail"
                                    class="btn btn-success btn-sm pull-right">

                                    <i class="fa fa-plus"></i>
                                    Add Detail

                                </button>

                            </div>


                            <div class="box-body table-responsive">

                                <table id="tblDetails"
                                    class="table table-bordered table-striped table-hover">

                                    <thead>
                                        <tr>
                                            <th>SL</th>
                                            <th>Detail Type</th>
                                            <th>Description</th>
                                            <th>Reference No</th>
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

            </div>


            <div class="modal-footer">

                <button type="button"
                    class="btn btn-default"
                    data-dismiss="modal">
                    Close
                </button>

            </div>

        </div>

    </div>

</div>



<!-- ADD / EDIT DETAIL MODAL -->

<div class="modal fade detail-modal"
    id="detailEditModal"
    tabindex="-1"
    role="dialog">

    <div class="modal-dialog modal-lg">

        <div class="modal-content">

            <div class="modal-header modal-header-custom">

                <button type="button"
                    class="close"
                    data-dismiss="modal">
                    &times;
                </button>

                <h4 class="modal-title" id="detailModalTitle">
                    Add Detail
                </h4>

            </div>


            <div class="modal-body">

                <input type="hidden" id="hdnDetailID" />

                <input type="hidden" id="hdnMasterID" />


                <div class="form-group">

                    <label>Detail Type <span style="color:red">*</span></label>

                    <select id="ddlDetailType"
                        class="form-control">

                        <option value="">-- Select Type --</option>
                        <option value="Application">Application</option>
                        <option value="Supporting Document">Supporting Document</option>
                        <option value="Correspondence">Correspondence</option>
                        <option value="Approval">Approval</option>
                        <option value="Agreement">Agreement</option>
                        <option value="Other">Other</option>

                    </select>

                </div>


                <div class="form-group">

                    <label>Description <span style="color:red">*</span></label>

                    <textarea id="txtDescription"
                        class="form-control"
                        rows="3"></textarea>

                </div>


                <div class="form-group">

                    <label>Reference No</label>

                    <input type="text"
                        id="txtReferenceNo"
                        class="form-control" />

                </div>


                <div class="form-group">

                    <label>Remarks</label>

                    <textarea id="txtDetailRemarks"
                        class="form-control"
                        rows="3"></textarea>

                </div>

            </div>


            <div class="modal-footer">

                <button type="button"
                    class="btn btn-default"
                    data-dismiss="modal">
                    Cancel
                </button>

                <button type="button"
                    id="btnSaveDetail"
                    class="btn btn-primary">

                    <i class="fa fa-save"></i>
                    Save Detail

                </button>

            </div>

        </div>

    </div>

</div>


</asp:Content>


<asp:Content ID="Content3"
    ContentPlaceHolderID="Scripts"
    runat="server">

<!-- Use the JavaScript from section 3 below here -->

</asp:Content>
