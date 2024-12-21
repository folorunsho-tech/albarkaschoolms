import jwt from "jsonwebtoken";
const secret = process.env.SECRET;
function authorize(req, res, next) {
	const token = req.headers["authorization"];
	if (!token) {
		return res.status(401).json({ message: "Access denied" });
	}

	jwt.verify(token, secret, (err, user) => {
		if (err) {
			return res.status(403).json({ message: "Invalid token" });
		}
		req.user = user;
		next();
	});
}

export default authorize;
