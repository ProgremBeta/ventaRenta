import * as services from './clientes.services.js';

export const obtenerClientes = async (req, res) => {
  try {
    const clientes = await services.obtenerClientes();
    res.status(200).json(clientes);
  } catch (error) {
    console.error("Error al obtener los clientes: ", error);
    res.status(500).json({ error: 'Error al obtener los clientes' });
  }
};

export const obtenerClientePorId = async (req, res) => {
  const { id } = req.params;
  try {
    const cliente = await services.obtenerClientePorId(id);
    if (cliente.length === 0) {
      res.status(404).json({ error: 'Cliente no encontrado' });
    } else {
      res.status(200).json(cliente[0]);
    }
  } catch (error) {
    console.error("Error al obtener el cliente: ", error);
    res.status(500).json({ error: 'Error al obtener el cliente' });
  }
};

export const crearCliente = async (req, res) => {
  const datos = req.body;
  try {
    const nuevoCliente = await services.crearCliente(datos);
    res.status(201).json(nuevoCliente[0]);
  } catch (error) {
    console.error("Error al crear el cliente: ", error);
    res.status(500).json({ error: 'Error al crear el cliente' });
  }
};

export const actualizarCliente = async (req, res) => {
  const { id } = req.params;
  const datos = req.body;
  try {
    const clienteActualizado = await services.actualizarCliente(id, datos);
    if (clienteActualizado.length === 0) {
      res.status(404).json({ error: 'Cliente no encontrado' });
    } else {
      res.status(200).json(clienteActualizado[0]);
    }
  } catch (error) {
    console.error("Error al actualizar el cliente: ", error);
    res.status(500).json({ error: 'Error al actualizar el cliente' });
  }
};

export const eliminarCliente = async (req, res) => {
  const { id } = req.params;
  try {
    const clienteEliminado = await services.eliminarCliente(id);
    if (clienteEliminado.length === 0) {
      res.status(404).json({ error: 'Cliente no encontrado' });
    } else {
      res.status(200).json(clienteEliminado[0]);
    }
  } catch (error) {
    console.error("Error al eliminar el cliente: ", error);
    res.status(500).json({ error: 'Error al eliminar el cliente' });
  }
};