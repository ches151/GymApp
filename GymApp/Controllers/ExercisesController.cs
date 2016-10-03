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
    public class ExercisesController : ODataController
    {
        private MainDataModel db = new MainDataModel();

        // GET: odata/Exercises
        [EnableQuery]
        public IQueryable<Exercise> GetExercises()
        {
            return db.Exercises.OrderBy(e=>e.Name);
        }

        // GET: odata/Exercises(5)
        [EnableQuery]
        public SingleResult<Exercise> GetExercise([FromODataUri] Guid key)
        {
            return SingleResult.Create(db.Exercises.Where(exercise => exercise.Id == key));
        }

        // PUT: odata/Exercises(5)
        public async Task<IHttpActionResult> Put([FromODataUri] Guid key, Delta<Exercise> patch)
        {
            Validate(patch.GetEntity());

            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            Exercise exercise = await db.Exercises.FindAsync(key);
            if (exercise == null)
            {
                return NotFound();
            }

            patch.Put(exercise);

            try
            {
                await db.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!ExerciseExists(key))
                {
                    return NotFound();
                }
                else
                {
                    throw;
                }
            }

            return Updated(exercise);
        }

        // POST: odata/Exercises
        public async Task<IHttpActionResult> Post(Exercise exercise)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            db.Exercises.Add(exercise);

            try
            {
                await db.SaveChangesAsync();
            }
            catch (DbUpdateException)
            {
                if (ExerciseExists(exercise.Id))
                {
                    return Conflict();
                }
                else
                {
                    throw;
                }
            }

            return Created(exercise);
        }

        // PATCH: odata/Exercises(5)
        [AcceptVerbs("PATCH", "MERGE")]
        public async Task<IHttpActionResult> Patch([FromODataUri] Guid key, Delta<Exercise> patch)
        {
            Validate(patch.GetEntity());

            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            Exercise exercise = await db.Exercises.FindAsync(key);
            if (exercise == null)
            {
                return NotFound();
            }

            patch.Patch(exercise);

            try
            {
                await db.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!ExerciseExists(key))
                {
                    return NotFound();
                }
                else
                {
                    throw;
                }
            }

            return Updated(exercise);
        }

        // DELETE: odata/Exercises(5)
        public async Task<IHttpActionResult> Delete([FromODataUri] Guid key)
        {
            Exercise exercise = await db.Exercises.FindAsync(key);
            if (exercise == null)
            {
                return NotFound();
            }

            db.Exercises.Remove(exercise);
            await db.SaveChangesAsync();

            return StatusCode(HttpStatusCode.NoContent);
        }

        // GET: odata/Exercises(5)/ExerciseSets
        [EnableQuery]
        public IQueryable<ExerciseSet> GetExerciseSets([FromODataUri] Guid key)
        {
            return db.Exercises.Where(m => m.Id == key).SelectMany(m => m.ExerciseSets);
        }

        // GET: odata/Exercises(5)/Workouts
        [EnableQuery]
        public IQueryable<Workout> GetWorkouts([FromODataUri] Guid key)
        {
            return db.Exercises.Where(m => m.Id == key).SelectMany(m => m.Workouts);
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                db.Dispose();
            }
            base.Dispose(disposing);
        }

        private bool ExerciseExists(Guid key)
        {
            return db.Exercises.Count(e => e.Id == key) > 0;
        }
    }
}
