using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Services;

public partial class index : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (HttpContext.Current.Session["username"] == null)
        {
            Response.Redirect("../Login.aspx");
        }
        user.Text = "欢迎您！" + HttpContext.Current.Session["username"].ToString() + "(" + HttpContext.Current.Session["czry_dm"].ToString() + ")";
        zsjg.Text = HttpContext.Current.Session["swjg_jc"].ToString() ;
        jgdm.Text = "征收机关代码：" + HttpContext.Current.Session["swjg_dm"].ToString();
    }

    [WebMethod]
    public static int quit()
    {
        HttpContext.Current.Session.Clear();
        return 1;
    }
   
}