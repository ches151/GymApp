using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Optimization;
using System.Web.Routing;
using System.Web.Http;
using Newtonsoft.Json;
using System.Net.Http.Headers;
using System.Net.Http.Formatting;

namespace Notes
{
    public class MvcApplication : System.Web.HttpApplication
    {
        protected void Application_Start()
        {
            //GlobalConfiguration.Configuration.Formatters.Clear();
            //GlobalConfiguration.Configuration.Formatters.Insert(0, new Misc.JsonNetFormatter());
            //var config = GlobalConfiguration.Configuration;
            //var formatters = config.Formatters;
            //JsonMediaTypeFormatter jsonFormatter = formatters.FindReader(typeof(Array), new MediaTypeHeaderValue("application/json")) as JsonMediaTypeFormatter;
            //jsonFormatter.SerializerSettings.PreserveReferencesHandling = PreserveReferencesHandling.Objects;

            AreaRegistration.RegisterAllAreas();
            GlobalConfiguration.Configure(WebApiConfig.Register);
            FilterConfig.RegisterGlobalFilters(GlobalFilters.Filters);
            RouteConfig.RegisterRoutes(RouteTable.Routes);
            BundleConfig.RegisterBundles(BundleTable.Bundles);
        }
        protected void Application_Error(Object sender, EventArgs e)
        {
            Exception exc = Server.GetLastError();
            Response.Write("Error encountered.");

        }
    }
}
    