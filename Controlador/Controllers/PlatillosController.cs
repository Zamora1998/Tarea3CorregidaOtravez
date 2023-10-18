using ClasesData;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Net;
using Controlador.Models;

namespace Controlador.Controllers
{
    public class PlatillosController : Controller
    {
        private RestauranteEntities Plati = new RestauranteEntities();

        public PlatillosController()
        {
            Plati.Configuration.LazyLoadingEnabled = false;
            Plati.Configuration.ProxyCreationEnabled = false;
        }
        [HttpGet]
        public ActionResult ListarPlatillos()
        {
            try
            {
                var platillos = from p in Plati.Platillos
                                join c in Plati.Categorias on p.CategoriaID equals c.CategoriaID
                                join e in Plati.Estado on p.IDESTADO equals e.EstadoID
                                select new
                                {
                                    PlatilloID = p.PlatilloID,
                                    Nombre = p.Nombre,
                                    Costo = p.Costo,
                                    CategoriaNombre = c.Nombre,
                                    EstadoDescripcion = e.Descripcion
                                };
                if (platillos.Any())
                {
                    return Json(platillos, JsonRequestBehavior.AllowGet);
                }
                else
                {
                    return new HttpStatusCodeResult(HttpStatusCode.NotFound);
                }
            }
            catch (Exception ex)
            {
                return new HttpStatusCodeResult(HttpStatusCode.InternalServerError, ex.Message);

            }
        }
        [HttpDelete]
        public ActionResult EliminarPlatillo(int idPlatillo)
        {
            try
            {

                var platilloExistente = Plati.Platillos.FirstOrDefault(p => p.PlatilloID == idPlatillo);

                if (platilloExistente == null)
                {
                    return new HttpStatusCodeResult(HttpStatusCode.NotFound);
                }
                Plati.Platillos.Remove(platilloExistente);
                Plati.SaveChanges();
                return new HttpStatusCodeResult(HttpStatusCode.OK);
            }
            catch (Exception)
            {
                return new HttpStatusCodeResult(HttpStatusCode.InternalServerError);
            }
        }

        [HttpPost]
        public ActionResult RegistrarPlatillo(Platilloclass platilloNuevo)
        {
            try
            {
                var platilloExistente = Plati.Platillos.FirstOrDefault(p => p.Nombre == platilloNuevo.Nombre);

                if (platilloExistente != null)
                {
                    return new HttpStatusCodeResult(HttpStatusCode.Conflict);
                }

                var nuevoPlatillo = new Platillos
                {
                    Nombre = platilloNuevo.Nombre,
                    Costo = platilloNuevo.Costo,
                    CategoriaID = platilloNuevo.CategoriaID,
                    IDESTADO = platilloNuevo.IDESTADO
                };

                Plati.Platillos.Add(nuevoPlatillo);
                Plati.SaveChanges();

                return new HttpStatusCodeResult(HttpStatusCode.Created);
            }
            catch (Exception)
            {
                return new HttpStatusCodeResult(HttpStatusCode.InternalServerError);
            }

        }

        [HttpPut]
        public ActionResult EditarPlatillo(string nombreActual, Platilloclass platilloEditado)
        {
            try
            {
                var platilloExistente = Plati.Platillos.FirstOrDefault(p => p.Nombre == nombreActual);

                if (platilloExistente == null)
                {
                     return new HttpStatusCodeResult(HttpStatusCode.NotFound);
                }

                platilloExistente.Nombre = platilloEditado.Nombre;
                platilloExistente.Costo = platilloEditado.Costo;
                platilloExistente.CategoriaID = platilloEditado.CategoriaID;
                platilloExistente.IDESTADO = platilloEditado.IDESTADO;

                Plati.SaveChanges();

                return new HttpStatusCodeResult(HttpStatusCode.OK);
            }
            catch (Exception)
            {
                return new HttpStatusCodeResult(HttpStatusCode.NotFound);
            }
        }

        [HttpGet]
        public ActionResult ListarPlatillosPorCategoria(string categoriaSeleccionada)
        {
            try
            {
                var platillos = from p in Plati.Platillos
                                join c in Plati.Categorias on p.CategoriaID equals c.CategoriaID
                                join e in Plati.Estado on p.IDESTADO equals e.EstadoID
                                where c.Nombre == categoriaSeleccionada
                                select new
                                {
                                    PlatilloID = p.PlatilloID,
                                    Nombre = p.Nombre,
                                    Costo = p.Costo,
                                    CategoriaNombre = c.Nombre,
                                    EstadoDescripcion = e.Descripcion
                                };

                return Json(platillos, JsonRequestBehavior.AllowGet);
            }
            catch (Exception)
            {
                return new HttpStatusCodeResult(HttpStatusCode.NotFound); 
            }
        }

    }
}