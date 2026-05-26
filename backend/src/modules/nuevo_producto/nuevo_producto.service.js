import * as productoService from '../productos/productos.service.js';
import * as categoriaService from '../categorias_productos/categorias_productos.repository.js';
import * as inventarioService from '../inventario_productos/inventario_productos.service.js';

export const crearProductos = async (datos) => {

  const categoria = await categoriaService.obtenerCategoriaProductoPorId(datos.categoria_id);
  if (!categoria.rows[0]) {
    throw new Error(`Categoría con id ${datos.categoria_id} no encontrada`);
  }

  // Crear el producto con la categoría
  const datosProductos = {
    nombre: datos.nombre,
    descripcion: datos.descripcion,
    precio: datos.precio,
    categoria_id: datos.categoria_id
  };

  console.log("datos para crear :", datosProductos);

  const producto = await productoService.crearProducto(datosProductos);

  const result_producto_id = producto[0].id;

  console.log("productos: ", result_producto_id);

  // Crear inventario para el producto recién creado
  const producto_id = result_producto_id;
  const stock_inicial = datos.stock || 0; // Si no se especifica stock, comienza en 0

  console.log("iniciando a crear el inventario: ", producto_id, " ", stock_inicial);

  const datos_productos = {
    producto_id: producto_id,
    stock: stock_inicial,
    stock_minimo : 2
  }
  
  console.log("los datos del producto a crear son: ", datos_productos)

  const inventario = await inventarioService.crearInventarioProducto(datos_productos);

  console.log(`Inventario creado para producto ${inventario} con stock inicial: ${stock_inicial}`);

  return producto;
}