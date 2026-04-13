import pool from '../../config/db.config.js';

export const obtenerRentaDispositivos = async () => {
  return await pool.query('SELECT * FROM detalles_rentas');
};

export const obtenerRentaDispositivoPorId = async (id) => {
  return await pool.query('SELECT * FROM detalles_rentas WHERE id =$1', [id]);
};

export const crearRentaDispositivo = async (datos) => {
  return await pool.query(`
    INSERT INTO detalles_rentas (
      renta_id,
      dispositivo_id,
      precio_hora
    ) VALUES ($1, $2, $3) RETURNING *`,
    [
      datos.renta_id,
      datos.dispositivo_id,
      datos.precio_hora
    ]);
};

export const actualizarRentaDispositivo = async (id, datos) => {
  return await pool.query(`
    UPDATE detalles_rentas SET 
      renta_id=$1,
      dispositivo_id=$2,
      precio_hora=$3 
    WHERE id=$4 RETURNING *`,
    [
      datos.renta_id,
      datos.dispositivo_id,
      datos.precio_hora,
      id
    ]);
};

export const eliminarRentaDispositivo = async (id) => {
  return await pool.query('DELETE FROM detalles_rentas WHERE id=$1 RETURNING *', [id]);
};