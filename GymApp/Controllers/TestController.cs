using GymWebApp.Models;
using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Threading.Tasks;
using System.Web.Http;

namespace GymApp.Controllers
{
    public class TestController : ApiController
    {
        private MainDataModel db = new MainDataModel();

        [HttpGet]
        public async Task<IHttpActionResult> Workouts()
        {
            return Json(await db.Workouts.ToListAsync());
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                db.Dispose();
            }
            base.Dispose(disposing);
        }
    }
}
