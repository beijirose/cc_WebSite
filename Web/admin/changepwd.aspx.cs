using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Services;
using System.Web.Security;

public partial class changepwd : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    [WebMethod]
    public static string cpwd(string oldpwd, string newpwd)
    {
      
        return BLL.change_pwd(oldpwd, newpwd);
    }
}