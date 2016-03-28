using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(GymWebApp.Startup))]
namespace GymWebApp
{
    public partial class Startup
    {
        public void Configuration(IAppBuilder app)
        {
            ConfigureAuth(app);
        }
    }
}
