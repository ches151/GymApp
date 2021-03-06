﻿using System;
using System.Data.Entity.Infrastructure;
using System.Data.Entity.Migrations;
using System.Linq;
using System.Net;
using System.Threading.Tasks;
using System.Web.Http;
using System.Web.Http.Cors;
using System.Web.Http.ModelBinding;
using System.Web.OData;
using GymWebApp.Models;
using System.Collections.Generic;

namespace GymWebApp.Controllers
{
    [EnableCors(origins: "http://192.168.10.2:8080", headers: "*", methods: "*")]
    public class WorkoutsController : ODataController
    {
        private MainDataModel db = new MainDataModel();

        // GET: odata/Workouts
        [EnableQuery]
        public IQueryable<Workout> GetWorkouts()
        {
            var res = db.Workouts.OrderBy(w => w.Name);

            return res;
        }

        // GET: odata/Workouts(5)
        [EnableQuery]
        public SingleResult<Workout> GetWorkout([FromODataUri] Guid key)
        {
            return SingleResult.Create(db.Workouts.Where(workout => workout.Id == key));
        }

        // PUT: odata/Workouts(5)
        public async Task<IHttpActionResult> Put([FromODataUri] Guid key, Workout vm)
        {
            Validate(vm);

            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            Workout workout = await db.Workouts.FindAsync(key);
            if (workout == null)
            {
                return NotFound();
            }

            workout.Name = vm.Name;
            foreach (var ex in vm.Exercises.Except(workout.Exercises).ToArray())
            {
                db.Exercises.Attach(ex);
                workout.Exercises.Add(ex);
            }
            foreach (var ex in vm.Exercises.Except(db.Exercises).ToArray())
            {
                db.Exercises.Add(ex);
                workout.Exercises.Add(ex);
            }
            foreach (var ex in workout.Exercises.Except(vm.Exercises).ToArray())
            {
                workout.Exercises.Remove(ex);
            }

            try
            {
                await db.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!WorkoutExists(key))
                {
                    return NotFound();
                }
                else
                {
                    throw;
                }
            }

            return Updated(workout);
        }

        // POST: odata/Workouts
        public async Task<IHttpActionResult> Post(Workout workout)
        {
            // TODO Implement concurrency check: http://www.asp.net/mvc/overview/getting-started/getting-started-with-ef-using-mvc/handling-concurrency-with-the-entity-framework-in-an-asp-net-mvc-application
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }
            var exercisesIds = db.Exercises.Select(e => e.Id).ToList();
            workout.DateCreated = DateTime.Now;
            db.Workouts.AddOrUpdate(workout);
            workout.Exercises.ForEach(exercise =>
            {
                if (exercisesIds.Contains(exercise.Id))
                {
                    db.Exercises.Attach(exercise);
                }
            });
            //var res = workout.Exercises.Any(e => e.)

            try
            {

                await db.SaveChangesAsync();
            }
            catch (DbUpdateException)
            {
                if (WorkoutExists(workout.Id))
                {
                    return Conflict();
                }
                else
                {
                    throw;
                }
            }

            return Created(workout);
        }

        //protected override CreatedODataResult<TEntity> Created<TEntity>(TEntity entity)
        //{
        //    if (entity == null)
        //    {
        //        throw new ArgumentNullException("entity");
        //    }
        //    var res = new CreatedODataResult<TEntity>(entity, this);

        //    return res;
        //}

        // PATCH: odata/Workouts(5)
        [AcceptVerbs("PATCH", "MERGE")]
        public async Task<IHttpActionResult> Patch([FromODataUri] Guid key, Delta<Workout> patch)
        {
            // TODO Implement concurrency check: http://www.asp.net/mvc/overview/getting-started/getting-started-with-ef-using-mvc/handling-concurrency-with-the-entity-framework-in-an-asp-net-mvc-application
            Validate(patch.GetEntity());

            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            Workout workout = await db.Workouts.FindAsync(key);
            if (workout == null)
            {
                return NotFound();
            }

            patch.Patch(workout);

            try
            {
                await db.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!WorkoutExists(key))
                {
                    return NotFound();
                }
                else
                {
                    throw;
                }
            }

            return Updated(workout);
        }

        // DELETE: odata/Workouts(5)
        public async Task<IHttpActionResult> Delete([FromODataUri] Guid key)
        {
            Workout workout = await db.Workouts.FindAsync(key);
            if (workout == null)
            {
                return NotFound();
            }

            db.Workouts.Remove(workout);
            await db.SaveChangesAsync();

            return StatusCode(HttpStatusCode.NoContent);
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                db.Dispose();
            }
            base.Dispose(disposing);
        }

        private bool WorkoutExists(Guid key)
        {
            return db.Workouts.Count(e => e.Id == key) > 0;
        }

    }
}
