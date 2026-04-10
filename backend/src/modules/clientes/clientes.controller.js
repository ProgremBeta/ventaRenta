import * as services from './clientes.service.js';

export const obtenerClientes = async (req, res) => {
  try {
    const result = await services.obtenerClientes();
    res.status(200).json(result);
  } catch (err) {
    console.error("Error al obtener los clientes: ", err);
    res.status(400).json({ error: 'Error al obtener los clientes' });
  }
};

export const obtenerClientePorId = async (req, res) => {
  const { id } = req.params;
  try {
    const result = await services.obtenerClientePorId(id);
    if (result.length === 0) {
      res.status(404).json({ error: 'Cliente no encontrado' });
    } else {
      res.status(200).json(result[0]);
    }
  } catch (err) {
    console.error("Error al obtener el cliente: ", err);
    res.status(400).json({ error: 'Error al obtener el cliente' });
  }
};

export const crearCliente = async (req, res) => {
  const datos = req.body;
  try {
    const result = await services.crearCliente(datos);
    res.status(201).json(result[0]);
  } catch (err) {
    console.error("Error al crear el cliente: ", err);
    res.status(400).json({ error: 'Error al crear el cliente' });
  }
};

export const actualizarCliente = async (req, res) => {
  const { id } = req.params;
  const datos = req.body;
  try {
    const result = await services.actualizarCliente(id, datos);
    if (result.length === 0) {
      res.status(404).json({ error: 'Cliente no encontrado' });
    } else {
      res.status(200).json(clienteActualizado[0]);
    }
  } catch (err) {
    console.error("Error al actualizar el cliente: ", err);
    res.status(400).json({ error: 'Error al actualizar el cliente' });
  }
};

export const eliminarCliente = async (req, res) => {
  const { id } = req.params;
  try {
    const result = await services.eliminarCliente(id);
    if (result.length === 0) {
      res.status(404).json({ error: 'Cliente no encontrado' });
    } else {
      res.status(200).json(result[0]);
    }
  } catch (err) {
    console.error("Error al eliminar el cliente: ", err);
    res.status(400).json({ error: 'Error al eliminar el cliente' });
  }
};