<%@ WebHandler Language="C#" Class="connection" %>

using System;
using System.Web;
using System.Data;
using System.Collections.Generic;
using System.Web.Services;

[WebService(Namespace = "http://tempuri.org/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
public class connection : IHttpHandler {
    public void ProcessRequest (HttpContext context) {
        context.Response.ContentType = "text/plain";
        context.Response.Buffer = true;
        context.Response.ExpiresAbsolute = DateTime.Now.AddDays(-1);
        context.Response.AddHeader("pragma", "no-cache");
        context.Response.AddHeader("cache-control", "");
        context.Response.CacheControl = "no-cache";
        string sPage = HttpContext.Current.Request.Params["page"].ToString();  //当前请求第几页  
        string sLimit = HttpContext.Current.Request.Params["rows"].ToString(); //grid需要显示几行   
        string jsonData = BLL.getData(sPage, sLimit);
        context.Response.Write(jsonData);//返回json数据
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }

}