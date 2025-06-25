import { nanoid } from "nanoid";
import express from "express";
import prisma from "../lib/prisma.js";
// import { PrismaClient } from "@prisma/client";
// const prisma = new PrismaClient();
const { createHash } = await import("node:crypto");
const router = express.Router();
const hashpass = (password) => {
	return createHash("sha256").update(password).digest("hex");
};
router.get("/", async (req, res) => {
	try {
		const accounts = await prisma.accounts.findMany({
			where: {
				NOT: [{ empid: "EMP0000" }, { empid: "EMP0001" }],
			},
			include: {
				staff: {
					select: {
						curr_appointment: {
							select: {
								name: true,
							},
						},
						empid: true,
					},
				},
			},

			orderBy: {
				empid: "asc",
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
		const { name, username, password, permissions, empid, role } = req.body;
		const passHash = hashpass(password);
		const created = await prisma.accounts.create({
			data: {
				id: nanoid(7),
				name,
				username,
				permissions,
				passHash,
				empid,
				role,
			},
		});

		res.status(200).json(created);
	} catch (error) {
		res.status(500).json(error);
		// console.log(error);
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
	}
});
router.post("/edit/:accountId", async (req, res) => {
	try {
		const { name, username, password, permissions, empid, updatedById, role } =
			req.body;
		const passHash = hashpass(password);
		const edited = await prisma.accounts.update({
			where: {
				id: req.params.accountId,
			},
			data: {
				name,
				username,
				permissions,
				passHash,
				empid,
				updatedById,
				role,
			},
		});
		res.json(edited);
	} catch (error) {
		res.status(500).json(error);
	}
});
router.post("/many", async (req, res) => {
	const created = await prisma.accounts.createMany({
		data: [...req.body],
	});
	res.json(created);
});
export default router;
