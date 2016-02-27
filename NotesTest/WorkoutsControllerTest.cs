using System;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Net;
using System.Threading.Tasks;
using Notes.Models;
using System.Web.OData;

namespace Notes.Controllers
{
    [TestClass]
    public class WorkoutsControllerTest
    {
        [TestMethod]
        public void GetWorkoutsTest()
        {
            var ctrl = new WorkoutsController();
            var result = ctrl.GetWorkouts();
        }
    }
}
