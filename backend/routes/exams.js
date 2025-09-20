import { nanoid } from "nanoid";
import express from "express";
const router = express.Router();
import prisma from "../lib/prisma.js";
router.get("/", async (req, res) => {
	try {
		const exams = await prisma.examresults.findMany({
			orderBy: {
				updatedAt: "desc",
			},
			include: {
				class: true,
				subject: true,
				student: true,
			},
		});
		res.json(exams);
	} catch (error) {
		res.status(500).json(error);
		console.log(error);
	}
});
router.post("/byId/bysessionnterm", async (req, res) => {
	const { session, term } = req.body;
	try {
		const found = await prisma.examresults.findMany({
			orderBy: {
				updatedAt: "desc",
			},
			where: {
				session,
				term,
			},
			include: {
				class: true,
				subject: true,
				student: true,
			},
		});
		res.status(200).json(found);
	} catch (error) {
		res.status(500).json(error);
	}
});
router.post("/byId/bysession", async (req, res) => {
	const { session } = req.body;

	try {
		const found = await prisma.examresults.findMany({
			orderBy: {
				updatedAt: "desc",
			},
			include: {
				class: true,
				subject: true,
				student: true,
			},
			where: {
				session,
			},
		});
		res.status(200).json(found);
	} catch (error) {
		res.status(500).json(error);
		console.log(error);
	}
});
router.get("/:examId", async (req, res) => {
	try {
		const exam = await prisma.examresults.findUnique({
			where: {
				id: req.params.examId,
			},
			include: {
				student: true,
				subject: true,
				class: true,
			},
		});
		res.json(exam);
	} catch (error) {
		res.status(500).json(error);
		console.log(error);
	}
});
router.post("/create", async (req, res) => {
	const uploads = req.body.uploads;
	const createdById = req.body.createdById;
	try {
		uploads.forEach(async (upload) => {
			const { student_id, class_id, subject_id, term, session, score } = upload;
			const found = await prisma.examresults.findFirst({
				where: {
					student_id,
					class_id,
					subject_id,
					term,
					session,
				},
			});
			if (found) {
				await prisma.examresults.update({
					where: {
						id: found?.id,
					},
					data: {
						score,
					},
				});
			} else {
				await prisma.examresults.create({
					data: {
						id: nanoid(7),
						...upload,
						createdById,
					},
				});
			}
		});
		res.json("done");
	} catch (error) {
		res.status(500).json(error);
		console.log(error);
	}
});
router.post("/edit/:examId", async (req, res) => {
	try {
		const edited = await prisma.examresults.update({
			where: {
				id: req.params.examId,
			},
			data: req.body,
		});
		res.json(edited);
	} catch (error) {
		res.status(500).json(error);
		console.log(error);
	}
});
export default router;
