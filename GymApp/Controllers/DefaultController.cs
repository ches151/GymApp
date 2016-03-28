using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace GymWebApp.Controllers
{
    public class DefaultController : Controller
    {
        // GET: Default
        public ActionResult Index()
        {
            ViewBag.AppUrl = GetAppUrl();
            return View();
        }

        protected string GetAppUrl(){
            var url = @Request.ApplicationPath;

            if (!url.EndsWith("/"))
                url += "/";

            return url;
        }
    }
}