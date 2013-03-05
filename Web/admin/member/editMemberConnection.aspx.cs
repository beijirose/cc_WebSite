using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Services;
using System.Data;

public partial class member_editMemberConnection : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            DataTable dt = null;
            conncetion.DataSource = dt;
            conncetion.DataTextField = "name";
            conncetion.DataValueField = "id";
            conncetion.DataBind();
        }
    }

    [WebMethod]
    public static string load(string id)
    {
        return "";
    }

    [WebMethod]
    public static int updataMC(string id, string name, string connection,string phone,string address,string remark)
    {
       
        return 1;
    }
}