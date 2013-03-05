using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Services;

public partial class admin_member_JCXXCXDetail : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    [WebMethod]
    public static int updataMember(string name, string age, string birthday, string sex, string phone, string address, string interests, string remark, string id)
    {

        return 1;
    }

    [WebMethod]
    public static string load(string id)
    {
        return id;
    }
}
