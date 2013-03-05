using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Services;
using System.Data;

public partial class member_addMemberConnection : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            DataTable dt =null;// b_member_connection.getConnection();
            conncetion.DataSource = dt;
            conncetion.DataTextField = "name";
            conncetion.DataValueField = "id";
            conncetion.DataBind();
        }
    }

    [WebMethod]
    public static int addMemberConnection(string name,string conncetion,string phone,string address,string remark,string member_id)
    {
       
        return 
            1;
    }
}