using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;

/// <summary>
///BLL 的摘要说明
/// </summary>
public class BLL
{
	public BLL()
	{
	}

    public static string getSWJG()
    {
        String sql = "select distinct t.swjg_jc mc from dm_swjg t";
        DataTable dt = DAO.getDateTable(sql);
        string returnvalue = "<option value=\"\">请选择</option>";
        for (int i = 0; i < dt.Rows.Count; i++)
        {
            returnvalue += "<option value=\"" + dt.Rows[i][0].ToString() + "\">" + dt.Rows[i][0].ToString() + "</option>";
        }
        return returnvalue;
    }

    public static string getStatistic(String swjg, String bsqk, String starttime, String endtime, String page, String limit)
    {
        String sql = "select m.ksmc,z.yzbh,z.yzmc,sum(q.cshxsy) yl,sum(q.cshxsje) je from yz z inner join yq q on z.yzbh=q.yzbh inner join ksdm m on z.ksbh=m.ksbh group by m.ksmc,z.yzbh,z.yzmc";
        DataTable dt = DAO.getDateTable(sql);


        string json = JsonHandle.GetJson(dt, page, limit);
        return json;
    }

    public static string getJCDetail(String id, String page, String limit)
    {
        String sql = "select c.rowid id ,q.yqbh,q.yqxh,c.jcrq,c.jczys,c.ny,c.yl,c.je,CASE c.yzbz when 0 then '一致' when 1 then '不一致' end as yzbz from jc c inner join yq q on c.yqbh=q.yqbh where q.yzbh='" + id + "'";
        DataTable dt = DAO.getDateTable(sql);


        string json = JsonHandle.GetJson(dt, page, limit);
        return json;
    }
    /// <summary>
    /// 基本查询里的详细
    /// </summary>
    /// <param name="id"></param>
    /// <param name="page"></param>
    /// <param name="limit"></param>
    /// <returns></returns>
    public static string getDetail(String id, String page, String limit)
    {
        String sql = "select b.rowid id, a.yqbh,a.yqxh,b.ny,b.sbrq,b.yl,b.je,b.bbys,case b.sbbz when 0 then '正常申报' when 1 then '未申报' end as sbbz from yq a inner join sb b on a.yqbh=b.yqbh where a.yzbh='" + id + "'";
         DataTable dt = DAO.getDateTable(sql);

     
        string json = JsonHandle.GetJson(dt, page, limit);
        return json;
         
    }
    /// <summary>
    /// 基本查询
    /// </summary>
    /// <param name="jyzmc"></param>
    /// <param name="nssbh"></param>
    /// <param name="dz"></param>
    /// <param name="jyzbh"></param>
    /// <param name="page"></param>
    /// <param name="limit"></param>
    /// <returns></returns>
    public static string getData(String jyzmc, String nssbh, String dz, String jyzbh, String page, String limit)
    {
        String sql = "select z.rowid id,m.ksmc,z.yzbh,z.yzmc,z.nsrdjh,z.yzdz,z.jsjbm,CASE z.nsrlb when 1 THEN '一般纳税人' when 2 THEN '小规模纳税人' end as nsrlb,z.dh,z.djsj,CASE z.nsqk  when 0 THEN '正常'  when 2 THEN '欠税'  end as nsqk ,CASE z.cshqk when 0 THEN '已初始化'when 1 THEN '未初始化' when 2 THEN '有枪未初始化' end as cshqk,count(*) sum from yz z inner join ksdm m on z.ksbh=m.ksbh  inner join yq q on q.yzbh=z.yzbh where 1=1";
        if (jyzmc != "" && jyzmc != null)
        {
            sql += " and z.yzmc like '%" + jyzmc + "%'";
        }
        if (nssbh != "" && nssbh != null)
        {
            sql += " and z.nsrdjh like '%" + nssbh + "%'";
        }
        if (dz != "" && dz != null)
        {
            sql += " and z.yzdz like '%" + dz + "%'";
        }
        if (jyzbh != "" && jyzbh != null)
        {
            sql += " and z.yzdz = '" + dz + "'";
        }
        sql += " group by z.rowid,  m.ksmc,z.yzbh,z.yzmc,z.nsrdjh,z.yzdz,z.jsjbm,z.nsrlb,z.dh,z.djsj,z.nsqk,z.cshqk";
        DataTable dt = DAO.getDateTable(sql);

        dt.Columns.Add("operate", typeof(string));
        for (int i = 0; i < dt.Rows.Count; i++)
        {
            dt.Rows[i]["operate"] = "<a href='#' onclick='edit(" + dt.Rows[i]["yzbh"] + ")'>详&nbsp;细</a>";
        }
        string json = JsonHandle.GetJson(dt, page, limit);
        return json;
    }

    public static string getData(String page,String limit)
    {
        DataTable dt = DAO.getDateTable("select * from czsj t ");
        dt.Columns.Add("operate", typeof(string));
        for (int i = 0; i < dt.Rows.Count; i++)
        {
            dt.Rows[i]["operate"] = "<a href='#' onclick='edit(" + dt.Rows[i]["CZYDM"] + ")'>编&nbsp;辑</a><a href='#' onclick='del(" + dt.Rows[i]["CZYDM"] + ")' style='margin-left:20px;'>删&nbsp;除</a>";
        }

        string json = JsonHandle.GetJson(dt, page, limit);
        return json;
    }

    /// <summary>
    /// 用户登录
    /// </summary>
    /// <param name="lg"></param>
    /// 查询用户，不存在返回0，存在且密码相符返回1
    /// <returns></returns>
    public static string loginYN(String username,String pass)
    {
        string sql = "select a.czry_dm,a.czry_mc,b.swjg_dm,b.swjg_jc,a.czry_mm from dm_czry a inner join dm_swjg b on a.swjg_dm=b.swjg_dm where a.czry_dm= '" + username + "'";
        DataTable table = DAO.getDateTable(sql);
        if (table.Rows.Count == 0)
        {
            return "0";
        }
        else if (pass != Convert.ToString(table.Rows[0][4]).Trim())
        {
            return "0";
        }
        else
        {
            HttpContext.Current.Session["username"] = Convert.ToString(table.Rows[0][1]).Trim();//获取用户登录帐号
            HttpContext.Current.Session["password"] = Convert.ToString(table.Rows[0][4]).Trim();//获取用户姓名
            HttpContext.Current.Session["czry_dm"] = Convert.ToString(table.Rows[0][0]).Trim();//获取用户登录帐号
            HttpContext.Current.Session["swjg_dm"] = Convert.ToString(table.Rows[0][2]).Trim();//获取用户姓名
            HttpContext.Current.Session["swjg_jc"] = Convert.ToString(table.Rows[0][3]).Trim();//获取用户姓名
            return "1";
        }
    }

    public static string change_pwd(string pwd, string newPwd)
    {
        string sql = "select czry_mc,czry_mm from dm_czry where czry_mc = '" + HttpContext.Current.Session["username"].ToString() + "'";
        DataTable table = DAO.getDateTable(sql);
        if (pwd.Trim() != Convert.ToString(table.Rows[0][1]).Trim())
        {
            return "0";
        }
        else
        {
            sql = string.Format("update dm_czry set czry_mm='{0}' where czry_mc='{1}'", newPwd.Trim(), table.Rows[0][0].ToString());
            int request = DAO.ExecuteCommand(sql);
            if (request == 0) return "0";
            return "1";
        }
    }
}
