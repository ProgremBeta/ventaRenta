import Pool from "./../../config/db.config.js";

export const obtenerCategoriasDispositivos = async () => {
  return await Pool.query("SELECT * FROM categorias_dispositivo");
};

export const obtenerCategoriaDispositivoPorId = async (id) => {
  return await Pool.query("SELECT * FROM categorias_dispositivo WHERE id = $1", [id]);
};

export const crearCategoriaDispositivo = async (datos) => {
  return await Pool.query("INSERT INTO categorias_dispositivo (nombre) VALUES ($1) RETURNING *", [datos.nombre]);
};

export const actualizarCategoriaDispositivo = async (id, datos) => {
  return await Pool.query("UPDATE categorias_dispositivo SET nombre = $1 WHERE id = $2 RETURNING *", [datos.nombre, id]);
};

export const eliminarCategoriaDispositivo = async (id) => {
  return await Pool.query("DELETE FROM categorias_dispositivo WHERE id = $1 RETURNING *", [id]);
};