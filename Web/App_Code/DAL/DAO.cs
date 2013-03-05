using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;

/// <summary>
///DAO 的摘要说明
/// </summary>
public class DAO
{
    //private static DBBase db = new DBBase("Data Source = CGS; User Id = cc; Password = cc;Persist Security Info=True;");
    //private static DBBase db = new DBBase("Data Source = ORCL; User Id = skjyj; Password = skjyj;Persist Security Info=True;");
    private static DBBase db = new DBBase(System.Configuration.ConfigurationManager.AppSettings["databasepash"]);
    public DAO()
    {
        //
        //TODO: 在此处添加构造函数逻辑
        //
    }

    public static DataTable getDateTable(string sql)
    {
        DataTable table = db.GetDataTable(sql);
        return table;
    }

    public static int ExecuteCommand(string sql)
    {
        int i = 0;
        try
        {
            db.BeginTransaction();
            i = db.DoSelectSql(sql);
            db.Commit();
           
        }
        catch(Exception e)
        {
        }
        finally
        {
            db.CloseCon();
        }
        return i;
    }
}
