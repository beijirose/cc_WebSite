using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Services;
using System.Data;

public partial class member_detailed : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            string id = Request["param"];
            DataTable dt =null;
            name.Text = dt.Rows[0][1].ToString().Trim();
            sex.Text = dt.Rows[0][3].ToString().Trim();
            age.Text = dt.Rows[0][2].ToString().Trim();
            birthday.Text = dt.Rows[0][10].ToString().Trim();
            phone.Text=dt.Rows[0][4].ToString().Trim();
            interests.Text = dt.Rows[0][6].ToString().Trim();
            address.Text = dt.Rows[0][5].ToString().Trim();
            add_admin.Text = dt.Rows[0][9].ToString().Trim();
            add_dt.Text = dt.Rows[0][8].ToString().Trim();
            remark.InnerHtml = dt.Rows[0][7].ToString().Trim();
            member_id.Value = id.ToString().Trim();

            DataTable conn = null;// b_member_connection.getConnection();
            s_conncetion.DataSource = conn;
            s_conncetion.DataTextField = "name";
            s_conncetion.DataValueField = "id";
            s_conncetion.DataBind();
        }
    }


    [WebMethod]
    public static string setConnection(string id)
    {
        return "";
    }

    [WebMethod]
    public static string search_Connection(string name, string connection_id, string member_id)
    {
        return "";
    }

    [WebMethod]
    public static string del_member_Connecton(string id,string member_id)
    {
      
        return "";
    }
}