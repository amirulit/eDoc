
<%@ Page Title="Master Detail"
    Language="C#"
    MasterPageFile="~/Site.Master"
    AutoEventWireup="true"
    CodeFile="MasterDetail_V2.aspx.cs"
    Inherits="MasterDetail_V2" %>

<asp:Content ID="Content1"
    ContentPlaceHolderID="PageTitle"
    runat="server">
    Master Detail Management
</asp:Content>

<asp:Content ID="Content2"
    ContentPlaceHolderID="MainContent"
    runat="server">

<style>

    .master-panel {
        background: #fff;
        border: 1px solid #e0e6ed;
        border-radius: 6px;
        min-height: 550px;
    }

    .master-panel-header {
        padding: 15px;
        background: #1265a8;
        color: white;
        font-weight: 600;
        border-radius: 5px 5px 0 0;
    }

    .master-search {
        padding: 12px;
        border-bottom: 1px solid #eee;
    }

    .master-list {
        padding: 8px;
        max-height: 650px;
        overflow-y: auto;
    }

    .master-item {
        display: block;
        width: 100%;
        text-align: left;
        background: white;
        border: 1px solid #e5eaf0;
        border-radius: 5px;
        padding: 12px;
        margin-bottom: 8px;
        cursor: pointer;
        transition: all .2s;
    }

    .master-item:hover {
        background: #f0f7ff;
        border-color: #1686c9;
    }

    .master-item.active {
        background: #eaf3fc;
        border-left: 4px solid #1686c9;
        border-top-color: #1686c9;
        border-right-color: #1686c9;
        border-bottom-color: #1686c9;
    }

    .master-item strong {
        color: #123c67;
        display: block;
        font-size: 14px;
    }

    .master-item small {
        color: #777;
        display: block;
        margin-top: 5px;
    }

    .detail-panel {
        background: white;
        border: 1px solid #e0e6ed;
        border-radius: 6px;
        min-height: 550px;
    }

    .detail-header {
        padding: 15px;
        border-bottom: 1px solid #e5eaf0;
    }

    .detail-header h4 {
        color: #123c67;
        font-weight: 600;
        margin: 0 0 6px;
    }

    .detail-body {
        padding: 20px;
    }

    #tblDetails thead th {
        background: #eaf2fb;
        color: #123c67;
    }

    .master-empty {
        padding: 30px 10px;
        color: #888;
        text-align: center;
    }

    @media(max-width:767px) {
        .master-panel {
            min-height: auto;
            margin-bottom: 15px;
        }

        .master-list {
            max-height: 250px;
        }
    }

</style>


<asp:HiddenField ID="hfSelectedMasterId"
    runat="server"
    ClientIDMode="Static" />


<div class="row">

    <!-- LEFT MASTER COLUMN -->

    <div class="col-md-3">

        <div class="master-panel">

            <div class="master-panel-header">

                <i class="fa fa-folder-open"></i>
                Master Records

                <span class="pull-right">
                    <i class="fa fa-list"></i>
                </span>

            </div>


            <div class="master-search">

                <input type="text"
                    id="txtMasterSearch"
                    class="form-control"
                    placeholder="Search master records..." />

            </div>


            <div class="master-list">

                <asp:Repeater ID="rptMaster"
                    runat="server">

                    <ItemTemplate>

                        <button type="button"
                            class="master-item"
                            data-id='<%# Eval("MasterID") %>'>

                            <strong>
                                <%#: Eval("DocumentNo") %>
                            </strong>

                            <small>
                                <%#: Eval("Subject") %>
                            </small>

                            <small>
                                <i class="fa fa-calendar"></i>
                                <%#: Eval("DocumentDate", "{0:dd-MMM-yyyy}") %>
                            </small>

                            <small>
                                <span class="label label-info">
                                    <%#: Eval("Status") %>
                                </span>
                            </small>

                        </button>

                    </ItemTemplate>

                    <FooterTemplate>
                        <% if (rptMaster.Items.Count == 0) { %>
                            <div class="master-empty">
                                <i class="fa fa-folder-open fa-2x"></i>
                                <p>No records found</p>
                            </div>
                        <% } %>
                    </FooterTemplate>

                </asp:Repeater>

            </div>

        </div>

    </div>


    <!-- RIGHT DETAIL COLUMN -->

    <div class="col-md-9">

        <div class="detail-panel">

            <div class="detail-header">

                <div class="row">

                    <div class="col-sm-8">

                        <h4>
                            <i class="fa fa-list-alt"></i>
                            Document Details
                        </h4>

                        <small id="lblSelectedMaster"
                            class="text-muted">
                            Select a master record
                        </small>

                    </div>

                    <div class="col-sm-4 text-right">

                        <button type="button"
                            class="btn btn-primary btn-sm"
                            id="btnAddDetail"
                            disabled="disabled">

                            <i class="fa fa-plus"></i>
                            Add Detail

                        </button>

                    </div>

                </div>

            </div>


            <div class="detail-body">

                <div class="row">

                    <div class="col-md-12">

                        <table id="tblDetails"
                            class="table table-bordered table-striped table-hover">

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

            </div>

        </div>

    </div>

</div>


<!-- DETAIL MODAL -->

<div class="modal fade" id="detailModal"
    tabindex="-1" role="dialog">

    <div class="modal-dialog modal-lg">

        <div class="modal-content">

            <div class="modal-header"
                style="background:#1265a8;color:white;">

                <button type="button"
                    class="close"
                    data-dismiss="modal"
                    style="color:white;opacity:1;">
                    &times;
                </button>

                <h4 class="modal-title">
                    <i class="fa fa-edit"></i>
                    Add / Edit Detail
                </h4>

            </div>


            <div class="modal-body">

                <input type="hidden" id="editDetailId"/>

                <input type="hidden" id="editMasterId"/>

                <div class="form-group">

                    <label>Detail Type</label>

                    <select id="ddlDetailType"
                        class="form-control">

                        <option value="">Select Type</option>
                        <option>Application</option>
                        <option>Supporting Document</option>
                        <option>Correspondence</option>
                        <option>Other</option>

                    </select>

                </div>


                <div class="form-group">

                    <label>Description</label>

                    <input type="text"
                        id="txtDescription"
                        class="form-control"/>

                </div>


                <div class="form-group">

                    <label>Reference Number</label>

                    <input type="text"
                        id="txtReference"
                        class="form-control"/>

                </div>


                <div class="form-group">

                    <label>Remarks</label>

                    <textarea id="txtRemarks"
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
                    class="btn btn-primary"
                    id="btnSaveDetail">
                    <i class="fa fa-save"></i>
                    Save Detail
                </button>

            </div>

        </div>

    </div>

</div>

</asp:Content>
