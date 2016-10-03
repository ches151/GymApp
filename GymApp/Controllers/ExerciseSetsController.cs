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
    public class ExerciseSetsController : ODataController
    {
        private MainDataModel db = new MainDataModel();

        // GET: odata/ExerciseSets
        [EnableQuery]
        public IQueryable<ExerciseSet> GetExerciseSets()
        {
            return db.ExerciseSets;
        }

        // GET: odata/ExerciseSets(5)
        [EnableQuery]
        public SingleResult<ExerciseSet> GetExerciseSet([FromODataUri] Guid key)
        {
            return SingleResult.Create(db.ExerciseSets.Where(exerciseSet => exerciseSet.Id == key));
        }

        // PUT: odata/ExerciseSets(5)
        public async Task<IHttpActionResult> Put([FromODataUri] Guid key, Delta<ExerciseSet> patch)
        {
            Validate(patch.GetEntity());

            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            ExerciseSet exerciseSet = await db.ExerciseSets.FindAsync(key);
            if (exerciseSet == null)
            {
                return NotFound();
            }

            patch.Put(exerciseSet);

            try
            {
                await db.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!ExerciseSetExists(key))
                {
                    return NotFound();
                }
                else
                {
                    throw;
                }
            }

            return Updated(exerciseSet);
        }

        // POST: odata/ExerciseSets
        public async Task<IHttpActionResult> Post(ExerciseSet exerciseSet)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            db.ExerciseSets.Add(exerciseSet);

            try
            {
                await db.SaveChangesAsync();
            }
            catch (DbUpdateException)
            {
                if (ExerciseSetExists(exerciseSet.Id))
                {
                    return Conflict();
                }
                else
                {
                    throw;
                }
            }

            return Created(exerciseSet);
        }

        // PATCH: odata/ExerciseSets(5)
        [AcceptVerbs("PATCH", "MERGE")]
        public async Task<IHttpActionResult> Patch([FromODataUri] Guid key, Delta<ExerciseSet> patch)
        {
            Validate(patch.GetEntity());

            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            ExerciseSet exerciseSet = await db.ExerciseSets.FindAsync(key);
            if (exerciseSet == null)
            {
                return NotFound();
            }

            patch.Patch(exerciseSet);

            try
            {
                await db.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!ExerciseSetExists(key))
                {
                    return NotFound();
                }
                else
                {
                    throw;
                }
            }

            return Updated(exerciseSet);
        }

        // DELETE: odata/ExerciseSets(5)
        public async Task<IHttpActionResult> Delete([FromODataUri] Guid key)
        {
            ExerciseSet exerciseSet = await db.ExerciseSets.FindAsync(key);
            if (exerciseSet == null)
            {
                return NotFound();
            }

            db.ExerciseSets.Remove(exerciseSet);
            await db.SaveChangesAsync();

            return StatusCode(HttpStatusCode.NoContent);
        }

        // GET: odata/ExerciseSets(5)/Exercise
        [EnableQuery]
        public SingleResult<Exercise> GetExercise([FromODataUri] Guid key)
        {
            return SingleResult.Create(db.ExerciseSets.Where(m => m.Id == key).Select(m => m.Exercise));
        }

        // GET: odata/ExerciseSets(5)/Workout
        [EnableQuery]
        public SingleResult<Workout> GetWorkout([FromODataUri] Guid key)
        {
            return SingleResult.Create(db.ExerciseSets.Where(m => m.Id == key).Select(m => m.Workout));
        }

        // GET: odata/ExerciseSets(5)/WorkoutSession
        [EnableQuery]
        public SingleResult<WorkoutSession> GetWorkoutSession([FromODataUri] Guid key)
        {
            return SingleResult.Create(db.ExerciseSets.Where(m => m.Id == key).Select(m => m.WorkoutSession));
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                db.Dispose();
            }
            base.Dispose(disposing);
        }

        private bool ExerciseSetExists(Guid key)
        {
            return db.ExerciseSets.Count(e => e.Id == key) > 0;
        }
    }
}
