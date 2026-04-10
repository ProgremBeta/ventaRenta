import pg from 'pg';
import dotenv from 'dotenv';

dotenv.config();

const pool = new pg.Pool({
  user: process.env.DB_USER,
  host: process.env.DB_HOST,
  database: process.env.DB_NAME,
  password: process.env.DB_PASSWORD,
  port: process.env.DB_PORT,
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