using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using UdemyETicaret.DB;

namespace UdemyETicaret.Controllers
{
    public class BaseController : Controller
    {
        protected UdemyETicaretDBEntities1 context { get; private set; }

        public BaseController()
        {
            context = new UdemyETicaretDBEntities1();
            ViewBag.MenuCategories = context.Categories.Where(x => x.Parent_Id == null).ToList();
        }
        protected DB.Members CurrentUser()
        {
            if (Session["LogOnUser"] == null)
            {
                return null;
            }
            return (DB.Members)Session["LogOnUser"];
        }
        protected int CurrentUserId()
        {
            if (Session["LogOnUser"] == null)
            {
                return 0;
            }
            return ((DB.Members)Session["LogOnUser"]).Id;
        }

        protected bool IsLogon()
        {
            if (Session["LogOnUser"] == null)
            {
                return false;
            }
            else
            {
                return true;
            }
        }

    }
}