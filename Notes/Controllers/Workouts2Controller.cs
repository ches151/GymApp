using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Threading.Tasks;
using System.Net;
using System.Web;
using System.Web.Mvc;
using Notes.Models;
using System.Web.Http.Cors;

namespace Notes.Controllers
{
    [EnableCors(origins: "http://192.168.100.2:8080", headers: "*", methods: "*")]
    public class Workouts2Controller : Controller
    {
        private MainDataModel db = new MainDataModel();

        // GET: WorkoutSessions
        public async Task<ActionResult> Index()
        {
            return View(await db.Workouts.ToListAsync());
        }
        public async Task<ActionResult> List()
        {
            return Json(await db.Workouts.ToListAsync());
        }

        // GET: WorkoutSessions/Details/5
        public async Task<ActionResult> Details(Guid? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Workout workout = await db.Workouts.FindAsync(id);
            if (workout == null)
            {
                return HttpNotFound();
            }
            return View(workout);
        }

        // GET: WorkoutSessions/Create
        public ActionResult Create()
        {
            return View();
        }

        // POST: WorkoutSessions/Create
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<ActionResult> Create([Bind(Include = "Id,Name")] Workout workout)
        {
            if (ModelState.IsValid)
            {
                workout.Id = Guid.NewGuid();
                db.Workouts.Add(workout);
                await db.SaveChangesAsync();
                return RedirectToAction("Index");
            }

            return View(workout);
        }

        // GET: WorkoutSessions/Edit/5
        public async Task<ActionResult> Edit(Guid? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Workout workout = await db.Workouts.FindAsync(id);
            if (workout == null)
            {
                return HttpNotFound();
            }
            return View(workout);
        }

        // POST: WorkoutSessions/Edit/5
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<ActionResult> Edit([Bind(Include = "Id,Name")] Workout workout)
        {
            if (ModelState.IsValid)
            {
                db.Entry(workout).State = EntityState.Modified;
                await db.SaveChangesAsync();
                return RedirectToAction("Index");
            }
            return View(workout);
        }

        // GET: WorkoutSessions/Delete/5
        public async Task<ActionResult> Delete(Guid? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Workout workout = await db.Workouts.FindAsync(id);
            if (workout == null)
            {
                return HttpNotFound();
            }
            return View(workout);
        }

        // POST: WorkoutSessions/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public async Task<ActionResult> DeleteConfirmed(Guid id)
        {
            Workout workout = await db.Workouts.FindAsync(id);
            db.Workouts.Remove(workout);
            await db.SaveChangesAsync();
            return RedirectToAction("Index");
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
