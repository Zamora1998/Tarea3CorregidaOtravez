using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;
using ClasesData;
using Controlador.Models;

namespace Controlador.Controllers
{
    public class EstadoController : Controller
    {
        private RestauranteEntities db = new RestauranteEntities();

        public EstadoController()
        {
            db.Configuration.LazyLoadingEnabled = false;
            db.Configuration.ProxyCreationEnabled = false;
        }

        [HttpGet]
        public ActionResult ObtenerEstados()
        {
            try
            {
                var todosLosEstados = db.Estado.ToList();
                var estados = todosLosEstados.Select(e => new Estadoclass
                {
                    EstadoID = e.EstadoID,
                    Descripcion = e.Descripcion
                }).ToList();

                return Json(estados, JsonRequestBehavior.AllowGet);
            }
            catch (Exception)
            {
                return new HttpStatusCodeResult(HttpStatusCode.InternalServerError);
            }
        }
    }
}
