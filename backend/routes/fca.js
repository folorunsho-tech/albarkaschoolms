import { nanoid } from "nanoid";
import express from "express";
const router = express.Router();
import prisma from "../lib/prisma.js";

router.get("/", async (req, res) => {
	const fCAResults = await prisma.fCAResults.findMany({
		orderBy: {
			updatedAt: "desc",
		},
		include: {
			class: true,
			subject: true,
			student: true,
		},
	});
	res.json(fCAResults);
});
router.post("/byId/:accId/bysessionnterm", async (req, res) => {
	const { session, term } = req.body;
	const user = await prisma.accounts.findUnique({
		where: {
			id: req.params.accId,
		},
		include: {
			staff: {
				select: {
					curr_appointment: true,
					school_section: true,
				},
			},
		},
	});
	if (
		user?.staff?.curr_appointment?.name.includes("Principal") ||
		user?.staff?.curr_appointment?.name.includes("VP Academy") ||
		user?.staff?.school_section == "All"
	) {
		const found = await prisma.fCAResults.findMany({
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
	} else if (user?.staff?.curr_appointment?.name.includes("Head Master")) {
		const found = await prisma.fCAResults.findMany({
			orderBy: {
				updatedAt: "desc",
			},
			where: {
				class: {
					OR: [
						{
							name: { contains: "Nursery" },
						},
						{
							name: { contains: "nursery" },
						},
						{
							name: { contains: "Primary" },
						},
					],
				},
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
	} else if (
		user?.staff?.curr_appointment?.name == "Exam Officer" ||
		user?.staff?.curr_appointment?.name == "Head teacher"
	) {
		const found = await prisma.fCAResults.findMany({
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
	} else {
		const fCAResults = await prisma.fCAResults.findMany({
			orderBy: {
				updatedAt: "desc",
			},
			where: {
				createdById: user?.id,
				session,
				term,
			},
			include: {
				class: true,
				subject: true,
				student: true,
			},
		});
		res.json(fCAResults);
	}
});
router.post("/byId/:accId/bysession", async (req, res) => {
	const { session } = req.body;
	const user = await prisma.accounts.findUnique({
		where: {
			id: req.params.accId,
		},
		include: {
			staff: {
				select: {
					curr_appointment: true,
					school_section: true,
				},
			},
		},
	});
	if (
		user?.staff?.curr_appointment?.name.includes("Principal") ||
		user?.staff?.curr_appointment?.name.includes("VP Academy") ||
		user?.staff?.school_section == "All"
	) {
		const found = await prisma.fCAResults.findMany({
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
	} else if (user?.staff?.curr_appointment?.name.includes("Head Master")) {
		const found = await prisma.fCAResults.findMany({
			orderBy: {
				updatedAt: "desc",
			},
			where: {
				class: {
					OR: [
						{
							name: { contains: "Nursery" },
						},
						{
							name: { contains: "nursery" },
						},
						{
							name: { contains: "Primary" },
						},
					],
				},
				session,
			},
			include: {
				class: true,
				subject: true,
				student: true,
			},
		});
		res.status(200).json(found);
	} else if (
		user?.staff?.curr_appointment?.name == "Exam Officer" ||
		user?.staff?.curr_appointment?.name == "Head teacher"
	) {
		const found = await prisma.fCAResults.findMany({
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
	} else {
		const fCAResults = await prisma.fCAResults.findMany({
			orderBy: {
				updatedAt: "desc",
			},
			where: {
				createdById: user?.id,
				session,
			},
			include: {
				class: true,
				subject: true,
				student: true,
			},
		});
		res.json(fCAResults);
	}
});
router.get("/byId/:accId", async (req, res) => {
	const user = await prisma.accounts.findUnique({
		where: {
			id: req.params.accId,
		},
		include: {
			staff: {
				select: {
					curr_appointment: true,
					school_section: true,
				},
			},
		},
	});
	if (
		user?.staff?.curr_appointment?.name.includes("Principal") ||
		user?.staff?.curr_appointment?.name.includes("VP Academy") ||
		user?.staff?.school_section == "All"
	) {
		const found = await prisma.fCAResults.findMany({
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
	} else if (user?.staff?.curr_appointment?.name.includes("Head Master")) {
		const found = await prisma.fCAResults.findMany({
			orderBy: {
				updatedAt: "desc",
			},
			where: {
				class: {
					OR: [
						{
							name: { contains: "Nursery" },
						},
						{
							name: { contains: "nursery" },
						},
						{
							name: { contains: "Primary" },
						},
					],
				},
			},
			include: {
				class: true,
				subject: true,
				student: true,
			},
		});
		res.status(200).json(found);
	} else if (
		user?.staff?.curr_appointment?.name == "Exam Officer" ||
		user?.staff?.curr_appointment?.name == "Head teacher"
	) {
		const found = await prisma.fCAResults.findMany({
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
		const fCAResults = await prisma.fCAResults.findMany({
			orderBy: {
				updatedAt: "desc",
			},
			where: {
				createdById: user?.id,
			},
			include: {
				class: true,
				subject: true,
				student: true,
			},
		});
		res.json(fCAResults);
	}
});
router.get("/:caId", async (req, res) => {
	const ca = await prisma.fCAResults.findUnique({
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
});

router.post("/create", async (req, res) => {
	const uploads = req.body.uploads;
	const createdById = req.body.createdById;
	try {
		uploads.forEach(async (upload) => {
			const { student_id, class_id, subject_id, term, session, score } = upload;
			const found = await prisma.fCAResults.findFirst({
				where: {
					student_id,
					class_id,
					subject_id,
					term,
					session,
				},
			});
			if (found) {
				await prisma.fCAResults.update({
					where: {
						id: found?.id,
					},
					data: {
						score,
					},
				});
			} else {
				await prisma.fCAResults.create({
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
		// console.log(error);
	}
});
router.post("/edit/:caId", async (req, res) => {
	const edited = await prisma.fCAResults.update({
		where: {
			id: req.params.caId,
		},
		data: { ...req.body },
	});
	res.json(edited);
});

export default router;
