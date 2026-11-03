<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Doc_Details.aspx.cs" Inherits="Doc_Details" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Security Information</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css" />
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
    <script src="SecurityInfo.js"></script>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <div class="container-fluid mt-4">
            <h4>
                Security Information</h4>
            <input type="hidden" id="parentId" value="1001" />
            <div id="keyButtons" class="mb-4">
            </div>
            <h5>
                Saved Information</h5>
            <div id="savedInformation">
            </div>
        </div>
        <!-- Common modal -->
        <div class="modal fade" id="infoModal" tabindex="-1" role="dialog">
            <div class="modal-dialog modal-lg">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="modalTitle">
                            Add Information
                        </h5>
                        <button type="button" class="close" data-dismiss="modal">
                            &times;
                        </button>
                    </div>
                    <div class="modal-body">
                        <input type="hidden" id="keyNo" />
                        <div id="dynamicFields" class="row">
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">
                            Cancel
                        </button>
                        <button type="button" class="btn btn-primary" id="btnSave">
                            Save
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </div>
    </form>
</body>
</html>
