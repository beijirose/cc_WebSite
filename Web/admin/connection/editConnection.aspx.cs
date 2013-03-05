using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Services;

public partial class connection_editConnection : System.Web.UI.Page
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
    public static int edit(string id,string name)
    {
       
        return 1;
    }
}