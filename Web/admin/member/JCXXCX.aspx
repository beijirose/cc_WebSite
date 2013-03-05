<%@ Page Language="C#" AutoEventWireup="true" CodeFile="JCXXCX.aspx.cs" Inherits="admin_member_JCXXCX" %>


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
            <label>
                加油站名称:</label><input id="jyzmc" name="jyzmc" type="text" class="textinput" style="float: left;" />
            <label>
                纳税识别号:</label><input id="nssbh" name="nssbh" type="text" class="textinput" style="float: left;" />
            <label>
                地址:</label><input id="dz" name="dz" type="text" class="textinput" style="float: left;" />
            <label>
                范围选择:</label><select id="nsqk">
                    <option value="null">--请选择--</option>
                    <option value="0">一致数据</option>
                    <option value="1">不一致数据</option>
                </select>
            <div class="hr">
            </div>
        </div>
        <div class="bar">
            <table width="100%" class="table" border="0" cellpadding="0" cellspacing="0" style="margin: 10px auto;">
                <tr>
                    <td>
                        
                        <label>
                            管辖税务机关:</label>
                        <select id="swjg">
                          
                        </select>
                    </td>
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
                </tr>
                <tr>
                    <td colspan="5">
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
            url: 'JCXXCXList.ashx', //地址文件
                datatype: "json",
                colNames: ['ID', '管辖税务机关', '加油站编号', '加油站名称', '纳税识别号', '地址', '法人姓名', '纳税人类型', '电话', '登记时间', '纳税情况', '初始化情况', '总枪数', '操作'],
                colModel: [
                { name: 'id', index: 'id', width: 10, hidden: true },
                { name: 'ksmc', index: 'ksmc', autowidth: true, align: "center" },
                { name: 'yzbh', index: 'yzbh', autowidth: true, align: "center" },
                { name: 'yzmc', index: 'yzmc', autowidth: true, align: "center" },
                { name: 'nsrdjh', index: 'nsrdjh', autowidth: true, align: "center" },
                { name: 'yzdz', index: 'yzdz', autowidth: true, align: "center" },
                { name: 'jsjbm', index: 'jsjbm', autowidth: true, align: "center" },
                { name: 'nsrlb', index: 'nsrlb', autowidth: true, align: "center" },
                { name: 'dh', index: 'dh', autowidth: true, align: "center" },
                { name: 'djsj', index: 'djsj', autowidth: true, align: "center" },
                 { name: 'nsqk', index: 'nsqk', autowidth: true, align: "center" },
                  { name: 'cshqk', index: 'cshqk', autowidth: true, align: "center" },
                    { name: 'sum', index: 'sum', autowidth: true, align: "center" },
                { name: 'operate', index: 'operate', autowidth: true, search: false, align: "center" }
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

            $("#gridTable").setGridWidth($(window).width() );
            $("#gridTable").setGridHeight($(window).height() - 156);
            $("#gbox_gridTable").css("margin", "0 auto");
        });

        $(window).bind('resize', winResize);
        function winResize() {
            $("#gridTable").setGridWidth($(window).width() );
            $("#gridTable").setGridHeight($(window).height() - 156);
        }

        $(".btn_azul").click(function() {
            $("#gridTable").jqGrid("setGridParam", {
            url: "JCXXCXList.ashx",
                postData: eval("({'jyzmc':'" + $("#jyzmc").val() + "','nssbh':'" + $("#nssbh").val() + "','dz':'" + $("#dz").val() + "'})") //发送数据
            }).trigger("reloadGrid");

        });

        function del(id) {
            var YN = confirm("你确定要删除该关系成员吗？");
            if (YN == true) {
                $.ajax({
                    type: 'Post',
                    async: false,
                    url: 'memberList.aspx/delMember',
                    data: "{'id':'" + id + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function(msg) {
                        $('#gridTable').trigger("reloadGrid");
                    },
                    error: function(err) {
                        alert("删除会员失败,请稍后再试!");
                    }
                });
            }
        }

        var api;
        function edit(id) {
            api = $.dialog({
                title: '详细查询',
                id: "JCXXCXDetail",
                content: 'url:JCXXCXDetail.aspx',
                data: id,
                width: 800,
                height: 480,
                max: false,
                min: false
            });
        }

        function editCloes() {
            api.close();
            $('#gridTable').trigger("reloadGrid");
        }

    </script>

</body>
</html>
