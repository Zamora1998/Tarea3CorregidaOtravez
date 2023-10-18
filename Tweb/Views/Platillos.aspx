<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Platillos.aspx.cs" Inherits="Tweb.Views.Platillos" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Administracion de Platillos</title>
    <link rel="stylesheet" type="text/css" href="../CSS/style.css" />
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" />
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"></script>
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>  
    <script src="../JS/Platillos.js"></script>        
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
            <h2>Platillos </h2>
            <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#nuevoPlatilloModal" onclick="mostrarModal()">
                Agregar Platillo
            </button>
            <div class="modal fade" id="nuevoPlatilloModal">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h4 class="modal-title">Nuevo Platillo</h4>
                            <button type="button" class="close" data-dismiss="modal">&times;</button>
                        </div>
                        <div class="modal-body">
                            <div class="form-group">
                                <label for="nombre">Nombre:</label>
                                <input type="text" class="form-control" id="nombre" runat="server"/>
                            </div>
                            <div class="form-group">
                                <label for="costo">Costo:</label>
                                <input type="text" class="form-control" id="costo" runat="server"/>
                            </div>
                            <div class="form-group">
                                <label for="ddlcategoria">Categoría:</label>
                                <select class="form-control" id="ddlcategoria" runat="server">
                                </select>
                            </div>
                            <div class="form-group">
                                <label for="ddlestado">Estado:</label>
                                <select class="form-control" id="ddlestado" runat="server">
                                </select>
                            </div>
                            <span id="errorMensaje" runat="server" style="color: red;"></span>
                        </div>
                        <div class="modal-footer">
                            <asp:Button ID="btnGuardarPlatillo" runat="server" Text="Aceptar" CssClass="btn btn-primary" OnClientClick="validarYGuardarPlatillo(); return false;" />
                            <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancelar</button>
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
                            <p>Por favor seleccione el platillo.</p>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-primary" data-dismiss="modal">Aceptar</button>
                        </div>
                    </div>
                </div>
            </div>
            <!-- Modal de Confirmación -->
            <div class="modal fade" id="confirmacionModal" tabindex="-1" role="dialog" aria-labelledby="confirmacionModalLabel" aria-hidden="true">
                <div class="modal-dialog" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="confirmacionModalLabel">Confirmar Eliminación</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <p>¿Desea eliminar el platillo seleccionado?</p>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-dismiss="modal">No</button>
                            <button type="button" class="btn btn-danger" id="botonEliminar">Si</button>
                        </div>
                    </div>
                </div>
            </div>
            <!-- Modal para Modificar Registro -->
            <div class="modal fade" id="modalModificar" tabindex="-1" role="dialog" aria-labelledby="modalModificarLabel" aria-hidden="true">
                <div class="modal-dialog" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="modalModificarLabel">Editar Platillo</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <p>ID de Platillo: <span id="modalPlatilloID"></span></p>
                            <p>Nombre Existente: <span id="txtmodalNombre2" class="form-control"></span></p>
                            <div class="form-group">
                                <label for="txtmodalNombre">Nombre:</label>
                                <input type="hidden" id="nombreActual" />
                                <input type="text" id="txtmodalNombre" class="form-control" placeholder="Ingrese el nuevo nombre del Platillo" pattern="[A-Za-zÁÉÍÓÚáéíóúñÑ\s]+" title="Solo letras, espacios y tildes/ñ" />
                            </div>
                            <div class="form-group">
                                <label for="txtmodalCosto">Costo:</label>
                                <input type="hidden" id="CostoActual" />
                                <input type="text" id="txtmodalCosto" class="form-control" placeholder="Ingrese el nuevo coste del platillo" pattern="[0-9]+(\.[0-9]{1,2})?" title="Solo números, opción decimal con hasta dos dígitos" />
                            </div>
                            <div class="form-group">
                                <label for="ddleditarcategoria">Categoría:</label>
                                <select class="form-control" id="ddleditarcategoria" runat="server">
                                </select>
                            </div>
                            <div class="form-group">
                                <label for="ddleditarestado">Estado:</label>
                                <select class="form-control" id="ddleditarestado" runat="server">
                                </select>
                            </div>
                            <span id="errorEditar" style="color: red;"></span>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancelar</button>
                            <button type="button" class="btn btn-primary" id="btnAceptarModificar">Aceptar</button>
                        </div>
                    </div>
                </div>
            </div>
            <h3>Listado de Platillos</h3>
            <table id="tablaPlatillos" class="table table-bordered  table-striped" >
                <thead>
                    <tr>
                        <th></th>
                        <th class="text-center">ID</th>
                        <th class="text-center">Nombre</th>
                        <th class="text-center">Costo</th>
                        <th class="text-center">Categoría</th>
                        <th class="text-center">Estado</th>
                        <th class="text-center">Acciones</th>
                    </tr>
                </thead>
                <tbody class="text-center"></tbody>
            </table>
        </div>
    </form>
    <script>
        function mostrarModal() {
            $('#nuevoPlatilloModal').modal('show');
            llenarCategorias();
            llenarEstados();
        }

        async function llenarECategorias() {
            try {
                var ddlCategorias = document.getElementById('<%= ddleditarcategoria.ClientID %>');
                ddlCategorias.innerHTML = '';

                const categoriasResponse = await fetch('http://localhost:50912/Categorias/ObtenerCategorias');
                const categoriasData = await categoriasResponse.json();
                categoriasData.forEach(categoria => {
                    var option = document.createElement('option');
                    option.value = categoria.CategoriaID;
                    option.text = categoria.Nombre;
                    ddlCategorias.appendChild(option);
                });
            } catch (error) {
                mostrarError(errorMensaje, "Error al cargar los datos de categorías y estados", false);
            }
        }
        async function llenarEEstados() {
            try {
                var ddlEstado = document.getElementById('<%= ddleditarestado.ClientID %>');
                ddlEstado.innerHTML = '';

                const response = await fetch('http://localhost:50912/Estado/ObtenerEstados');
                const data = await response.json();

                data.forEach(estado => {
                    var option = document.createElement('option');
                    option.value = estado.EstadoID;
                    option.text = estado.Descripcion;
                    ddlEstado.appendChild(option);
                });
            } catch (error) {
                mostrarError(errorMensaje, "Error al cargar los datos de estados", false);
            }
        }

        async function llenarCategorias() {
            try {
                var ddlCategorias = document.getElementById('<%= ddlcategoria.ClientID %>');
                ddlCategorias.innerHTML = '';

                const categoriasResponse = await fetch('http://localhost:50912/Categorias/ObtenerCategorias');
                const categoriasData = await categoriasResponse.json();
                categoriasData.forEach(categoria => {
                    var option = document.createElement('option');
                    option.value = categoria.CategoriaID;
                    option.text = categoria.Nombre;
                    ddlCategorias.appendChild(option);
                });
            } catch (error) {
                mostrarError(errorMensaje, "Error al cargar los datos de categorías y estados", false);
            }
        }
        async function llenarEstados() {
            try {
                var ddlEstado = document.getElementById('<%= ddlestado.ClientID %>');
                ddlEstado.innerHTML = '';

                const response = await fetch('http://localhost:50912/Estado/ObtenerEstados');
                const data = await response.json();

                data.forEach(estado => {
                    var option = document.createElement('option');
                    option.value = estado.EstadoID;
                    option.text = estado.Descripcion;
                    ddlEstado.appendChild(option);
                });
            } catch (error) {
                mostrarError(errorMensaje, "Error al cargar los datos de estados", false);
            }
        }

        function validarYGuardarPlatillo() {
            if (validarPlatillo()) {
                const nombre = document.getElementById('<%= nombre.ClientID %>').value;
        const costo = parseFloat(document.getElementById('<%= costo.ClientID %>').value);
        const categoria = parseInt(document.getElementById('<%= ddlcategoria.ClientID %>').value);
        const estado = parseInt(document.getElementById('<%= ddlestado.ClientID %>').value);

        fetch('http://localhost:50912/Platillos/RegistrarPlatillo', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({
                Nombre: nombre,
                Costo: costo,
                CategoriaID: categoria,
                IDESTADO: estado
            })
        })
            .then(response => {
                if (response.status === 201) {
                    mostrarError(errorMensaje, "Platillo creado con éxito.", true);
                } else if (response.status === 409) {
                    mostrarError(errorMensaje, "El platillo ya existe.", false);
                } else {
                    mostrarError(errorMensaje, "El platillo no se envio correctamente.", false);
                }
            })
            .catch(error => {
                mostrarError(errorMensaje, error.message, true);
            })
    }
}

function validarPlatillo() {
    var nombre = document.getElementById('<%= nombre.ClientID %>').value;
    var costo = document.getElementById('<%= costo.ClientID %>').value;
    var categoria = document.getElementById('<%= ddlcategoria.ClientID %>').value;
    var estado = document.getElementById('<%= ddlestado.ClientID %>').value;
    var errorMensaje = document.getElementById('<%= errorMensaje.ClientID %>');

    // Validar que los campos no estén vacíos
    if (nombre.trim() === "" || costo.trim() === "" || categoria.trim() === "" || estado.trim() === "") {
        mostrarError(errorMensaje, "Todos los campos son obligatorios.", false);
        return false;
    }

    // Validar que el nombre solo contenga letras y tenga como máximo 100 caracteres
    if (!/^[A-Za-z]+$/.test(nombre) || nombre.length > 100) {
        mostrarError(errorMensaje, "El campo Nombre debe contener solo letras", false);
        return false;
    }

    // Validar que el costo sea numérico con hasta dos decimales
    if (!/^\d+(\.\d{1,2})?$/.test(costo)) {
        mostrarError(errorMensaje, "El campo Costo debe ser un número válido con hasta dos decimales.", false);
        return false;
    }

    // Validar que la categoría esté seleccionada
    if (estado === "0") {
        mostrarError(errorMensaje, "Por favor, seleccione un estado.", false);
        return false;
    }

    // Validar que la categoría esté seleccionada
    if (categoria === "0") {
        mostrarError(errorMensaje, "Por favor, seleccione una categoría.", false);
        return false;
    }
    // Si todas las validaciones pasan, retorna true
    return true;
}

function mostrarError(elemento, mensaje, recargarPagina) {
    elemento.textContent = mensaje;
    setTimeout(function () {
        elemento.textContent = "";
        if (recargarPagina) {
            location.reload();
        }
    }, 4000);
}

async function cargarPlatillosDesdeAPI() {
    try {
        const response = await fetch('http://localhost:50912/Platillos/ListarPlatillos');
        if (response.ok) {
            const data = await response.json();
            const tabla = document.getElementById('tablaPlatillos').getElementsByTagName('tbody')[0];
            data.forEach(platillo => {
                const row = tabla.insertRow();
                const checkboxCell = row.insertCell();
                const idCell = row.insertCell();
                const nombreCell = row.insertCell();
                const costoCell = row.insertCell();
                const categoriaCell = row.insertCell();
                const estadoCell = row.insertCell();
                const cellAcciones = row.insertCell();
                cellAcciones.classList.add('text-center');

                const checkbox = document.createElement('input');
                checkbox.type = 'checkbox';
                checkboxCell.appendChild(checkbox);

                idCell.textContent = platillo.PlatilloID;
                nombreCell.textContent = platillo.Nombre;
                costoCell.textContent = platillo.Costo.toFixed(2);
                categoriaCell.textContent = platillo.CategoriaNombre;
                estadoCell.textContent = platillo.EstadoDescripcion;

                const btnEliminar = document.createElement('button');
                btnEliminar.textContent = 'Eliminar';
                btnEliminar.classList.add('btn', 'btn-danger');
                btnEliminar.type = 'button';

                btnEliminar.dataset.idPlatillo = platillo.PlatilloID; // Establece el PlatilloID como atributo de datos

                btnEliminar.onclick = (event) => {
                    event.stopPropagation();

                    // Obtén el PlatilloID del botón
                    const PlatilloID = event.target.dataset.idPlatillo;

                    // Verificar si se ha seleccionado alguna casilla de verificación
                    const row = event.target.closest('tr');
                    const checkbox = row.querySelector('input[type="checkbox"]');

                    if (checkbox && checkbox.checked) {
                        // Mostrar el modal de confirmación si se ha seleccionado una casilla
                        $('#confirmacionModal').modal('show');

                        // Configurar el manejador del botón "Sí, Eliminar" en el modal de confirmación
                        document.getElementById('botonEliminar').onclick = async () => {
                            // Realizar la solicitud para eliminar el platillo
                            const response = await fetch(`http://localhost:50912/Platillos/EliminarPlatillo/${PlatilloID}`, {
                                method: 'DELETE'
                            });

                            if (response.status === 200) {
                                // Si la solicitud es exitosa, cierra el modal de confirmación suavemente
                                $('#confirmacionModal').modal('hide');
                                $('#confirmacionModal').on('hidden.bs.modal', function () {
                                    // Puedes recargar la página o realizar otras acciones después de eliminar
                                    window.location.reload(); // Recargar la página
                                });
                            } else {
                                mostrarError(errorMensaje, "El platillo no se pudo eliminar correctamente.", false);
                            }
                        };
                    } else {
                        $('#modalAdvertencia').modal('show');
                    }
                    return false;
                };

                cellAcciones.appendChild(btnEliminar);

                const btnModificar = document.createElement('button');
                btnModificar.textContent = 'Modificar';
                btnModificar.classList.add('btn', 'btn-warning', 'ml-2');
                btnModificar.type = 'button';
                btnModificar.onclick = (event) => {
                    event.stopPropagation();
                    const selectedRow = obtenerFilaSeleccionada();

                    if (selectedRow) {
                        // Obtener datos de la fila seleccionada
                        const idPlatillo = selectedRow.cells[1].textContent;
                        const nombreActual = selectedRow.cells[2].textContent;
                        const nuevoNombre = document.getElementById('txtmodalNombre').value;
                        const nuevoCosto = parseFloat(document.getElementById('txtmodalCosto').value);

                        // Llenar modal con datos de la fila seleccionada
                        document.getElementById('modalPlatilloID').textContent = idPlatillo;
                        document.getElementById('txtmodalNombre2').textContent = nombreActual;
                        document.getElementById('txtmodalNombre').value = nuevoNombre;
                        document.getElementById('txtmodalCosto').value = nuevoCosto;

                        // Mostrar modal de modificación
                        $('#modalModificar').modal('show');
                        llenarECategorias();
                        llenarEEstados();

                        document.getElementById('btnAceptarModificar').onclick = async () => {
                            const nuevoNombre = document.getElementById('txtmodalNombre').value;
                            const nuevoCosto = parseInt(document.getElementById('txtmodalCosto').value);
                            const categoria = parseInt(document.getElementById('<%= ddleditarcategoria.ClientID %>').value);
                            const estado = parseInt(document.getElementById('<%= ddleditarestado.ClientID %>').value);

                            const requestBody = {
                                Nombre: nuevoNombre,
                                Costo: nuevoCosto,
                                CategoriaID: categoria,
                                IDESTADO: estado
                            };

                            const response = await fetch(`http://localhost:50912/Platillos/EditarPlatillo/?nombreActual=${nombreActual}`, {
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
                                mostrarError(errorMensaje, "Error al editar el platillo.", true);
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
                    mostrarError(errorMensaje, "Error al cargar datos desde la api.", false);
                }
            } catch (error) {
                mostrarError(errorMensaje, "Error inesperado.", true);
            }
        }

        function obtenerFilaSeleccionada() {
            const checkboxes = document.querySelectorAll('#tablaPlatillos tbody input[type="checkbox"]');
            for (const checkbox of checkboxes) {
                if (checkbox.checked) {
                    const row = checkbox.closest('tr');
                    return row;
                }
            }
            return null;
        }
        cargarPlatillosDesdeAPI();

    </script>
    <style>
        #tablaPlatillos td {
            text-align: center;
        }
    </style>
</body>
</html>
