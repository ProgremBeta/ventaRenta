import * as service from './deudas.service.js';

export const obtenerDeudas = async (req, res, next) => {
    try {
        const result = await service.obtenerDeudas()
        if (!result || result.length == 0) {
            return res.status(404).json({ message: 'No existen deudas' });
        }
        console.log("en controller: ", result)
        return res.status(200).json(result);
    } catch (err) {
        next(err);
    }
}