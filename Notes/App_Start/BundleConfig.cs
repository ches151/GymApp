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
            bundles.Add(new ScriptBundle("~/bundles/jquery").Include(
                        "~/bower_components/jquery/dist/jquery.js"));

            // Use the development version of Modernizr to develop with and learn from. Then, when you're
            // ready for production, use the build tool at http://modernizr.com to pick only the tests you need.
            bundles.Add(new ScriptBundle("~/bundles/modernizr").Include(
                        "~/app/js/modernizr-*"));

            bundles.Add(new ScriptBundle("~/bundles/bootstrap").Include(
                      "~/bower_components/bootstrap/dist/js/bootstrap.js"));

            bundles.Add(new StyleBundle("~/Content/bootstrap").Include(
                      "~/bower_components/bootstrap/dist/css/bootstrap.css"
                      , "~/bower_components/bootstrap/dist/css/bootstrap-theme.css"
            ));

            bundles.Add(new ScriptBundle("~/bundles/angular").Include(
                      "~/bower_components/angular/angular.js"
                      , "~/bower_components/angular-animate/angular-animate.js"
                      , "~/bower_components/angular-aria/angular-aria.js"
                      , "~/bower_components/angular-messages/angular-messages.js"
                      , "~/bower_components/angular-material/angular-material.js"
            ));
            bundles.Add(new StyleBundle("~/Content/angular-material").Include(
                      "~/bower_components/angular-material/angular-material.css"));

            bundles.Add(new StyleBundle("~/Content/css").Include(
                      "~/app/css/site.css"));

            bundles.Add(new ScriptBundle("~/bundles/main").Include(
                        "~/app/js/tools.js"
                        , "~/app/js/app.js"
            ));
#if !DEBUG
            BundleTable.EnableOptimizations = true;
#endif

        }
    }
}
