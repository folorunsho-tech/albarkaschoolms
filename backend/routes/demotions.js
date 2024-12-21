import { nanoid } from "nanoid";

import express from "express";
const router = express.Router();
import { PrismaClient } from "@prisma/client";
const prisma = new PrismaClient();

router.get("/staffs", async (req, res) => {
	const demotions = await prisma.demotions.findMany({
		orderBy: {
			demotedOn: "desc",
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
	res.json(demotions);
});
router.get("/staffs/:empid", async (req, res) => {
	const demotions = await prisma.demotions.findMany({
		where: {
			staff_id: req.params.empid,
		},
		orderBy: {
			demotedOn: "desc",
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
	res.json(demotions);
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
	const created = await prisma.demotions.create({
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
	const demotions = await prisma.studentsDemotions.findMany({
		orderBy: {
			demotedOn: "desc",
		},
		include: {
			student: true,
			to: true,
		},
	});
	res.json(demotions);
});
router.get("/students/:student_id", async (req, res) => {
	const demotions = await prisma.studentsDemotions.findMany({
		where: {
			student: {
				id: req.params.student_id,
			},
		},
		orderBy: {
			demotedOn: "desc",
		},
		include: {
			student: true,
			to: true,
		},
	});
	res.json(demotions);
});

router.post("/students/create", async (req, res) => {
	const { session } = req.body;
	const created = await prisma.studentsDemotions.create({
		data: {
			id: nanoid(7),
			...req.body,
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
