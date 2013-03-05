using System;
using System.Collections.Generic;
using System.Web;
using System.Text;
using System.Data;

/// <summary>
///JsonHandle 的摘要说明
/// </summary>
public class JsonHandle
{
    public static string GetJson(DataTable dt, String page, String rows)
    {
        int totalRecord = dt.Rows.Count; // 总记录数(应根据数据库取得，在此只是模拟)   
        int totalPage = totalRecord % int.Parse(rows) == 0 ? totalRecord
                / int.Parse(rows) : totalRecord / int.Parse(rows)
                + 1; // 计算总页数   

        int index = (int.Parse(page) - 1) * int.Parse(rows); // 开始记录数   
        int pageSize = int.Parse(rows);
        // 以下模拟构造JSON数据对象   
        StringBuilder jsonBuilder = new StringBuilder();
        jsonBuilder.Append("{\"page\":" + page + ",\"total\":" + totalPage + ",\"records\":" + totalRecord + ",\"rows\"");
        jsonBuilder.Append(":[");         
        for (int i = index; i < pageSize + index && i < totalRecord; i++)
        {
            jsonBuilder.Append("{\"id\":" + i + ",\"cell\":[");
            for (int j = 0; j < dt.Columns.Count; j++)
            {
                jsonBuilder.Append("\"" + dt.Rows[i][j].ToString().Trim() + "\",");
            }
            jsonBuilder.Remove(jsonBuilder.Length - 1, 1);
            jsonBuilder.Append("]},");
        }
        jsonBuilder.Remove(jsonBuilder.Length - 1, 1);
        jsonBuilder.Append("]");
        jsonBuilder.Append("}");
        return jsonBuilder.ToString();
    }
}
