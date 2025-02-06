import express from "express";
const router = express.Router();
// import { PrismaClient } from "@prisma/client";
// const prisma = new PrismaClient();
import prisma from "../lib/prisma.js";
router.get("/", async (req, res) => {
	const payments = await prisma.payments.findMany({
		include: {
			item: true,
			transaction: {
				include: {
					student: true,
				},
			},
		},
		orderBy: {
			createdAt: "desc",
		},
	});

	res.json(payments);
});
router.post("/bydate", async (req, res) => {
	const { from, to } = req.body;
	try {
		const found = await prisma.payments.findMany({
			where: {
				AND: [
					{
						createdAt: {
							gte: new Date(new Date(from).setUTCHours(0, 0, 0, 0)),
						},
					},
					{
						createdAt: {
							lte: new Date(new Date(to).setUTCHours(0, 0, 0, 0)),
						},
					},
				],
			},
			include: {
				item: true,
				transaction: {
					include: {
						student: true,
					},
				},
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
		const found = await prisma.payments.findMany({
			where: {
				session,
			},
			include: {
				item: true,
				transaction: {
					include: {
						student: true,
					},
				},
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
		const found = await prisma.payments.findMany({
			where: {
				session,
				term,
			},
			include: {
				item: true,
				transaction: {
					include: {
						student: true,
					},
				},
			},
		});
		res.status(200).json(found);
	} catch (error) {
		res.status(500).json(error);
	}
});
export default router;
