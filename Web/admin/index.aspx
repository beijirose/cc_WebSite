<%@ Page Language="C#" AutoEventWireup="true" CodeFile="index.aspx.cs" Inherits="index" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>加油站信息管理系统</title>
    <link href="css/rest.css" type="text/css" rel="stylesheet" />
    <link href="css/layout.css" type="text/css" rel="stylesheet" />
    <script type="text/javascript" src="js/jquery-1.8.1.min.js"></script>
    <script type="text/javascript" src="lhgdialog/lhgdialog.min.js?self=true&skin=blue"></script>
    <style type="text/css">
    body{background:#FFF;
    SCROLLBAR-FACE-COLOR: #9CC5D7;
    SCROLLBAR-HIGHLIGHT-COLOR: #ffffff; 
    SCROLLBAR-SHADOW-COLOR: #006699; 
    SCROLLBAR-3DLIGHT-COLOR: #006699; 
    SCROLLBAR-ARROW-COLOR: #330000; 
    SCROLLBAR-TRACK-COLOR: #E2F3F1; 
    SCROLLBAR-DARKSHADOW-COLOR: #ffffff;
    margin-left: 0px;
    margin-top: 0px;
    margin-right: 0px;
    margin-bottom: 0px;
    }
    html{overflow:auto;}
    html 
        {     
            margin:0; 
            overflow:hidden; 
            _padding:61px 0 0 0;/*IE6下通过设置上下的填充来给上下固定部分腾出空间*/ 
            _border:0;       
        }     
         body  
        { 
            margin:0;            
            height:100%; 
            border:0;                 
        }    
        #content  
        {    
            margin:0; 
            width:100%; 
            position:fixed;/*FF IE7 SF*/  
            top:61px; 
            bottom:0px;               
            overflow: auto !important; 
            _position: relative;/**IE6***/         
            _top:0px;         
            _OVERFLOW-Y: auto;  
            _OVERFLOW-X: auto;  
            SCROLLBAR-FACE-COLOR: #EEEEEE;
            SCROLLBAR-HIGHLIGHT-COLOR: #ffffff;  
            SCROLLBAR-SHADOW-COLOR: #919192;         
            SCROLLBAR-3DLIGHT-COLOR:#ffffff; 
            SCROLLBAR-ARROW-COLOR: #919192;  
            SCROLLBAR-TRACK-COLOR: #ffffff;  
            SCROLLBAR-DARKSHADOW-COLOR: #ffffff;         
            _height:100%;               
        }    
        #header { 
            position:absolute;/*公共*/ 
		    color:#FFF;
		    text-indent:30px;
		    line-height:60px;
		    font-size:30px;
		    font-weight:bold;
            top:0; 
            left:0; 
            width:100%; 
            height:60px;    
		    background:#016a99; 
            border-bottom:solid 1px #DDDDDC;         
            overflow:auto !important;/*FF*/ 
            _OVERFLOW-Y: auto;/*IE6*/  
            _OVERFLOW-X: auto;     
        } 
        #header img{float:right;width:144px;height:49px;margin:8px 80px 0 0;_display:inline;}
    </style>
    <script type="text/javascript">
            $(document).ready(function () {
                $(".left").height($("#content").height());
                $(".right").height($("#content").height());
            });

            $(window).bind('resize', winResize);
            function winResize() {
                $(".left").height($("#content").height());
                $(".right").height($("#content").height());
            }

            function show(name) {
                this.name = name;
                var currentDisplay = document.getElementById(this.name).style.display;
                document.getElementById(this.name).style.display = currentDisplay == "block" ? "none" : "block";
            }

            function doQuit() {
                $.ajax({
                    type: 'Post',
                    async: false,
                    url: 'index.aspx/quit',
                    data: "",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (msg) {
                        window.location.href = '../Login.aspx';
                    }
                });
            }

            var api;
            function changePwd() {
                api = $.dialog({
                      title: '修改密码',
                      id: "editpwd",
                      content: 'url:changepwd.aspx',
                      width: 400,
                      height: 200,
                      max: false,
                      min: false
                  });
              }

              function closeWin() {
                  api.close();
              }
    </script>
</head>
<body>
<div id="header">加油站信息管理系统</div>
<div id="content"> 
      <div class="left">
         <p class="dt">○ 控制面板</p>
         <div style="display:block;">
             <a href="#"><asp:Label ID="user" runat="server" Text=""></asp:Label></a>
             <a href="#"><asp:Label ID="zsjg" runat="server" Text=""></asp:Label></a>
              <a href="#"><asp:Label ID="jgdm" runat="server" Text=""></asp:Label></a>
             <a href="#" onclick="doQuit();">>> 安全退出 >> </a>
             <a href="#" onclick="changePwd();">>> 修改密码 >> </a>
             
         </div>
         
         <p class="dt" onclick="show('child1')">+ 信息比对</p>
         <div id="child1" style="display:block;">
             <a href="connection/connection.aspx"  target="frame_a">- 信息比对 </a>
         </div>
         <p class="dt" onclick="show('child2')">+ 信息查询</p>
         <div id="child2" style="display:block;">
             <a href="member/memberList.aspx" target="frame_a">- 基本信息查询</a>
             <a href="member/JCXXCX.aspx" target="frame_a">- 稽查信息查询</a>
             <a href="member/Statistics.aspx" target="frame_a">- 汇总统计查询</a>
         </div>
          <p class="dt" onclick="show('child3')">+ 信息管理</p>
         <div id="child3" style="display:block;">
             <a href="connection/connection.aspx" target="frame_a">- 信息管理</a>
             <a href="connection/connection.aspx" target="frame_a">- 信息管理</a>
         </div> 
   </div>
   <div class="right">
      <iframe width="100%" height="100%" name="frame_a" id="frame_a" frameborder="0" scrolling="auto" src="welcome.html"></iframe>
   </div>
</div> 
</body>
</html>
