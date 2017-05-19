using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Data;
using System.Data.SqlClient;

/// <summary>
/// Summary description for WebService
/// </summary>
[WebService(Namespace = "http://tempuri.org/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
// To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
// [System.Web.Script.Services.ScriptService]
public class WebService : System.Web.Services.WebService {

    public WebService () {

        //Uncomment the following line if using designed components 
        //InitializeComponent(); 
    }

    [WebMethod]
    public string HelloWorld()
    {
        return "Hello World";
    }

    [WebMethod]
    public string SaveText(String inputText)
    {
        String conn = Constants.CONNECTION_STRING();

        String sql = @"insert into CapturedText([text]) values ('" + inputText + "')";

        SqlCommand runRulesCmd = new SqlCommand();
        SqlConnection sqlconnection = new SqlConnection(conn);

        runRulesCmd.Connection = sqlconnection;
        runRulesCmd.CommandText = sql;

        sqlconnection.Open();

        runRulesCmd.ExecuteNonQuery();

        sqlconnection.Close();
        sqlconnection.Dispose();

        return "Saved input text: " + inputText;
    }

    [WebMethod]
    public string SaveDefaultText()
    {
        String conn = Constants.CONNECTION_STRING();

        String sql = @"insert into CapturedText([text]) values ('defaultText')";

        SqlCommand runRulesCmd = new SqlCommand();
        SqlConnection sqlconnection = new SqlConnection(conn);

        runRulesCmd.Connection = sqlconnection;
        runRulesCmd.CommandText = sql;

        sqlconnection.Open();

        runRulesCmd.ExecuteNonQuery();

        sqlconnection.Close();
        sqlconnection.Dispose();

        return "";
    }
    
}
