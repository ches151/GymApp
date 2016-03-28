using GymWebApp.Models;
using System.Web.Http;
using System.Web.OData.Builder;
using System.Web.OData.Extensions;

namespace GymWebApp
{
    public static class WebApiConfig
    {
        public static void Register(HttpConfiguration config)
        {
            config.EnableCors();

            config.MapHttpAttributeRoutes();

            config.Routes.MapHttpRoute(
                name: "DefaultApi",
                routeTemplate: "api/{controller}/{id}",
                defaults: new { id = RouteParameter.Optional }
            );

            ODataConventionModelBuilder builder = new ODataConventionModelBuilder();
            builder.EntitySet<Exercise>("Exercises");
            builder.EntitySet<Workout>("Workouts");
            builder.EntitySet<WorkoutSession>("WorkoutSessions");
            builder.EntitySet<ExerciseSet>("ExerciseSets");
            builder.EnableLowerCamelCase();
            config.MapODataServiceRoute("odata", "odata", builder.GetEdmModel());
        }
    }
}