import { nanoid } from "nanoid";

import express from "express";
const router = express.Router();
import prisma from "../lib/prisma.js";

router.get("/", async (req, res) => {
	const subjects = await prisma.subjects.findMany({
		include: {
			_count: {
				select: {
					Staffs: true,
					Classes: true,
				},
			},
		},
		orderBy: {
			name: "asc",
		},
	});
	res.json(subjects);
});
router.get("/:subjectId", async (req, res) => {
	const subject = await prisma.subjects.findUnique({
		where: {
			id: req.params.subjectId,
		},
	});
	res.json(subject);
});
router.post("/create", async (req, res) => {
	const { name } = req.body;
	const created = await prisma.subjects.create({
		data: {
			id: nanoid(7),
			name,
		},
	});
	res.json(created);
});
router.post("/many", async (req, res) => {
	const created = await prisma.subjects.createMany({
		data: [...req.body],
	});
	res.json(created);
});
router.post("/edit/:subjectId", async (req, res) => {
	const { name } = req.body;
	const edited = await prisma.subjects.update({
		where: {
			id: req.params.subjectId,
		},
		data: name,
	});
	res.json(edited);
});

export default router;
