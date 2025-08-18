import { nanoid } from "nanoid";
import express from "express";
const router = express.Router();
import prisma from "../lib/prisma.js";
router.get("/", async (req, res) => {
	try {
		const SCAResults = await prisma.sCAResults.findMany({
			orderBy: {
				updatedAt: "desc",
			},
			include: {
				class: true,
				subject: true,
				student: true,
			},
		});
		res.json(SCAResults);
	} catch (error) {
		res.status(500).json(error);
		console.log(error);
	}
});
router.post("/byId/bysession", async (req, res) => {
	const { session } = req.body;

	try {
		const found = await prisma.sCAResults.findMany({
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
router.post("/byId/bysessionnterm", async (req, res) => {
	const { session, term } = req.body;

	try {
		const found = await prisma.sCAResults.findMany({
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
				term,
			},
		});
		res.status(200).json(found);
	} catch (error) {
		res.status(500).json(error);
		console.log(error);
	}
});
router.get("/byId/:accId", async (req, res) => {
	const account = await prisma.accounts.findUnique({
		where: {
			id: req.params.accId,
		},
	});
	try {
		if (account?.role == "admin" || account?.role == "editor") {
			const found = await prisma.sCAResults.findMany({
				orderBy: {
					updatedAt: "desc",
				},
				include: {
					class: true,
					subject: true,
					student: true,
				},
			});
			res.status(200).json(found);
		} else {
			const found = await prisma.sCAResults.findMany({
				orderBy: {
					updatedAt: "desc",
				},
				include: {
					class: true,
					subject: true,
					student: true,
				},
				where: {
					createdById: req.params.accId,
				},
			});
			res.status(200).json(found);
		}
	} catch (error) {
		res.status(500).json(error);
		console.log(error);
	}
});
router.get("/:caId", async (req, res) => {
	try {
		const ca = await prisma.sCAResults.findUnique({
			where: {
				id: req.params.caId,
			},
			include: {
				student: true,
				subject: true,
				class: true,
			},
		});
		res.json(ca);
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
			const found = await prisma.sCAResults.findFirst({
				where: {
					student_id,
					class_id,
					subject_id,
					term,
					session,
				},
			});
			if (found) {
				await prisma.sCAResults.update({
					where: {
						id: found?.id,
					},
					data: {
						score,
					},
				});
			} else {
				await prisma.sCAResults.create({
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
router.post("/edit/:caId", async (req, res) => {
	try {
		const edited = await prisma.sCAResults.update({
			where: {
				id: req.params.caId,
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
