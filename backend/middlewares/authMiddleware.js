import { verifyToken } from "../middlewares/jwt.js";
export const authMiddleware = (req, res, next) => {
	const token = req.cookies?.token;
	try {
		verifyToken(token, res, next);
	} catch (err) {
		console.log(err);
		res.status(401).json(err);
	}
};
