
<%@ Page Title="Document List" Language="C#"
    MasterPageFile="~/Site.Master"
    AutoEventWireup="true"
    CodeFile="DocumentList.aspx.cs"
    Inherits="DocumentList" %>

<asp:Content ID="Content1" ContentPlaceHolderID="PageTitle"
    runat="server">
    Document Listing
</asp:Content>


<asp:Content ID="Content2" ContentPlaceHolderID="MainContent"
    runat="server">
  
<!-- EDIT DOCUMENT MODAL -->
<div class="modal" id="editDocumentModal"
     tabindex="-1" role="dialog">

    <div class="modal-dialog modal-lg" role="document">

        <div class="modal-content">

            <!-- HEADER -->
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
                    Edit Document Information
                </h4>

            </div>

            <!-- BODY -->
            <div class="modal-body">

                <input type="hidden" id="editDocumentId" />

                <div class="row">

                    <div class="col-md-6">

                        <div class="form-group">
                            <label>Document Type</label>

                            <select id="editDocumentType"
                                    class="form-control">

                                <option value="">Select Type</option>
                                <option value="Office Memo">Office Memo</option>
                                <option value="Loan Proposal">Loan Proposal</option>
                                <option value="Credit Proposal">Credit Proposal</option>
                                <option value="Agreement">Agreement</option>
                                <option value="Other">Other</option>

                            </select>
                        </div>

                    </div>

                    <div class="col-md-6">

                        <div class="form-group">
                            <label>Reference Number</label>

                            <input type="text"
                                   id="editReference"
                                   class="form-control" />
                        </div>

                    </div>

                </div>


                <div class="row">

                    <div class="col-md-6">

                        <div class="form-group">
                            <label>Document Date</label>

                            <input type="date"
                                   id="editDocumentDate"
                                   class="form-control" />
                        </div>

                    </div>

                    <div class="col-md-6">

                        <div class="form-group">
                            <label>Department</label>

                            <select id="editDepartment"
                                    class="form-control">

                                <option value="">Select Department</option>
                                <option value="CAD">CAD</option>
                                <option value="Credit (SME)">Credit (SME)</option>
                                <option value="Credit (Corporate)">Credit (Corporate)</option>
                                <option value="Credit (Retail)">Credit (Retail)</option>
                                <option value="Credit (Agri)">Credit (Agri)</option>

                            </select>
                        </div>

                    </div>

                </div>


                <div class="form-group">

                    <label>Subject</label>

                    <input type="text"
                           id="editSubject"
                           class="form-control"
                           placeholder="Enter Subject" />

                </div>


                <div class="form-group">

                    <label>Remarks</label>

                    <textarea id="editRemarks"
                              class="form-control"
                              rows="3"
                              placeholder="Enter Remarks"></textarea>

                </div>


                <div class="form-group">

                    <label>Upload New Attachment</label>

                    <input type="file"
                           id="editAttachment"
                           class="form-control"
                           accept=".pdf,.doc,.docx,.xls,.xlsx" />

                    <small class="text-muted">
                        Leave empty to retain the existing attachment.
                    </small>

                </div>

            </div>


            <!-- FOOTER -->
            <div class="modal-footer">

                <button type="button"
                        class="btn btn-default"
                        data-dismiss="modal">

                    <i class="fa fa-times"></i>
                    Cancel

                </button>

                <button type="button"
                        id="btnUpdateDocument"
                        class="btn btn-primary">

                    <i class="fa fa-save"></i>
                    Save Changes

                </button>

            </div>

        </div>

    </div>

</div>

    <div class="box box-primary">

        <div class="box-header with-border">

            <h3 class="box-title">  <a href="javascript:void(0);"
   class="btn btn-primary btn-xs btnEdit"
   data-id="1"
   title="Edit Document">

    <i class="fa fa-edit"></i>

</a>
                <i class="fa fa-list-alt"></i>
                All Documents
            </h3>

            <div class="box-tools pull-right">

                <a href="DocumentEntry.aspx"
                   class="btn btn-primary btn-sm">

                    <i class="fa fa-plus"></i>
                    New Document

                </a>

            </div>

        </div>


        <div class="box-body table-responsive">

            <table id="tblDocuments"
                   class="table table-bordered table-striped table-hover">

                <thead>

                    <tr>
                        <th>SL</th>
                        <th>Document ID</th>
                        <th>Subject</th>
                        <th>Document Type</th>
                        <th>Document Date</th>
                        <th>Submitted By</th>
                        <th>Status</th>
                        <th>Action</th>
                    </tr>

                </thead>


                <tbody>

                    <tr>
                        <td>1</td>
                        <td>DMS-001</td>
                        <td>Loan Proposal</td>
                        <td>Credit Proposal</td>
                        <td>12-11-2026</td>
                        <td>John</td>
                        <td>
                            <span class="label label-success">
                                Approved
                            </span>
                        </td>
                        <td>

                            <a href="#"
                               class="btn btn-info btn-xs"
                               title="View">
                                <i class="fa fa-eye"></i>
                            </a>

                            <a href="#"
                               class="btn btn-primary btn-xs"
                               title="Edit">
                                <i class="fa fa-edit"></i>
                            </a>

                            <a href="#"
                               class="btn btn-danger btn-xs"
                               title="Delete">
                                <i class="fa fa-trash"></i>
                            </a>

                        </td>
                    </tr>


                    <tr>
                        <td>2</td>
                        <td>DMS-002</td>
                        <td>Office Memo</td>
                        <td>Memo</td>
                        <td>11-11-2026</td>
                        <td>David</td>
                        <td>
                            <span class="label label-warning">
                                Pending
                            </span>
                        </td>
                        <td>

                            <a href="#" class="btn btn-info btn-xs">
                                <i class="fa fa-eye"></i>
                            </a>

                            <a href="#" class="btn btn-primary btn-xs">
                                <i class="fa fa-edit"></i>
                            </a>

                            <a href="#" class="btn btn-danger btn-xs">
                                <i class="fa fa-trash"></i>
                            </a>

                        </td>
                    </tr>


                    <tr>
                        <td>3</td>
                        <td>DMS-003</td>
                        <td>Agreement Document</td>
                        <td>Agreement</td>
                        <td>10-11-2026</td>
                        <td>Michael</td>
                        <td>
                            <span class="label label-danger">
                                Rejected
                            </span>
                        </td>
                        <td>

                            <a href="#" class="btn btn-info btn-xs">
                                <i class="fa fa-eye"></i>
                            </a>

                            <a href="#" class="btn btn-primary btn-xs">
                                <i class="fa fa-edit"></i>
                            </a>

                            <a href="#" class="btn btn-danger btn-xs">
                                <i class="fa fa-trash"></i>
                            </a>

                        </td>
                    </tr>

                </tbody>

            </table>

        </div>

    </div>

</asp:Content>


<asp:Content ID="Content3" ContentPlaceHolderID="Scripts"
    runat="server">

    <script type="text/javascript">

        $(document).ready(function () {

            $('#tblDocuments').DataTable({

                "pageLength": 10,

                "lengthMenu": [
                    [10, 25, 50, 100],
                    [10, 25, 50, 100]
                ],

                "ordering": true,

                "searching": true,

                "paging": true,

                "info": true,

                "autoWidth": false,

                "language": {

                    "search": "Search Documents:",

                    "lengthMenu": "Show _MENU_ records",

                    "info": "Showing _START_ to _END_ of _TOTAL_ documents",

                    "emptyTable": "No documents available"

                }

            });



        });


        $(document).on('click', '.btnEdit', function () {

            var documentId = $(this).data('id');

            // Example data
            var data = {
                id: documentId,
                documentType: 'Credit Proposal',
                reference: 'REF-2026-001',
                documentDate: '2026-11-12',
                department: 'Credit (SME)',
                subject: 'Loan Proposal for Customer',
                remarks: 'Updated document information'
            };

            $('#editDocumentId').val(data.id);
            $('#editDocumentType').val(data.documentType);
            $('#editReference').val(data.reference);
            $('#editDocumentDate').val(data.documentDate);
            $('#editDepartment').val(data.department);
            $('#editSubject').val(data.subject);
            $('#editRemarks').val(data.remarks);

            $('#editAttachment').val('');

            $('#editDocumentModal').modal('show');

        });


        $('#btnUpdateDocument').click(function () {

            var documentData = {
                id: $('#editDocumentId').val(),
                documentType: $('#editDocumentType').val(),
                reference: $('#editReference').val(),
                documentDate: $('#editDocumentDate').val(),
                department: $('#editDepartment').val(),
                subject: $('#editSubject').val(),
                remarks: $('#editRemarks').val()
            };

            if (!documentData.documentType ||
        !documentData.subject) {

                alert('Please fill up required fields.');
                return;
            }

            $.ajax({

                type: "POST",

                url: "DocumentList.aspx/UpdateDocument",

                data: JSON.stringify({ data: documentData }),

                contentType: "application/json; charset=utf-8",

                dataType: "json",

                success: function (response) {

                    alert('Document updated successfully.');

                    $('#editDocumentModal').modal('hide');

                    $('#tblDocuments').DataTable().ajax.reload(null, false);

                },

                error: function (xhr) {

                    alert('Unable to update document.');

                    console.log(xhr.responseText);

                }

            });

        });

    </script>

</asp:Content>
