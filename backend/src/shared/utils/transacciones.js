import pool from '../../config/db.config.js';

async function transaccionesDB(callback) {
  const client = await pool.connect();

  try {
    // Iniciar la transacción
    await client.query('BEGIN');

    // Ejecutar el procedimiento proporcionado por el usuario
    const result = await callback(client);

    // Confirmar la transacción si no hay errores
    await client.query('COMMIT');

    return result;

  } catch (err) {
    // En caso de error, hacer rollback
    await client.query('ROLLBACK');
    throw err; // Re-lanzar el error para que sea manejado por el llamador
  } finally {
    // Liberar el cliente de vuelta al pool
    client.release();
  }
}

export default transaccionesDB;