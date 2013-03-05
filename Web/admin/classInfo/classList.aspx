<%@ Page Language="C#" AutoEventWireup="true" CodeFile="classList.aspx.cs" Inherits="classInfo_classList" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>班级管理</title>
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
    <div id="topBar"><img src="../images/ico_home.gif" width="17" height="17"/>班级管理&nbsp;<span>>&nbsp;班级管理</span></div>
<div id="main">
<div class="bar">
	<label>班级名称:</label><input id="name" name="name" type="text" class="textinput" style="float:left;" />
    <label>录入人:</label><input id="addAdmin" name="addAdmin" type="text" class="textinput" style="float:left;" />
    <label>当前状态</label>
    <select id="flag">
       <option value ="null">--请选择--</option>
       <option value ="未开始">未开始</option>
       <option value ="进行中">进行中</option>
       <option value ="已结束">已结束</option>
    </select>
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
    $(document).ready(function () {
        $("#name").focus();

        jQuery("#gridTable").jqGrid({
            url: 'classList.ashx', //地址文件
            datatype: "json",
            colNames: ['ID', '班级名称', '开始日期','结束日期','创建日期','录入人','是否结束','操作'], 
            colModel: [
                { name: 'id', index: 'id', width: 30, hidden:true },
                { name: 'name', index: 'name',width: 100, align: "left" },
                { name: 'starttime', index: 'starttime',width: 50, align: "center" },
                { name: 'endtime', index: 'endtime', width: 50, align: "center" },
                { name: 'add_dt', index: 'add_dt', width: 80, align: "center" },
                { name: 'add_admin', index: 'add_admin',width: 40, align: "center" },
                { name: 'flag', index: 'flag',width: 50, align: "center" },
                { name: 'operate', index: 'operate', width: 120, search: false, align: "center" }
            ],
            rowNum: 15,
            rowList: [15,30,50],
            pager: jQuery('#gridPager'),
            sortname: 'id',
            viewrecords: true,
            rownumbers: true,
            rownumWidth: 40,
            sortorder: "asc"
        });
	
	$("#gridTable").setGridWidth($(window).width()-20);
	$("#gridTable").setGridHeight($(window).height()-156);
	$("#gbox_gridTable").css("margin","0 auto");
});

$(window).bind('resize', winResize);
function winResize() {
    $("#gridTable").setGridWidth($(window).width() - 20);
    $("#gridTable").setGridHeight($(window).height() - 156);
}

function del(id) {
    var YN = confirm("你确定要删除该班级信息吗？");
    if (YN == true) {
        $.ajax({
            type: 'Post',
            async: false,
            url: 'classList.aspx/del_class',
            data: "{'id':'" + id + "'}",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (msg) {
                $('#gridTable').trigger("reloadGrid");
            },
            error: function (err) {
                alert("删除班级失败,请稍后再试!");
            }
        });
    }
}

var api;
function edit(id) {
    api = $.dialog({
        title: '会员信息修改',
        id: "editClass",
        content: 'url:editClass.aspx',
        data: id,
        width: 800,
        height: 340,
        max: false,
        min: false
    });
}

function addStu(id) {
    api = $.dialog({
        title: '添加学员',
        id: "addStudent",
        content: 'url:addStudent.aspx',
        data: id,
        width: 800,
        height: 540,
        max: false,
        min: false
    });
}

function delStu(id) {
    api = $.dialog({
        title: '删除学员',
        id: "delStudent",
        content: 'url:delStudent.aspx',
        data: id,
        width: 800,
        height: 540,
        max: false,
        min: false
    });
}

function look(id) {
    api = $.dialog({
        title: '查看学员名单',
        id: "lookStudent",
        content: 'url:lookUser.aspx',
        data: id,
        width: 800,
        height: 540,
        max: false,
        min: false
    });
}

function editCloes() {
    api.close();
    $('#gridTable').trigger("reloadGrid");
}

$(".btn_azul").click(function () {
    $("#gridTable").jqGrid("setGridParam", {
        url: "search_class.ashx",
        postData: eval("({'name':'" + $("#name").val() + "','addAdmin':'" + $("#addAdmin").val() + "','flag':'" + $("#flag").val() + "'})") //发送数据 
    }).trigger("reloadGrid");
});
    </script>
</body>
</html>
