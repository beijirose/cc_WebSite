<%@ Page Language="C#" AutoEventWireup="true" CodeFile="detailed.aspx.cs" Inherits="member_detailed" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>会员详细信息</title>
    <link href="../css/rest.css" type="text/css" rel="stylesheet" />
    <link href="../css/layout.css" type="text/css" rel="stylesheet" />
    <script type="text/javascript" src="../js/jquery-1.8.1.min.js"></script>
    <script type="text/javascript" src="../lhgdialog/lhgdialog.min.js?self=true&skin=blue"></script>
    <style type="text/css">
    select{width:180px;height:24px;line-height:24px;padding:1px;margin:0 0 0 3px;}
    textarea {display: block;}
    input{width:250px;}
	.tableDIV{font-size:9pt;color:#515559;width:90%;background:#FFF;border:1px solid #DDDDDC;margin:10px auto;overflow:hidden;overflow-y:scroll;}
	.tableDIV ul{width:100%;height:auto;margin:5px;padding:5px;}
	.tableDIV ul li{float:left;width:48%;margin-right:10px;margin-bottom:10px;}
	.tableDIV p{float:left;width:100%;text-align:center;margin-top:50px;}
	.tableDIV p a{text-decoration:underline;}
	.tableDIV p a:hover{color:#F00;}
	.spanOper{float:right;}
	.spanOper a{color:#FFF;}
	.spanOper a:hover{ text-decoration:underline;}
	.search_bar,#s_conncetion{float:left;}
	.search_bar{width:auto;}
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <div id="topBar"><img src="../images/ico_home.gif" width="17" height="17"/>会员管理&nbsp;<span>>&nbsp;会员详细信息</span></div>
    <div id="main">
    <div class="bar">
	    <table width="90%" class="table" border="1" cellpadding="0" cellspacing="0" style="margin:10px auto;background:#FFF;">
           <tr>
             <td width="14%" rowspan="6">&nbsp;</td>
             <td width="8%" style="text-align:right;">姓名：</td>
             <td width="35%"><asp:Label ID="name" runat="server" Text="name"></asp:Label><input type="hidden" id="member_id" runat="server"/></td>
             <td width="8%" style="text-align:right;">性别：</td>
             <td width="35%"><asp:Label ID="sex" runat="server" Text="sex"></asp:Label></td>
          </tr>
          <tr>
             <td style="text-align:right;">年龄：</td>
             <td><asp:Label ID="age" runat="server" Text="age"></asp:Label></td>
             <td style="text-align:right;">生日：</td>
             <td><asp:Label ID="birthday" runat="server" Text="birthday"></asp:Label></td>
          </tr>
          <tr>
             <td style="text-align:right;">电话：</td>
             <td><asp:Label ID="phone" runat="server" Text="phone"></asp:Label></td>
             <td style="text-align:right;">爱好：</td>
             <td><asp:Label ID="interests" runat="server" Text="interests"></asp:Label></td>
          </tr>
          <tr>
             <td style="text-align:right;">住址：</td>
             <td colspan="3"><asp:Label ID="address" runat="server" Text="address"></asp:Label></td>
          </tr>
          <tr>
             <td style="text-align:right;">添加人：</td>
             <td><asp:Label ID="add_admin" runat="server" Text="add_admin"></asp:Label></td>
             <td style="text-align:right;">添加日期：</td>
             <td><asp:Label ID="add_dt" runat="server" Text="add_dt"></asp:Label></td>
          </tr>
          <tr>
             <td style="text-align:right;">备注：</td>
             <td colspan="3" runat="server" id="remark"></td>
          </tr>
        </table>
        <table width="90%" style="margin:0 auto;background:#F1F1F1;">
           <tr>
              <td>
                 <a href="#" class="btn_azul" id="back" style="float:right;">返&nbsp;&nbsp;&nbsp;回</a>
                 <a href="#" class="btn_azul" id="addConn" style="float:right;margin-right:10px;">添加关系</a>
                 <div class="search_bar">
                    <label>姓&nbsp;&nbsp;&nbsp;名:</label><input id="s_name" name="name" type="text" class="textinput" style="float:left;" />
                    <label>关&nbsp;&nbsp;&nbsp;系:</label><asp:DropDownList ID="s_conncetion" runat="server"></asp:DropDownList>
                    <a href="#" class="btn_azul" id="search" style="float:left;margin-left:20px;">搜&nbsp;&nbsp;&nbsp;索</a>
                 </div>
              </td>
           </tr>
        </table>
    <div class="hr"></div>
    </div>
       <div class="tableDIV"></div>
    </div>
    </form>
    <script type="text/javascript">
       $(document).ready(function(){
           $(".tableDIV").height($(window).height() - $(".table").height() - 130);
		   load_Connection();
		   mouseEvent();
	    });
		
		$("#back").click(function(){
				location.href="memberList.aspx";
			}); 
			
		var api;
		$("#addConn").click(function(){
				api=$.dialog({
				  title: '添加会员关系',
				  id:"addMenberConnection",
				  content: 'url:addMemberConnection.aspx',
				  data:$("#member_id").val(),
				  width:800,
				  height:400,
				  max: false,
				  min: false
		   });
	    }); 
		
	   function mouseEvent(){
			$("li").mouseenter(function(){
			   $(this).find(".table").css({"color":"#FFF","background":"#016A99"});
			   var mc_id;
			   if($(this).find(".table td").eq(2).find("span").length<=0)
			   {
				   mc_id=$(this).find(".table").attr("name");
				   $(this).find(".table td").eq(2).append("<span class='spanOper'><a href='#' onclick='editMC("+mc_id+")'>编辑</a><a href='#' style='margin-left:8px;' onclick='del("+mc_id+")'>删除</a></span>");
			    }
	        });
			   
	        $("li").mouseleave (function(){
			   $(this).find(".table").css({"color":"#515559","background":"#FFF"});
			   $(this).find(".table td").eq(2).find("span").remove();
		     });   
	   }
	   
	   function addConn(){
		   $("#addConn").click();
	   }
	   
	   $(window).bind('resize', winResize);
       function winResize() {
          $(".tableDIV").height($(window).height()-$(".table").height()-100);
      }
 
	  function load_Connection(){
		  $.ajax({
               type: 'Post',
               async: false,
               url: 'detailed.aspx/setConnection',
               data: "{'id':'" + $('#member_id').val() + "'}",
               contentType: "application/json; charset=utf-8",
               dataType: "json",
               success: function (msg) {
				   $(".tableDIV").empty();
                   $(".tableDIV").append(msg.d);
				   mouseEvent();
               },
               error: function (err) {
                   alert("加载关系失败,请稍后再试!");
               }
           });
       }

       $("#search").click(function () {
           $.ajax({
               type: 'Post',
               async: false,
               url: 'detailed.aspx/search_Connection',
               data: "{'name':'" + $('#s_name').val() + "','connection_id':'" + $('#s_conncetion').val() + "','member_id':'" + $('#member_id').val() + "'}",
               contentType: "application/json; charset=utf-8",
               dataType: "json",
               success: function (msg) {
                   $(".tableDIV").empty();
                   $(".tableDIV").append(msg.d);
				   mouseEvent();
               },
               error: function (err) {
                   alert("加载关系失败,请稍后再试!");
               }
           });
       });

      function reloadPage() {
		  api.close();
          load_Connection();
      }	 
	  
	  function del(id){
		  var YN=confirm("你确定要删除该关系成员吗？");
		  if(YN==true){
			  $.ajax({
               type: 'Post',
               async: false,
               url: 'detailed.aspx/del_member_Connecton',
               data: "{'id':'" + id + "','member_id':'" + $('#member_id').val() + "'}",
               contentType: "application/json; charset=utf-8",
               dataType: "json",
               success: function (msg) {
                   $(".tableDIV").empty();
                   $(".tableDIV").append(msg.d);
				   mouseEvent();
               },
               error: function (err) {
                   alert("加载关系失败,请稍后再试!");
               }
           });
		  }
	  }
	  
	  var edit;
	  function editMC(id){
		  edit=$.dialog({
				  title: '添加会员关系',
				  id:"editMenberConnection",
				  content: 'url:editMemberConnection.aspx',
				  data:id,
				  width:800,
				  height:400,
				  max: false,
				  min: false
		   });
	  }
    </script>
</body>
</html>
