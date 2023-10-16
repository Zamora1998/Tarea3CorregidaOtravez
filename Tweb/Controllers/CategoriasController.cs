/*using ClasesData;
using System;
using System.Collections.Generic;
using System.Data.Common;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using Tweb.Models;

namespace Tweb.Controllers
{
    public class CategoriasController : ApiController
    {
        private RestauranteEntities Categ = new RestauranteEntities();

        public CategoriasController()
        {
            Categ.Configuration.LazyLoadingEnabled = false;
            Categ.Configuration.ProxyCreationEnabled = false;
        }

        [HttpPost]
        [Route("api/Categorias/AgregarCategoria")]
        public IHttpActionResult AgregarCategoria(Categoriasclasso nuevaCategoria)
        {
            try
            {
                var categoriaExistente = Categ.Categorias.FirstOrDefault(c => c.Nombre == nuevaCategoria.Nombre);

                if (categoriaExistente != null)
                {
                    return Conflict();
                }
                var nuevaCategoriaEntity = new Categorias
                {
                    Nombre = nuevaCategoria.Nombre
                };

                Categ.Categorias.Add(nuevaCategoriaEntity);
                Categ.SaveChanges();
                return Created(Request.RequestUri, "R");
            }
            catch (DbException)
            {
                return NotFound();
            }
            catch (Exception)
            {
                return InternalServerError();
            }
        }
        [HttpPut]
        [Route("api/Categorias/EditarCategoria")]
        public IHttpActionResult EditarCategoria([FromUri] string nombreActual, [FromBody] Categoriasclasso categoriaEditada)
        {
            try
            {
                var categoriaExistente = Categ.Categorias.FirstOrDefault(c => c.Nombre == nombreActual);

                if (categoriaExistente == null)
                {
                    return NotFound();
                }

                var otroCategoriaMismoNombre = Categ.Categorias.FirstOrDefault(c => c.Nombre == categoriaEditada.Nombre && c.Nombre != nombreActual);

                if (otroCategoriaMismoNombre != null)
                {
                    return Conflict();
                }

                // Actualiza el nombre de la categoría con el nuevo nombre recibido en el JSON
                categoriaExistente.Nombre = categoriaEditada.Nombre;

                Categ.SaveChanges();

                return Ok("R");
            }
            catch (Exception)
            {
                return InternalServerError();
            }
        }



        [HttpDelete]
        [Route("api/Categorias/EliminarCategoria/{id}")]
        public IHttpActionResult EliminarCategoria(int id)
        {
            try
            {
                var categoriaExistente = Categ.Categorias.FirstOrDefault(c => c.CategoriaID == id);

                if (categoriaExistente == null)
                {
                    return NotFound();
                }

                Categ.Categorias.Remove(categoriaExistente);
                Categ.SaveChanges();

                return Ok();
            }
            catch (Exception)
            {
                return InternalServerError();
            }
        }

        [HttpGet]
        [Route("api/Categorias/ObtenerCategorias")]
        public IHttpActionResult ObtenerCategorias()
        {
            try
            {
                var todasLasCategorias = Categ.Categorias.ToList();
                return Ok(todasLasCategorias);
            }
            catch (Exception)
            {
                return InternalServerError();
            }
        }


    }
}
*/