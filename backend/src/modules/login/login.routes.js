import express from 'express';
import * as controller from './login.controller.js';

const router = express.Router();

router.post('/', controller.hacerLogin)

export default router;