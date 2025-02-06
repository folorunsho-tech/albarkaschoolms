import express from "express";
const router = express.Router();
import prisma from "../lib/prisma.js";
// import { PrismaClient } from "@prisma/client";
// const prisma = new PrismaClient();
router.get("/:tnxId", async (req, res) => {
	try {
		const found = await prisma.transactions.findUnique({
			where: {
				tnxId: Number(req.params.tnxId),
			},
			include: {
				student: {
					include: {
						curr_class: true,
					},
				},
				items: {
					include: {
						item: true,
					},
				},
				createdBy: {
					select: {
						name: true,
						username: true,
					},
				},
			},
		});
		const updatedBy = await prisma.accounts.findUnique({
			where: {
				id: found.updatedById,
			},
			select: {
				name: true,
				id: true,
				username: true,
			},
		});
		res.status(200).json({ tnx: found, updatedBy });
	} catch (error) {
		res.status(500).json(error);
		console.log(error);
	}
});
router.get("/history/:tnxId", async (req, res) => {
	try {
		const found = await prisma.transactionHistory.findMany({
			where: {
				tnxId: Number(req.params.tnxId),
			},
			include: {
				student: {
					include: {
						curr_class: true,
					},
				},
				createdBy: {
					select: {
						name: true,
						username: true,
					},
				},
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
router.get("/", async (req, res) => {
	try {
		const found = await prisma.transactions.findMany({
			where: {
				NOT: {
					status: "Cancelled",
				},
			},
			include: {
				student: true,
				items: true,
				createdBy: {
					select: {
						name: true,
						username: true,
					},
				},
				_count: {
					select: {
						items: true,
					},
				},
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
router.post("/bydate", async (req, res) => {
	const { from, to } = req.body;
	try {
		const found = await prisma.transactions.findMany({
			where: {
				AND: [
					{
						updatedAt: {
							gte: new Date(new Date(from).setUTCHours(0, 0, 0, 0)),
						},
					},
					{
						updatedAt: {
							lte: new Date(new Date(to).setUTCHours(0, 0, 0, 0)),
						},
					},
				],
			},
			include: {
				student: true,
				items: true,
				createdBy: {
					select: {
						name: true,
						username: true,
					},
				},
				_count: {
					select: {
						items: true,
					},
				},
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
router.post("/bysession", async (req, res) => {
	const { session } = req.body;
	try {
		const found = await prisma.transactions.findMany({
			where: {
				session,
			},
			include: {
				student: true,
				items: true,
				createdBy: {
					select: {
						name: true,
						username: true,
					},
				},
				_count: {
					select: {
						items: true,
					},
				},
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
		const found = await prisma.transactions.findMany({
			where: {
				session,
				term,
			},
			include: {
				student: true,
				items: true,
				createdBy: {
					select: {
						name: true,
						username: true,
					},
				},
				_count: {
					select: {
						items: true,
					},
				},
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
router.post("/active/bysession", async (req, res) => {
	const { session } = req.body;
	try {
		const found = await prisma.transactions.findMany({
			where: {
				NOT: {
					status: "Cancelled",
				},
				session,
			},
			include: {
				student: true,
				items: true,
				createdBy: {
					select: {
						name: true,
						username: true,
					},
				},
				_count: {
					select: {
						items: true,
					},
				},
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
router.post("/active/bysessionnterm", async (req, res) => {
	const { session, term } = req.body;
	try {
		const found = await prisma.transactions.findMany({
			where: {
				NOT: {
					status: "Cancelled",
				},
				session,
				term,
			},
			include: {
				student: true,
				items: true,
				createdBy: {
					select: {
						name: true,
						username: true,
					},
				},
				_count: {
					select: {
						items: true,
					},
				},
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
router.post("/cancelled/bysession", async (req, res) => {
	const { session } = req.body;
	try {
		const found = await prisma.transactions.findMany({
			where: {
				status: "Cancelled",
				session,
			},
			include: {
				student: true,
				items: true,
				createdBy: {
					select: {
						name: true,
						username: true,
					},
				},
				_count: {
					select: {
						items: true,
					},
				},
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
router.post("/cancelled/bysessionnterm", async (req, res) => {
	const { session, term } = req.body;
	try {
		const found = await prisma.transactions.findMany({
			where: {
				status: "Cancelled",
				session,
				term,
			},
			include: {
				student: true,
				items: true,
				createdBy: {
					select: {
						name: true,
						username: true,
					},
				},
				_count: {
					select: {
						items: true,
					},
				},
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

router.post("/create", async (req, res) => {
	try {
		const created = await prisma.transactions.create({
			data: {
				...req.body,
				items: {
					createMany: {
						data: req.body.items,
					},
				},
			},
			include: {
				items: {
					include: {
						item: true,
					},
				},
				student: true,
				createdBy: true,
			},
		});

		await prisma.transactionHistory.create({
			data: {
				tnxId: created.tnxId,
				student_id: created.student_id,
				items: JSON.stringify(created.items),
				status: created.status,
				term: created.term,
				session: created.session,
				total: created.total,
				class: created.class,
				paid: created.paid,
				createdById: created.createdById,
			},
		});
		res.status(200).json(created);
	} catch (error) {
		res.status(500).json(error);
	}
});
router.post("/cancel/:tnxId", async (req, res) => {
	try {
		const cancelledP = await prisma.payments.findMany({
			where: {
				transactionId: req.params.tnxId,
			},
		});
		const toCancel = cancelledP.map((p) => {
			return {
				where: {
					payment_id: p.payment_id,
				},
				data: {
					status: "Cancelled",
				},
			};
		});
		const cancelled = await prisma.transactions.update({
			where: {
				tnxId: Number(req.params.tnxId),
			},
			data: {
				status: "Cancelled",
				items: {
					updateMany: toCancel,
				},
			},
		});
		res.status(200).json(cancelled);
	} catch (error) {
		res.status(500).json(error);
	}
});
router.post("/balance/:tnxId", async (req, res) => {
	const { histItems, items } = req.body;
	try {
		items?.forEach(async (item) => {
			return await prisma.payments.update({
				where: {
					payment_id: item?.payment_id,
				},
				data: {
					paid: item?.paid,
					amount: item?.amount,
					status: item?.status,
					payment_method: item?.payment_method,
					teller_no: item?.teller_no,
				},
			});
		});
		const created = await prisma.transactions.update({
			where: {
				tnxId: Number(req.params.tnxId),
			},
			data: {
				paid: req.body.paid,
				total: req.body.total,
				status: req.body.status,
				updatedById: req.body.updatedById,
			},
		});
		const hist = await prisma.transactionHistory.create({
			data: {
				tnxId: created.tnxId,
				student_id: created.student_id,
				items: JSON.stringify(histItems),
				paid: created.paid,
				status: created.status,
				term: created.term,
				session: created.session,
				total: created.total,
				class: created.class,
				createdById: created.updatedById,
			},
			include: {
				student: true,
				createdBy: true,
			},
		});
		res.status(200).json({ ...hist, items: JSON.parse(hist.items) });
	} catch (error) {
		res.status(500).json(error);
		// console.log(error);
	}
});
export default router;
