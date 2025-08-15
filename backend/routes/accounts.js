import { nanoid } from "nanoid";
import express from "express";
import prisma from "../lib/prisma.js";
import bcrypt from "bcryptjs";
// import { authMiddleware } from "../middlewares/authMiddleware.js";
const router = express.Router();
router.get("/", async (req, res) => {
	try {
		const accounts = await prisma.accounts.findMany({
			orderBy: {
				name: "asc",
			},
		});
		res.status(200).json(accounts);
	} catch (error) {
		res.status(500).json(error);
	}
});
router.get("/:accountId", async (req, res) => {
	try {
		const account = await prisma.accounts.findUnique({
			where: {
				id: req.params.accountId,
			},
		});
		res.status(200).json(account);
	} catch (error) {
		res.status(500).json(error);
	}
});
router.post("/create", async (req, res) => {
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
router.get("/:account_id/basic", async (req, res) => {
	try {
		const found = await prisma.accounts.findUnique({
			where: {
				id: req.params.account_id,
			},
		});
		res.status(200).json(found);
	} catch (error) {
		res.status(500).json(error);
		console.log(error);
	}
});
router.post("/edit/:accountId", async (req, res) => {
	const { username, password, permissions, updatedById, role } = req.body;
	try {
		if (password) {
			const passHash = await bcrypt.hash(password, 10);
			const edited = await prisma.accounts.update({
				where: {
					id: req.params.accountId,
				},
				data: {
					username,
					permissions,
					passHash,
					updatedById,
					role,
				},
			});
			res.json(edited);
		} else {
			const edited = await prisma.accounts.update({
				where: {
					id: req.params.accountId,
				},
				data: {
					username,
					permissions,
					updatedById,
					role,
				},
			});
			res.json(edited);
		}
	} catch (error) {
		res.status(500).json(error);
		console.log(error);
	}
});
router.post("/many", async (req, res) => {
	const created = await prisma.accounts.createMany({
		data: [...req.body],
	});
	res.json(created);
});
export default router;
