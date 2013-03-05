<%@ WebHandler Language="C#" Class="search_student" %>

using System;
using System.Web;
using System.Data;
using System.Collections.Generic;
using System.Web.Services;

public class search_student : IHttpHandler {
    
    public void ProcessRequest (HttpContext context) {
        context.Response.ContentType = "text/plain";
        context.Response.Buffer = true;
        context.Response.ExpiresAbsolute = DateTime.Now.AddDays(-1);
        context.Response.AddHeader("pragma", "no-cache");
        context.Response.AddHeader("cache-control", "");
        context.Response.CacheControl = "no-cache";

        string name = context.Request.Params["name"].Trim();
        string flag = context.Request.Params["flag"].Trim();
        string id = context.Request.Params["id"].Trim();
        string jsonData = "";//b_class_info.get_student_info_byname(name,flag,id);
        context.Response.Write(jsonData);//返回json数据
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }

}