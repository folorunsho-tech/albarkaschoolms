import { Router } from "express";
import bcrypt from "bcryptjs";
import prisma from "../lib/prisma.js";
import { decodeToken, signToken } from "../middlewares/jwt.js";
import { nanoid } from "nanoid";
const router = Router();
router.post("/login", async (req, res) => {
	const { username, password } = req.body;
	try {
		const user = await prisma.accounts.findFirst({
			where: {
				username,
			},
		});
		const compared = await bcrypt.compare(password, user?.passHash);
		if (user?.active && compared) {
			const token = signToken({
				userId: user.id,
				menu: user.permissions,
				role: user.role,
				active: user.active,
				username: user.username,
			});
			// Set cookie
			res.cookie("token", token);
			res.status(200).json({
				token,
				userId: user.id,
				menu: user.permissions,
				role: user.role,
				active: user.active,
				username: user.username,
			});
		} else if (!compared) {
			res.status(401).json({ message: "Invalid Credentials" });
		} else if (!user?.active) {
			res.status(401).json({ message: "Account is inactive" });
		}
	} catch (error) {
		console.error(error);
		res.status(500).json(error);
	}
});
router.post("/revoke/:accId", async (req, res) => {
	try {
		const updated = await prisma.accounts.update({
			where: {
				id: req.params.accId,
			},
			data: {
				active: false,
			},
		});
		res.json(updated);
	} catch (error) {
		res.status(500).json(error);
	}
});
router.post("/allow/:accId", async (req, res) => {
	try {
		const updated = await prisma.accounts.update({
			where: {
				id: req.params.accId,
			},
			data: {
				active: true,
			},
		});
		res.json(updated);
	} catch (error) {
		res.status(500).json(error);
	}
});
router.post("/logout", (req, res) => {
	res.clearCookie("token");
	res.json({ message: "Logged out" });
});
router.get("/:account_id/basic", async (req, res) => {
	try {
		const found = await prisma.accounts.findUnique({
			where: {
				id: req.params.account_id,
			},
			select: {
				permissions: true,
				id: true,
				active: true,
				name: true,
				username: true,
				role: true,
			},
		});
		res.status(200).json(found);
	} catch (error) {
		res.status(500).json(error);
	}
});
router.get("/me", async (req, res) => {
	const token = req.cookies.token;
	try {
		const returned = decodeToken(token);
		if (!returned) {
			res.status(401).json({ message: "Invalid Token" });
		} else {
			res.json(returned);
		}
	} catch (error) {
		res.status(500).json(error);
		console.log(error);
	}
});
router.post("/register", async (req, res) => {
	try {
		const { username, password, permissions, role } = req.body;
		const passHash = await bcrypt.hash(password, 10);
		const created = await prisma.accounts.create({
			data: {
				id: nanoid(),
				username,
				permissions,
				passHash,
				role,
			},
		});
		res.status(200).json(created);
	} catch (error) {
		res.status(500).json(error);
		console.log(error);
	}
});
export default router;
