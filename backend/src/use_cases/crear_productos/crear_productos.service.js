import * as productoRepository from '../../modules/productos/productos.repository.js';
import * as categoriaRepository from '../../modules/categorias_productos/categorias_productos.repository.js';
import * as inventarioRepository from './../../modules/inventario_productos/inventario_productos.repository.js'

export const crearProductos = async (data) => {
  // Validar que la categoría existe
  if (!data.categoria_id) {
    throw new Error("no se ingresó categoria_id");
  }

  const categoria = await categoriaRepository.obtenerCategoriaProductoPorId(data.categoria_id);
  if (!categoria.rows[0]) {
    throw new Error(`Categoría con id ${data.categoria_id} no encontrada`);
  }

  // Crear el producto con la categoría
  const datosProductos = {
    nombre: data.nombre,
    descripcion: data.descripcion,
    precio: data.precio,
    categoria_id: data.categoria_id
  };

  const producto = await productoRepository.crearProducto(datosProductos);

  // Crear inventario para el producto recién creado
  const producto_id = producto.rows[0].id;
  const stock_inicial = data.stock || 0; // Si no se especifica stock, comienza en 0
  
  await inventarioRepository.crearInventarioProducto({
    producto_id: producto_id,
    stock: stock_inicial
  });

  console.log(`Inventario creado para producto ${producto_id} con stock inicial: ${stock_inicial}`);

  return producto;
}