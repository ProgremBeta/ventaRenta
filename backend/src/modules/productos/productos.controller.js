import * as services from './productos.services.js';

export const obtenerProductos = async (req, res) => {
  try {
    const productos = await services.obtenerProductos();
    res.status(200).json(productos);
  } catch (error) {
    console.error("Error al obtener los productos: ", error);
    res.status(500).json({ error: 'Error al obtener los productos' });
  }
};

export const obtenerProductoPorId = async (req, res) => {
  const { id } = req.params;
  try {
    const producto = await services.obtenerProductoPorId(id);
    if (producto.length === 0) {
      return res.status(404).json({ error: 'Producto no encontrado' });
    }
    res.status(200).json(producto);
  } catch (error) {
    console.error("Error al obtener el producto: ", error);
    res.status(500).json({ error: 'Error al obtener el producto' });
  }
};

export const crearProducto = async (req, res) => {
  const datos = req.body;
  try {
    const nuevoProducto = await services.crearProducto(datos);
    res.status(201).json(nuevoProducto);
  } catch (error) {
    console.error("Error al crear el producto: ", error);
    res.status(500).json({ error: 'Error al crear el producto' });
  }
};

export const actualizarProducto = async (req, res) => {
  const { id } = req.params;
  const datos = req.body;
  try {
    const productoActualizado = await services.actualizarProducto(id, datos);
    if (productoActualizado.length === 0) {
      return res.status(404).json({ error: 'Producto no encontrado' });
    }
    res.status(200).json(productoActualizado);
  } catch (error) {
    console.error("Error al actualizar el producto: ", error);
    res.status(500).json({ error: 'Error al actualizar el producto' });
  }
};

export const eliminarProducto = async (req, res) => {
  const { id } = req.params;
  try {
    const productoEliminado = await services.eliminarProducto(id);
    if (productoEliminado.length === 0) {
      return res.status(404).json({ error: 'Producto no encontrado' });
    }
    res.status(200).json(productoEliminado);
  } catch (error) {
    console.error("Error al eliminar el producto: ", error);
    res.status(500).json({ error: 'Error al eliminar el producto' });
  }
};