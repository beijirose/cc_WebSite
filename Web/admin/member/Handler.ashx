<%@ WebHandler Language="C#" Class="Handler" %>

using System;
using System.Web;

public class Handler : IHttpHandler
{

    public void ProcessRequest(HttpContext context)
    {
        context.Response.ContentType = "text/plain";
        
        context.Response.Write(BLL.getSWJG());
    }

    public bool IsReusable
    {
        get
        {
            return false;
        }
    }

}