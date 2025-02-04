import { nanoid } from "nanoid";

import express from "express";
const router = express.Router();
import prisma from "../lib/prisma.js";
// import { PrismaClient } from "@prisma/client";
// const prisma = new PrismaClient();
router.get("/", async (req, res) => {
	const feesGroup = await prisma.feesGroup.findMany({
		include: { classes: true },
	});
	res.json(feesGroup);
});
router.get("/:id", async (req, res) => {
	const feesGroup = await prisma.feesGroup.findUnique({
		where: { id: req.params.id },
		include: { classes: true },
	});
	res.json(feesGroup);
});
router.post("/create", async (req, res) => {
	const { name, amount, classes } = req.body;
	const created = await prisma.feesGroup.create({
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
});
router.post("/edit/:feesId", async (req, res) => {
	const { amount, classes } = req.body;
	const edited = await prisma.feesGroup.update({
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
});

export default router;
