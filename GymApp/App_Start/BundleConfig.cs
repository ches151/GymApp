using System.Web;
using System.Web.Http;
using System.Web.Optimization;

namespace Notes
{
    public class BundleConfig
    {
        // For more information on bundling, visit http://go.microsoft.com/fwlink/?LinkId=301862
        public static void RegisterBundles(BundleCollection bundles)
        {
            bundles.Add(new StyleBundle("~/Content/angular-material").Include(
                "~/bower_components/angular-material/angular-material.css"));

            bundles.Add(new StyleBundle("~/Content/css").Include(
                "~/app/css/Site.css",
                "~/app/css/animations.css"));

            bundles.Add(new ScriptBundle("~/bundles/angular").Include(
                  "~/bower_components/angular/angular.js"
                , "~/bower_components/angular-route/angular-route.js"
                , "~/bower_components/angular-animate/angular-animate.js"
                , "~/bower_components/angular-resource/angular-resource.js"
                , "~/bower_components/angular-aria/angular-aria.js"
                , "~/bower_components/angular-material/angular-material.js"
            ));

            bundles.Add(new ScriptBundle("~/bundles/main").Include(
                  "~/app/js/tools.js"
                , "~/app/js/gym.js"
                , "~/app/js/gym.directives.js"
                , "~/app/js/gym.services.js"
                , "~/app/js/gym.workout-list-controller.js"
                , "~/app/js/gym.workout-new-controller.js"
                , "~/app/js/gym.workout-edit-controller.js"
                , "~/app/js/gym.workout-session-controller.js"
            ));
#if !DEBUG
            BundleTable.EnableOptimizations = true;
#endif

        }
    }
}