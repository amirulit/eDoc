<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default2.aspx.cs" Inherits="Default2" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <title>Student Management System</title>
  <!-- Tell the browser to be responsive to screen width -->
  <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
  <!-- Bootstrap 3.3.6 -->
  <link rel="stylesheet" href="bootstrap/css/bootstrap.min.css">
  <!-- Font Awesome -->
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.5.0/css/font-awesome.min.css">
  <!-- Ionicons -->
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/ionicons/2.0.1/css/ionicons.min.css">
  <!-- Theme style -->
  <link rel="stylesheet" href="dist/css/AdminLTE.min.css">
  <!-- AdminLTE Skins. Choose a skin from the css/skins
       folder instead of downloading all of them to reduce the load. -->
  <link rel="stylesheet" href="dist/css/skins/_all-skins.min.css">
  <!-- iCheck -->
  <link rel="stylesheet" href="plugins/iCheck/flat/blue.css">
  <!-- Bootstrap Color Picker -->
  <link rel="stylesheet" href="plugins/colorpicker/bootstrap-colorpicker.min.css">
  
  <!-- jvectormap -->
  <link rel="stylesheet" href="plugins/jvectormap/jquery-jvectormap-1.2.2.css">
  <!-- Date Picker -->
  <link rel="stylesheet" href="plugins/datepicker/datepicker3.css">
  <!-- Daterange picker -->
  <link rel="stylesheet" href="plugins/daterangepicker/daterangepicker-bs3.css">
  <!-- bootstrap wysihtml5 - text editor -->
  <link rel="stylesheet" href="plugins/bootstrap-wysihtml5/bootstrap3-wysihtml5.min.css">
   <!-- DataTables -->
    <link rel="stylesheet" href="plugins/datatables/dataTables.bootstrap.css">
    <link rel="icon" href="uploads/logo3.png">
    
    <!-- jQuery 2.1.4 --> 
    <script src="plugins/jQuery/jQuery-2.1.4.min.js"></script>
    <!-- Bootstrap 3.3.5 -->
    <script src="bootstrap/js/bootstrap.min.js"></script>
    <!-- DataTables -->
    <script src="plugins/datatables/jquery.dataTables.min.js"></script>
    <script src="plugins/datatables/dataTables.bootstrap.min.js"></script>
    <!-- iCheck 1.0.1 -->
    <script src="plugins/iCheck/icheck.min.js"></script>
    <!-- AdminLTE App -->
    <script src="dist/js/app.min.js"></script>
    <!-- AdminLTE for demo purposes -->
    <script src="dist/js/demo.js"></script>
   	<!-- Chart JS -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.4.0/Chart.bundle.js"> </script> 
	<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.4.0/Chart.js"> </script>
    <!-- Select2 -->
    <script src="plugins/select2/select2.full.min.js"></script>
    <!-- InputMask -->
    <script src="plugins/input-mask/jquery.inputmask.js"></script>
    <script src="plugins/input-mask/jquery.inputmask.date.extensions.js"></script>
    <script src="plugins/input-mask/jquery.inputmask.extensions.js"></script>
    <!-- date-range-picker -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.10.2/moment.min.js"></script>
    <script src="plugins/daterangepicker/daterangepicker.js"></script>
   	
    <!-- page script -->
    <script>
        $(function () {
            $("#example1").DataTable();
            $('#example2').DataTable({
                "paging": true,
                "lengthChange": false,
                "searching": false,
                "ordering": true,
                "info": true,
                "autoWidth": false
            });
        });
    </script><!-- Here is the End of page script--> 
    
  <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
  <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
  <!--[if lt IE 9]>
  <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
  <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
  <![endif]-->
</head>
<body class="hold-transition skin-blue sidebar-mini" >
<div class="wrapper">
  <header class="main-header" >
    <!-- Logo -->
    <a href="" class="logo">
      <!-- mini logo for sidebar mini 50x50 pixels -->
      <span class="logo-mini"><strong>INS</strong></span>
      <!-- logo for regular state and mobile devices -->
      <span class="logo-lg"><strong>Ingenious </strong></span>
    </a>
    <!-- Header Navbar: style can be found in header.less -->
    <nav class="navbar navbar-static-top">
      <!-- Sidebar toggle button-->
		<a href="#" class="sidebar-toggle" data-toggle="offcanvas" role="button">
       		<span class="sr-only">Toggle navigation</span>
       	</a>
		<div class="navbar-custom-menu">
			<ul class="nav navbar-nav">
            
              <!-- Notifications: style can be found in dropdown.less -->
              <li class="dropdown notifications-menu">
                <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                  <i class="fa fa-bell-o"></i>
<br />
 
            	<!-- Messages: style can be found in dropdown.less-->
              <li class="dropdown messages-menu"  id="friend_request">
              	<a href="#" class="dropdown-toggle" data-toggle="dropdown" onClick="showFriendRequest('','')">
                  <i class="fa fa-user-plus"></i>
                  <span class="label label-success">0</span>
                </a>
              </li> 
              
 

              <!-- Messages: style can be found in dropdown.less-->
              <li class="dropdown messages-menu" id="unread_msg">
                <a href="#" class="dropdown-toggle" data-toggle="dropdown" >
                  <i class="fa fa-envelope-o"></i>
                  <span class="label label-success">0</span>
                </a>
                <ul class="dropdown-menu">
                  <li class="header">You have 0 messages</li>
                  
                  <li>
                    <!-- inner menu: contains the actual data -->
                    <ul class="menu">
<br />
 
 
                    </ul>
                  </li>
                  <li class="footer"><a href="#">See All Messages</a></li>
                </ul>
              </li>  

<br /> 

 

                <!-- User Account: style can be found in dropdown.less -->
            	<li class="dropdown user user-menu">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                      <img src="user2-160x160.jpg" class="user-image" alt="User Image">
                      <span class="hidden-xs"></span>
                    </a>
                    <ul class="dropdown-menu">
                      <!-- User image -->
                      <li class="user-header">
                        <img src="" class="img-circle" alt="User Image">
        
                        <p>
                           -                           <small>Member since Jan. 1970</small>                        </p>
                      </li>
                      <!-- Menu Body -->
                      
                      <!-- Menu Footer-->
                      <li class="user-footer">
                        <div class="pull-left">
                          <a href="#" class="btn btn-default btn-flat">Profile</a>
                        </div>
                        <div class="pull-right">
                          <a href="login.php" class="btn btn-default btn-flat">Sign out</a>
                        </div>
                      </li>
                    </ul>
              </li>
            </ul> 
        </div>
	</nav>
  </header>
  <div class="row" id="fProfile">
        
  </div>
  <div id="viewDuePayment">
    
  </div>
  <div id="viewAllNotification">
    
  </div>
  <div id="stdProfile">
    
  </div>
  <div id="showEvent2">
  
  </div>
  
   <!-- //MSK-000124 Modal-Delete Confirm Popup -->
	<div class="modal msk-fade" id="deleteConfirmReq" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  		<div class="modal-dialog">
    		<div class="modal-content">
				<div class="modal-header bg-primary">
        			<button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
        			<h4 class="modal-title" id="frm_title">Delete</h4>
      			</div>

				<div class="modal-body bgColorWhite">
        			<strong style="color:red;">Are you sure?</strong>  Do you want to Delete this Friend Request.
        		</div>
      			<div class="modal-footer">
					<a href="#" style='margin-left:10px;' id="btnYesReq" class="deletebtn btn btn-danger col-sm-2 pull-right">Yes</a><!-- MSK-000125 -->
        			<button type="button" class="btn btn-primary col-sm-2 pull-right" data-dismiss="modal" id="frm_cancel">No</button>
      			</div>
    		</div>
  		</div>
	</div>
     
    
<style>
.msk-fade {  
      
    -webkit-animation-name: animatetop;
    -webkit-animation-duration: 0.4s;
    animation-name: animatetop;
    animation-duration: 0.4s

}  
  /* Add Animation */
@-webkit-keyframes animatetop {
    from {top:-300px; opacity:0} 
    to {top:0; opacity:1}
}

@keyframes animatetop {
    from {top:-300px; opacity:0}
    to {top:0; opacity:1}
}

.modal-content1 {
   position: absolute;
   left: 25%; 
}

</style><!-- Left side column. contains the logo and sidebar -->
  <aside class="main-sidebar">
    <!-- sidebar: style can be found in sidebar.less -->
    <section class="sidebar">
      <!-- Sidebar user panel -->
<br />
<b>Notice</b>:  Undefined index: index_number in <b>C:\xampp\htdocs\std1\std1\view\sidebar.php</b> on line <b>9</b><br />
      
      
      <div class="user-panel">
      	<div class="pull-left image">
        	<img src="user2-160x160.jpg" class="img-circle" alt="User Image">
        </div>
        <div class="pull-left info">
        	<p></p>
            <a href="#"><i class="fa fa-circle text-success"></i> Online</a>
        </div>
      </div>
      <!-- sidebar menu: : style can be found in sidebar.less -->
      <ul class="sidebar-menu">
        <li class="header">MAIN NAVIGATION</li>
        <li class="active treeview">
          <a href="dashboard.php">
            <i class="fa fa-dashboard"></i> <span>Dashboard</span>
          </a>
        </li>
         <li>
          <a href="admin_profile.php">
            <i class="fa fa-flag"></i> <span>My Profile</span>
          </a>
        </li>
        <li>
          <a href="class_room.php">
            <i class="fa fa-list-ul"></i> <span>Classroom</span>
          </a>
        </li>
        <li>
          <a href="grade.php">
            <i class="fa fa-database"></i> <span>Grade</span>
          </a>
        </li>
        <li>
          <a href="subject.php">
            <i class="fa fa-book"></i> <span>Subject</span>
          </a>
        </li>
        <li class="treeview">
          <a href="#">
            <i class="fa fa-user" aria-hidden="true"></i>
            <span>Teacher</span>
            <span class="pull-right-container">
              <i class="fa fa-angle-left pull-right"></i>
            </span>
          </a>
          <ul class="treeview-menu">
            <li><a href="teacher.php"><i class="fa fa-circle-o"></i> Add Teacher</a></li>
            <li><a href="all_teacher.php"><i class="fa fa-circle-o"></i> All Teacher</a></li>
          </ul>
        </li>
        <li>
          <a href="subject_routing.php">
            <i class="fa fa-th"></i> <span>Subject Routing</span>
          </a>
        </li>
        <li>
          <a href="timetable.php">
            <i class="fa fa-calendar-plus-o"></i> <span>Timetable</span>
          </a>
        </li>
        <li class="treeview">
          <a href="#">
            <i class="fa fa-graduation-cap"></i>
            <span>Student</span>
            <span class="pull-right-container">
              <i class="fa fa-angle-left pull-right"></i>
            </span>
          </a>
          <ul class="treeview-menu">
            <li><a href="student.php"><i class="fa fa-circle-o"></i> Add Student</a></li>
            <li><a href="all_student.php"><i class="fa fa-circle-o"></i> All Student</a></li>
            <li><a href="student_leave.php"><i class="fa fa-circle-o"></i> Leave Student</a></li>
          </ul>
        </li>
        <li>
          <a href="student_payment.php">
            <i class="fa fa-money"></i> <span>Student Payment</span>
          </a>
        </li>
         <li class="treeview">
          <a href="#">
            <i class="fa fa-calendar-check-o"></i>
            <span>Attendance</span>
            <span class="pull-right-container">
              <i class="fa fa-angle-left pull-right"></i>
            </span>
          </a>
          <ul class="treeview-menu">
            <li><a href="add_attendance.php"><i class="fa fa-circle-o"></i> Add Attendance</a></li>
            <li><a href="student_attendance_history.php"><i class="fa fa-circle-o"></i>Student Attendance History </a></li>
            <li><a href="teacher_attendance_history.php"><i class="fa fa-circle-o"></i> Teacher Attendance History</a></li>
          </ul>
        </li>
        <li class="treeview">
          <a href="#">
            <i class="fa fa-certificate"></i>
            <span>Exam</span>
            <span class="pull-right-container">
              <i class="fa fa-angle-left pull-right"></i>
            </span>
          </a>
          <ul class="treeview-menu">
            <li><a href="exam.php"><i class="fa fa-circle-o"></i>Create Exam</a></li>
            <li><a href="exam_timetable.php"><i class="fa fa-circle-o"></i> Exam Timetable</a></li>
            <li><a href="student_exam_marks.php"><i class="fa fa-circle-o"></i>Student Exam Marks</a></li>
            <li><a href="student_exam_marks_history.php"><i class="fa fa-circle-o"></i>Student Exam Marks History</a></li>
          </ul>
        </li>
        <li>
          <a href="petty_cash.php">
            <i class="fa fa-yen"></i> <span>Petty Cash</span>
          </a>
        </li>
        <li class="treeview">
          <a href="#">
            <i class="fa fa-facebook"></i>
            <span>Friends</span>
            <span class="pull-right-container">
              <i class="fa fa-angle-left pull-right"></i>
            </span>
          </a>
          <ul class="treeview-menu">
          	<li><a href="add_friends.php"><i class="fa fa-circle-o"></i> Add Friends</a></li>
            <li><a href="my_friends.php"><i class="fa fa-circle-o"></i> My Friends</a>
           
          </ul>
        </li>
        <li class="treeview">
          <a href="#">
            <i class="fa fa-calendar"></i>
            <span>Event</span>
            <span class="pull-right-container">
              <i class="fa fa-angle-left pull-right"></i>
            </span>
          </a>
          <ul class="treeview-menu">
            <li><a href="my_events.php"><i class="fa fa-circle-o"></i> My Events</a></li>
            <li><a href="all_events.php"><i class="fa fa-circle-o"></i> All Events</a></li>
          </ul>
        </li>
      </ul>
    </section>
    <!-- /.sidebar -->
  </aside> 	<!--Success! - Insert-->
  	<div class="modal fade" id="insert_Success" tabindex="-1" role="dialog" aria-labelledby="insert_alert2" aria-hidden="true">
    	<div class="modal-dialog">    
        	<div class="modal-content">
        		<div class="modal-header bg-primary">
          			<button type="button" class="close" data-dismiss="modal" aria-hidden="true"><span class="glyphicon glyphicon-remove" aria-hidden="true"></span></button>
          			<h4>Information...!</h4>
        		</div>
        		<div class="modal-body bgColorWhite">
        			<strong style="color:red;">Success!</strong> Your information has been successfully inserted in our database.
        		</div>
      		</div>      
		</div>
	</div><!--/.Modal--> 
    
    <!--Success! - Update-->
  	<div class="modal fade" id="update_Success" tabindex="-1" role="dialog" aria-labelledby="update_alert1" aria-hidden="true">
    	<div class="modal-dialog">    
      		<div class="modal-content">
        		<div class="modal-header bg-primary">
          			<button type="button" class="close" data-dismiss="modal" aria-hidden="true"><span class="glyphicon glyphicon-remove" aria-hidden="true"></span></button>
          			<h4>Information...!</h4>
        		</div>
        		<div class="modal-body bgColorWhite">
        			<strong style="color:red;">Success!</strong> Your information has been successfully updated in our database.
        		</div>
      		</div>
    	</div>
	</div><!--/.Modal-Update feedback alert 1 --> 
  
	<!--Success! - Delete-->
  	<div class="modal fade" id="delete_Success" tabindex="-1" role="dialog" aria-labelledby="insert_alert1" aria-hidden="true">
    	<div class="modal-dialog">    
      		<div class="modal-content">
        		<div class="modal-header bg-primary">
          			<button type="button" class="close" data-dismiss="modal" aria-hidden="true"><span class="glyphicon glyphicon-remove" aria-hidden="true"></span></button>
          			<h4>Information...!</h4>
        		</div>
        		<div class="modal-body bgColorWhite">
        			<strong style="color:red;">Success!</strong> Your information has been successfully deleted in our database.
        		</div>
      		</div>
    	</div>
  	</div><!--/.Modal--> 
    
    <!--Success! - Leave-->
  	<div class="modal fade" id="leave_Success" tabindex="-1" role="dialog" aria-labelledby="insert_alert1" aria-hidden="true">
    	<div class="modal-dialog">    
      		<div class="modal-content">
        		<div class="modal-header bg-primary">
          			<button type="button" class="close" data-dismiss="modal" aria-hidden="true"><span class="glyphicon glyphicon-remove" aria-hidden="true"></span></button>
          			<h4>Information...!</h4>
        		</div>
        		<div class="modal-body bgColorWhite">
        			<strong style="color:red;">Success!</strong> The student has been successfully leave in our database.
        		</div>
      		</div>
    	</div>
  	</div><!--/.Modal--> 
    
    	<!--Success! - Approve-->
  	<div class="modal fade" id="approve_Success" tabindex="-1" role="dialog" aria-labelledby="insert_alert2" aria-hidden="true">
    	<div class="modal-dialog">    
        	<div class="modal-content">
        		<div class="modal-header bg-primary">
          			<button type="button" class="close" data-dismiss="modal" aria-hidden="true"><span class="glyphicon glyphicon-remove" aria-hidden="true"></span></button>
          			<h4>Information...!</h4>
        		</div>
        		<div class="modal-body bgColorWhite">
        			<strong style="color:red;">Success!</strong> Petty Cash has been successfully Approved.
        		</div>
      		</div>      
		</div>
	</div><!--/.Modal-->
    
    <!--Something is wrong! - Connection Problem-->
	<div class="modal fade" id="connection_Problem" tabindex="-1" role="dialog" aria-labelledby="insert_alert3" aria-hidden="true">
    	<div class="modal-dialog">    
      		<div class="modal-content">
        		<div class="modal-header bg-purple-active">
          			<button type="button" class="close" data-dismiss="modal" aria-hidden="true"><span class="glyphicon glyphicon-remove" aria-hidden="true"></span></button>
          			<h4>Information...!</h4>
        		</div>
        		<div class="modal-body bgColorWhite">
        			<strong style="color:red; font-size:14px">Something is wrong!</strong> Check your Internet Connection and try again.
        		</div>
      		</div>
		</div>
	</div><!--/.Modal>
    
    <!--You didn't make any changes.:D -->
  	<div class="modal fade" id="update_error1" tabindex="-1" role="dialog" aria-labelledby="update_alert2" aria-hidden="true">
    	<div class="modal-dialog">    
      		<div class="modal-content">
        		<div class="modal-header bg-green-active">
          			<button type="button" class="close" data-dismiss="modal" aria-hidden="true"><span class="glyphicon glyphicon-remove" aria-hidden="true"></span></button>
          			<h4>Information...!</h4>
        		</div>
        		<div class="modal-body bgColorWhite">
        			<strong style="color:red;">Warnning!</strong> You didn't make any changes. <strong style="color:red;">:D</strong>
        		</div>
      		</div>
    	</div>
	</div><!--/.Modal-->
     
	<!--Warnning! - Classroom is Duplicated-->
	<div class="modal fade" id="classroom_Duplicated" tabindex="-1" role="dialog" aria-labelledby="insert_alert1" aria-hidden="true">
    	<div class="modal-dialog">    
      		<div class="modal-content">
        		<div class="modal-header bg-red-active">
          			<button type="button" class="close" data-dismiss="modal" aria-hidden="true"><span class="glyphicon glyphicon-remove" aria-hidden="true"></span></button>
          			<h4>Information...!</h4>
        		</div>
        		<div class="modal-body bgColorWhite">
        			<strong style="color:red; font-size:14px">Warnning!</strong> This Classroom is already have in our Database.
        		</div>
			</div>
		</div>
	</div><!--/.Modal-->
    
    <!--Warnning! - Grade is Duplicated-->
	<div class="modal fade" id="grade_Duplicated" tabindex="-1" role="dialog" aria-labelledby="insert_alert1" aria-hidden="true">
    	<div class="modal-dialog">    
      		<div class="modal-content">
        		<div class="modal-header bg-red-active">
          			<button type="button" class="close" data-dismiss="modal" aria-hidden="true"><span class="glyphicon glyphicon-remove" aria-hidden="true"></span></button>
          			<h4>Information...!</h4>
        		</div>
        		<div class="modal-body bgColorWhite">
        			<strong style="color:red; font-size:14px">Warnning!</strong> This Grade is already have in our Database.
        		</div>
			</div>
		</div>
	</div><!--/.Modal--> 
    
    <!--Warnning! - Subject is Duplicated-->
	<div class="modal fade" id="subject_Duplicated" tabindex="-1" role="dialog" aria-labelledby="insert_alert1" aria-hidden="true">
    	<div class="modal-dialog">    
      		<div class="modal-content">
        		<div class="modal-header bg-red-active">
          			<button type="button" class="close" data-dismiss="modal" aria-hidden="true"><span class="glyphicon glyphicon-remove" aria-hidden="true"></span></button>
          			<h4>Information...!</h4>
        		</div>
        		<div class="modal-body bgColorWhite">
        			<strong style="color:red; font-size:14px">Warnning!</strong> This Subject is already have in our Database.
        		</div>
			</div>
		</div>
	</div><!--/.Modal--> 
    
      <!--Warnning! - Exam is Duplicated-->
	<div class="modal fade" id="exam_Duplicated" tabindex="-1" role="dialog" aria-labelledby="insert_alert1" aria-hidden="true">
    	<div class="modal-dialog">    
      		<div class="modal-content">
        		<div class="modal-header bg-red-active">
          			<button type="button" class="close" data-dismiss="modal" aria-hidden="true"><span class="glyphicon glyphicon-remove" aria-hidden="true"></span></button>
          			<h4>Information...!</h4>
        		</div>
        		<div class="modal-body bgColorWhite">
        			<strong style="color:red; font-size:14px">Warnning!</strong> This Exam is already have in our Database.
        		</div>
			</div>
		</div>
	</div><!--/.Modal--> 
    
    <!--Warnning! - Index Number is Duplicated-->
  	<div class="modal fade" id="index_Duplicated" tabindex="-1" role="dialog" aria-labelledby="insert_alert1" aria-hidden="true">
    	<div class="modal-dialog">    
      		<div class="modal-content">
        		<div class="modal-header bg-red-active">
          			<button type="button" class="close" data-dismiss="modal" aria-hidden="true"><span class="glyphicon glyphicon-remove" aria-hidden="true"></span></button>
          			<h4>Information...!</h4>
        		</div>
        		<div class="modal-body bgColorWhite">
        			<strong style="color:red; font-size:14px">Warnning!</strong> This Index Number already have in our Database.
        		</div>
      		</div>
    	</div>
	</div><!--/.Modal-->
    
    <!--Warnning! - Email Address is Duplicated-->
  	<div class="modal fade" id="email_Duplicated" tabindex="-1" role="dialog" aria-labelledby="insert_alert1" aria-hidden="true">
    	<div class="modal-dialog">    
      		<div class="modal-content">
        		<div class="modal-header bg-red-active">
          			<button type="button" class="close" data-dismiss="modal" aria-hidden="true"><span class="glyphicon glyphicon-remove" aria-hidden="true"></span></button>
          			<h4>Information...!</h4>
        		</div>
        		<div class="modal-body bgColorWhite">
        			<strong style="color:red; font-size:14px">Warnning!</strong> This Email Address already have in our Database.
        		</div>
      		</div>
    	</div>
	</div><!--/.Modal-->
    
    <!--Warnning! - Index Number and Email Address are Duplicated-->
  	<div class="modal fade" id="index_email_Duplicated" tabindex="-1" role="dialog" aria-labelledby="insert_alert1" aria-hidden="true">
    	<div class="modal-dialog">    
      		<div class="modal-content">
        		<div class="modal-header bg-red-active">
          			<button type="button" class="close" data-dismiss="modal" aria-hidden="true"><span class="glyphicon glyphicon-remove" aria-hidden="true"></span></button>
          			<h4>Information...!</h4>
        		</div>
        		<div class="modal-body bgColorWhite">
        			<strong style="color:red; font-size:14px">Warnning!</strong> This Index Number and Email Address already have in our Database.
        		</div>
      		</div>
    	</div>
	</div><!--/.Modal-->
    
    <!--Warnning! - Email Address is Duplicated-->
  	<div class="modal fade" id="exam_Duplicated" tabindex="-1" role="dialog" aria-labelledby="insert_alert1" aria-hidden="true">
    	<div class="modal-dialog">    
      		<div class="modal-content">
        		<div class="modal-header bg-red-active">
          			<button type="button" class="close" data-dismiss="modal" aria-hidden="true"><span class="glyphicon glyphicon-remove" aria-hidden="true"></span></button>
          			<h4>Information...!</h4>
        		</div>
        		<div class="modal-body bgColorWhite">
        			<strong style="color:red; font-size:14px">Warnning!</strong> This Exam name already have in our Database.
        		</div>
      		</div>
    	</div>
	</div><!--/.Modal-->
    
     <!--Warnning! - Attendance is Duplicated-->
  	<div class="modal fade" id="attendance_Duplicated" tabindex="-1" role="dialog" aria-labelledby="insert_alert1" aria-hidden="true">
    	<div class="modal-dialog">    
      		<div class="modal-content">
        		<div class="modal-header bg-red-active">
          			<button type="button" class="close" data-dismiss="modal" aria-hidden="true"><span class="glyphicon glyphicon-remove" aria-hidden="true"></span></button>
          			<h4>Information...!</h4>
        		</div>
        		<div class="modal-body bgColorWhite">
        			<strong style="color:red; font-size:14px">Warnning!</strong> Your Attendance already have in our Database.
        		</div>
      		</div>
    	</div>
	</div><!--/.Modal-->
    
    
    <!--Warnning! - For Subject Routing, -->
  	<div class="modal fade" id="duplicate_Record1" tabindex="-1" role="dialog" aria-labelledby="insert_alert1" aria-hidden="true">
    	<div class="modal-dialog">    
      		<div class="modal-content">
        		<div class="modal-header bg-red-active">
          			<button type="button" class="close" data-dismiss="modal" aria-hidden="true"><span class="glyphicon glyphicon-remove" aria-hidden="true"></span></button>
          			<h4>Information...!</h4>
        		</div>
        		<div class="modal-body bgColorWhite">
        			<strong style="color:red; font-size:14px">Warnning!</strong> Duplicate Record.
        		</div>
      		</div>
    	</div>
	</div><!--/.Modal-->
    
     <!--Warnning! - For the Timetable -->
  	<div class="modal fade" id="duplicate_Record2" tabindex="-1" role="dialog" aria-labelledby="insert_alert1" aria-hidden="true">
    	<div class="modal-dialog">    
      		<div class="modal-content">
        		<div class="modal-header bg-red-active">
          			<button type="button" class="close" data-dismiss="modal" aria-hidden="true"><span class="glyphicon glyphicon-remove" aria-hidden="true"></span></button>
          			<h4>Information...!</h4>
        		</div>
        		<div class="modal-body bgColorWhite">
        			<strong style="color:red; font-size:14px">Warnning!</strong> At this time there already have class, in that classroom. 
        		</div>
      		</div>
    	</div>
	</div><!--/.Modal-->
    
     <!--Warnning! - There haven't default image upload folder-->
  	<div class="modal fade" id="upload_error1" tabindex="-1" role="dialog" aria-labelledby="insert_alert1" aria-hidden="true">
    	<div class="modal-dialog">    
      		<div class="modal-content">
        		<div class="modal-header bg-red-active">
          			<button type="button" class="close" data-dismiss="modal" aria-hidden="true"><span class="glyphicon glyphicon-remove" aria-hidden="true"></span></button>
          			<h4>Information...!</h4>
        		</div>
        		<div class="modal-body bgColorWhite">
        			<strong style="color:red; font-size:14px">Warnning!</strong> There haven't, default image upload folder.
        		</div>
      		</div>
    	</div>
	</div><!--/.Modal-->	
    
     <!--Warnning! - This Index Number haven't in our Database-->
  	<div class="modal fade" id="wrong_Index" tabindex="-1" role="dialog" aria-labelledby="insert_alert1" aria-hidden="true">
    	<div class="modal-dialog">    
      		<div class="modal-content">
        		<div class="modal-header bg-red-active">
          			<button type="button" class="close" data-dismiss="modal" aria-hidden="true"><span class="glyphicon glyphicon-remove" aria-hidden="true"></span></button>
          			<h4>Information...!</h4>
        		</div>
        		<div class="modal-body bgColorWhite">
        			<strong style="color:red; font-size:14px">Warnning!</strong> This Index Number haven't in our Database.
        		</div>
      		</div>
    	</div>
	</div><!--/.Modal-->	

<style>

.form-control-feedback {
  
   pointer-events: auto;
  
}

.set-width-tooltip + .tooltip > .tooltip-inner { 
     min-width:180px;
}
.msk-fade {  
      
    -webkit-animation-name: animatetop;
    -webkit-animation-duration: 0.5s;
    animation-name: animatetop;
    animation-duration: 0.5s;
	

}

.modal-content1 {
  height: auto;
  min-height: 100%;
  border-radius: 0;
  position: absolute;
  left: 25%; 
}

/* Add Animation */
@-webkit-keyframes animatetop {
    from {top:-300px; opacity:0} 
    to {top:0; opacity:1}
}

@keyframes animatetop {
    from {top:-300px; opacity:0}
    to {top:0; opacity:1}
}

.cal-table{
	
width:100%;
padding:0;
margin:0;	
}

#calendar_dates{
	padding:10px;
	margin-left:10px;
	width:95%;	
	
}

.tHead{
	
	height:40px;
	background-color:#8e1c82;
	color:#FFF;
	text-align:center;
	border:1px solid #FFF;
	width:70px;
}

.cal-tr{
	height:50px;
	
}

.td_no_number{
	border:1px solid white;
	width:70px;
	background-color:#979045;
	padding:0;
}



.cal-number-td{
	border:1px solid white;
	width:70px;
	background-color:#677be2;
	color:white;
	
		
}

.h5{
	color:#FFF;
	display: inline-block;
	background:#636;
	width:15px;
	height:15px;	
	font-size:11px;
	font-weight:bold;
	font-family:Cambria, "Hoefler Text", "Liberation Serif", Times, "Times New Roman", serif;
	text-align:center;
	float:right;
	padding-top:1px;
	margin-bottom:50%;
	
}
.div-event-c{
	margin-top:65%;
	height:17px;
	
}

#cal_month{
	width:20%;
	border-radius:5%;
	
	padding:0;
}
#cal_year{
	width:15%;
	border-radius:5%;
	margin-left:5px;
	padding:0;
}

#btnShow{
	
	margin-left:5px;
	
}


</style>

<!-- Content Wrapper. Contains page content -->
<div class="content-wrapper">
	<!-- Content Header (Page header) -->
    <section class="content-header">
    	<h1>
        	Dashboard
        	<small>Preview</small>
        </h1>
        <ol class="breadcrumb">
        	<li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
            <li><a href="#">Dashboard</a></li>
    	</ol>
	</section>
    
<br />
<b>Notice</b>:  Undefined index: index_number in <b>C:\xampp\htdocs\std1\std1\view\dashboard.php</b> on line <b>161</b><br />
  
    
    <!-- Main content -->
    <section class="content">
      <!-- Info boxes -->
      <div class="row">
        <div class="col-md-3 col-sm-6 col-xs-12">
          <div class="info-box">
            <span class="info-box-icon bg-aqua"><i class="ion ion-ios-gear-outline"></i></span>

            <div class="info-box-content">
              <span class="info-box-text">Total Student</span>
               
              <span class="info-box-number">1</span>
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
              <span class="info-box-text">Total Teacher</span>
 
              <span class="info-box-number">1</span>
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
              <span class="info-box-text">Monthly Income</span>
             
        
              <span class="info-box-number"><small>$</small></span>
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
              <span class="info-box-text">Total Income</span>
             
        
              <span class="info-box-number"><small>$</small></span>
            </div>
            <!-- /.info-box-content -->
          </div>
          <!-- /.info-box -->
        </div>
        <!-- /.col -->
      </div>
      <!-- /.row -->
      <h5>,<strong><span style="color:#cf4ed4;"> Welcome back! </span></strong></h5>
	    
		<div class="row" id="table1"><!--MSK-000132-1-->    
        	<div class="col-md-8">
           		<center><h4 class="box-title">Monthly Income</h4></center>
                <canvas id="barChart" width="800" height="438"></canvas>
  			</div>
 

<script>    showBarChart('"","","","","","","","","","","",""');</script>            
          
        	<div class="col-md-4">
                <div id="calendar-container">
                	<div id="calendar-header">
                    	<center><h4><span id="calendar_month_year"></span> 2024 </h4></center>
        			</div>
                    <input type="hidden" id="my_index" value="">  
                    <input type="hidden" id="my_type" value="">                         
                 </div>
                 <div class="row1" id="row">
                        
                 </div>
       		</div>
        </div>  
	
    	<div id="cEvent">
    
    	</div>  
     

	<div id="showEvent">
    
    </div>
     

<br />
<b>Notice</b>:  Undefined index: index_number in <b>C:\xampp\htdocs\std1\std1\view\dashboard.php</b> on line <b>586</b><br />
<br />
<b>Notice</b>:  Undefined index: type in <b>C:\xampp\htdocs\std1\std1\view\dashboard.php</b> on line <b>587</b><br />
<script>ShowEvents("K",,"");</script>
	<div class="row" >
    	<div class="col-md-10" ><!-- left column -->
        	<center><h4>Monthly Student Registration</h4></center>
            
            <canvas id="lineChart" width="800" height="450"></canvas>
         </div>  
     </div>
		 
 
                 
</div><!-- /.content-wrapper --> 
    
	<footer class="main-footer">
        <div class="pull-right hidden-xs">
          <b>Version</b> 1.0.2
        </div>
        <strong>Copyright &copy; 2018-2019 <a href="">ILovePrograming</a>.</strong> All rights reserved.
     </footer>
      
  </body>
</html>