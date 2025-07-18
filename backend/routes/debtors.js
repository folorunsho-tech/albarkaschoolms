import express from "express";
const router = express.Router();
// import { PrismaClient } from "@prisma/client";
// const prisma = new PrismaClient();
import prisma from "../lib/prisma.js";
router.get("/", async (req, res) => {
	const debtors = await prisma.tnxItem.findMany({
		where: {
			balance: {
				gt: 0,
			},
			active: true,
		},
		include: {
			transaction: {
				include: {
					student: true,
				},
			},
			fee: true,
		},
		orderBy: {
			updatedAt: "desc",
		},
	});

	res.json(debtors);
});
router.post("/bydate", async (req, res) => {
	const { from, to } = req.body;
	try {
		const found = await prisma.tnxItem.findMany({
			where: {
				AND: [
					{
						updatedAt: {
							gte: new Date(new Date(from).setUTCHours(0, 0, 0, 0)),
						},
					},
					{
						updatedAt: {
							lte: new Date(new Date(to).setUTCHours(23, 59, 59, 999)),
						},
					},
					{
						active: true,
					},
				],
			},
			include: {
				transaction: {
					include: {
						student: true,
					},
				},
				fee: true,
			},
			orderBy: {
				updatedAt: "desc",
			},
		});
		res.status(200).json(found);
	} catch (error) {
		res.status(500).json(error);
		console.log(error);
	}
});
router.post("/bysession", async (req, res) => {
	const { session } = req.body;
	try {
		const found = await prisma.tnxItem.findMany({
			where: {
				session,
				balance: {
					gt: 0,
				},
				active: true,
			},
			include: {
				transaction: {
					include: {
						student: true,
					},
				},
				fee: true,
			},
			orderBy: {
				updatedAt: "desc",
			},
		});
		res.status(200).json(found);
	} catch (error) {
		res.status(500).json(error);
	}
});
router.post("/bysessionnterm", async (req, res) => {
	const { session, term } = req.body;
	try {
		const found = await prisma.tnxItem.findMany({
			where: {
				session,
				term,
				balance: {
					gt: 0,
				},
				active: true,
			},
			include: {
				transaction: {
					include: {
						student: true,
					},
				},
				fee: true,
			},
			orderBy: {
				updatedAt: "desc",
			},
		});
		res.status(200).json(found);
	} catch (error) {
		res.status(500).json(error);
	}
});
export default router;
