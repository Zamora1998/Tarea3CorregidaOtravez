<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Categorias.aspx.cs" Inherits="Tweb.Views.Categorias" Async="true" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Categorias</title>
    <link rel="stylesheet" type="text/css" href="../CSS/style.css" />
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"></script>
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" />
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script> 
    <script src="../Scripts/AgregarCategoria.js"></script>
    <script src="../Scripts/CargarCategorias.js"></script>
    <script src="../Scripts/CargarCategoriasnuevas.js"></script>

</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-light bg-light">
        <div class="container">
            <a class="navbar-brand mr-auto" href="#">Administrador de Categorias</a>
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ml-auto">
                    <li class="nav-item">
                        <a class="nav-link" href="Platillos.aspx">Platillos</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="Categorias.aspx">Categorias</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="Listado.aspx">Listado Platillos</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>
    <form id="form1" runat="server">
        <div>
            <h2> </h2>
            <asp:Button ID="btnAgregar" runat="server" Text="Agregar" OnClick="btnAgregar_Click" class="btn btn-primary" data-toggle="modal" data-target="#miModal" OnClientClick="return false;" />

            <div id="miModal" class="modal fade" runat="server">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h4 class="modal-title">Categorias</h4>
                            <button type="button" class="close" data-dismiss="modal">&times;</button>
                        </div>
                        <div class="modal-body">
                            <p>Agregar Categoria</p>
                            <asp:TextBox ID="txtInputregistrar" runat="server" CssClass="form-control" placeholder="Ingrese el nombre de Categoria" />

                            <span id="errorMensaje" style="color: red;"></span>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-primary" id="btnAceptar" onclick="validarInput();">Aceptar</button>
                            <button type="button" class="btn btn-secondary" id="btnCerrarModal" data-dismiss="modal">Cancelar</button>
                        </div>
                    </div>
                </div>
            </div>
            <div id="modalAdvertencia" class="modal fade" runat="server">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h4 class="modal-title">Advertencia</h4>
                            <button type="button" class="close" data-dismiss="modal">&times;</button>
                        </div>
                        <div class="modal-body">
                            <p>Por favor seleccione la categoría.</p>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-primary" data-dismiss="modal">Aceptar</button>
                        </div>
                    </div>
                </div>
            </div>
            <div id="modalConfirmacion" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="modalConfirmacionLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="modalConfirmacionLabel">Confirmar Eliminación</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                       ¿Desea eliminar la categoría seleccionada?
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Cerrar</button>
                        <button type="button" id="btnConfirmarEliminar" class="btn btn-danger">Sí, Eliminar</button>
                    </div>
                </div>
            </div>
        </div>
        <!-- Modal para Modificar Registro -->
        <div class="modal fade" id="modalModificar" tabindex="-1" role="dialog" aria-labelledby="modalModificarLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="modalModificarLabel">Modificar Categoría</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <p>Nombre Actual De Categoría: <span id="modalCategoriaID"></span></p>
                        <label for="txtNombre">Nombre Nuevo:</label>
                        <input type="hidden" id="nombreActual" />
                        <input type="text" id="txtinputNombre" class="form-control" placeholder="Ingrese el nuevo nombre de la Categoría" pattern="[A-Za-zÁÉÍÓÚáéíóúñÑ\s]+" title="Solo letras, espacios y tildes/ñ" />
                         <span id="errorEditar" style="color: red;"></span> 
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancelar</button>
                        <button type="button" class="btn btn-primary" id="btnAceptarModificar">Aceptar</button>
                    </div>
                </div>
            </div>
        </div>


            <asp:Table ID="tablaCategorias" runat="server" BorderWidth="1" CssClass="table table-bordered table-striped">
                <asp:TableHeaderRow>
                    <asp:TableHeaderCell CssClass="text-center">Check</asp:TableHeaderCell>
                    <asp:TableHeaderCell ID="thID" CssClass="text-center">ID</asp:TableHeaderCell>
                    <asp:TableHeaderCell ID="thNombre" CssClass="text-center">Nombre</asp:TableHeaderCell>
                    <asp:TableHeaderCell ID="thAcciones" CssClass="text-center">Acciones</asp:TableHeaderCell>
                </asp:TableHeaderRow>
            </asp:Table>
        </div>
    </form>
<script>
    async function cargarDatosDesdeControlador() {
        try {
            const response = await fetch('http://localhost:50912/Categorias/ObtenerCategorias');
            if (response.ok) {
                const data = await response.json();
                const tabla = document.getElementById('tablaCategorias');
                const tbody = tabla.createTBody();

                data.sort((a, b) => a.Nombre.localeCompare(b.Nombre));

                data.forEach(categoria => {
                    const row = tbody.insertRow();

                    const cellCheck = row.insertCell();
                    cellCheck.classList.add('text-center');
                    const checkbox = document.createElement('input');
                    checkbox.type = 'checkbox';
                    cellCheck.appendChild(checkbox);

                    const cellId = row.insertCell();
                    cellId.classList.add('text-center');
                    cellId.textContent = categoria.CategoriaID;
                    const cellNombre = row.insertCell();
                    cellNombre.classList.add('text-center');
                    cellNombre.textContent = categoria.Nombre;

                    const cellAcciones = row.insertCell();
                    cellAcciones.classList.add('text-center');

                    const btnEliminar = document.createElement('button');
                    btnEliminar.textContent = 'Eliminar';
                    btnEliminar.classList.add('btn', 'btn-danger');
                    btnEliminar.type = 'button';
                    btnEliminar.onclick = (event) => {
                        event.stopPropagation();

                        // Verificar si se ha seleccionado alguna casilla de verificación
                        const row = event.target.closest('tr');
                        const checkbox = row.querySelector('input[type="checkbox"]');

                        if (checkbox && checkbox.checked) {
                            // Mostrar el modal de confirmación si se ha seleccionado una casilla
                            const id = categoria.CategoriaID;
                            $('#modalConfirmacion').modal('show');

                            // Configurar el manejador del botón "Sí, Eliminar" en el modal de confirmación
                            document.getElementById('btnConfirmarEliminar').onclick = async () => {
                                // Realizar la solicitud para eliminar la categoría
                                const response = await fetch(`http://localhost:50912/api/Categorias/EliminarCategoria/${id}`, {
                                    method: 'DELETE'
                                });

                                if (response.status === 200) {
                                    // Si la solicitud es exitosa, cierra el modal de confirmación suavemente
                                    $('#modalConfirmacion').modal('hide');
                                    $('#modalConfirmacion').on('hidden.bs.modal', function () {
                                        // Puedes recargar la página o realizar otras acciones después de eliminar
                                        window.location.reload(); // Recargar la página
                                    });
                                } else {
                                    console.error('Error al eliminar la categoría');
                                }
                            };
                        } else {
                            $('#modalAdvertencia').modal('show');
                        }

                        return false;
                    };
                    cellAcciones.appendChild(btnEliminar);

                    // Agregar el botón "Modificar"
                    const btnModificar = document.createElement('button');
                    btnModificar.textContent = 'Modificar';
                    btnModificar.classList.add('btn', 'btn-warning', 'ml-2'); // Agrega margen izquierdo para separarlos
                    btnModificar.type = 'button';
                    btnModificar.onclick = (event) => {
                        event.stopPropagation();
                        const row = event.target.closest('tr');
                        const checkbox = row.querySelector('input[type="checkbox"]');

                        if (checkbox && checkbox.checked) {
                            // Mostrar el modal de edición
                            const nombre = categoria.Nombre;
                            $('#modalModificar').modal('show');
                            document.getElementById('modalCategoriaID').textContent = nombre; // Mostrar el nombre en el modal

                            document.getElementById('btnAceptarModificar').onclick = async () => {
                                const nombreActual = document.getElementById('modalCategoriaID').textContent; // Obtén el nombre actual del elemento span
                                const nuevoNombre = document.getElementById('txtinputNombre').value; // Obtén el nuevo nombre del input en el modal

                                // Expresión regular para validar que el valor solo contenga letras
                                const letrasRegex = /^[A-Za-z]+$/;

                                if (!nuevoNombre || !letrasRegex.test(nuevoNombre)) {
                                    document.getElementById('errorEditar').textContent = 'El nombre no es válido.';
                                    return;
                                }

                                const requestBody = {
                                    Nombre: nuevoNombre
                                };

                                const response = await fetch(`http://localhost:50912/api/Categorias/EditarCategoria?nombreActual=${nombreActual}`, {
                                    method: 'PUT',
                                    headers: {
                                        'Content-Type': 'application/json'
                                    },
                                    body: JSON.stringify(requestBody)
                                });

                                if (response.status === 200) {
                                    $('#modalModificar').modal('hide');
                                    $('#modalModificar').on('hidden.bs.modal', function () {
                                        window.location.reload();
                                    });
                                } else if (response.status === 409) {
                                    document.getElementById('errorEditar').textContent = 'El nombre ya se encuentra en uso.';
                                } else {
                                    console.error('Error al editar la categoría');
                                }
                            };
                        } else {
                            $('#modalAdvertencia').modal('show');
                        }

                        return false;
                    };
                    cellAcciones.appendChild(btnModificar);
                });
            } else {
                console.error('Error al cargar datos desde Controlador');
            }
        } catch (error) {
            console.error('Error inesperado: ' + error.message);
        }
    }

    cargarDatosDesdeControlador();
</script>


</body>
</html>
