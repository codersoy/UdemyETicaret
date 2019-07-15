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

        /// <summary>
        /// tüm alt kategorileri getir
        /// </summary>
        /// <param name="cat">Hangi kategorinin alt kategorilerini getirsin</param>
        /// <returns></returns>
        protected List<Categories> GetChildCategories(Categories cat)
        {
            var result = new List<Categories>();

            result.AddRange(cat.Categories1);
            foreach (var item in cat.Categories1)
            {
                var list = GetChildCategories(item);
                result.AddRange(list);
            }

            return result;
        }
    }
}