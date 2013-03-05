<%@ WebHandler Language="C#" Class="Statistics" %>

using System;
using System.Web;
using System.Data;
using System.Collections.Generic;
using System.Web.Services;

public class Statistics : IHttpHandler
{
    
    public void ProcessRequest (HttpContext context) {
        context.Response.ContentType = "text/plain";
        context.Response.Buffer = true;
        context.Response.ExpiresAbsolute = DateTime.Now.AddDays(-1);
        context.Response.AddHeader("pragma", "no-cache");
        context.Response.AddHeader("cache-control", "");
        context.Response.CacheControl = "no-cache";

        string sPage = HttpContext.Current.Request.Params["page"].ToString();  //当前请求第几页  
        string sLimit = HttpContext.Current.Request.Params["rows"].ToString(); //grid需要显示几行   

        string swjg = context.Request.Params["swjg"];
        string bsqk = context.Request.Params["bsqk"];
        string starttime = context.Request.Params["starttime"];
        string endtime = context.Request.Params["endtime"];
        string jsonData = BLL.getStatistic(swjg, bsqk, starttime, endtime, sPage, sLimit);
        context.Response.Write(jsonData);//返回json数据
       
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }

}