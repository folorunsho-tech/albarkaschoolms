import jwt from "jsonwebtoken";
export function verifyToken(token, res, next) {
	try {
		jwt.verify(token, process.env.JWT_SECRET);
		next();
	} catch (error) {
		console.log(error);
		res.status(401).json({ message: "Invalid token" });
	}
}
export function signToken(payload) {
	return jwt.sign(payload, process.env.JWT_SECRET, {
		expiresIn: "10h",
	});
}

export function decodeToken(token) {
	return jwt.decode(token);
}
