<%@ Page Language="C#" AutoEventWireup="true" CodeFile="editMember.aspx.cs" Inherits="member_editMember" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>查询详情</title>
    <link href="../css/rest.css" type="text/css" rel="stylesheet" />
    <link href="../css/layout.css" type="text/css" rel="stylesheet" />

    <script type="text/javascript" src="../js/jquery-1.8.1.min.js"></script>

    <script type="text/javascript" src="../js/jqgrid/js/jquery.jqGrid.min.js"></script>

    <script type="text/javascript" src="../js/jqgrid/js/i18n/grid.locale-en.js"></script>

    <script type="text/javascript" src="../lhgdialog/lhgdialog.min.js?self=true&skin=blue"></script>

    <script type="text/javascript" charset="utf-8" src="../kindeditor/kindeditor-min.js"></script>

    <script type="text/javascript" charset="utf-8" src="../kindeditor/zh_CN.js"></script>

    <script language="javascript" type="text/javascript" src="../DatePicker/WdatePicker.js"></script>

    <style type="text/css">
        select
        {
            width: 80px;
            height: 24px;
            line-height: 24px;
            padding: 1px;
            margin: 0 0 0 3px;
        }
        table
        {
            background: #FFF;
        }
        textarea
        {
            display: block;
        }
        input
        {
            width: 180px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <div id="topBar">
        <img src="../images/ico_home.gif" width="17" height="17" />查询&nbsp;<span>>&nbsp;详细查询</span></div>
    <div id="main">
        <div style="width: 100%; height: 100%;">
            <table id="gridTable">
            </table>
            <div id="gridPager">
            </div>
        </div>
    </div>
    </form>

    <script type="text/javascript">
        //  var editor;
        var api = frameElement.api; W = api.opener;
        $(document).ready(function() {
            $.ajax({
                type: 'Post',
                async: false,
                url: 'editMember.aspx/load',
                data: "{'id':'" + api.data + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function(msg) {
                jQuery("#gridTable").jqGrid({
                url: 'DetailList.ashx?id=' + api.data, //地址文件
                        datatype: "json",
                        colNames: ['ID', '加油枪编号', '加油枪序号', '所属年月', '申报日期', '油量(升)', '金额(元)', '补报月数', '申报标志'],
                        colModel: [
                { name: 'id', index: 'id', width: 30, hidden: true },
                { name: 'yqbh', index: 'yqbh', width: 100, align: "center" },
                { name: 'yqxh', index: 'yqxh', width: 100, align: "center" },
                { name: 'ny', index: 'ny', width: 100, align: "center" },
                { name: 'sbrq', index: 'sbrq', width: 100, align: "center" },
                { name: 'yl', index: 'yl', width: 100, align: "left" },
                { name: 'je', index: 'je', width: 100, align: "center" },
                { name: 'bbys', index: 'bbys', width: 100, align: "center" },
                { name: 'sbbz', index: 'sbbz', width: 100, align: "center" }
                         ],
                width: 800,
                height: 450,
                        rowNum: 15,
                        rowList: [15, 30, 50],
                        pager: jQuery('#gridPager'),
                        sortname: 'id',
                        viewrecords: true,
                        rownumbers: true,
                        rownumWidth: 40,
                        sortorder: "asc"
                    });
                },
                error: function(err) {
                    alert("加载称谓失败,请稍后再试!");
                }
            });



        });
    </script>

</body>
</html>
