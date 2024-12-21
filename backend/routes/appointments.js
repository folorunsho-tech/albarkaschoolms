import { nanoid } from "nanoid";
import express from "express";
const router = express.Router();
import { PrismaClient } from "@prisma/client";
const prisma = new PrismaClient();

router.get("/", async (req, res) => {
	const appointments = await prisma.appointments.findMany({
		orderBy: {
			name: "asc",
		},
	});
	res.json(appointments);
});
router.get("/:appointmentId", async (req, res) => {
	const appointment = await prisma.appointments.findUnique({
		where: {
			id: req.params.appointmentId,
		},
	});
	res.json(appointment);
});
router.post("/create", async (req, res) => {
	const { name, salary, school_section } = req.body;
	const created = await prisma.appointments.create({
		data: {
			id: nanoid(7),
			name,
			salary,
			school_section,
		},
	});
	res.json(created);
});
router.post("/edit/:appointmentId", async (req, res) => {
	const { salary } = req.body;
	const edited = await prisma.appointments.update({
		where: {
			id: req.params.appointmentId,
		},
		data: { salary },
	});
	res.json(edited);
});

export default router;
