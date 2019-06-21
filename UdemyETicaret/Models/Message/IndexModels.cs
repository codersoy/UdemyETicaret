using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace UdemyETicaret.Models.Message
{
    public class IndexModels
    {
        public List<SelectListItem> Users { get; set; }
        public List<DB.Messages> Messages { get; set; }
    }
}