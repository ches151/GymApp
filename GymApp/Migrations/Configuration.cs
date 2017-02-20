using System;
using System.Data.Entity.Migrations;

namespace GymWebApp.Migrations
{
    using Models;

    internal sealed class Configuration : DbMigrationsConfiguration<MainDataModel>
    {
        public Configuration()
        {
            AutomaticMigrationsEnabled = false;
        }

        protected override void Seed(MainDataModel context)
        {
            var ex1 = new Exercise { Id = Guid.NewGuid(), Name = "Alternate Dumb Bell Press", DateCreated = DateTime.Now };
            var ex2 = new Exercise { Id = Guid.NewGuid(), Name = "Back Hyper Extension", DateCreated = DateTime.Now };
            var ex3 = new Exercise { Id = Guid.NewGuid(), Name = "Bench Press", DateCreated = DateTime.Now };
            var ex4 = new Exercise { Id = Guid.NewGuid(), Name = "Bent Arm Pullover", DateCreated = DateTime.Now };
            var ex5 = new Exercise { Id = Guid.NewGuid(), Name = "Calf Raise", DateCreated = DateTime.Now };
            var ex6 = new Exercise { Id = Guid.NewGuid(), Name = "Curl", DateCreated = DateTime.Now };
            var ex7 = new Exercise { Id = Guid.NewGuid(), Name = "Dead Lift", DateCreated = DateTime.Now };
            var ex8 = new Exercise { Id = Guid.NewGuid(), Name = "Alternate Dumb Bell Curl", DateCreated = DateTime.Now };
            var ex9 = new Exercise { Id = Guid.NewGuid(), Name = "Forward Lunge", DateCreated = DateTime.Now };
            var ex10 = new Exercise { Id = Guid.NewGuid(), Name = "Half Squat", DateCreated = DateTime.Now };
            var ex11 = new Exercise { Id = Guid.NewGuid(), Name = "Leg Curl", DateCreated = DateTime.Now };
            var ex12 = new Exercise { Id = Guid.NewGuid(), Name = "Leg Extension", DateCreated = DateTime.Now };
            context.Exercises.AddOrUpdate(
                e => e.Name,
                new Exercise { Id = Guid.NewGuid(), Name = "Leg Press", DateCreated = DateTime.Now },
                new Exercise { Id = Guid.NewGuid(), Name = "Leg Raises", DateCreated = DateTime.Now },
                new Exercise { Id = Guid.NewGuid(), Name = "Pull-up", DateCreated = DateTime.Now },
                new Exercise { Id = Guid.NewGuid(), Name = "Push-up", DateCreated = DateTime.Now },
                new Exercise { Id = Guid.NewGuid(), Name = "Side Bends", DateCreated = DateTime.Now },
                new Exercise { Id = Guid.NewGuid(), Name = "Sit Up", DateCreated = DateTime.Now },
                new Exercise { Id = Guid.NewGuid(), Name = "Squat", DateCreated = DateTime.Now },
                new Exercise { Id = Guid.NewGuid(), Name = "Step Up", DateCreated = DateTime.Now },
                new Exercise { Id = Guid.NewGuid(), Name = "Sumo Squat", DateCreated = DateTime.Now },
                new Exercise { Id = Guid.NewGuid(), Name = "Tricept Stretch", DateCreated = DateTime.Now },
                new Exercise { Id = Guid.NewGuid(), Name = "Wrist Curl", DateCreated = DateTime.Now }
            );

            var group1 = new Workout { Id = Guid.NewGuid(), Name = "Monday", Exercises = new System.Collections.Generic.List<Exercise> { ex1, ex2, ex3, ex4 }, DateCreated = DateTime.Now };
            var group2 = new Workout { Id = Guid.NewGuid(), Name = "Wednesday", Exercises = new System.Collections.Generic.List<Exercise> { ex5, ex6, ex7, ex8 }, DateCreated = DateTime.Now };
            var group3 = new Workout { Id = Guid.NewGuid(), Name = "Friday", Exercises = new System.Collections.Generic.List<Exercise> { ex9, ex10, ex11, ex12 }, DateCreated = DateTime.Now };
            context.Workouts.AddOrUpdate(
                g => g.Name,
                group1, group2, group3
            );
        }
    }
}
