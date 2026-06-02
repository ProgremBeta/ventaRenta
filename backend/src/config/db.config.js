import pg from 'pg';
import dotenv from 'dotenv';

dotenv.config();
console.log("Variables de entorno cargadas, db.config.js ")

const BD_URL = process.env.DATABASE_URL;

let pool

if (!BD_URL || BD_URL.length === 0 ) 
  {     
    console.log("no existe conexion con la base de datos DESPLEGADA")

    pool = new pg.Pool({
      user: process.env.DB_USER,
      host: process.env.DB_HOST,
      database: process.env.DB_NAME,
      password: process.env.DB_PASSWORD,
      port: process.env.DB_PORT
    });

  }else{
    pool = new pg.Pool({
      connectionString: BD_URL,
      ssl: {
        rejectUnauthorized: false
      }
    });
  }



async () => {
  try {
    console.log("conectando a la base de datos...");
    const client = await pool.connect();
    console.log("Conexión exitosa a la base de datos");

    if (!BD_URL || BD_URL.lenght === 0 ) 
    { 
      new Error("no existe conexion con la base de datos")
    }

    client.release();
  } catch (error) {
    console.error('Error connecting to the database:', error);
    process.exit(1);
  }
}

export default pool;