using ClasesData;
using Controlador.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;

namespace Controlador.Controllers
{
    public class CategoriasController : Controller
    {
        // GET: Categorias
        private RestauranteEntities Categ = new RestauranteEntities();

        public CategoriasController()
        {
            Categ.Configuration.LazyLoadingEnabled = false;
            Categ.Configuration.ProxyCreationEnabled = false;
        }

        // GET: Categorias/ObtenerCategorias
        public JsonResult ObtenerCategorias()
        {
            var categorias = Categ.Categorias
                .Select(c => new Categoriasclasso
                {
                    CategoriaID = c.CategoriaID,
                    Nombre = c.Nombre
                })
                .ToList();

            // Reorganizar las propiedades en el JSON
            var categoriasConOrden = categorias.Select(c => new
            {
                CategoriaID = c.CategoriaID,
                Nombre = c.Nombre
            }).ToList();

            return Json(categoriasConOrden, JsonRequestBehavior.AllowGet);
        }


        [HttpPost]
        public ActionResult AgregarCategoria(Categoriasclasso nuevaCategoria)
        {
            try
            {
                var categoriaExistente = Categ.Categorias.FirstOrDefault(c => c.Nombre == nuevaCategoria.Nombre);

                if (categoriaExistente != null)
                {
                    // Devolver un código de estado HTTP 409 (Conflict)
                    return new HttpStatusCodeResult(HttpStatusCode.Conflict);
                }

                var nuevaCategoriaEntity = new Categorias
                {
                    Nombre = nuevaCategoria.Nombre
                };

                Categ.Categorias.Add(nuevaCategoriaEntity);
                Categ.SaveChanges();

                // Devolver un código de estado HTTP 201 (Created) con un objeto JSON
                return Json(new { Message = "Categoría creada con éxito" }, JsonRequestBehavior.AllowGet);
            }
            catch (Exception)
            {
                // Devolver un código de estado HTTP 500 (Internal Server Error)
                return new HttpStatusCodeResult(HttpStatusCode.InternalServerError);
            }
        }
    }
}