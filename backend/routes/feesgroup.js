import { nanoid } from "nanoid";
import express from "express";
const router = express.Router();
import prisma from "../lib/prisma.js";
router.get("/", async (req, res) => {
	try {
		const feesGroup = await prisma.feesgroup.findMany({
			include: { classes: true },
		});
		res.json(feesGroup);
	} catch (error) {
		res.status(500).json(error);
		console.log(error);
	}
});
router.get("/:id", async (req, res) => {
	try {
		const feesGroup = await prisma.feesgroup.findUnique({
			where: { id: req.params.id },
			include: { classes: true },
		});
		res.json(feesGroup);
	} catch (error) {
		res.status(500).json(error);
		console.log(error);
	}
});
router.post("/create", async (req, res) => {
	const { name, amount, classes } = req.body;
	try {
		const created = await prisma.feesgroup.create({
			data: {
				id: nanoid(7),
				name,
				amount,
				classes: {
					connect: classes,
				},
			},
		});
		res.json(created);
	} catch (error) {
		res.status(500).json(error);
		console.log(error);
	}
});
router.post("/many", async (req, res) => {
	try {
		const created = await prisma.feesgroup.createMany({
			data: [...req.body],
		});
		res.json(created);
	} catch (error) {
		res.status(500).json(error);
		console.log(error);
	}
});
router.post("/edit/:feesId", async (req, res) => {
	const { amount, classes } = req.body;
	try {
		const edited = await prisma.feesgroup.update({
			where: {
				id: req.params.feesId,
			},
			data: {
				amount,
				classes: {
					set: [],
					connect: classes,
				},
			},
		});
		res.json(edited);
	} catch (error) {
		res.status(500).json(error);
		console.log(error);
	}
});
export default router;
