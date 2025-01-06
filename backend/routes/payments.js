import express from "express";
const router = express.Router();
import { PrismaClient } from "@prisma/client";
const prisma = new PrismaClient();
import { invoiceIdGen } from "../lib/idGenerator.js";
router.get("/reversed", async (req, res) => {
	const payments = await prisma.payments.findMany({
		where: {
			status: "Cancelled",
		},
		include: {
			student: {
				select: {
					first_name: true,
					last_name: true,
					admission_no: true,
				},
			},
		},
		orderBy: {
			updatedAt: "desc",
		},
	});

	res.json(payments);
});
router.get("/", async (req, res) => {
	const payments = await prisma.payments.findMany({
		where: {
			NOT: [
				{
					status: "Cancelled",
				},
			],
		},
		include: {
			student: {
				select: {
					first_name: true,
					last_name: true,
					admission_no: true,
				},
			},
		},
		orderBy: {
			updatedAt: "desc",
		},
	});

	res.json(payments);
});
router.get("/bysession", async (req, res) => {
	const payments = await prisma.payments.findMany({
		where: {
			NOT: {
				status: "Cancelled",
			},

			session: req.body.session,
		},
		include: {
			student: {
				select: {
					first_name: true,
					last_name: true,
					admission_no: true,
				},
			},
		},
		orderBy: {
			updatedAt: "desc",
		},
	});

	res.json(payments);
});
router.get("/:paymentId", async (req, res) => {
	const payment = await prisma.payments.findUnique({
		where: {
			payment_id: req.params.paymentId,
		},
	});
	res.json(payment);
});
router.get("/history/:student_id", async (req, res) => {
	const payment = await prisma.payments.findMany({
		where: {
			student_id: req.params.student_id,
		},
		include: {
			student: {
				select: {
					first_name: true,
					last_name: true,
					admission_no: true,
				},
			},
		},
	});
	res.json(payment);
});
router.post("/create", async (req, res) => {
	const created = await prisma.payments.create({
		data: {
			payment_id: await invoiceIdGen(),
			...req.body,
		},
	});
	res.json(created);
});

router.post("/edit/:paymentId", async (req, res) => {
	const edited = await prisma.payments.update({
		where: {
			payment_id: req.params.paymentId,
		},
		data: req.body,
	});
	res.json(edited);
});
router.post("/reverse/:paymentId", async (req, res) => {
	const edited = await prisma.payments.update({
		where: {
			payment_id: req.params.paymentId,
		},
		data: {
			status: "Cancelled",
		},
	});
	res.json(edited);
});

export default router;
