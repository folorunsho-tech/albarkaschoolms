import express from "express";
const router = express.Router();
import { PrismaClient } from "@prisma/client";
const prisma = new PrismaClient();

router.post("/byStudent/:student_id", async (req, res) => {
	const { session, term } = req.body;
	const results = await prisma.students.findUnique({
		where: {
			id: req.params.student_id,
		},

		include: {
			FCAResults: {
				where: {
					session,
					term,
				},

				select: {
					id: true,
					subject: {
						select: {
							name: true,
						},
					},
					score: true,
				},
				orderBy: {
					subject: {
						name: "asc",
					},
				},
			},
			SCAResults: {
				where: {
					session,
					term,
				},
				select: {
					id: true,
					subject: {
						select: {
							name: true,
						},
					},
					score: true,
				},
				orderBy: {
					subject: {
						name: "asc",
					},
				},
			},
			ExamResults: {
				where: {
					session,
					term,
				},
				select: {
					id: true,
					subject: {
						select: {
							name: true,
						},
					},
					score: true,
				},
				orderBy: {
					subject: {
						name: "asc",
					},
				},
			},
		},
	});
	res.json(results);
});
router.post("/byClass/:classId", async (req, res) => {
	const { session, term } = req.body;
	const results = await prisma.classes.findMany({
		where: {
			id: req.params.classId,
		},
		include: {
			Students: true,
			FCAResults: {
				where: {
					session,
					term,
				},
				select: {
					id: true,
					subject: true,
					student: true,
					student_id: true,
					score: true,
					session: true,
					term: true,
				},
			},
			SCAResults: {
				where: {
					session,
					term,
				},
				select: {
					id: true,
					subject: true,
					student: true,
					student_id: true,
					score: true,
					session: true,
					term: true,
				},
			},
			ExamResults: {
				where: {
					session,
					term,
				},
				select: {
					id: true,
					subject: true,
					student: true,
					student_id: true,
					score: true,
					session: true,
					term: true,
				},
			},
		},
	});
	res.json(results);
});

export default router;
