import pg from 'pg';
import dotenv from 'dotenv';

dotenv.config();
console.log("Variables de entorno cargadas, db.config.js ")

const BD_URL = process.env.DATABASE_URL;

const pool = new pg.Pool({
  connectionString: BD_URL,
  ssl: {
    rejectUnauthorized: false
  }
});

async () => {
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

export default pool;