<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Login.aspx.cs" Inherits="Login" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="content-type" content="text/html; charset=utf-8" />
    <title>管理员登录</title>
    <link href="css/rest.css" type="text/css" rel="stylesheet" />
    <link href="css/layout.css" type="text/css" rel="stylesheet" />
    <script type="text/javascript" src="js/jquery-1.8.1.min.js"></script>
    <style type="text/css">
    body{font: 100% 'MovistarTxt', Arial, Helvetica, sans-serif;margin: 0;padding: 0;color: #00567d;background:url("images/fndpage.jpg") top left repeat-x #FFF;}
    table{position:absolute;top:160px;right:70px;}
    table td{padding-bottom:10px;text-align:left;color:#000;}
    html{overflow:auto;}
    .login_bg{width:1000px;height:500px;margin:0 auto; background:url("images/a.png") no-repeat;}
    .login_logo{width:1002px;margin:0 auto;text-align:right;}
    .login_logo img{margin:20px 0;}
    </style>
</head>
<body>
   <div class="login_logo" style="height:70px;"></div>
   <div class="login_bg" style="position:relative;">
        <table width="200" border="0">
          <tr>
            <td style="text-align:right;font-size:12px;">操作员代码:</td>
            <td><input type="text" style="width:120px;background-color:#FFF;" id="userId"/></td>
          </tr>
          <tr>
            <td style="text-align:right;font-size:12px;">密&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;码:</td>
            <td><input type="password" style="width:120px;background-color:#FFF;" id="pwdId"/></td>
          </tr>
          <tr>
            <td style="text-align:right;">&nbsp;</td>
            <td>&nbsp;</td>
          </tr>
          <tr>
            <td colspan="2"><a href="#" class="btn_azul_login" id="login" style="margin-left:90px;text-indent:7px;">登&nbsp;&nbsp;录</a></td>
          </tr>
        </table>
   </div>
   <script type="text/javascript">
       $(document).ready(function() {
           $('#userId').focus();

           $("#login").click(function() {
               if ($('#userId').val() != "" && $('#pwdId').val() != "") {
                   $.ajax({
                       type: 'Post',
                       async: false,
                       url: 'Login.aspx/loginYN',
                       data: "{'username':'" + $('#userId').val() + "','password':'" + $('#pwdId').val() + "'}",
                       contentType: "application/json; charset=utf-8",
                       dataType: "json",
                       success: function(msg) {
                           if (msg.d == "1") {
                               window.location.href = 'admin/index.aspx';
                           } else {
                               alert("用户名或密码错误!");
                           }
                       },
                       error: function(err) {
                           alert("登录失败！请稍后再试或联系管理员。");
                       }
                   });
               }
               else {
                   alert("请输入用户名或密码！");
               }
           });

           
       });
    </script>
</body>
</html>
