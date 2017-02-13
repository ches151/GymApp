using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using GymWebApp.Models;

namespace GymWebApp
{
    public partial class KeepAlive : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            form1.InnerHtml += "<br/>" + DateTime.Now.ToString(@"MM\/dd\/yyyy HH:mm:ss");
            try
            {
                using (MainDataModel db = new MainDataModel())
                {
                    if (db.Exercises.Count() >= 0) {
                        form1.InnerHtml += "<br/>DB connection OK.";
                    }
                }
            }
            catch (Exception ex)
            {
                form1.InnerHtml += String.Format("<br/>Failed to create instance of MainDataModel: {0}", ex.ToString());
            }
        }
    }
}