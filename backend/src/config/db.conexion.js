import pool from './db.config.js';

const connectDB = async () => {
  try {
    console.log("conectando a la base de datos...");
    const client = await pool.connect();
    console.log("Conexión exitosa a la base de datos");
    client.release();
  } catch (error) {
    console.error('Error connecting to the database:', error);
    process.exit(1);
  }
}

export default connectDB;