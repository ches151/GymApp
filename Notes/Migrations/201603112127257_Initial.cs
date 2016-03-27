namespace Notes.Migrations
{
    using System;
    using System.Data.Entity.Migrations;
    
    public partial class Initial : DbMigration
    {
        public override void Up()
        {
            CreateTable(
                "dbo.Exercises",
                c => new
                    {
                        Id = c.Guid(nullable: false),
                        Name = c.String(nullable: false, maxLength: 50),
                        RowVersion = c.Binary(nullable: false, fixedLength: true, timestamp: true, storeType: "rowversion"),
                        DateCreated = c.DateTime(nullable: false, precision: 7, storeType: "datetime2"),
                    })
                .PrimaryKey(t => t.Id);
            
            CreateTable(
                "dbo.ExerciseSets",
                c => new
                    {
                        Id = c.Guid(nullable: false),
                        Date = c.DateTime(nullable: false, precision: 7, storeType: "datetime2"),
                        RowVersion = c.Binary(nullable: false, fixedLength: true, timestamp: true, storeType: "rowversion"),
                        ExerciseId = c.Guid(nullable: false),
                        WorkoutId = c.Guid(nullable: false),
                        WorkoutSessionId = c.Guid(nullable: false),
                        Weight = c.Double(),
                        Unit = c.Int(nullable: false),
                        SerialNumber = c.Int(),
                        NumberOfRepetitions = c.Int(),
                    })
                .PrimaryKey(t => t.Id)
                .ForeignKey("dbo.Exercises", t => t.ExerciseId, cascadeDelete: true)
                .ForeignKey("dbo.Workouts", t => t.WorkoutId, cascadeDelete: true)
                .ForeignKey("dbo.WorkoutSessions", t => t.WorkoutSessionId, cascadeDelete: true)
                .Index(t => t.ExerciseId)
                .Index(t => t.WorkoutId)
                .Index(t => t.WorkoutSessionId);
            
            CreateTable(
                "dbo.Workouts",
                c => new
                    {
                        Id = c.Guid(nullable: false),
                        Name = c.String(nullable: false, maxLength: 50),
                        RowVersion = c.Binary(nullable: false, fixedLength: true, timestamp: true, storeType: "rowversion"),
                        DateCreated = c.DateTime(nullable: false, precision: 7, storeType: "datetime2"),
                    })
                .PrimaryKey(t => t.Id);
            
            CreateTable(
                "dbo.WorkoutSessions",
                c => new
                    {
                        Id = c.Guid(nullable: false),
                        DateStart = c.DateTime(nullable: false, precision: 7, storeType: "datetime2"),
                        DateEnd = c.DateTime(precision: 7, storeType: "datetime2"),
                        RowVersion = c.Binary(nullable: false, fixedLength: true, timestamp: true, storeType: "rowversion"),
                    })
                .PrimaryKey(t => t.Id);
            
            CreateTable(
                "dbo.WorkoutExercises",
                c => new
                    {
                        Workout_Id = c.Guid(nullable: false),
                        Exercise_Id = c.Guid(nullable: false),
                    })
                .PrimaryKey(t => new { t.Workout_Id, t.Exercise_Id })
                .ForeignKey("dbo.Workouts", t => t.Workout_Id, cascadeDelete: true)
                .ForeignKey("dbo.Exercises", t => t.Exercise_Id, cascadeDelete: true)
                .Index(t => t.Workout_Id)
                .Index(t => t.Exercise_Id);
            
        }
        
        public override void Down()
        {
            DropForeignKey("dbo.ExerciseSets", "WorkoutSessionId", "dbo.WorkoutSessions");
            DropForeignKey("dbo.ExerciseSets", "WorkoutId", "dbo.Workouts");
            DropForeignKey("dbo.WorkoutExercises", "Exercise_Id", "dbo.Exercises");
            DropForeignKey("dbo.WorkoutExercises", "Workout_Id", "dbo.Workouts");
            DropForeignKey("dbo.ExerciseSets", "ExerciseId", "dbo.Exercises");
            DropIndex("dbo.WorkoutExercises", new[] { "Exercise_Id" });
            DropIndex("dbo.WorkoutExercises", new[] { "Workout_Id" });
            DropIndex("dbo.ExerciseSets", new[] { "WorkoutSessionId" });
            DropIndex("dbo.ExerciseSets", new[] { "WorkoutId" });
            DropIndex("dbo.ExerciseSets", new[] { "ExerciseId" });
            DropTable("dbo.WorkoutExercises");
            DropTable("dbo.WorkoutSessions");
            DropTable("dbo.Workouts");
            DropTable("dbo.ExerciseSets");
            DropTable("dbo.Exercises");
        }
    }
}
