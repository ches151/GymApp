namespace GymWebApp.Models
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity;
    using System.Data.Entity.Infrastructure;
    using System.Linq;
    using System.Web.Script.Serialization;
    public class MainDataModel : DbContext
    {
        // Your context has been configured to use a 'MainDataModel' connection string from your application's 
        // configuration file (App.config or Web.config). By default, this connection string targets the 
        // 'GymWebApp.MainDataModel' database on your LocalDb instance. 
        // 
        // If you wish to target a different database and/or database provider, modify the 'MainDataModel' 
        // connection string in the application configuration file.
        public MainDataModel()
            : base("name=DefaultConnection")
        {
        }
        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            modelBuilder.Properties<DateTime>()
            .Configure(c => c.HasColumnType("datetime2"));
        }

        // Add a DbSet for each entity type that you want to include in your model. For more information 
        // on configuring and using a Code First model, see http://go.microsoft.com/fwlink/?LinkId=390109.

        public virtual DbSet<Exercise> Exercises { get; set; }
        public virtual DbSet<Workout> Workouts { get; set; }
        public virtual DbSet<ExerciseSet> ExerciseSets { get; set; }
        public virtual DbSet<WorkoutSession> WorkoutSessions { get; set; }

    }

    public abstract class EntityBase
    {
        [Key]
        public Guid Id { get; set; }

        public override bool Equals(object obj)
        {
            var item = obj as EntityBase;

            if (item == null)
            {
                return false;
            }

            return Id.Equals(item.Id);
        }

        public override int GetHashCode()
        {
            return Id.GetHashCode();
        }
    }

    public class Exercise : EntityBase
    {
        [Required]
        [MaxLength(50, ErrorMessage = "The {0} field must be no longer than {1} characters")]
        public string Name { get; set; }

        [StringLength(128, ErrorMessage = "The {0} field must be no longer than {1} characters")]
        public string Feedback { get; set; }

        [Timestamp]
        public byte[] RowVersion { get; set; }

        public DateTime DateCreated { get; set; }

        [ScriptIgnore]
        public virtual List<Workout> Workouts { get; set; }

        [ScriptIgnore]
        public virtual List<ExerciseSet> ExerciseSets { get; set; }

        public Exercise()
        {
            DateCreated = DateTime.Now;
        }

        public override bool Equals(object obj)
        {
            var item = obj as Exercise;

            if (item == null)
            {
                return false;
            }

            return Name.Equals(item.Name);
        }

        public override int GetHashCode()
        {
            return Name.GetHashCode();
        }
    }
    /// <summary>
    /// Набор упражнений для определённого дня недели
    /// </summary>
    public class Workout : EntityBase
    {
        [Required]
        [MaxLength(50, ErrorMessage = "Name must be no longer than 50 characters")]
        public string Name { get; set; }

        [Timestamp]
        public byte[] RowVersion { get; set; }

        public DateTime DateCreated { get; set; }

        public virtual List<Exercise> Exercises { get; set; }

        public Workout()
        {
            DateCreated = DateTime.Now;
        }
    }
    public enum MassUnit
    {
        kg = 0,
        lb = 1
    }

    /// <summary>
    /// Единичный подход.
    /// Пример: 
    ///     1/20/2016 9:05:05 Жим лёжа, 50кг, №1, 8 раз
    ///     1/20/2016 9:07:12 Жим лёжа, 50кг, №2, 8 раз
    ///     1/20/2016 9:09:30 Жим лёжа, 50кг, №3, 7 раз
    ///     ...
    /// </summary>
    public class ExerciseSet : EntityBase
    {
        public DateTime Date { get; set; }

        [Timestamp]
        public byte[] RowVersion { get; set; }

        [ForeignKey("Exercise")]
        public Guid ExerciseId { get; set; }
        /// <summary>
        /// Link to exercise
        /// </summary>
        public virtual Exercise Exercise { get; set; }


        [ForeignKey("Workout")]
        public Guid WorkoutId { get; set; }
        /// <summary>
        /// Link to group of exercises
        /// </summary>
        public virtual Workout Workout { get; set; }


        [ForeignKey("WorkoutSession")]
        public Guid WorkoutSessionId { get; set; }
        /// <summary>
        /// Link to a particular WorkoutSession, containing this ExerciseSet
        /// </summary>
        public virtual WorkoutSession WorkoutSession { get; set; }

        public double? Weight { get; set; }

        public MassUnit Unit { get; set; }

        public int? SerialNumber { get; set; }

        public int? NumberOfRepetitions { get; set; }

    }
    /// <summary>
    /// Тренировка состоит из подходов
    /// </summary>
    public class WorkoutSession : EntityBase
    {
        public DateTime DateStart { get; set; }
        public DateTime? DateEnd { get; set; }

        [Timestamp]
        public byte[] RowVersion { get; set; }

        public virtual List<ExerciseSet> ExerciseSets { get; set; }
    }


    public class WorkoutExercise : EntityBase
    {
        [ForeignKey("Workout")]
        public Guid WorkoutId { get; set; }

        public virtual Workout Workout { get; set; }


        [ForeignKey("Exercise")]
        public Guid ExerciseId { get; set; }

        public virtual Exercise Exercise { get; set; }
    }
}