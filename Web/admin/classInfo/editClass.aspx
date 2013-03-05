<%@ Page Language="C#" AutoEventWireup="true" CodeFile="editClass.aspx.cs" Inherits="classInfo_editClass" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>修改班级</title>
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
    <div id="topBar"><img src="../images/ico_home.gif" width="17" height="17"/>班级管理&nbsp;<span>>&nbsp;修改班级</span></div>
    <div id="main">
    <table width="90%" class="table" border="1" cellpadding="0" cellspacing="0" style="margin:10px auto;">
       <tr>
          <td width="100" style="text-align:right;">班级名称：</td>
          <td colspan="3"><asp:TextBox ID="name" runat="server"></asp:TextBox><span style="color:Red;">*</span></td>
       </tr>
       <tr>
          <td width="100" style="text-align:right;">开始时间：</td>
          <td><asp:TextBox ID="starttime" runat="server" CssClass="Wdate" onFocus="WdatePicker({maxDate:'#F{$dp.$D(\'endtime\')}',minDate:'%y-%M-%d'})"></asp:TextBox><span style="color:Red;">*</span></td>
          <td width="100" style="text-align:right;">结束时间：</td>
          <td><asp:TextBox ID="endtime" runat="server" CssClass="Wdate" onFocus="WdatePicker({minDate:'#F{$dp.$D(\'starttime\')||\'%y-%M-%d\'}',maxDate:'2020-10-01'})"></asp:TextBox><span style="color:Red;">*</span></td>
       </tr>
       <tr>
          <td width="100" style="text-align:right;">备注：</td>
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
        var api = frameElement.api; W = api.opener;
        $(document).ready(function () {
            $.ajax({
                type: 'Post',
                async: false,
                url: 'editClass.aspx/load',
                data: "{'id':'" + api.data + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (msg) {
                    var jsonObj = eval("(" + msg.d + ")");   //转换成json对象
                    $("#name").val(jsonObj.name);
                    $("#starttime").val(jsonObj.startime);
                    $("#endtime").val(jsonObj.endtime);
                    setContent(jsonObj.remark);
                },
                error: function (err) {
                    alert("加载班级失败,请稍后再试!");
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

        $("#save").click(function () {
            if ($("#name").val() != "") {
                if ($("#starttime").val() != "" && $("#endtime").val() != "") {
                    $.ajax({
                        type: 'Post',
                        async: false,
                        url: 'editClass.aspx/updataClass',
                        data: "{'name':'" + $('#name').val() + "','starttime':'" + $('#starttime').val() + "','endtime':'" + $('#endtime').val() + "','remark':'" + editor.html() + "','id':'" + api.data + "'}",
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        success: function (msg) {
                            W.editCloes();
                        },
                        error: function (err) {
                            alert("更新会员失败,请稍后再试!");
                        }
                    });
                }
                else {
                    alert("请选择起止时间!");
                }
            }
            else {
                alert("请输入班级名称!");
                $("#name").focus();
            }
        });

        $("#back").click(function () {
            W.editCloes();
        });
    </script>
</body>
</html>
