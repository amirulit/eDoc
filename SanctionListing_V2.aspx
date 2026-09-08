<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="SanctionListing_V2.aspx.cs" Inherits="SanctionListing_V2"
    
    
    Debug="true"
     %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script type="text/javascript">

        $(document).ready(function () {

            $("body").on("click", ".upload", function () {

                var cus_type = $(this).attr("cus-type");
                var auto_id = $(this).attr("auto-id");
                var e_doc_id = $(this).attr("edoc-id");
                var drawdown_id = $(this).attr("drawdown-id");

                //alert(cus_type + '-' + e_doc_id);

                url = "DocumentUpload_V9.aspx?var=" + cus_type + "&var1=" + auto_id + "&var2=" + e_doc_id + "&var3=" + drawdown_id;

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

    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <section class="content"> <!-- Start of table section -->
    	<div class="row" id="table1"><!--MSK-000132-1-->
        	<div class="col-md-12">
            	<div class="box">
                	<div class="box-header">
                  		<h3 class="box-title">Sanction Listing </h3>
                	</div><!-- /.box-header -->
                	<div class="box-body table-responsive"  >
                     
                		<table id="example1" class="table table-bordered table-striped">
                    		<thead>
                            <tr>
                        		<th>ID</th>
                                <th>Reference</th>
                            	<th>Date</th>
                            	<th>Authority</th>
                            	<th>Branch</th>
                                <th>Action</th>
                             </tr>
                        	</thead>
                         
                        	<tbody>
    <%
                    
        //var sts = "";
        //var css = "";

        //var last_renew_dt = "";


        if (TableData.Rows.Count > 0)
        {
            for (var data = 0; data < TableData.Rows.Count; data++)
            {
                            
%>
<tr>
                        <td><%=TableData.Rows[data]["id"]%></td>
                        <td><%=TableData.Rows[data]["sanction_reference"]%></td>
                        <td><%=TableData.Rows[data]["sanction_date"]%></td>
                        <td><%=TableData.Rows[data]["sanction_authority"]%></td>
                        <td><%=TableData.Rows[data]["booking_branch"]%></td>
                        	
                        <td>        

                        <a href="#"  class="btn btn-success btn-xs edit" cus-type="<%=TableData.Rows[data]["id"]%>"  drawdown-id="<%=TableData.Rows[data]["id"]%>">Edit</a>                                    

                        <a href="#"  class="btn btn-info btn-xs upload" cus-type="<%=TableData.Rows[data]["id"]%>" auto-id="<%=TableData.Rows[data]["id"]%>"  edoc-id="<%=TableData.Rows[data]["id"]%>" drawdown-id="<%=TableData.Rows[data]["id"]%>">Document Upload</a>                                    
  


                        <a href="DrawdownCreate_V3.aspx?id=<%=TableData.Rows[data]["id"]%>&ref=<%=TableData.Rows[data]["sanction_reference"]%>"  class="btn btn-success btn-xs" cus-type="<%=TableData.Rows[data]["id"]%>" auto-id="<%=TableData.Rows[data]["id"]%>"  edoc-id="<%=TableData.Rows[data]["id"]%>" drawdown-id="<%=TableData.Rows[data]["id"]%>">Initiate Checklist</a>                                    



                        </td>                                
</tr>
     <%
                        }

                    }
                                                   %>
                        	</tbody>
                    	</table>	                
               		</div>
              	</div>
            </div>
		</div>
</asp:Content>
