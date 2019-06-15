using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using UdemyETicaret.DB;

namespace UdemyETicaret.Controllers
{
    public class iController : BaseController
    {
       
        // GET: i
        public ActionResult Index(int? id )
        {

            IQueryable<DB.Products> products = context.Products;
            DB.Categories category = null;

            if (id.HasValue)
            {
                products = products.Where(x=>x.Category_Id == id);
                category = context.Categories.FirstOrDefault(x => x.Id == id);
            }
           
            var viewModel = new Models.i.IndexModel()
            {
                Products = products.ToList(),
                Category = category
            };


            return View(viewModel);
        }
    }
}