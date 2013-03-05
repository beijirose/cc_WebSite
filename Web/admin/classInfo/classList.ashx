<%@ WebHandler Language="C#" Class="classList" %>

using System;
using System.Web;
using System.Data;
using System.Collections.Generic;
using System.Web.Services;

public class classList : IHttpHandler {
    
    public void ProcessRequest (HttpContext context) {
        context.Response.ContentType = "text/plain";
        context.Response.Buffer = true;
        context.Response.ExpiresAbsolute = DateTime.Now.AddDays(-1);
        context.Response.AddHeader("pragma", "no-cache");
        context.Response.AddHeader("cache-control", "");
        context.Response.CacheControl = "no-cache";

        string jsonData = "";// b_class_info.get_all_class_info();
        context.Response.Write(jsonData);//返回json数据
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }

}