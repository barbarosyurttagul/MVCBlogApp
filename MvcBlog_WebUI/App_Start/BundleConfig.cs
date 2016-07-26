using System.Web;
using System.Web.Optimization;

namespace MvcBlog_WebUI
{
    public class BundleConfig
    {
        // For more information on bundling, visit http://go.microsoft.com/fwlink/?LinkId=301862
        public static void RegisterBundles(BundleCollection bundles)
        {
            bundles.Add(new ScriptBundle("~/bundles/jquery").Include(
                        "~/Content/js/jquery.min.js",
                        "~/Content/js/jquery.migrate.js",
                        "~/Content/js/jquery.magnific-popup.min.js",
                        "~/Content/js/jquery.bxslider.min.js",
                        "~/Content/js/jquery.flexslider.js",
                        "~/Content/js/jquery.appear.js",
                        "~/Content/js/jquery.stellar.min.js",
                        "~/Content/js/bootstrap.js",
                        "~/Content/js/jquery.imagesloaded.min.js",
                        "~/Content/js/jquery.isotope.min.js",
                        "~/Content/js/retina-1.1.0.min.js",
                        "~/Content/js/plugins-scroll.js",
                        "~/Content/js/waypoint.min.js",
                        "~/Content/js/script.js",
                        "~/Content/js/jquery.countTo.js",
                        "~/Content/js/owl.carousel.min.js"));

            bundles.Add(new ScriptBundle("~/bundles/MyScriptBundle").Include(
                       "~/Scripts/MyScripts/MemberValidation.js"));



            bundles.Add(new StyleBundle("~/Content/css").Include(
                      "~/Content/css/bootstrap.css",
                      "~/Content/css/flexslider.css",
                      "~/Content/css/font-awesome.css",
                      "~/Content/css/animate.css",
                      "~/Content/css/owl.carousel.css",
                      "~/Content/css/owl.theme.css",
                      "~/Content/css/jquery.bxslider.css",
                      "~/Content/css/magnific-popup.css",
                      "~/Content/css/animate.css",
                      "~/Content/css/style.css"));

            bundles.Add(new StyleBundle("~/Content/Login/css").Include(
                      "~/Content/css/Login/css/normalize.css",
                      "~/Content/css/Login/css/style.css"));
        }
    }
}
