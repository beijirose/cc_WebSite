<%@ Page Language="C#" AutoEventWireup="true" CodeFile="connection.aspx.cs" Inherits="connection_connection" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>信息比对</title>
    <link href="../css/rest.css" type="text/css" rel="stylesheet" />
    <link href="../css/layout.css" type="text/css" rel="stylesheet" />
    <link media="screen" href="../js/jqgrid/css/ui.jqgrid.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="../js/jquery-1.8.1.min.js"></script>
    <script type="text/javascript" src="../js/jqgrid/js/jquery.jqGrid.min.js"></script>
    <script type="text/javascript" src="../js/jqgrid/js/i18n/grid.locale-en.js"></script>
    <script type="text/javascript" src="../lhgdialog/lhgdialog.min.js?self=true&skin=blue"></script>
</head>
<body>
    <form id="form1" runat="server">
    <div id="topBar"><img src="../images/ico_home.gif" width="17" height="17"/>信息比对&nbsp;<span>>&nbsp;信息比对</span></div>
<div id="main">
<div class="bar">
	<label>名&nbsp;&nbsp;&nbsp;称:</label><input id="name" name="name" type="text" class="textinput" style="float:left;" />
    <a href="#" class="btn_azul" style="margin-left:20px;">查&nbsp;&nbsp;&nbsp;询</a>
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
            url: 'connection.ashx', //地址文件
            datatype: "json",
            colNames: ['操作员代码', '操&nbsp;&nbsp;&nbsp;作', '操作时间','操作'], 
            colModel: [
               { name: 'CZYDM', index: 'CZYDM', width: 30 },
                { name: 'CZ', index: 'CZ', width: 30 },
                { name: 'CZSJ', index: 'CZSJ', width: 30, align: "center" },
                { name: 'operate', index: 'operate', width: 30, search: false, align: "center" }
            ],
            rowNum: 15,
            rowList: [15,30,50],
            pager: jQuery('#gridPager'),
            sortname: 'id',
            viewrecords: true,
            rownumbers: true,
            rownumWidth: 40,
            sortorder: "asc", 

            gridComplete:function(){
             },
        });
        $("#gridTable").navGrid("#pager", { edit: false, add: false, del: false ,search:false});

	$("#gridTable").setGridWidth($(window).width()-20);
	$("#gridTable").setGridHeight($(window).height()-156);
	$("#gbox_gridTable").css("margin","0 auto");
});

$(".btn_azul").click(function(){
   if($('#name').val()!=""){
        $.ajax({
            type: 'Post',
            async: false,
            url: 'connection.aspx/addConnection',
            data: "{'name':'" + $('#name').val() + "'}",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (msg) {
                    $('#gridTable').trigger("reloadGrid");
                    $('#name').val("");
                 },
                 error: function (err) {
                       alert("新增关系失败,请稍后再试!");
                  }
         });
     }
     else{
         alert("请输入称谓名称!");
     }
});

$(window).bind('resize', winResize);
function winResize() {
	$("#gridTable").setGridWidth($(window).width()-20);
	$("#gridTable").setGridHeight($(window).height()-156);
}

function del(id){
   $.ajax({
     type: 'Post',
     async: false,
     url: 'connection.aspx/delConnection',
     data: "{'id':'" + id + "'}",
     contentType: "application/json; charset=utf-8",
     dataType: "json",
     success: function (msg) {
          $('#gridTable').trigger("reloadGrid");
     },
     error: function (err) {
          alert("删除关系失败,请稍后再试!");
     }
   });
}

var api;
function edit(id){
      api=$.dialog({
      title: '修改',
      id:"editConn",
      content: 'url:editConnection.aspx',
      data:id,
      max: false,
      min: false
   });
}

function editCloes(){
     api.close();
     $('#gridTable').trigger("reloadGrid");
}

</script>
</body>
</html>
