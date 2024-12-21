import { nanoid } from "nanoid";

import express from "express";
const router = express.Router();
import { PrismaClient } from "@prisma/client";
const prisma = new PrismaClient();

router.get("/", async (req, res) => {
	const classes = await prisma.classes.findMany({
		include: {
			_count: {
				select: {
					Students: {
						where: {
							active: true,
						},
					},
					subjects: true,
				},
			},
			teacher: {
				select: {
					first_name: true,
					last_name: true,
					empid: true,
				},
			},
			subjects: true,
			Students: true,
			ClassHistory: {
				select: {
					student: true,
					session: true,
				},
			},
		},

		orderBy: {
			name: "asc",
		},
	});

	res.json(classes);
});
router.get("/byStatement", async (req, res) => {
	const classes = await prisma.classes.findMany({
		include: {
			subjects: true,
			Students: true,
			ClassHistory: {
				select: {
					student: true,
				},
			},
		},

		orderBy: {
			name: "asc",
		},
	});

	res.json(classes);
});
router.get("/:classId", async (req, res) => {
	const currClass = await prisma.classes.findUnique({
		where: {
			id: req.params.classId,
		},
		include: {
			subjects: {
				select: {
					name: true,
					id: true,
				},
				orderBy: {
					name: "asc",
				},
			},
			teacher: {
				select: {
					first_name: true,
					last_name: true,
					empid: true,
				},
			},
			Students: {
				where: {
					active: true,
				},
				select: {
					first_name: true,
					last_name: true,
					admission_no: true,
					sex: true,
					religion: true,
					guardian_name: true,
					guardian_telephone: true,
				},
			},
			ClassHistory: {
				select: {
					student: true,
					session: true,
				},
			},
			_count: {
				select: {
					subjects: true,
					Students: true,
				},
			},
		},
	});

	res.json(currClass);
});
router.get("/subjects/:classId", async (req, res) => {
	const currClass = await prisma.classes.findUnique({
		where: {
			id: req.params.classId,
		},
		include: {
			subjects: {
				select: {
					name: true,
					id: true,
				},
				orderBy: {
					name: "asc",
				},
			},
		},
	});

	res.json(currClass);
});
router.post("/create", async (req, res) => {
	const { name, teacherId, section, subjects } = req.body;
	const created = await prisma.classes.create({
		data: {
			id: nanoid(7),
			teacher_id: teacherId,
			name,
			section,
			subjects: {
				connect: subjects,
			},
		},
	});

	res.json(created);
});
router.post("/edit/:classId", async (req, res) => {
	const { teacher_id, section, subjects } = req.body;
	let edited;
	if (teacher_id == "" || teacher_id == null) {
		edited = await prisma.classes.update({
			where: {
				id: req.params.classId,
			},
			data: {
				section,
				subjects: {
					set: [],
					connect: subjects,
				},
			},
			include: {
				subjects: true,
			},
		});
	} else {
		edited = await prisma.classes.update({
			where: {
				id: req.params.classId,
			},
			data: {
				teacher: {
					connect: {
						empid: teacher_id,
					},
				},
				section,
				subjects: {
					set: [],
					connect: subjects,
				},
			},
			include: {
				subjects: true,
			},
		});
	}

	res.json(edited);
});

export default router;