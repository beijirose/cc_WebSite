using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Services;

public partial class connection_connection : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
         
    }

    [WebMethod]
    public static int addConnection(string name)
    {
       
        return 1;
    }

    [WebMethod]
    public static int delConnection(int id)
    {
       
        return 1;
    }
}