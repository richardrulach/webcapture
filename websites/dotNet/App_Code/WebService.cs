﻿using System;
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
    public string SaveText(String question, String answer)
    {
        String conn = Constants.CONNECTION_STRING();
        String sql = @"insert into [QAText]([QATextTypeId],[CategoryId],[question],[answer]) values (1,1,'" + question + "','" + answer + "')";

        SqlCommand runRulesCmd = new SqlCommand();
        SqlConnection sqlconnection = new SqlConnection(conn);

        runRulesCmd.Connection = sqlconnection;
        runRulesCmd.CommandText = sql;

        sqlconnection.Open();

        runRulesCmd.ExecuteNonQuery();

        sqlconnection.Close();
        sqlconnection.Dispose();

        return "Saved question: " + question + " answer: " + answer;
    }

    [WebMethod]
    public string SaveDefaultText()
    {
        String conn = Constants.CONNECTION_STRING();

        String sql = @"insert into [QAText]([QATextTypeId],[CategoryId],[question],[answer]) values (1, 1,'what is the capital of london','n/a')";

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


    [WebMethod]
    public string GetText()
    {
        String conn = Constants.CONNECTION_STRING();
        
        ArrayList al = new ArrayList();

        String sql = @"select [question] from QAText ";

        SqlCommand runRulesCmd = new SqlCommand();
        SqlConnection sqlconnection = new SqlConnection(conn);

        runRulesCmd.Connection = sqlconnection;
        runRulesCmd.CommandText = sql;

        sqlconnection.Open();
        SqlDataReader dr = runRulesCmd.ExecuteReader();

        List<String> myText = new List<String>();

        while (dr.Read())
        {
            myText.Add(dr.GetValue(0).ToString());
        }
        dr.Close();

        return new JavaScriptSerializer().Serialize(myText);
    }


}
