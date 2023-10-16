
using System;
using System.Collections.Generic;
using System.IO;
using System.Net;
using System.Net.Http;
using System.Text;
using System.Threading.Tasks;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;


namespace Tweb.Views
{
    public partial class Categorias : Page
    {

        protected void btnAgregar_Click(object sender, EventArgs e)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "mostrarModal", "$('#miModal').modal('show');", true);

        }
        protected void btnvalidarInput(object sender, EventArgs e)
        {
        }

        protected async void Page_Load(object sender, EventArgs e)
        {
            /*
            if (!IsPostBack)
            {

                List<Categoria> listaDeCategorias = await ObtenerCategoriasDesdeAPI();
                listaDeCategorias.Sort((a, b) => string.Compare(a.Nombre, b.Nombre));
                foreach (var categoria in listaDeCategorias)
                {
                    TableRow row = new TableRow();
                    row.CssClass = "align-middle";

                    TableCell cellCheck = new TableCell();
                    cellCheck.CssClass = "text-center";

                    // Crear un control de checkbox
                    CheckBox checkbox = new CheckBox();
                    //checkbox.ID = "chkCategoria_" + categoria.CategoriaID; // Asigna un ID único
                    cellCheck.Controls.Add(checkbox);

                    TableCell cellId = new TableCell();
                    cellId.CssClass = "text-center";
                    cellId.Text = categoria.CategoriaID.ToString();

                    TableCell cellNombre = new TableCell();
                    cellNombre.CssClass = "text-center";
                    cellNombre.Text = categoria.Nombre;

                    TableCell cellAcciones = new TableCell();
                    cellAcciones.CssClass = "text-center";

                    Button btnAcciones = new Button();
                    btnAcciones.Text = "Acciones";
                    btnAcciones.CssClass = "btn btn-primary";
                    btnAcciones.Attributes.Add("data-toggle", "dropdown");
                    btnAcciones.Attributes.Add("aria-haspopup", "true");
                    btnAcciones.Attributes.Add("aria-expanded", "false");

                    HtmlGenericControl dropdownMenu = new HtmlGenericControl("div");
                    dropdownMenu.Attributes.Add("class", "dropdown-menu");

                    Button btnEliminar = new Button();
                    btnEliminar.Text = "Eliminar";
                    btnEliminar.CssClass = "dropdown-item btn btn-danger";
                    // Agregar el atributo data-id al botón
                    btnEliminar.Attributes.Add("data-id", categoria.CategoriaID.ToString());
                    btnEliminar.OnClientClick = "return verificarSeleccion(this);"; // Llama a la función JavaScript



                    Button btnModificar = new Button();
                    btnModificar.Text = "Modificar";
                    btnModificar.CssClass = "dropdown-item";
                    btnModificar.CssClass = "btn btn-warning";


                    dropdownMenu.Controls.Add(btnEliminar);
                    dropdownMenu.Controls.Add(btnModificar);

                    cellAcciones.Controls.Add(btnAcciones);
                    cellAcciones.Controls.Add(dropdownMenu);
                    row.Cells.Add(cellCheck);
                    row.Cells.Add(cellId);
                    row.Cells.Add(cellNombre);
                    row.Cells.Add(cellAcciones);

                    tablaCategorias.Rows.Add(row);

                }

            }
            */
        }
        /*


               private async Task<List<Categoria>> ObtenerCategoriasDesdeAPI()
               {
                   try
                   {
                       using (HttpClient client = new HttpClient())
                       {
                           string apiUrl = "http://localhost:50912/api/Categorias/ObtenerCategorias";
                           HttpResponseMessage response = await client.GetAsync(apiUrl);

                           if (response.IsSuccessStatusCode)
                           {
                               List<Categoria> categorias = await response.Content.ReadAsAsync<List<Categoria>>();
                               return categorias;
                           }
                           else
                           {
                               return new List<Categoria>();
                           }
                       }
                   }
                   catch (Exception ex)
                   {
                       return new List<Categoria>();
                   }
               }
           }
        */
    }
}
