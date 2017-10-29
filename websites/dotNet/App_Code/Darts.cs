using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.Script.Services;
using System.Web.Script.Serialization;
using System.Data;
using System.Data.SqlClient;
using System.Collections;

/// <summary>
/// Summary description for Darts
/// </summary>
[WebService(Namespace = "http://tempuri.org/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
// To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
// [System.Web.Script.Services.ScriptService]
public class Darts : System.Web.Services.WebService {

    public Darts () {

        //Uncomment the following line if using designed components 
        //InitializeComponent(); 
    }

    [WebMethod]
    public string HelloWorld() {
        return "Hello World";
    }

    [WebMethod]
    public string NewGame(Int32 target, Boolean isExactDate)
    {
        String conn = Constants.CONNECTION_STRING_DARTS();

        SqlCommand cmd = new SqlCommand();
        SqlConnection sqlconnection = new SqlConnection(conn);

        cmd.Connection = sqlconnection;
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.CommandText = "dbo.NewGame";

        cmd.Parameters.Add("target",SqlDbType.Int).Value = target;
        cmd.Parameters.Add("isExactDate", SqlDbType.Bit).Value = isExactDate;

        SqlParameter param = cmd.Parameters.Add("id", SqlDbType.Int);
        param.Direction = ParameterDirection.Output;
       
        sqlconnection.Open();
        cmd.ExecuteNonQuery();

        int result = (int) cmd.Parameters["id"].Value;

        sqlconnection.Close();
        sqlconnection.Dispose();

        return result.ToString();
    }


    [WebMethod]
    public string NewPlayer(String name)
    {
        String conn = Constants.CONNECTION_STRING_DARTS();

        SqlCommand cmd = new SqlCommand();
        SqlConnection sqlconnection = new SqlConnection(conn);

        cmd.Connection = sqlconnection;
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.CommandText = "dbo.NewPlayer";

        cmd.Parameters.Add("name", SqlDbType.NText, 50).Value = name;

        SqlParameter param = cmd.Parameters.Add("id", SqlDbType.Int);
        param.Direction = ParameterDirection.Output;

        sqlconnection.Open();
        cmd.ExecuteNonQuery();

        int result = (int)cmd.Parameters["id"].Value;

        sqlconnection.Close();
        sqlconnection.Dispose();

        return result.ToString();
    }





}
