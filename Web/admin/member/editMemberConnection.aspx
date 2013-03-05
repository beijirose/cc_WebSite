<%@ Page Language="C#" AutoEventWireup="true" CodeFile="editMemberConnection.aspx.cs" Inherits="member_editMemberConnection" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>修改会员关系</title>
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
    <div id="topBar"><img src="../images/ico_home.gif" width="17" height="17"/>会员管理&nbsp;<span>>&nbsp;修改会员关系</span></div>
    <div id="main">
    <table width="90%" class="table" border="1" cellpadding="0" cellspacing="0" style="margin:10px auto;">
       <tr>
          <td width="130" style="text-align:right;">姓名：</td>
          <td colspan="3"><asp:TextBox ID="name" runat="server"></asp:TextBox><span style="color:Red;">*</span></td>
       </tr>
       <tr>
          <td width="130" style="text-align:right;">关系：</td>
          <td colspan="3">
              <asp:DropDownList ID="conncetion" runat="server">
              </asp:DropDownList><span style="color:Red;">*</span>
          </td>
       </tr>
       <tr>
          <td width="130" style="text-align:right;">电话：</td>
          <td colspan="3"><asp:TextBox ID="phone" runat="server" onkeyup="this.value=this.value.replace(/\D/g,'')" onafterpaste="this.value=this.value.replace(/\D/g,'')"></asp:TextBox></td>
       </tr>
       <tr>
          <td width="130" style="text-align:right;">住址：</td>
          <td colspan="3"><asp:TextBox ID="address" runat="server" Width="600"></asp:TextBox></td>
       </tr>
       <tr>
          <td width="130" style="text-align:right;">备注：</td>
          <td colspan="3">
             <textarea name="content" id="remark" style="width:600px;height:150px;visibility:hidden;"></textarea>
          </td>
       </tr>
       <tr>
          <td colspan="4">
             <a href="#" class="btn_azul" id="save" style="margin-left:270px;float:left;">保&nbsp;&nbsp;&nbsp;存</a>
             <a href="#" class="btn_azul" id="back" style="margin-left:20px;float:left;">返&nbsp;&nbsp;&nbsp;回</a>
          </td>
       </tr>
    </table>
    </div>
    </form>
    <script type="text/javascript">
    var editor;
    var edit = frameElement.api; W = edit.opener;
    $(document).ready(function () {
        $.ajax({
            type: 'Post',
            async: false,
            url: 'editMemberConnection.aspx/load',
            data: "{'id':'" + edit.data + "'}",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (msg) {
                var jsonObj = eval("(" + msg.d + ")");   //转换成json对象
                $("#name").val(jsonObj.name);
                $("#conncetion").val(jsonObj.connection);
                $("#phone").val(jsonObj.phone);
                $("#address").val(jsonObj.address);
                setContent(jsonObj.remark);
            },
            error: function (err) {
                alert("加载关系信息失败,请稍后再试!");
            }
        });
    });

    function setContent(info) {
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
            editor.html(info);
        });
    }

    $("#back").click(function () {
        edit.close();
    });

    $("#save").click(function () {
        $.ajax({
            type: 'Post',
            async: false,
            url: 'editMemberConnection.aspx/updataMC',
            data: "{'id':'" + edit.data + "','name':'" + $("#name").val() + "','connection':'" + $("#conncetion").val() + "','phone':'" + $("#phone").val() + "','address':'" + $("#address").val() + "','remark':'" + editor.html() + "'}",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (msg) {
                W.load_Connection();
				edit.close();
            },
            error: function (err) {
                alert("更新关系信息失败,请稍后再试!");
            }
        });
    });
    </script>
</body>
</html>
