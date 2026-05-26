import * as service from './categorias_productos.service.js';

export const obtenerCategoriasProductos = async (req, res, next) => {
  try {
    const result = await service.obtenerCategoriasProductos();

    if (result.length === 0) {
      console.log('no se encontraron datos');
      return res.status(404).json({ mensaje: "no se encontraron datos" });
    }
    
    res.status(200).json(result);
  } catch (err) {
    console.error("Error al obtener categorías de productos:", err);
    next(err);
  }
};

export const obtenerCategoriaProductoPorId = async (req, res, next) => {
  const { id } = req.params;
  try {
    const result = await service.obtenerCategoriaProductoPorId(id);
    
    if (result.length === 0) {
      console.log(`No se encontron ID ${id}`);
      return res.status(404).json({ error: "Categoría de producto no encontrada" });
    }
    
    res.status(200).json(result);
  } catch (err) {
    console.log("error en el controller de obtener categoria de producto por ID: ", err)
    next(err);
  }
};

export const crearCategoriaProducto = async (req, res, next) => {
  const datos = req.body;
  try {
    if (!datos) {
      console.log('No ingresastes datos para crear la categoria');
      return res.status(404).json({ error: "No ingresastes datos para crear la categoria" });
    }

    if (!datos.nombre) { 
    console.log("no ingresaste nombre para la categoria"); 
    return res.status(404).json({mensaje: "no ingresaste nombre para la categoria"})
    }

    const result = await service.crearCategoriaProducto(datos);
    
    res.status(201).json(result);
  } catch (err) {
    console.log("error en el controller de crear categoria de producto", err)
    next(err);
  }
};

export const actualizarCategoriaProducto = async (req, res, next) => {
  const { id } = req.params;
  const datos = req.body;
  try {
    if (!datos) {
      console.log(`No se ingresaron datos para actualizar`);
      return res.status(404).json({ error: "No se ingresaron datos para actualizar" });
    }

    const result = await service.actualizarCategoriaProducto(id, datos);
    
    res.status(200).json(result);
  } catch (err) {
    next(err);
  }
};

export const eliminarCategoriaProducto = async (req, res, next) => {
  const { id } = req.params;
  try {
    const result = await service.eliminarCategoriaProducto(id);

    if (!result || result.length === 0) {
      console.log(`no existe categoria con el id: ${id} o ya fue eliminada`)
      res.status(404).json({mensaje: `no existe categoria con el id: ${id} o ya fue eliminada`});
    }
  
    res.status(200).json({mensaje: "Categoria a eliminar: ", result});
  } catch (err) {
    next(err);
  }
};