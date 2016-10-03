using System;
using System.Data.Entity.Infrastructure;
using System.Linq;
using System.Net;
using System.Threading.Tasks;
using System.Web.Http;
using System.Web.Http.Cors;
using System.Web.Http.ModelBinding;
using System.Web.OData;
using GymWebApp.Models;

namespace GymWebApp.Controllers
{
    [EnableCors(origins: "http://192.168.10.2:8080", headers: "*", methods: "*")]
    public class WorkoutSessionsController : ODataController
    {
        private MainDataModel db = new MainDataModel();

        // GET: odata/WorkoutSessions
        [EnableQuery]
        public IQueryable<WorkoutSession> GetWorkoutSessions()
        {
            return db.WorkoutSessions;
        }

        // GET: odata/WorkoutSessions(5)
        [EnableQuery]
        public SingleResult<WorkoutSession> GetWorkoutSession([FromODataUri] Guid key)
        {
            return SingleResult.Create(db.WorkoutSessions.Where(workoutSession => workoutSession.Id == key));
        }

        // PUT: odata/WorkoutSessions(5)
        public async Task<IHttpActionResult> Put([FromODataUri] Guid key, Delta<WorkoutSession> patch)
        {
            Validate(patch.GetEntity());

            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            WorkoutSession workoutSession = await db.WorkoutSessions.FindAsync(key);
            if (workoutSession == null)
            {
                return NotFound();
            }

            patch.Put(workoutSession);

            try
            {
                await db.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!WorkoutSessionExists(key))
                {
                    return NotFound();
                }
                else
                {
                    throw;
                }
            }

            return Updated(workoutSession);
        }

        // POST: odata/WorkoutSessions
        public async Task<IHttpActionResult> Post(WorkoutSession workoutSession)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            db.WorkoutSessions.Add(workoutSession);

            try
            {
                await db.SaveChangesAsync();
            }
            catch (DbUpdateException)
            {
                if (WorkoutSessionExists(workoutSession.Id))
                {
                    return Conflict();
                }
                else
                {
                    throw;
                }
            }

            return Created(workoutSession);
        }

        // PATCH: odata/WorkoutSessions(5)
        [AcceptVerbs("PATCH", "MERGE")]
        public async Task<IHttpActionResult> Patch([FromODataUri] Guid key, Delta<WorkoutSession> patch)
        {
            Validate(patch.GetEntity());

            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            WorkoutSession workoutSession = await db.WorkoutSessions.FindAsync(key);
            if (workoutSession == null)
            {
                return NotFound();
            }

            patch.Patch(workoutSession);

            try
            {
                await db.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!WorkoutSessionExists(key))
                {
                    return NotFound();
                }
                else
                {
                    throw;
                }
            }

            return Updated(workoutSession);
        }

        // DELETE: odata/WorkoutSessions(5)
        public async Task<IHttpActionResult> Delete([FromODataUri] Guid key)
        {
            WorkoutSession workoutSession = await db.WorkoutSessions.FindAsync(key);
            if (workoutSession == null)
            {
                return NotFound();
            }

            db.WorkoutSessions.Remove(workoutSession);
            await db.SaveChangesAsync();

            return StatusCode(HttpStatusCode.NoContent);
        }

        // GET: odata/WorkoutSessions(5)/ExerciseSets
        [EnableQuery]
        public IQueryable<ExerciseSet> GetExerciseSets([FromODataUri] Guid key)
        {
            return db.WorkoutSessions.Where(m => m.Id == key).SelectMany(m => m.ExerciseSets);
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                db.Dispose();
            }
            base.Dispose(disposing);
        }

        private bool WorkoutSessionExists(Guid key)
        {
            return db.WorkoutSessions.Count(e => e.Id == key) > 0;
        }
    }
}
