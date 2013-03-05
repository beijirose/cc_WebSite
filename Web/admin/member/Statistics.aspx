<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Statistics.aspx.cs" Inherits="admin_member_Statistics" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
    <link href="../css/rest.css" type="text/css" rel="stylesheet" />
    <link href="../css/layout.css" type="text/css" rel="stylesheet" />
    <link media="screen" href="../js/jqgrid/css/ui.jqgrid.css" rel="stylesheet" type="text/css" />

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
            float: left;
            height: 24px;
            line-height: 24px;
            padding: 1px;
            margin: 0 0 0 3px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <div id="topBar">
        <img src="../images/ico_home.gif" width="17" height="17" />信息查询&nbsp;<span>>&nbsp;加油站基本信息查询</span></div>
    <div id="main">
        <div class="bar">
            <table width="100%" class="table" border="0" cellpadding="0" cellspacing="0" style="margin: 10px auto;">
                <tr>
                    <td  colspan="2">
                        <label>
                            管辖税务机关:</label>
                        <select id="swjg">
                           
                        </select>
                         </td>
                    <td colspan="2">
                        
                        <label>
                            报税情况:</label><select id="bsqk">
                                <option value="null">--请选择--</option>
                                <option value="0">已申报</option>
                                <option value="1">未申报</option>
                            </select>
                    </td>
                    
                </tr>
                <td>
                        <label>
                            查询时间段:</label>
                    </td>
                    <td>
                        <asp:TextBox ID="starttime" runat="server" CssClass="Wdate" onFocus="WdatePicker({maxDate:'#F{$dp.$D(\'endtime\')}',minDate:'%y-%M-%d'})"></asp:TextBox>
                    </td>
                    <td>
                        <label>
                            至</label>
                    </td>
                    <td>
                        <asp:TextBox ID="endtime" runat="server" CssClass="Wdate" onFocus="WdatePicker({minDate:'#F{$dp.$D(\'starttime\')||\'%y-%M-%d\'}',maxDate:'2020-10-01'})"></asp:TextBox>
                    </td>
                <tr>
                </tr>
                <tr>
                    <td colspan="4">
                        <a href="#" class="btn_azul" style="margin-left: 20px;">查&nbsp;&nbsp;&nbsp;询</a>
                    </td>
                </tr>
            </table>
            <div class="hr">
            </div>
        </div>
        <div style="width: 100%; height: auto;">
            <table id="gridTable">
            </table>
            <div id="gridPager">
            </div>
        </div>
    </div>
    </form>

    <script type="text/javascript">
        $(document).ready(function() {
        $.ajax({ type: "GET", url: "Handler.ashx",

            cache: true,
            success: function(returnvalue) {
                $("#swjg").append(returnvalue);
            }
        });
            jQuery("#gridTable").jqGrid({
              
                datatype: "json",
                colNames: [ '管辖税务机关', '加油站编号', '加油站名称', '总油量(升)', '总金额(元)'],
                colModel: [
                { name: 'ksmc', index: 'ksmc', autowidth: true, align: "center" },
                { name: 'yzbh', index: 'yzbh', autowidth: true, align: "center" },
                { name: 'yzmc', index: 'yzmc', autowidth: true, align: "center" },
                { name: 'yl', index: 'yl', autowidth: true, align: "center" },
                { name: 'je', index: 'je', autowidth: true, align: "center" }

            ],
                autowidth: true,
                rowNum: 15,
                rowList: [15, 30, 50],
                pager: jQuery('#gridPager'),
                sortname: 'id',
                viewrecords: true,
                rownumbers: true,
                rownumWidth: 40,
                sortorder: "asc"
            });

            $("#gridTable").setGridWidth($(window).width());
            $("#gridTable").setGridHeight($(window).height() - 156);
            $("#gbox_gridTable").css("margin", "0 auto");
        });

        $(window).bind('resize', winResize);
        function winResize() {
            $("#gridTable").setGridWidth($(window).width());
            $("#gridTable").setGridHeight($(window).height() - 156);
        }

        $(".btn_azul").click(function() {
            $("#gridTable").jqGrid("setGridParam", {
            url: "Statistics.ashx",
                postData: eval("({'swjg':'" + $("#swjg").val() + "','bsqk':'" + $("#bsqk").val() + "','starttime':'" + $("#starttime").val() + "','endtime':'" + $("#endtime").val() + "'})") //发送数据
            }).trigger("reloadGrid");

        });

       
    </script>

</body>
</html>
