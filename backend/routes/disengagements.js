import express from "express";
const router = express.Router();
import prisma from "../lib/prisma.js";

router.get("/staffs", async (req, res) => {
	const dises = await prisma.disengagemnets.findMany({
		include: {
			staff: {
				select: {
					first_name: true,
					last_name: true,
					empid: true,
					date_of_emp: true,
					school_section: true,
					telephone: true,

					curr_appointment: true,
					sex: true,
				},
			},
		},
	});
	res.json(dises);
});
router.get("/staffs/:empid", async (req, res) => {
	const dises = await prisma.disengagemnets.findMany({
		where: {
			staff_id: req.params.empid,
		},
		include: {
			staff: {
				select: {
					empid: true,
					first_name: true,
					last_name: true,
					empid: true,
					date_of_emp: true,
					school_section: true,
					telephone: true,

					curr_appointment: true,
					sex: true,
				},
			},
		},
	});
	res.json(dises);
});
router.post("/staffs", async (req, res) => {
	const dis = await prisma.disengagemnets.create({
		data: { ...req.body },
		include: {
			staff: true,
		},
	});
	await prisma.staffs.update({
		where: {
			empid: dis.staff_id,
		},
		data: {
			active: false,
		},
	});
	const isAccount = await prisma.accounts.findFirst({
		where: {
			empid: dis.staff_id,
		},
	});
	if (isAccount) {
		await prisma.accounts.update({
			where: {
				id: isAccount.id,
			},
			data: {
				active: false,
			},
		});
	}
	res.json(dis);
});
router.get("/students", async (req, res) => {
	const dises = await prisma.disengagedstudent.findMany({
		include: {
			student: {
				select: {
					id: true,
					admission_no: true,

					first_name: true,
					last_name: true,
					admission_class: true,
					date_of_admission: true,
					curr_class: true,
					sex: true,
				},
			},
		},
	});
	res.json(dises);
});
router.post("/students/bysession", async (req, res) => {
	const dises = await prisma.disengagedstudent.findMany({
		where: {
			session: req.body.session,
		},
		include: {
			student: {
				select: {
					id: true,
					admission_no: true,

					first_name: true,
					last_name: true,
					admission_class: true,
					date_of_admission: true,
					curr_class: true,
					sex: true,
				},
			},
		},
	});
	res.json(dises);
});
router.get("/students/:students_id", async (req, res) => {
	const dises = await prisma.disengagedstudent.findMany({
		where: {
			student: {
				id: req.params.students_id,
			},
		},
		include: {
			student: {
				select: {
					id: true,
					admission_no: true,
					first_name: true,
					last_name: true,
					admission_class: true,
					date_of_admission: true,
					curr_class: true,
					sex: true,
				},
			},
		},
	});
	res.json(dises);
});
router.post("/students", async (req, res) => {
	const dis = await prisma.disengagedstudent.create({
		data: { ...req.body },
		include: {
			student: true,
		},
	});
	await prisma.students.update({
		where: {
			id: dis.student_id,
		},
		data: {
			active: false,
		},
	});

	res.json(dis);
});

export default router;
