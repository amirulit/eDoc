<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="Dashboard.aspx.cs" Inherits="Dashboard" Debug="true" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <link href="bootstrap4/boostrap.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript">


        $(function () {


            var d = new Date();

            //alert(d);
        });


        function openNewWindow(win,status) {
            //window.open('Dashboard_Credit.aspx', '_blank', 'width=1000,height=700');


            window.open(win + '?S=' + status, '_blank', 'width=1000,height=700');
        }

    </script>
    <style type="text/css">
        .modal-header {
            display: flex;
            align-items: center;
            justify-content: space-between;
        }

            .modal-header .close {
                margin-top: 0;
            }


        .small-box {
            border-radius: 5px;
            overflow: hidden;
        }


        .info-box {
            border-radius: 10px;
            overflow: hidden;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <section class="content-header">
      <h1>
        Dashboard
       
      </h1>
      <ol class="breadcrumb">
        <li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
        <li class="active">Dashboard</li>
      </ol>
    </section>
    <section class="content">

        <!--Credit Division-->

     <% if (Role == 21 || Role == 23 || Role == 25 || Role == 27 || Role == 29 || Role == 31 || Role == 33 || Role == 35)
        { %>
    <div class="row">

    <div class="col-lg-4 col-xs-6">
        <div class="small-box bg-aqua">
            <div class="inner">
                <h3>
                   <%-- <asp:Label ID="lblUploadedSanction" runat="server" Text="0"></asp:Label>--%>   

                    <%=tot_uploaded %>
                </h3>
                <p>Uploaded Sanction</p>
            </div>
            <div class="icon">
                <i class="ion ion-bag"></i>
            </div>
           <a href="javascript:void(0);" class="small-box-footer" onclick="openNewWindow('Dashboard_Uploaded.aspx',1)">
    More info <i class="fa fa-arrow-circle-right"></i>
</a>
        </div>
    </div>

    <div class="col-lg-4 col-xs-6">
        <div class="small-box bg-green">
            <div class="inner">
                <h3>
                    <%--<asp:Label ID="lblPendingSanction" runat="server" Text="0"></asp:Label>--%>
                    <%=tot_pending %>
                </h3>
                <p>Pending List</p>
            </div>
            <div class="icon">
                <i class="ion ion-stats-bars"></i>
            </div>
            <a href="#" class="small-box-footer" onclick="openNewWindow('Dashboard_Uploaded.aspx',0)">
                More info <i class="fa fa-arrow-circle-right"></i>
            </a>
        </div>
    </div>

    <div class="col-lg-4 col-xs-6">
        <div class="small-box bg-yellow">
            <div class="inner">
                <h3>
                   <%-- <asp:Label ID="lblTotalUsers" runat="server" Text="0"></asp:Label>--%>
                <%= tot_user %>
                </h3>
                <p>Total Users</p>
            </div>
            <div class="icon">
                <i class="ion ion-person-add"></i>
            </div>
            <a href="#" class="small-box-footer"  onclick="openNewWindow('Dashboard_UserList.aspx',1)">
                More info <i class="fa fa-arrow-circle-right"></i>
            </a>
        </div>
    </div>

</div>

<%} %>

           <!--Branch/Uposhakha-->

        <% if (Role == 5 || Role == 7 || Role == 9 || Role == 11)
        {
                
                 %>
    <div class="row">

    <div class="col-lg-3 col-xs-6">
        <div class="small-box bg-aqua">
            <div class="inner">
                <h3>
                   <%-- <asp:Label ID="lblUploadedSanction" runat="server" Text="0"></asp:Label>--%><%=tot_uploaded %>
                </h3>
                <p>Uploaded Sanction</p>
            </div>
            <div class="icon">
                <i class="ion ion-bag"></i>
            </div>
           <a href="javascript:void(0);" class="small-box-footer" onclick="openNewWindow('Dashboard_Uploaded.aspx',1)">
    More info <i class="fa fa-arrow-circle-right"></i>
</a>
        </div>
    </div>

    <div class="col-lg-3 col-xs-6">
        <div class="small-box bg-green">
            <div class="inner">
                <h3>
                    <%--<asp:Label ID="lblPendingSanction" runat="server" Text="0"></asp:Label>--%>
                    <%=tot_ongoing %>
                </h3>
                <p>On Going</p>
            </div>
            <div class="icon">
                <i class="ion ion-stats-bars"></i>
            </div>
            <a href="#" class="small-box-footer" onclick="openNewWindow('Dashboard_Ongoing.aspx',0)">
                More info <i class="fa fa-arrow-circle-right"></i>
            </a>
        </div>
    </div>

    <div class="col-lg-3 col-xs-6">
        <div class="small-box bg-yellow">
            <div class="inner">
                <h3>
                   <%-- <asp:Label ID="lblTotalUsers" runat="server" Text="0"></asp:Label>--%>
                <%= tot_ssc_completed %>
                </h3>
                <p>Completed SSC</p>
            </div>
            <div class="icon">
                <i class="ion ion-person-add"></i>
            </div>
            <a href="#" class="small-box-footer"  onclick="openNewWindow('Dashboard_SSC_Complete.aspx',1)">
                More info <i class="fa fa-arrow-circle-right"></i>
            </a>
        </div>
    </div>

        <div class="col-lg-3 col-xs-6">
        <div class="small-box  bg-info">
            <div class="inner">
                <h3>
                   <%-- <asp:Label ID="lblTotalUsers" runat="server" Text="0"></asp:Label>--%>
                <%= tot_user %>
                </h3>
                <p>Total Users</p>
            </div>
            <div class="icon">
                <i class="ion ion-person-add"></i>
            </div>
            <a href="#" class="small-box-footer"  onclick="openNewWindow('Dashboard_UserList.aspx',1)">
                More info <i class="fa fa-arrow-circle-right"></i>
            </a>
        </div>
    </div>

</div>

<%} %>



        
           <!--CAD-->

        






        <% if (Role == 57 || Role == 59 || Role == 61 || Role == 63 || Role == 65 || Role == 67)
        {
                
                 %>
    <div class="row">

    <div class="col-lg-3 col-xs-6">
        <div class="small-box bg-aqua">
            <div class="inner">
                <h3>
                   <%-- <asp:Label ID="lblUploadedSanction" runat="server" Text="0"></asp:Label>--%><%=tot_uploaded %>
                </h3>
                <p>Uploaded Sanction</p>
            </div>
            <div class="icon">
                <i class="ion ion-bag"></i>
            </div>
           <a href="javascript:void(0);" class="small-box-footer" onclick="openNewWindow('Dashboard_Uploaded.aspx',1)">
    More info <i class="fa fa-arrow-circle-right"></i>
</a>
        </div>
    </div>

    <div class="col-lg-3 col-xs-6">
        <div class="small-box bg-green">
            <div class="inner">
                <h3>
                    <%--<asp:Label ID="lblPendingSanction" runat="server" Text="0"></asp:Label>--%>
                    <%=tot_ongoing %>
                </h3>
                <p>On Going</p>
            </div>
            <div class="icon">
                <i class="ion ion-stats-bars"></i>
            </div>
            <a href="#" class="small-box-footer" onclick="openNewWindow('Dashboard_Ongoing.aspx',0)">
                More info <i class="fa fa-arrow-circle-right"></i>
            </a>
        </div>
    </div>

    <div class="col-lg-3 col-xs-6">
        <div class="small-box bg-yellow">
            <div class="inner">
                <h3>
                   <%-- <asp:Label ID="lblTotalUsers" runat="server" Text="0"></asp:Label>--%>
                <%= tot_ssc_completed %>
                </h3>
                <p>Completed SSC</p>
            </div>
            <div class="icon">
                <i class="ion ion-person-add"></i>
            </div>
            <a href="#" class="small-box-footer"  onclick="openNewWindow('Dashboard_SSC_Complete.aspx',1)">
                More info <i class="fa fa-arrow-circle-right"></i>
            </a>
        </div>
    </div>

        <div class="col-lg-3 col-xs-6">
        <div class="small-box  bg-info">
            <div class="inner">
                <h3>
                   <%-- <asp:Label ID="lblTotalUsers" runat="server" Text="0"></asp:Label>--%>
                <%= tot_user %>
                </h3>
                <p>Total Users</p>
            </div>
            <div class="icon">
                <i class="ion   ion-person-add"></i>
            </div>
            <a href="#" class="small-box-footer"  onclick="openNewWindow('Dashboard_UserList.aspx',1)">
                More info <i class="fa fa-arrow-circle-right"></i>
            </a>
        </div>
    </div>

</div>

<%} %>





       <% if (Role == 81 || Role == 83)
              
              
              
              
          { %>

      <div class="row">
        <div class="col-md-3 col-sm-6 col-xs-12">
          <div class="info-box">
            <span class="info-box-icon bg-aqua"><i class="ion ion-ios-gear-outline"></i></span>

            <div class="info-box-content">
              <span class="info-box-text">Document Expiring</span>
              <span class="info-box-number">90</span>
            </div>
            <!-- /.info-box-content -->
          </div>
          <!-- /.info-box -->
        </div>
        <!-- /.col -->
        <div class="col-md-3 col-sm-6 col-xs-12">
          <div class="info-box">
            <span class="info-box-icon bg-red"><i class="fa fa-google-plus"></i></span>

            <div class="info-box-content">
              <span class="info-box-text">Completed SSC</span>
              <span class="info-box-number">41</span>
            </div>
            <!-- /.info-box-content -->
          </div>
          <!-- /.info-box -->
        </div>

        </div>

        
       <%
          }
           
            %>


         <% if (Role == 97 || Role == 99)
              
              
              
              
          { %>
    <div class="row">

    <div class="col-lg-3 col-xs-6">
        <div class="small-box bg-aqua">
            <div class="inner">
                <h3>
                   <%-- <asp:Label ID="lblUploadedSanction" runat="server" Text="0"></asp:Label>--%><%=tot_uploaded %>
                </h3>
                <p>Uploaded Sanction</p>
            </div>
            <div class="icon">
                <i class="ion ion-bag"></i>
            </div>
           <a href="javascript:void(0);" class="small-box-footer" onclick="openNewWindow('Dashboard_Uploaded.aspx',1)">
    More info <i class="fa fa-arrow-circle-right"></i>
</a>
        </div>
    </div>

    <div class="col-lg-3 col-xs-6">
        <div class="small-box bg-green">
            <div class="inner">
                <h3>
                    <%--<asp:Label ID="lblPendingSanction" runat="server" Text="0"></asp:Label>--%>
                    <%=tot_ongoing %>
                </h3>
                <p>On Going</p>
            </div>
            <div class="icon">
                <i class="ion ion-stats-bars"></i>
            </div>
            <a href="#" class="small-box-footer" onclick="openNewWindow('Dashboard_Ongoing.aspx',0)">
                More info <i class="fa fa-arrow-circle-right"></i>
            </a>
        </div>
    </div>

    <div class="col-lg-3 col-xs-6">
        <div class="small-box bg-yellow">
            <div class="inner">
                <h3>
                   <%-- <asp:Label ID="lblTotalUsers" runat="server" Text="0"></asp:Label>--%>
                <%= tot_ssc_completed %>
                </h3>
                <p>Completed SSC</p>
            </div>
            <div class="icon">
                <i class="ion ion-person-add"></i>
            </div>
            <a href="#" class="small-box-footer"  onclick="openNewWindow('Dashboard_SSC_Complete.aspx',1)">
                More info <i class="fa fa-arrow-circle-right"></i>
            </a>
        </div>
    </div>

        <div class="col-lg-3 col-xs-6">
        <div class="small-box bg-info">
            <div class="inner">
                <h3>
                   <%-- <asp:Label ID="lblTotalUsers" runat="server" Text="0"></asp:Label>--%>
                <%= tot_user %>
                </h3>
                <p>Total Users</p>
            </div>
            <div class="icon">
                <i class="ion ion-person-add"></i>
            </div>
            <a href="#" class="small-box-footer"  onclick="openNewWindow('Dashboard_UserList.aspx',1)">
                More info <i class="fa fa-arrow-circle-right"></i>
            </a>
        </div>
    </div>

</div>
        
       <%
          }
           
            %>

<%--
 <div class="row">
        <div class="col-lg-3 col-xs-6">
      
          <div class="small-box bg-aqua">
            <div class="inner">
              <h3>150</h3>

              <p>Relation Manager</p>
            </div>
            <div class="icon">
              <i class="ion ion-bag"></i>
            </div>
            <a href="#" class="small-box-footer">More info <i class="fa fa-arrow-circle-right"></i></a>
          </div>
        </div>
    
        <div class="col-lg-3 col-xs-6">
     
          <div class="small-box bg-green">
            <div class="inner">
              <h3>53<sup style="font-size: 20px"></sup></h3>

              <p>Credit Division</p>
            </div>
            <div class="icon">
              <i class="ion ion-stats-bars"></i>
            </div>
            <a href="#" class="small-box-footer">More info <i class="fa fa-arrow-circle-right"></i></a>
          </div>
        </div>
     
        <div class="col-lg-3 col-xs-6">
       
          <div class="small-box bg-yellow">
            <div class="inner">
              <h3>44</h3>

              <p>Documentation Manager</p>
            </div>
            <div class="icon">
              <i class="ion ion-person-add"></i>
            </div>
            <a href="#" class="small-box-footer">More info <i class="fa fa-arrow-circle-right"></i></a>
          </div>
        </div>
       
        <div class="col-lg-3 col-xs-6">
       
          <div class="small-box bg-red">
            <div class="inner">
              <h3>65</h3>

              <p>Unit Head</p>
            </div>
            <div class="icon">
              <i class="ion ion-pie-graph"></i>
            </div>
            <a href="#" class="small-box-footer">More info <i class="fa fa-arrow-circle-right"></i></a>
          </div>
        </div>
     
      </div>

       <div class="row">
        <div class="col-md-3 col-sm-6 col-xs-12">
          <div class="info-box">
            <span class="info-box-icon bg-aqua"><i class="ion ion-ios-gear-outline"></i></span>

            <div class="info-box-content">
              <span class="info-box-text">Document Expiring</span>
              <span class="info-box-number">90</span>
            </div>
            <!-- /.info-box-content -->
          </div>
          <!-- /.info-box -->
        </div>
        <!-- /.col -->
        <div class="col-md-3 col-sm-6 col-xs-12">
          <div class="info-box">
            <span class="info-box-icon bg-red"><i class="fa fa-google-plus"></i></span>

            <div class="info-box-content">
              <span class="info-box-text">Document Pending</span>
              <span class="info-box-number">41</span>
            </div>
            <!-- /.info-box-content -->
          </div>
          <!-- /.info-box -->
        </div>
        <!-- /.col -->

        <!-- fix for small devices only -->
        <div class="clearfix visible-sm-block"></div>

        <div class="col-md-3 col-sm-6 col-xs-12">
          <div class="info-box">
            <span class="info-box-icon bg-green"><i class="ion ion-ios-cart-outline"></i></span>

            <div class="info-box-content">
              <span class="info-box-text">SSC Pending</span>
              <span class="info-box-number">760</span>
            </div>
            <!-- /.info-box-content -->
          </div>
          <!-- /.info-box -->
        </div>
        <!-- /.col -->
        <div class="col-md-3 col-sm-6 col-xs-12">
          <div class="info-box">
            <span class="info-box-icon bg-yellow"><i class="ion ion-ios-people-outline"></i></span>

            <div class="info-box-content">
              <span class="info-box-text">LLI Pending</span>
              <span class="info-box-number">5</span>
            </div>
            <!-- /.info-box-content -->
          </div>
          <!-- /.info-box -->
        </div>
        <!-- /.col -->
      </div>--%>
      
      
   <%-- <a href="#teacherDetails" data-toggle="modal" onclick="teacherDetails(this);" data-id="1">Test Modal</a>--%>

    <div class="modal" id="teacherDetails" tabindex="-1" role="dialog" data-backdrop="static" data-keyboard="false">
        <div class="modal-dialog modal-lg" style="width: 90%" role="document">
            <div class="modal-content">
                <div class="modal-header bg-green">
                    <h5 class="modal-title" id="tName">
                    </h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="row">
                        <div class="col-sm-3">
                            <img id="tImage" class="img-circle" style="width: 120px; height: 120px;">
                        </div>
                        <div class="col-sm-9">
                            <table class="table">
                                <tbody>
                                    <tr>
                                        <td>
                                            Index Number
                                        </td>
                                        <td id="tIndex">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            Name
                                        </td>
                                        <td id="tName1">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            Address
                                        </td>
                                        <td id="tAddress">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            Gender
                                        </td>
                                        <td id="tGender">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            Phone
                                        </td>
                                        <td id="tPhone">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            Email
                                        </td>
                                        <td id="tEmail">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            Register Date
                                        </td>
                                        <td id="tRegDate">
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    

      </section>
</asp:Content>
