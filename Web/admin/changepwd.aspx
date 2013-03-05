<%@ Page Language="C#" AutoEventWireup="true" CodeFile="changepwd.aspx.cs" Inherits="changepwd" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>修改密码</title>
    <link href="css/rest.css" type="text/css" rel="stylesheet" />
    <link href="css/layout.css" type="text/css" rel="stylesheet" />
    <script type="text/javascript" src="js/jquery-1.8.1.min.js"></script>
    <style type="text/css">
    table{background:#FFF;}
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <div id="topBar"><img src="images/ico_home.gif" width="17" height="17"/>控制面板&nbsp;<span>>&nbsp;修改密码</span></div>
    <div id="main">
    <table width="90%" class="table" border="1" cellpadding="0" cellspacing="0" style="margin:10px auto;">
       <tr>
          <td width="100" style="text-align:right;">旧密码：</td>
          <td colspan="3"><asp:TextBox ID="odlpwd" runat="server" TextMode="Password"></asp:TextBox></td>
       </tr>
       <tr>
          <td width="100" style="text-align:right;">新密码：</td>
          <td colspan="3"><asp:TextBox ID="newpwd" runat="server" TextMode="Password"></asp:TextBox></td>
       </tr>
       <tr>
          <td width="100" style="text-align:right;">重复新密码：</td>
          <td colspan="3"><asp:TextBox ID="repwd" runat="server" TextMode="Password"></asp:TextBox></td>
       </tr>
       <tr>
          <td colspan="4"><a href="#" class="btn_azul" style="margin:0 auto;float:none;">保&nbsp;&nbsp;&nbsp;存</a></td>
       </tr>
    </table>
    </div>
    </form>
    <script type="text/javascript">
        var api = frameElement.api; W = api.opener;
        $(".btn_azul").click(function () {
            if ($("#odlpwd").val() != "") {
                if ($("#newpwd").val() != "" && $("#repwd").val() != "") {
                    if ($("#newpwd").val() == $("#repwd").val()) {
                        $.ajax({
                            type: 'Post',
                            async: false,
                            url: 'changepwd.aspx/cpwd',
                            data: "{'oldpwd':'" + $("#odlpwd").val() + "','newpwd':'" + $("#newpwd").val() + "'}",
                            contentType: "application/json; charset=utf-8",
                            dataType: "json",
                            success: function (msg) {
                                if (msg.d == "0") {
                                    alert("修改密码失败，请确认您的旧密码是否正确！");
                                }
                                else {
                                    alert("密码修改成功！");
                                    W.closeWin();
                                }
                            }
                        });
                    }
                    else {
                        alert("两次输入密码不一致！")
                    }
                }
                else {
                    alert("请输入新密码！")
                }
            }
            else {
                alert("请输入旧密码！")
            }
        });
    </script>
</body>
</html>
