﻿<%@ WebHandler Language="C#" Class="search_class" %>

using System;
using System.Web;
using System.Data;
using System.Collections.Generic;
using System.Web.Services;

public class search_class : IHttpHandler {
    
    public void ProcessRequest (HttpContext context) {
        context.Response.ContentType = "text/plain";
        context.Response.Buffer = true;
        context.Response.ExpiresAbsolute = DateTime.Now.AddDays(-1);
        context.Response.AddHeader("pragma", "no-cache");
        context.Response.AddHeader("cache-control", "");
        context.Response.CacheControl = "no-cache";

        string name = context.Request.Params["name"];
        string addAdmin = context.Request.Params["addAdmin"];
        string flag = context.Request.Params["flag"];
        string jsonData = "";// b_class_info.search_class_info(name, addAdmin, flag);
        context.Response.Write(jsonData);//返回json数据
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }

}