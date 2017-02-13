using GymWebApp.Models;
using System.Net.Http;
using System.Web.Http;
using System.Web.Http.Dispatcher;
using System.Web.OData;
using System.Web.OData.Builder;
using System.Web.OData.Extensions;

namespace GymWebApp
{
    // http://stackoverflow.com/a/27191598/5910706
    public static class ODataConfig
    {
        public static void Register(HttpConfiguration config)
        {

            config.MapHttpAttributeRoutes();

            ODataConventionModelBuilder builder = new ODataConventionModelBuilder();
            builder.EntitySet<Exercise>("Exercises");
            builder.EntitySet<Workout>("Workouts");
            builder.EntitySet<WorkoutSession>("WorkoutSessions");
            builder.EntitySet<ExerciseSet>("ExerciseSets");
            builder.EnableLowerCamelCase();

            // Need this. Otherwise SingleResult<WorkoutSession> GetWorkoutSession tries to return null and then fails to serialize the null value.
            config.MapODataServiceRoute(
                "odata"
                , "odata"
                , builder.GetEdmModel()
                , defaultHandler: HttpClientFactory.CreatePipeline(
                    innerHandler: new HttpControllerDispatcher(config)
                    , handlers: new[] { new ODataNullValueMessageHandler() }));
        }
    }
}