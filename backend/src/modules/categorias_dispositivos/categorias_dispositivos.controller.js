import * as service from './categorias_dispositivos.service.js';

export const obtenerCategoriasDispositivos = async (req, res, next) => {
  try {
    const result = await service.obtenerCategoriasDispositivos();
    
    if (result.length === 0) {
      console.log("No existen categorias");
      return res.status(200).json({ mensaje: "No existen categorias" });
    }

    res.status(200).json(result);
  } catch (err) {
    console.log("Error en el controller de obtener categorias del dispositivos: ", err)
    next(err);
  }
};

export const obtenerCategoriaDispositivoPorId = async (req, res, next) => {
  const { id } = req.params;
  try {
    const result = await service.obtenerCategoriaDispositivoPorId(id);

    if (result.length === 0) {
      console.log(`No se encontró la categoría de dispositivo con ID ${id}`);
      return res.status(200).json({ "mensaje": `No se encontró la categoría de dispositivo con ID ${id}`});
    }

    res.status(200).json(result);

  } catch (err) {
    console.log("Error en el controller de obtener categoria del dispositivo por el id: ", err)
    next(err);
  }
};

export const crearCategoriaDispositivo = async (req, res, next) => {
  const datos = req.body;
  try {
    if (!datos) { res.status(200).json({mensaje : "no ingresastes datos"})}
    if (!datos.nombre) { res.status(200).json({mensaje : "no ingresastes nombre para la categoria"})}

    const result = await service.crearCategoriaDispositivo(datos);
    
    res.status(201).json(result);
  } catch (err) {
    console.log("Error en el controller de crear categoria del dispositivo: ", err)
    next(err);
  }
};

export const actualizarCategoriaDispositivo = async (req, res, next) => {
  const { id } = req.params;
  const datos = req.body;
  try {
    if (!id) {
      console.log(`No se encontro el ID`);
      res.status(200).json({ error: "No se ingreso ID" });
    }

    if(!datos)
    {
      console.log(`No se ingreso datos para actualizar la categoria`);
      return res.status(200).json({ error: "No se ingreso datos para actualizar la categoria" });
    }

    const result = await service.actualizarCategoriaDispositivo(id, datos);
    
    res.status(201).json(result);

  } catch (err) {
    console.log("Error en el controller al actualizar la categoria del dispositivo: ", err)
    next(err);
  }
};

export const eliminarCategoriaDispositivo = async (req, res, next) => {
  const { id } = req.params;
  try {
    const result = await service.eliminarCategoriaDispositivo(id);
    
    if (!result) {
      console.log(`No se encontró la categoría de dispositivo con ID ${id} para eliminar`);
      return res.status(200).json({ error: "Categoría de dispositivo no encontrada" });
    }

    if (result.length === 0) { 
      console.log("La categoria no existe o ya fue eliminada")
      return res.status(200).json({ error: "La categoria no existe o ya fue eliminada" });
    }
    
    res.status(200).json(result);

  } catch (err) {
    console.log("Error en el controller de eliminar categoria del dispositivo: ", err)
    next(err);
  }
};