<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="CompanyListing_V3.aspx.cs" Inherits="CompanyListing_V3" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script type="text/javascript">

        // Show textbox when Add is clicked
        $(document).on("click", ".add-mother", function () {

            var cell = $(this).closest("td");

            $(this).hide();

            cell.find(".mother-input-area").show();

            /*
            var inputArea = $(this).siblings('.mother-input-area');
            var container = inputArea.find('.select-container');
            if (container.children().length == 0) {

                var dropdown = $('#childSelectTemplate select').clone();

                container.append(dropdown);
            }
            inputArea.show();
            */

          
            var dropdown = cell.find(".child-company-input");
            if (dropdown.length > 0 && dropdown.children().length <= 1) {
                var options = $('#<%= Select1.ClientID %>').html();
                dropdown.html(options);
            }
          


        });


        // Cancel adding
        $(document).on("click", ".cancel-mother", function () {

            var cell = $(this).closest("td");

            cell.find(".mother-company-input").val("");

            cell.find(".mother-input-area").hide();

            cell.find(".add-mother").show();

        });


        // Save Mother Company
        $(document).on("click", ".save-mother", function () {

            var button = $(this);

            var cell = button.closest("td");

            var cusId = button.attr("cus-id");

            var motherCompany = cell.find(".mother-company-input").val().trim();

            if (motherCompany == "") {
                alert("Please enter Mother Company Cus ID");
                return;
            }

            if (cusId == motherCompany) {
                alert("Customer cannot be its own Mother Company");
                return;
            }

            button.prop("disabled", true);

            $.ajax({

                type: "POST",

                url: "CompanyListing.aspx/SaveMotherCompany",

                data: JSON.stringify({
                    cusId: cusId,
                    motherCompany: motherCompany
                }),

                contentType: "application/json; charset=utf-8",

                dataType: "json",

                success: function (response) {

                    var result = response.d;


                    var row = button.closest("tr");

                    if (result.success) {

                        cell.html('<span class="mother-company-value">' + $('<div>').text(result.motherCompany).html() + '</span> ' + '<button type="button" class="btn btn-danger btn-xs delete-mother" cus-id="' + $('<div>').text(cusId).html() + '">Delete</button>');

                        //var row = button.closest("tr");

                        row.find(".mother-company-name").text(result.motherCompanyName);


                    }
                    else {

                        alert(result.message);
                        button.prop("disabled", false);

                    }

                },

                error: function () {

                    alert("Something went wrong!");
                    button.prop("disabled", false);

                }

            });

        });


        // Delete Mother Company
        $(document).on("click", ".delete-mother", function () {

            if (!confirm("Are you sure you want to delete Mother Company?")) {
                return;
            }

            var button = $(this);

            var cell = button.closest("td");

            var cusId = button.attr("cus-id");

            button.prop("disabled", true);

            $.ajax({

                type: "POST",

                url: "CompanyListing.aspx/DeleteMotherCompany",

                data: JSON.stringify({
                    cusId: cusId
                }),

                contentType: "application/json; charset=utf-8",

                dataType: "json",

                success: function (response) {

                    var result = response.d;


                    var row = button.closest("tr");

                    if (result.success) {

                        cell.html(

                        '<button type="button" class="btn btn-primary btn-xs add-mother" cus-id="' + $('<div>').text(cusId).html() + '">Add</button>' +

                        '<div class="mother-input-area" style="display:none; margin-top:5px;">' +

                        '<input type="text" class="form-control input-sm mother-company-input" placeholder="Enter Mother Company Cus ID" />' +

                        '<button type="button" class="btn btn-success btn-xs save-mother" cus-id="' + $('<div>').text(cusId).html() + '" style="margin-top:5px;">Save</button>' +

                        '<button type="button" class="btn btn-default btn-xs cancel-mother" style="margin-top:5px;">Cancel</button>' +

                        '</div>'
                   );


                        //var row = button.closest("tr");

                        row.find(".mother-company-name").text('');


                    }
                    else {

                        alert(result.message);
                        button.prop("disabled", false);

                    }

                },

                error: function () {

                    alert("Something went wrong!");
                    button.prop("disabled", false);

                }

            });

        });

    </script>
    <script type="text/javascript">

        $(document).ready(function () {

            $("body").on("click", ".upload", function () {

                var cus_type = $(this).attr("cus-type");
                var auto_id = $(this).attr("auto-id");
                var e_doc_id = $(this).attr("edoc-id");

                var cus_id = $(this).attr("cus-id");

                //alert(cus_type + '-' + e_doc_id);

                //url = "DocumentUpload_V8.aspx?var=" + cus_type + "&var3=" + cus_id;

                url = "DocumentUpload_V10_New_Mapping_CusTypeWise.aspx?var=" + cus_type + "&var2=&var3=&var4=" + cus_id;

                var width = screen.availWidth - 100;
                var height = screen.availHeight - 100;
                var left = parseInt((screen.availWidth / 2) - (width / 2));
                var top = parseInt((screen.availHeight / 2) - (height / 2));
                var windowFeatures = "width=" + width + ", height=" + height + ", status, resizable, screenX=" + left + ", screenY=" + top;

                //var NWin = window.open("PopUpHelper.aspx?txtBox='"+test+"'&var1="+test+"&var2="+test,'_blank', windowFeatures);
                //var NWin = window.open("Menu.aspx", windowFeatures);
                //alert(windowFeatures);
                //newwindow = window.open('Menu.aspx', 'name', 'height=' + height + ', width=' + width + ', left=' + left + ', top=' + top + ', resizable=yes, scrollbars=yes, toolbar=no, status=yes, menubar=no');

                //newwindow = window.open(pagename, '_blank', ' resizable=yes, scrollbars=yes, toolbar=no, status=yes, menubar=no');

                newwindow = window.open(url, '_blank', 'height=' + height + ', width=' + width + ', left=' + left + ', top=' + top + ', resizable=yes, scrollbars=yes, toolbar=no, status=yes, menubar=no');

                newwindow.focus();

            });



        });



        function deleteChildCompany(motherCode, childCode) {

            if (confirm("Are you sure you want to delete this child company?")) {

                window.location.href =
            "DeleteChildCompany.aspx?motherCode=" +
            encodeURIComponent(motherCode) +
            "&childCode=" +
            encodeURIComponent(childCode);
            }
        }

        /*
        
        $(document).on('click', '.add-mother', function () {

        var td = $(this).closest('td');

        td.find('.mother-input-area').show();
        td.find('.mother-company-input').focus();

        $(this).hide();
        });


        $(document).on('click', '.cancel-mother', function () {

        var td = $(this).closest('td');

        td.find('.mother-input-area').hide();
        td.find('.mother-company-input').val('');

        td.find('.add-mother').show();
        });


        $(document).on('click', '.save-mother', function () {

        var motherCode = $(this).attr('cus-id');

        var td = $(this).closest('td');

        var childCode = td.find('.mother-company-input').val().trim();

        if (childCode == '') {
        alert('Please enter Child Company Cus ID');
        return;
        }

        alert('Mother Code: ' + motherCode +
        '\nChild Code: ' + childCode);

        // Call your AJAX save method here.
        });
        
        */


        /*
        
        $(document).on('click', '.add-mother', function () {
    $(this).siblings('.mother-input-area').show();
});

$(document).on('click', '.cancel-mother', function () {
    $(this).closest('.mother-input-area').hide();
});
        
        */
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <section class="content"> <!-- Start of table section -->
    	<div class="row" id="table1"><!--MSK-000132-1-->
        	<div class="col-md-12">
            	<div class="box">
                	<div class="box-header">
                  		<h3 class="box-title">Company Listing </h3>
                	</div><!-- /.box-header -->
                	<div class="box-body table-responsive"  >
                     
                		<table id="example1" class="table table-bordered table-striped">
                    		<thead>
                            <tr>
                        		<th>Cus ID</th>
                            	<th>Cus Name</th>
                            	<th>Mother Company Cus ID</th>
                                <th>Mother Company Name</th>
              
                            	<th>Action</th>
                                </tr>
                        	</thead>
                        	<tbody>
    <%
                    
        //var sts = "";
        //var id = "";
        //var css = "";

        //var last_renew_dt = "";


        if (TableData.Rows.Count > 0)
        {
            for (var data = 0; data < TableData.Rows.Count; data++)
            {
                            
%>
<tr>
                        <td><%=TableData.Rows[data]["cus_code"]%></td>
                        <td><%=TableData.Rows[data]["name"]%></td>
                      <td class="mother-company-cell">
    <%
                string motherCompany = Convert.ToString(
                    TableData.Rows[data]["mother_company"]
                ).Trim();

                if (string.IsNullOrEmpty(motherCompany))
                {
    %>

        <button type="button"
                class="btn btn-primary btn-xs add-mother"
                cus-id="<%=TableData.Rows[data]["cus_code"]%>">
            Add
        </button>

        <div class="mother-input-area" style="display:none; margin-top:5px;">

            <input type="text"
                   class="form-control input-sm mother-company-input"
                   placeholder="Enter Mother Company Cus ID" />

            <button type="button"
                    class="btn btn-success btn-xs save-mother"
                    cus-id="<%=TableData.Rows[data]["cus_code"]%>"
                    style="margin-top:5px;">
                Save
            </button>

            <button type="button"
                    class="btn btn-default btn-xs cancel-mother"
                    style="margin-top:5px;">
                Cancel
            </button>

        </div>

    <%
                }
                else
                {
    %>

        <span class="mother-company-value">
            <%=Server.HtmlEncode(motherCompany)%>
        </span>

        <button type="button"
                class="btn btn-danger btn-xs delete-mother"
                cus-id="<%=TableData.Rows[data]["cus_code"]%>">
            Delete
        </button>

    <%
                }
    %>
</td>
                     <td class="mother-company-name">
    <%=TableData.Rows[data]["mother_company_name"]%>
</td>
                       
                     
                        	
                        <td>        

                                    <a href="#"  class="btn btn-success btn-xs edit" cus-type="<%=TableData.Rows[data]["cus_type"]%>"   cus-id="<%=TableData.Rows[data]["cus_code"]%>" >Edit</a>                                    

                                    <a href="#"  class="btn btn-info btn-xs upload" cus-type="<%=TableData.Rows[data]["cus_type"]%>"   cus-id="<%=TableData.Rows[data]["cus_code"]%>">Document Upload</a>                                    


                                    <%  if (Role == 3)
                                        { 
                                            %>

                                    <a href="SanctionUpload_V4.aspx?CusID=<%=TableData.Rows[data]["cus_code"]%>"  class="btn btn-success btn-xs sanction" cus-type="<%=TableData.Rows[data]["cus_type"]%>"   cus-id="<%=TableData.Rows[data]["cus_code"]%>">New Sanction</a>                                    

                                    <%
                                        }
                                        
                                        
                                         %>

  
                        </td>                                
</tr>
     <%
            }

        }
                                                   %>
                        	</tbody>
                    	</table>	
                        
                        <br />
                        AAAA

<select id="Select1"  runat="server"  class="form-control"  style="display:none;">
<option></option>

</select>
                        <asp:Literal ID="ltrMotherChildCompany" runat="server"  Mode="PassThrough"></asp:Literal>                
               		 </div>
              	</div>

                </div>
                </div>
                </section>
</asp:Content>
