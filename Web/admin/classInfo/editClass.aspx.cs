using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Services;

public partial class classInfo_editClass : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    [WebMethod]
    public static string load(string id)
    {
        return "";
    }

    [WebMethod]
    public static int updataClass(string name, string starttime, string endtime, string remark, string id)
    {
       
        return 1;
    }
}