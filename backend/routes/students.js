import express from "express";
const router = express.Router();
import prisma from "../lib/prisma.js";
// import { PrismaClient } from "@prisma/client";
// const prisma = new PrismaClient();
import { nanoid } from "nanoid";

router.get("/", async (req, res) => {
	const students = await prisma.students.findMany({
		where: {
			active: true,
		},
		include: {
			curr_class: true,
		},
		// orderBy: {
		// 	updatedAt: "desc",
		// },
	});
	res.json(students);
});
router.get("/all", async (req, res) => {
	const students = await prisma.students.findMany({});
	res.json(students);
});
router.get("/fees", async (req, res) => {
	const students = await prisma.students.findMany({
		where: {
			active: true,
		},
		include: {
			curr_class: {
				include: {
					fees: true,
				},
			},
			transactions: true,
		},
		orderBy: {
			updatedAt: "desc",
		},
	});
	res.json(students);
});
router.post("/bysession", async (req, res) => {
	const { session } = req.body;

	const students = await prisma.students.findMany({
		where: {
			active: true,
			admission_session: session,
		},
		include: {
			curr_class: true,
			StudentsDemotions: true,
			StudentsPromotions: true,
			ClassHistory: true,
		},
		orderBy: {
			updatedAt: "desc",
		},
	});
	res.json(students);
});
router.post("/bysessionnterm", async (req, res) => {
	const { session, term } = req.body;

	const students = await prisma.students.findMany({
		where: {
			active: true,
			admission_session: session,
			admission_term: term,
		},
		include: {
			curr_class: true,
			StudentsDemotions: true,
			StudentsPromotions: true,
			ClassHistory: true,
		},
		orderBy: {
			updatedAt: "desc",
		},
	});
	res.json(students);
});
router.get("/:studentId", async (req, res) => {
	const student = await prisma.students.findUnique({
		where: {
			id: req.params.studentId,
		},
		include: {
			curr_class: {
				select: {
					name: true,
					id: true,
					subjects: true,
					teacher_id: true,
					school_section: true,
				},
			},
			transactions: true,
			StudentsDemotions: true,
			StudentsPromotions: true,
			Disengagedstudent: true,
			ClassHistory: true,
		},
	});
	res.json(student);
});
router.get("/byClass/:classId", async (req, res) => {
	const student = await prisma.students.findMany({
		where: {
			AND: [{ curr_class_id: req.params.classId }, { active: true }],
		},
		include: {
			curr_class: true,
		},
	});
	res.json(student);
});
router.post("/byClassHistory", async (req, res) => {
	const { session, class_id } = req.body;
	const students = await prisma.classHistory.findMany({
		where: {
			session,
			class_id,
		},
		include: {
			student: {
				select: {
					first_name: true,
					last_name: true,
					admission_no: true,
					id: true,
				},
			},
		},
	});
	res.status(200).json(students);
});

router.post("/create", async (req, res) => {
	const {
		date_of_birth,
		date_of_admission,
		sex,
		religion,
		admission_term,
		admission_session,
		admission_class,
		curr_class_id,
		school_section,
		admission_no,
		first_name,
		last_name,
		address,
		state_of_origin,
		lga,
		guardian_name,
		guardian_telephone,
		curr_session,
	} = req.body;
	try {
		const found = await prisma.students.findUnique({
			where: {
				admission_no: req.body.admission_no,
			},
		});
		if (found) {
			res.status(400).json("already exist");
		} else {
			const created = await prisma.students.create({
				data: {
					id: nanoid(7),
					date_of_admission,
					sex,
					religion,
					admission_term,
					admission_session,
					admission_class,
					curr_class_id,
					school_section,
					admission_no,
					first_name,
					last_name,
					address,
					state_of_origin,
					lga,
					guardian_name,
					guardian_telephone,
					date_of_birth,
				},
			});

			const connectHistory = await prisma.classHistory.create({
				data: {
					student_id: created?.id,
					class_id: created?.curr_class_id,
					session: curr_session,
				},
			});
			res.json({ created, connectHistory });
		}
	} catch (error) {
		res.status(500).json(error);
		console.log(error);
	}
});
router.post("/many", async (req, res) => {
	try {
		req.body.forEach(async (d) => {
			const created = await prisma.students.create({
				data: d,
			});

			await prisma.classHistory.create({
				data: {
					student_id: created?.id,
					class_id: created?.curr_class_id,
					session: created?.admission_session,
				},
			});
		});
		res.json("ok");
	} catch (error) {
		res.status(500).json(error);
		console.log(error);
	}
});
router.post("/edit/:studentId", async (req, res) => {
	const { curr_class_id } = req.body;
	const edited = await prisma.students.update({
		where: {
			id: req.params.studentId,
		},
		data: { ...req.body },
	});
	if (edited.curr_class_id !== curr_class_id) {
		const connectHistory = await prisma.classHistory.create({
			data: {
				student_id: edited?.id,
				session: edited?.admission_session,
				class_id: edited.curr_class_id,
			},
		});
		res.json({ edited, connectHistory });
	}
	res.json(edited);
});
// router.post("/edits/many", async (req, res) => {
// 	const updated = await prisma.classHistory.updateMany({
// 		where: {
// 			class_id: "2_fPzDw",
// 		},
// 		data: {
// 			session: "2024/2025",
// 		},
// 	});
// 	res.json(updated);
// });

router.post("/search", async (req, res) => {
	const { value } = req.body;

	try {
		if (value !== "") {
			const found = await prisma.students.findMany({
				where: {
					OR: [
						{
							admission_no: {
								contains: value,
							},
						},
						{
							first_name: {
								contains: value,
							},
						},
						{
							last_name: {
								contains: value,
							},
						},
					],
				},
				take: 100,
				include: {
					curr_class: {
						select: {
							id: true,
							name: true,
							fees: true,
						},
					},
				},
			});

			res.status(200).json(found);
		} else {
			res.status(200).json([]);
		}
	} catch (error) {
		res.status(500).json(error);
	}
});
router.get("/outstanding/:studentId", async (req, res) => {
	try {
		const outstandingFees = await prisma.tnxItem.findMany({
			where: {
				transaction: {
					studentId: req.params.studentId,
				},
				balance: {
					gt: 0,
				},
				active: true,
			},
			include: {
				fee: true,
			},
		});
		res.status(200).json(outstandingFees);
	} catch (error) {
		res.status(500).json(error);
		console.log(error);
	}
});
router.post("/outstanding", async (req, res) => {
	const { session, term, className, studentId } = req.body;
	try {
		const outstandingFees = await prisma.tnxItem.findMany({
			where: {
				session,
				term,
				class: className,
				transaction: {
					studentId,
				},
				balance: {
					gt: 0,
				},
				// active: true,
			},
			include: {
				fee: true,
			},
		});
		res.status(200).json(outstandingFees);
	} catch (error) {
		res.status(500).json(error);
		console.log(error);
	}
});
export default router;
