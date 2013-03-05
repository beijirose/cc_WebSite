<%@ Page Language="C#" AutoEventWireup="true" CodeFile="addMember.aspx.cs" Inherits="member_addMember" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>添加会员</title>
    <link href="../css/rest.css" type="text/css" rel="stylesheet" />
    <link href="../css/layout.css" type="text/css" rel="stylesheet" />
    <script type="text/javascript" src="../js/jquery-1.8.1.min.js"></script>
    <script type="text/javascript" charset="utf-8" src="../kindeditor/kindeditor-min.js"></script>
	<script type="text/javascript" charset="utf-8" src="../kindeditor/zh_CN.js"></script>
    <script language="javascript" type="text/javascript" src="../DatePicker/WdatePicker.js"></script>
    <style type="text/css">
    select{width:180px;height:24px;line-height:24px;padding:1px;margin:0 0 0 3px;}
    table{background:#FFF;}
    textarea {display: block;}
    input{width:250px;}
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <div id="topBar"><img src="../images/ico_home.gif" width="17" height="17"/>会员管理&nbsp;<span>>&nbsp;添加会员</span></div>
    <div id="main">
    <table width="90%" class="table" border="1" cellpadding="0" cellspacing="0" style="margin:10px auto;">
       <tr>
          <td width="100" style="text-align:right;">姓名：</td>
          <td colspan="3"><asp:TextBox ID="name" runat="server"></asp:TextBox><span style="color:Red;">*</span></td>
       </tr>
       <tr>
          <td width="100" style="text-align:right;">生日：</td>
          <td><asp:TextBox ID="birthday" runat="server" CssClass="Wdate" onfocus="WdatePicker({maxDate:'%y-%M-%d'})"></asp:TextBox><span style="color:Red;">*</span></td>
          <td width="100" style="text-align:right;">年龄：</td>
          <td><asp:TextBox ID="age" runat="server" onkeyup="this.value=this.value.replace(/\D/g,'')" onafterpaste="this.value=this.value.replace(/\D/g,'')"></asp:TextBox><span style="color:Red;">*</span></td>
       </tr>
       <tr>
          <td width="100" style="text-align:right;">性别：</td>
          <td colspan="3">
              <select id="sex" runat="server">
                  <option value ="男">男</option>
                  <option value ="女">女</option>
              </select>
          </td>
       </tr>
       <tr>
          <td width="100" style="text-align:right;">电话：</td>
          <td colspan="3"><asp:TextBox ID="phone" runat="server" onkeyup="this.value=this.value.replace(/\D/g,'')" onafterpaste="this.value=this.value.replace(/\D/g,'')"></asp:TextBox></td>
       </tr>
       <tr>
          <td width="100" style="text-align:right;">住址：</td>
          <td colspan="3"><asp:TextBox ID="address" runat="server" Width="600"></asp:TextBox></td>
       </tr>
       <tr>
          <td width="100" style="text-align:right;">爱好：</td>
          <td colspan="3"><asp:TextBox ID="interests" runat="server" Width="400"></asp:TextBox></td>
       </tr>
       <tr>
          <td width="100" style="text-align:right;">备注：</td>
          <td colspan="3">
             <textarea name="content" id="remark" style="width:700px;height:150px;visibility:hidden;"></textarea>
          </td>
       </tr>
       <tr>
          <td colspan="4"><a href="#" class="btn_azul" style="margin:0 auto;float:none;">保&nbsp;&nbsp;&nbsp;存</a></td>
       </tr>
    </table>
    </div>
    </form>
    <script type="text/javascript">
        var editor;
        KindEditor.ready(function (K) {
            editor = K.create('textarea[name="content"]', {
                resizeType: 1,
                allowPreviewEmoticons: false,
                allowImageUpload: false,
                items: [
						'fontname', 'fontsize', '|', 'forecolor', 'hilitecolor', 'bold', 'italic', 'underline',
						'removeformat', '|', 'justifyleft', 'justifycenter', 'justifyright', 'insertorderedlist',
						'insertunorderedlist']
            });
        });

        $(document).ready(function () {
            var dateTime = new Date();
            var yy = dateTime.getFullYear();
            $("#age").focus(function () {
                if ($("#birthday").val() != "") {
                    $("#age").val(yy - $("#birthday").val().substr(0, 4));
                }
            });
        });

        $(".btn_azul").click(function () {
            if ($("#name").val() != "") {
                if ($("#age").val() != "" && $("#age").val() != "birthday") {
                    $.ajax({
                        type: 'Post',
                        async: false,
                        url: 'addMember.aspx/addMember',
                        data: "{'name':'" + $('#name').val() + "','age':'" + $('#age').val() + "','birthday':'" + $('#birthday').val() + "','sex':'" + $('#sex').val() + "','phone':'" + $('#phone').val() + "','address':'" + $('#address').val() + "','interests':'" + $('#interests').val() + "','remark':'" + editor.html() + "'}",
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        success: function (msg) {
                            alert("添加会员成功！");
                            location.reload();
                        },
                        error: function (err) {
                            alert("新增会员失败,请稍后再试!");
                        }
                    });
                }
                else {
                    alert("请选择出生日期和年龄!");
                }
            }
            else {
                alert("请输入会员姓名!");
            }
        });
    </script>
</body>
</html>
