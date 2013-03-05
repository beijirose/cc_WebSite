<%@ Page Language="C#" AutoEventWireup="true" CodeFile="editConnection.aspx.cs" Inherits="connection_editConnection" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>关系表修改</title>
    <link href="../css/rest.css" type="text/css" rel="stylesheet" />
    <link href="../css/layout.css" type="text/css" rel="stylesheet" />
    <script type="text/javascript" src="../js/jquery-1.8.1.min.js"></script>
    <script type="text/javascript" src="../lhgdialog/lhgdialog.min.js?self=true&skin=blue"></script>
    <style type="text/css">
	table{margin:20px 0 0 0;}
    table td{padding:12px 0;}
    </style>
</head>
<body>
   <form runat="server">
       <table width="300" cellpadding="0" cellspacing="0" border="0">
          <tr>
            <td style="padding-bottom:45px;"><label>称&nbsp;&nbsp;&nbsp;谓:</label><asp:TextBox ID="name" runat="server" CssClass="textinput"></asp:TextBox></td>
          </tr>
          <tr>
            <td><a href="#" class="btn_azul" style="margin-left:120px;">保&nbsp;&nbsp;&nbsp;存</a></td>
          </tr>
      </table>
  </form>
  	<script type="text/javascript">
  	    var api = frameElement.api;W = api.opener;
  	    $(document).ready(function () {
  	        $.ajax({
  	            type: 'Post',
  	            async: false,
  	            url: 'editConnection.aspx/load',
  	            data: "{'id':'" + api.data + "'}",
  	            contentType: "application/json; charset=utf-8",
  	            dataType: "json",
  	            success: function (msg) {
  	                var str = msg.d;
  	                str = str.replace(/[ ]/g, ""); //替换所有空格
  	                $("#name").val(str);
  	            },
  	            error: function (err) {
  	                alert("加载称谓失败,请稍后再试!");
  	            }
  	        });
  	    });

  	    $(".btn_azul").click(function () {
  	        if ($("#name").val() != "") {
  	            $.ajax({
  	                type: 'Post',
  	                async: false,
  	                url: 'editConnection.aspx/edit',
  	                data: "{'id':'" + api.data + "','name':'" + $("#name").val() + "'}",
  	                contentType: "application/json; charset=utf-8",
  	                dataType: "json",
  	                success: function (msg) {
  	                    W.editCloes();
  	                },
  	                error: function (err) {
  	                    alert("修改称谓失败,请稍后再试!");
  	                }
  	            });
  	        }
  	        else {
  	            alert("请输入称谓名称!");
  	        }
  	    });
	</script>
</body>
</html>
