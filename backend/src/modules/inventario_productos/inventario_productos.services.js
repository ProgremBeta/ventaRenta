import * as repository from './inventario_productos.repository.js';

console.log("Cargando servicios de inventario...");

export const obtenerInventarioProductos = async () => {
  const result = await repository.obtenerInventarioProductos();
  console.log("Inventario obtenido:", result.rows);

  return result.rows;
}

export const obtenerInventarioProductoPorId = async (id) => {
  const result = await repository.obtenerInventarioProductoPorId(id);
  console.log("Inventario obtenido por ID:", result.rows);

  if (result.rows.length === 0) {
    throw new Error({ message: "No se encontró el inventario" });
  }

  return result.rows;
};

export const crearInventarioProducto = async (datos) => {
  const result = await repository.crearInventarioProducto(datos);
  console.log("Inventario creado:", result.rows);

  if (!datos.producto_id) {
    throw new Error({ message: "Falta el ID del producto o no esta registrado" });
  }

  if (datos.stock === undefined) {
    throw new Error({ message: "Falta el stock del producto" });
  }

  return result.rows;
};

export const actualizarInventarioProducto = async (id, datos) => {
  const result = await repository.actualizarInventarioProducto(id, datos);
  console.log("Inventario actualizado:", result.rows);

  if (result.rows.length === 0) {
    throw new Error({ message: "No se encontró el inventario para actualizar" });
  }

  return result.rows;
};

export const eliminarInventarioProducto = async (id) => {
  const result = await repository.eliminarInventarioProducto(id);
  console.log("Inventario eliminado:", result.rows);

  if (result.rows.length === 0) {
    throw new Error({ message: "No se encontró el inventario para eliminar" });
  }

  return result.rows;
};