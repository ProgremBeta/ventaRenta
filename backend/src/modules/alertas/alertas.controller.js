import * as services from './alertas.service.js';

/* encargado de enviar los datos y gestionar el estado de la peticion HTTP */

export const obtenerAlertas = async (req, res) => {
  try {
    const result = await services.obtenerAlertas()
    res.status(200).json(result);

  } catch (err) {
    console.error("error al obtener alertas: ", err);
    res.status(400).json({ mensaje: "error al obtener las alertas" })
  }
}

export const obtenerAlertaPorId = async (req, res) => {
  const { id } = req.params;
  try {
    const result = await services.obtenerAlertasPorId(id);
    if (result.length === 0) {
      res.status(404).json({ mensaje: "Alerta no encontrada" });
    } else {
      res.status(200).json(result[0]);
    }
  } catch (err) {
    console.error("Error al obtener la alerta: ", err);
    res.status(500).json({ error: 'Error al obtener la alerta' });
  }
};

export const crearAlerta = async (req, res) => {
  const datos = req.body;
  try {
    const result = await services.crearAlertas(datos);
    res.status(201).json(result);
  } catch (err) {
    console.error("Error al crear la alerta: ", err);
    res.status(500).json({ error: 'Error al crear la alerta' });
  }
};

export const actualizarAlerta = async (req, res) => {
  const { id } = req.params;
  const datos = req.body;
  try {
    const result = await services.actualizarAlerta(id, datos);
    if (result.length === 0) {
      res.status(404).json({ mensaje: "Alerta no encontrada" });
    } else {
      res.status(200).json(result);
    }
  } catch (err) {
    console.error("Error al actualizar la alerta: ", err);
    res.status(500).json({ error: 'Error al actualizar la alerta' });
  }
};

export const eliminarAlerta = async (req, res) => {
  const { id } = req.params;
  try {
    const result = await services.eliminarAlerta(id);
    if (result.length === 0) {
      res.status(404).json({ mensaje: "Alerta no encontrada" });
    } else {
      res.status(200).json(result);
    }
  } catch (err) {
    console.error("Error al eliminar la alerta: ", err);
    res.status(500).json({ error: 'Error al eliminar la alerta' });
  }
};