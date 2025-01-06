import { nanoid } from "nanoid";

import express from "express";
const router = express.Router();
import { PrismaClient } from "@prisma/client";
const prisma = new PrismaClient();

router.get("/staffs", async (req, res) => {
	const promotions = await prisma.promotions.findMany({
		orderBy: {
			promotedOn: "desc",
		},
		include: {
			staff: {
				select: {
					first_name: true,
					last_name: true,
					empid: true,
				},
			},
			to: true,
		},
	});
	res.json(promotions);
});
router.get("/staffs/:empid", async (req, res) => {
	const promotions = await prisma.promotions.findMany({
		where: {
			staff_id: req.params.empid,
		},
		orderBy: {
			promotedOn: "desc",
		},
		include: {
			staff: {
				select: {
					first_name: true,
					last_name: true,
					empid: true,
				},
			},
			to: true,
		},
	});
	res.json(promotions);
});

router.post("/staffs/create", async (req, res) => {
	const {
		staff_id,
		from,
		from_section,
		to_section,
		prev_salary,
		curr_salary,
		to_id,
	} = req.body;
	const created = await prisma.promotions.create({
		data: {
			id: nanoid(7),
			staff_id,
			from,
			from_section,
			prev_salary,
			curr_salary,
			to_id,
		},
	});
	await prisma.staffs.update({
		where: {
			empid: created.staff_id,
		},
		data: {
			curr_appointment_id: created.to_id,
			salary: created.curr_salary,
			school_section: to_section,
		},
	});
	res.json(created);
});

router.get("/students", async (req, res) => {
	const promotions = await prisma.studentsPromotions.findMany({
		orderBy: {
			promotedOn: "desc",
		},
		include: {
			student: true,
			to: true,
		},
	});
	res.json(promotions);
});
router.post("/students/bysession", async (req, res) => {
	const { session } = req.body;
	const promotions = await prisma.studentsPromotions.findMany({
		where: {
			session,
		},
		orderBy: {
			promotedOn: "desc",
		},
		include: {
			student: true,
			to: true,
		},
	});
	res.json(promotions);
});
router.get("/students/:student_id", async (req, res) => {
	const promotions = await prisma.studentsPromotions.findMany({
		where: {
			student: {
				id: req.params.student_id,
			},
		},
		orderBy: {
			promotedOn: "desc",
		},
		include: {
			student: true,
			to: true,
		},
	});
	res.json(promotions);
});

router.post("/students/create", async (req, res) => {
	const { session } = req.body;
	const created = await prisma.studentsPromotions.create({
		data: {
			id: nanoid(7),
			...req.body,
		},
		include: {
			student: true,
			to: true,
		},
	});
	const updated = await prisma.students.update({
		where: {
			id: created.student_id,
		},
		data: {
			curr_class_id: created.to_id,
		},
	});
	const connectHistory = await prisma.classHistory.create({
		data: {
			student_id: updated?.id,
			class_id: updated?.curr_class_id,
			session,
		},
	});
	res.json({ created, connectHistory });
});

export default router;
