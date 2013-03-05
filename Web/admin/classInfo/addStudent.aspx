<%@ Page Language="C#" AutoEventWireup="true" CodeFile="addStudent.aspx.cs" Inherits="classInfo_addStudent" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>班级管理-添加学员</title>
    <link href="../css/rest.css" type="text/css" rel="stylesheet" />
    <link href="../css/layout.css" type="text/css" rel="stylesheet" />
    <link media="screen" href="../js/jqgrid/css/ui.jqgrid.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="../js/jquery-1.8.1.min.js"></script>
    <script type="text/javascript" src="../js/jqgrid/js/jquery.jqGrid.min.js"></script>
    <script type="text/javascript" src="../js/jqgrid/js/i18n/grid.locale-en.js"></script>
    <script type="text/javascript" src="../lhgdialog/lhgdialog.min.js?self=true&skin=blue"></script>
    <style type="text/css">
    select{float:left;height:24px;line-height:24px;padding:1px;margin:0 0 0 3px;}
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <div id="topBar"><img src="../images/ico_home.gif" width="17" height="17"/>班级管理&nbsp;<span>>&nbsp;添加学员</span></div>
<div id="main">
<div class="bar">
	<label>学员姓名:</label><input id="name" name="name" type="text" class="textinput" style="float:left;" />
    <a href="#" class="btn_azul" style="margin-left:20px;">搜&nbsp;&nbsp;&nbsp;索</a>
<div class="hr"></div>
</div>

	<div style="width:100%;height:auto;"> 
		<table id="gridTable"></table>
	 	<div id="gridPager"></div>  
	</div>

</div>
    </form>
<script type="text/javascript">
    var api = frameElement.api; W = api.opener;
    $(document).ready(function () {
        $("#name").focus();

        jQuery("#gridTable").jqGrid({
            url: 'addStudent.ashx?id='+api.data, //地址文件
            datatype: "json",
            colNames: ['ID', '姓名', '性别', '年龄', '电话', '操作'],
            colModel: [
                { name: 'id', index: 'id', width: 30, hidden: true },
                { name: 'name', index: 'name', width: 50, align: "center" },
                { name: 'sex', index: 'sex', width: 30, align: "center" },
                { name: 'age', index: 'age', width: 30, align: "center" },
                { name: 'phone', index: 'phone', width: 80, align: "center" },
                { name: 'operate', index: 'operate', width: 100, search: false, align: "center" }
            ],
            rowNum: 15,
            rowList: [15, 30, 50],
            pager: jQuery('#gridPager'),
            sortname: 'id',
            viewrecords: true,
            rownumbers: true,
            rownumWidth: 40,
            sortorder: "asc"
        });

        $("#gridTable").setGridWidth($(window).width() - 20);
        $("#gridTable").setGridHeight($(window).height() - 156);
        $("#gbox_gridTable").css("margin", "0 auto");
    });

    $(window).bind('resize', winResize);
    function winResize() {
        $("#gridTable").setGridWidth($(window).width() - 20);
        $("#gridTable").setGridHeight($(window).height() - 156);
    }

    $(".btn_azul").click(function () {
        $("#gridTable").jqGrid("setGridParam", {
            url: "search_student.ashx",
            postData: eval("({'name':'" + $("#name").val() + "','flag':'add','id':'"+api.data+"'})") //发送数据 
        }).trigger("reloadGrid");
    });

    function addStu(id) {
        $.ajax({
            type: 'Post',
            async: false,
            url: 'addStudent.aspx/addStu',
            data: "{'user_id':'" + id + "','class_id':'" + api.data + "'}",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (msg) {
                $('#gridTable').trigger("reloadGrid");
            },
            error: function (err) {
                alert("添加成员失败,请稍后再试!");
            }
        });
    }

</script>
</body>
</html>
