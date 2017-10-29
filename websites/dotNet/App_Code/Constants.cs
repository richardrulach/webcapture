using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for Constants
/// </summary>
public class Constants
{
	public Constants()
	{
		//
		// TODO: Add constructor logic here
		//
    }

    public static String CONNECTION_STRING()
    {
        if (Environment.MachineName == "7PG5CC2")
        {
            return @"Server=.\localtest;Database=Cards;User Id=richard;Password=richard;";
        }
        else
        {
            return @"Server=.;Database=Cards;User Id=richard;Password=richard;";
        }
    }

    public static String CONNECTION_STRING_DARTS()
    {
        if (Environment.MachineName == "7PG5CC2")
        {
            return @"Server=.\localtest;Database=xiyudemo;User Id=richard;Password=richard;";
        }
        else
        {
            return @"Server=.;Database=xiyudemo;User Id=richard;Password=richard;";
        }
    }    

}
