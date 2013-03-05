using System;
using System.Data;
using System.Configuration;
using System.Web;

using System.Data.OracleClient;


/// <summary>
///DBBase 的摘要说明
/// </summary>
public class DBBase
{
    

        #region 构造函数

        /// <summary>

        /// 构造函数(默认)

        /// </summary>

        public DBBase() { }



        /// <summary>

        /// 构造函数

        /// </summary>

        /// <param name="connString">连接字符串(类型：string)</param>

        /// 例子："Data Source=ServerName;User ID=userid;Password=password;Unicode=True"

        public DBBase(string connString)
        {

            this.ConnectionString = connString;

        }



        #endregion



        #region 私有变量



        /// <summary>

        /// 表示针对数据库执行的SQL语句或存储过程

        /// </summary>

        private System.Data.OracleClient.OracleCommand cmd;



        /// <summary>

        /// 表示一个到数据库的打开的连接

        /// </summary>

        private System.Data.OracleClient.OracleConnection con;



        /// <summary>

        /// 表示要在数据库中生成的事务

        /// </summary>

        private System.Data.OracleClient.OracleTransaction tran;



        /// <summary>

        /// 表示用于填充System.Data.DataSet和更新数据库的一组数据命令和到数据库的连接。

        /// </summary>

        private System.Data.OracleClient.OracleDataAdapter adapter;



        /// <summary>

        /// 提供从数据源读取数据行的只进流的方法

        /// </summary>

        private System.Data.OracleClient.OracleDataReader reader;



        /// <summary>

        /// 表示内存中数据的一个表

        /// </summary>

        private System.Data.DataTable dt;



        /// <summary>

        /// 表示数据在内存中的缓存

        /// </summary>

        private System.Data.DataSet ds;

        /// <summary>

        /// 连接字符串

        /// </summary>

        string ConnectionString = "";



        /// <summary>

        /// 返回与打开的数据库连接

        /// </summary>

        private System.Data.OracleClient.OracleConnection openedCon
        {

            get
            {

                this.openCon(); //固定地打开数据库与之连接

                return this.con;

            }

            //connectiongString是由固定的,存放在Web.config文件的AppSetting节点下,因此无需set访问器

        }

        #endregion



        #region 私有方法

        /// <summary>

        /// 打开与数据库的连接

        /// </summary>

        private void openCon()
        {

            try
            {

                if (this.con == null)
                {

                    //使用using可以使该连接可以调用Dispose方法来释放资源

                    //using (this.con = new OracleConnection())

                    //{

                    this.con = new OracleConnection();

                    //设置数据库连接属性为web.config中的设置的值(默认)

                    //或者设置为构造函数中指定的connString的值

                    this.con.ConnectionString = this.ConnectionString;

                    this.con.Open();

                    //}

                    //System.Web.HttpContext.Current.Response.Write("数据库连接成功!"); //Test

                }

                else if (con.State != ConnectionState.Open)
                {

                    this.con.Open();

                }

            }

            catch
            {

            }

        }



        /// <summary>

        /// 获取或设置将在其中执行System.Data.OracleClient.OracleCommand的

        /// System.Data.OracleClient.OracleTransaction。

        /// 因为OracleConnection 不支持并行事务。所以在添加事务前必须要检查是否为空！

        /// </summary>

        private void checkTransaction()
        {

            if (this.tran != null)
            {

                this.cmd.Transaction = this.tran;

            }

        }



        /// <summary>

        /// 设置基本Command对象

        /// </summary>

        /// <param name="sql"></param>

        private void CreateCmd(string sql)
        {

            //方法1

            this.cmd = new OracleCommand();

            this.checkTransaction();

            this.cmd.Connection = this.openedCon;

            this.cmd.CommandText = sql;



            //方法2

            //this.checkTransaction();

            //this.cmd=new OracleCommand(sql);

            //this.cmd.Connection=this.openedCon;



            //方法3

            //this.checkTransaction();

            //this.cmd = new OracleCommand(sql, this.openedCon);



            //方法4

            //this.cmd = new OracleCommand(sql, this.openedCon, this.tran);



            //方法5(Oracle中只支持.NET2.0以上版本)

            // this.cmd = this.openedCon.CreateCommand();

            //  this.checkTransaction();

            // this.cmd.CommandText = sql;

        }



        #endregion



        #region 公共方法



        /// <summary>

        /// 开始事务

        /// </summary>

        public void BeginTransaction()
        {

            this.tran = this.openedCon.BeginTransaction();

        }

        /// <summary>

        /// 提交事务

        /// </summary>

        public void Commit()
        {

            this.tran.Commit();

        }

        /// <summary>

        /// 回滚事务

        /// </summary>

        public void RollBack()
        {

            this.tran.Rollback();

        }



        /// <summary>

        /// 关闭与数据库的连接

        /// </summary>

        public void CloseCon()
        {

            if (this.openedCon != null && this.openedCon.State == ConnectionState.Open)
            {

                this.openedCon.Close();

            }

        }



        /// <summary>

        /// 执行SQL语句

        /// </summary>

        /// <param name="sql">SQL语句</param>

        /// <returns>受影响的行数</returns>

        public int DoSelectSql(string sql)
        {

            this.CreateCmd(sql);

            return this.cmd.ExecuteNonQuery();

        }



        /// <summary>

        /// 获得OracleDataReader对象

        /// </summary>

        /// <param name="sql">SQL语句</param>

        /// <returns>OracleDataReader对象</returns>

        public System.Data.OracleClient.OracleDataReader GetReader(string sql)
        {

            this.CreateCmd(sql);

            this.reader = this.cmd.ExecuteReader();

            return this.reader;

        }



        /// <summary>

        /// 获得DataTable

        /// </summary>

        /// <param name="sql">SQL语句</param>

        /// <returns>DataTable对象</returns>

        public System.Data.DataTable GetDataTable(string sql)
        {

            this.adapter = new OracleDataAdapter();

            this.dt = new DataTable();

            this.CreateCmd(sql);

            this.adapter.SelectCommand = this.cmd;

            this.adapter.Fill(this.dt);

            return this.dt;

        }



        /// <summary>

        /// 获得DataSet(通过sql语句)

        /// </summary>

        /// <param name="sql">SQL语句</param>

        /// <returns>DataSet对象</returns>

        public System.Data.DataSet GetDataSet(string sql)
        {

            this.adapter = new OracleDataAdapter();

            this.ds = new DataSet();

            this.CreateCmd(sql);

            this.adapter.SelectCommand = this.cmd;

            this.adapter.Fill(this.ds);

            return this.ds;

        }



        /// <summary>

        /// 获得DataSet(通过sql语句、表名)

        /// </summary>

        /// <param name="sql">SQL语句</param>

        /// <param name="srcTableName">用于表映射的源表的名称</param>

        /// <returns>DataSet对象</returns>

        public System.Data.DataSet GetDataSet(string sql, string srcTableName)
        {

            if (this.ds == null)
            {

                this.ds = new DataSet();

            }

            this.adapter = new OracleDataAdapter();

            this.CreateCmd(sql);

            this.adapter.SelectCommand = this.cmd;

            this.adapter.Fill(ds, srcTableName);

            return this.ds;

        }



        /// <summary>

        /// 获得DataSet(通过sql语句、表名、已存在的DataSet)

        /// </summary>

        /// <param name="sql">SQL语句</param>

        /// <param name="srcTableName">用于表映射的源表的名称</param>

        /// <param name="DataSet">已存在的DataSet对象</param>

        /// <returns>DataSet对象</returns>

        public System.Data.DataSet GetDataSet(string sql, string srcTableName, DataSet DataSet)
        {

            this.ds = DataSet;

            return GetDataSet(sql, srcTableName);

        }





        #endregion

}
