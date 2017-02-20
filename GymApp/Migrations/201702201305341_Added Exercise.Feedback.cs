namespace GymWebApp.Migrations
{
    using System;
    using System.Data.Entity.Migrations;
    
    public partial class AddedExerciseFeedback : DbMigration
    {
        public override void Up()
        {
            AddColumn("dbo.Exercises", "Feedback", c => c.String(maxLength: 128));
        }
        
        public override void Down()
        {
            DropColumn("dbo.Exercises", "Feedback");
        }
    }
}
