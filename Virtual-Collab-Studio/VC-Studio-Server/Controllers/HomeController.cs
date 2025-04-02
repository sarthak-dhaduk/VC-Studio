using Microsoft.AspNetCore.Mvc;

namespace VC_Studio_Server.Controllers
{
    public class HomeController : Controller
    {
        public IActionResult Index()
        {
            return View();
        }
    }
}
