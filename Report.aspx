<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="Report.aspx.cs" Inherits="Report" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">


    <script type="text/javascript" language="javascript">

        function LoadApprovalAuthority(type) {

            $("#data").html(
                '<div class="text-center p-4">' +
                '<div class="spinner-border text-primary"></div>' +
                '<p class="mt-2">Loading records...</p>' +
                '</div>'
            );

            $.ajax({

                type: "POST",

                url: "Report.aspx/GetApprovalAuthorityInfo",

                data: JSON.stringify({ type: type }),

                contentType: "application/json; charset=utf-8",

                dataType: "json",

                success: function (response) {

                    var result = response.d;

                    if (result.length === 0) {

                        $("#data").html(
                            '<div class="alert alert-warning">' +
                            'No Trade License Records Found' +
                            '</div>'
                        );

                        return;
                    }

                    var html = '';

                    html += '<div class="table-responsive">';

                    html += '<table class="table table-bordered table-striped table-hover align-middle">';

                    html += '<thead class="table-dark"><tr>';

                    html += '<th>SL</th>';
                    html += '<th>Sanction ID</th>';
                    html += '<th>Reference No</th>';
                    html += '<th>Drawdown ID</th>';
                    html += '<th>Customer Type</th>';
                    html += '<th>Loan Nature</th>';
                    html += '<th>Securities</th>';
                    html += '<th>Loan Amount</th>';
                    html += '<th>Approval Authority</th>';
                    html += '<th>Expiry Date</th>';

                    html += '</tr></thead><tbody>';

                    $.each(result, function (i, item) {

                        html += '<tr>';

                        html += '<td>' + (i + 1) + '</td>';
                        html += '<td>' + escapeHtml(item.sanction_ids) + '</td>';
                        html += '<td>' + escapeHtml(item.sanction_refno) + '</td>';
                        html += '<td>' + escapeHtml(item.drawdown_id) + '</td>';
                        html += '<td>' + escapeHtml(item.cus_types) + '</td>';
                        html += '<td>' + escapeHtml(item.loan_natures) + '</td>';
                        html += '<td>' + escapeHtml(item.securities) + '</td>';
                        html += '<td class="text-end">' + escapeHtml(item.loan_amount) + '</td>';
                        html += '<td>' + escapeHtml(item.appr_auth) + '</td>';

                        var expiryClass = type === 'Expired'
                            ? 'text-danger fw-bold'
                            : (type === 'Upcoming' ? 'text-warning fw-bold' : '');

                        html += '<td class="' + expiryClass + '">' +
                                escapeHtml(item.expiry) + '</td>';

                        html += '</tr>';

                    });

                    html += '</tbody></table></div>';

                    html += '<div class="text-muted mt-2">';
                    html += 'Total Records: <strong>' + result.length + '</strong>';
                    html += '</div>';

                    $("#data").html(html);

                },

                error: function (xhr, status, error) {

                    $("#data").html(
                        '<div class="alert alert-danger">' +
                        'Error loading data: ' + escapeHtml(xhr.responseText) +
                        '</div>'
                    );

                    console.log(xhr.responseText);

                }

            });

        }

        function escapeHtml(value) {

            return $('<div>').text(value == null ? '' : value).html();

        }




        function LoadCreditRating(type) {

            $("#creditRatingData").html(
                '<div class="text-center p-4">' +
                '<div class="spinner-border text-primary"></div>' +
                '<p>Loading Credit Rating Records...</p>' +
                '</div>'
            );

            $.ajax({

                type: "POST",

                url: "Report.aspx/GetCreditRatingInfo",

                data: JSON.stringify({ type: type }),

                contentType: "application/json; charset=utf-8",

                dataType: "json",

                success: function (response) {

                    var result = response.d;

                    if (result.length === 0) {

                        $("#creditRatingData").html(
                            '<div class="alert alert-warning">' +
                            'No Credit Rating Records Found' +
                            '</div>'
                        );

                        return;
                    }

                    var html = '';

                    html += '<div class="table-responsive">';

                    html += '<table class="table table-bordered table-striped table-hover align-middle">';

                    html += '<thead class="table-dark"><tr>';

                    html += '<th>SL</th>';
                    html += '<th>Sanction ID</th>';
                    html += '<th>Reference No</th>';
                    html += '<th>Drawdown ID</th>';
                    html += '<th>Customer Type</th>';
                    html += '<th>Loan Nature</th>';
                    html += '<th>Securities</th>';
                    html += '<th>Loan Amount</th>';
                    html += '<th>Rating Company</th>';
                    html += '<th>Expiry Date</th>';

                    html += '</tr></thead><tbody>';

                    $.each(result, function (i, item) {

                        html += '<tr>';

                        html += '<td>' + (i + 1) + '</td>';
                        html += '<td>' + escapeHtml(item.sanction_ids) + '</td>';
                        html += '<td>' + escapeHtml(item.sanction_refno) + '</td>';
                        html += '<td>' + escapeHtml(item.drawdown_id) + '</td>';
                        html += '<td>' + escapeHtml(item.cus_types) + '</td>';
                        html += '<td>' + escapeHtml(item.loan_natures) + '</td>';
                        html += '<td>' + escapeHtml(item.securities) + '</td>';
                        html += '<td class="text-end">' + escapeHtml(item.loan_amount) + '</td>';
                        html += '<td class="fw-semibold">' + escapeHtml(item.rating_company) + '</td>';

                        var expiryClass = type === 'Expired'
                            ? 'text-danger fw-bold'
                            : (type === 'Upcoming' ? 'text-warning fw-bold' : '');

                        html += '<td class="' + expiryClass + '">' +
                            escapeHtml(item.expiry) + '</td>';

                        html += '</tr>';

                    });

                    html += '</tbody></table></div>';

                    html += '<div class="text-muted mt-2">';
                    html += 'Total Credit Rating Records: <strong>' +
                        result.length + '</strong>';
                    html += '</div>';

                    $("#creditRatingData").html(html);

                },

                error: function (xhr) {

                    $("#creditRatingData").html(
                        '<div class="alert alert-danger">' +
                        'Unable to load Credit Rating Records' +
                        '</div>'
                    );

                    console.log(xhr.responseText);

                }

            });

        }

</script>



</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <section class="content-header">
      <h1>
        Reports
       
      </h1>
      <ol class="breadcrumb">
        <li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
        <li class="active">Report</li>
      </ol>
    </section>
    <section class="content">


 

<div class="row">
        <div class="col-md-12">
          <!-- Custom Tabs -->
          <div class="nav-tabs-custom">
            <ul class="nav nav-tabs">
              <li class="active"><a href="#tab_1" data-toggle="tab">Approval Authority</a></li>
              <li><a href="#tab_2" data-toggle="tab">Credit Rating Report</a></li>
              <li><a href="#tab_3" data-toggle="tab">Tab 3</a></li>
              <li class="dropdown">
                <a class="dropdown-toggle" data-toggle="dropdown" href="#">
                  Dropdown <span class="caret"></span>
                </a>
                <ul class="dropdown-menu">
                  <li role="presentation"><a role="menuitem" tabindex="-1" href="#">Action</a></li>
                  <li role="presentation"><a role="menuitem" tabindex="-1" href="#">Another action</a></li>
                  <li role="presentation"><a role="menuitem" tabindex="-1" href="#">Something else here</a></li>
                  <li role="presentation" class="divider"></li>
                  <li role="presentation"><a role="menuitem" tabindex="-1" href="#">Separated link</a></li>
                </ul>
              </li>
              <li class="pull-right"><a href="#" class="text-muted"><i class="fa fa-gear"></i></a></li>
            </ul>
            <div class="tab-content">
              <div class="tab-pane active" id="tab_1">
               
<div class="container-fluid mt-4">

    <div class="card shadow-sm border-0">

        <div class="card-header bg-primary text-white">
          <%--  <h5 class="mb-0">Trade License Information</h5>--%>
        </div>

        <div class="card-body">

            <div class="d-flex gap-2 flex-wrap mb-3">

                <input id="btnApprovalAuthority_Missing"
                    type="button"
                    value="All Records"
                    class="btn btn-primary"
                    onclick="LoadApprovalAuthority('ALL')" />

                <input id="btnApprovalAuthority_Expired"
                    type="button"
                    value="Expired"
                    class="btn btn-danger"
                    onclick="LoadApprovalAuthority('Expired')" />

                <input id="btnApprovalAuthority_By_30Days"
                    type="button"
                    value="Upcoming (30 Days)"
                    class="btn btn-warning"
                    onclick="LoadApprovalAuthority('Upcoming')" />

            </div>

            <div id="data"></div>

        </div>
    </div>

</div>


                 


              </div>
              <!-- /.tab-pane -->
              <div class="tab-pane" id="tab_2">
                
<div class="container-fluid mt-4">

    <div class="card shadow-sm border-0">

        <div class="card-header bg-primary text-white">
            <h5 class="mb-0"></h5>
        </div>

        <div class="card-body">
              <div class="d-flex gap-2 flex-wrap mb-3">

                        <button type="button"
                            class="btn btn-primary"
                            onclick="LoadCreditRating('ALL')">
                            All Records
                        </button>

                        <button type="button"
                            class="btn btn-danger"
                            onclick="LoadCreditRating('Expired')">
                            Expired
                        </button>

                        <button type="button"
                            class="btn btn-warning"
                            onclick="LoadCreditRating('Upcoming')">
                            Upcoming (30 Days)
                        </button>

                    </div>

                    <div id="creditRatingData"></div>

        </div>
    </div>

</div>




              </div>
              <!-- /.tab-pane -->
              <div class="tab-pane" id="tab_3">
                Lorem Ipsum is simply dummy text of the printing and typesetting industry.
                Lorem Ipsum has been the industry's standard dummy text ever since the 1500s,
                when an unknown printer took a galley of type and scrambled it to make a type specimen book.
                It has survived not only five centuries, but also the leap into electronic typesetting,
                remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset
                sheets containing Lorem Ipsum passages, and more recently with desktop publishing software
                like Aldus PageMaker including versions of Lorem Ipsum.
              </div>
              <!-- /.tab-pane -->
            </div>
            <!-- /.tab-content -->
          </div>
          <!-- nav-tabs-custom -->
        </div>
        <!-- /.col -->
         </div>
        

      </section>
</asp:Content>
