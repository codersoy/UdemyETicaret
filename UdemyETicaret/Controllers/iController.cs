using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using UdemyETicaret.DB;
using UdemyETicaret.Models.i;

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

        public ActionResult Product(int id = 0)
        {
            var pro = context.Products.FirstOrDefault(x => x.Id == id);
            if (pro == null)
            {
                return RedirectToAction("Index", "i");
            }
            ProductModels model = new ProductModels()
            {
                Product = pro,
                Comment = pro.Comments.ToList()
            };
            return View(model);
        }

        [HttpPost]
        public ActionResult Product(DB.Comments  comment)
        {
            try
            {
                comment.Member_Id = base.CurrentUserId();
                comment.AddedDate = DateTime.Now;
                context.Comments.Add(comment);
                context.SaveChanges();
            }
            catch (Exception ex)
            {
                ViewBag.MyError = ex.Message;
            }
            return RedirectToAction("Product", "i");
        }
    }
}