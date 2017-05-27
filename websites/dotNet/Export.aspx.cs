using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;


public partial class Export : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

        String output = string.Empty;

        string liveConnection = Constants.CONNECTION_STRING();// @"Server=.\localtest;Database=Cards;User Id=richard;Password=richard;";

        SqlConnection sqlconnection = new SqlConnection(liveConnection);
        sqlconnection.Open();

        SqlCommand sqlcommand = new SqlCommand();
        sqlcommand.Connection = sqlconnection;

        sqlcommand.CommandText = "select answer, question from [text] order by textid asc";

        SqlDataReader dr = sqlcommand.ExecuteReader();


        while (dr.Read())
        {
            output += dr[0].ToString() + "|" + dr[1].ToString() + "¬";
        }

        dr.Close();
        sqlcommand.Dispose();
        sqlconnection.Close();

        LitOutput.Text = output;
    }



}