import test from 'node:test';
import assert from 'node:assert';
import request from 'supertest';
import app from '../src/app.js';
import pool from '../src/config/db.config.js';

const IDENTIFICACION = '999999999999';
const CONTRASENA = '999999999999';
const EMAIL = 'test_999999999999@test.com';

let token;
let usuarioId;
let categoriaId;
let productoId;
let ventaId;

test('Flujo completo: crear usuario, login, categoria, producto y venta', async (t) => {

  await t.test('1. POST /api/nuevo_usuario — crear usuario', async () => {
    const res = await request(app)
      .post('/api/nuevo_usuario')
      .send({
        identificacion: IDENTIFICACION,
        nombre: 'Usuario Test',
        email: EMAIL,
        telefono: '9999999999',
        contrasena_hash: CONTRASENA,
      });

    assert.strictEqual(res.status, 200);
    usuarioId = res.body[0]?.id ?? res.body.id;
    assert.ok(usuarioId, 'Debe devolver un id de usuario');
  });

  await t.test('2. POST /api/login — login con credenciales test', async () => {
    const res = await request(app)
      .post('/api/login')
      .send({
        identificacion: IDENTIFICACION,
        contrasena_hash: CONTRASENA,
      });

    assert.strictEqual(res.status, 200);
    token = res.body.token;
    assert.ok(token, 'Debe devolver un token JWT');
  });

  await t.test('3. POST /api/categorias_productos — crear categoria', async () => {
    const res = await request(app)
      .post('/api/categorias_productos')
      .set('Authorization', `Bearer ${token}`)
      .send({
        nombre: 'Categoria Test 999',
        descripcion: 'Categoria creada para test',
      });

    assert.strictEqual(res.status, 201);
    categoriaId = res.body[0]?.id ?? res.body.id;
    assert.ok(categoriaId, 'Debe devolver un id de categoria');
  });

  await t.test('4. POST /api/nuevo_producto — crear producto', async () => {
    const res = await request(app)
      .post('/api/nuevo_producto')
      .set('Authorization', `Bearer ${token}`)
      .send({
        nombre: 'Producto Test 999',
        descripcion: 'Producto creado para test',
        precio: 999.99,
        categoria_id: categoriaId,
        stock: 100,
      });

    assert.strictEqual(res.status, 200);
    productoId = res.body[0]?.id ?? res.body.id;
    assert.ok(productoId, 'Debe devolver un id de producto');
  });

  await t.test('5. POST /api/nueva_venta — crear venta', async () => {
    const res = await request(app)
      .post('/api/nueva_venta')
      .set('Authorization', `Bearer ${token}`)
      .send({
        usuario_id: usuarioId,
        metodo_pago: 1,
        detalles: [{ producto_id: productoId, cantidad: 1 }],
      });

    assert.strictEqual(res.status, 200);
    ventaId = res.body[0]?.id ?? res.body.id;
    assert.ok(ventaId, 'Debe devolver un id de venta');
  });
});

test.after('Limpiar datos de prueba', async () => {
  try {
    if (ventaId) await pool.query('DELETE FROM detalles_ventas WHERE venta_id = $1', [ventaId]);
    if (ventaId) await pool.query('DELETE FROM ventas WHERE id = $1', [ventaId]);
    if (productoId) await pool.query('DELETE FROM inventario_productos WHERE producto_id = $1', [productoId]);
    if (productoId) await pool.query('DELETE FROM productos WHERE id = $1', [productoId]);
    if (categoriaId) await pool.query('DELETE FROM categorias_productos WHERE id = $1', [categoriaId]);
    if (usuarioId) await pool.query('DELETE FROM usuarios WHERE id = $1', [usuarioId]);
    console.log('Datos de prueba eliminados correctamente');
  } catch (err) {
    console.error('Error limpiando datos de prueba:', err.message);
  }
});
