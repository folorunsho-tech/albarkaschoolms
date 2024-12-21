import { nanoid } from "nanoid";

import express from "express";
const router = express.Router();
import { PrismaClient } from "@prisma/client";
const prisma = new PrismaClient();

router.get("/", async (req, res) => {
	const feesGroup = await prisma.feesGroup.findMany({
		orderBy: {
			school_section: "asc",
		},
	});
	res.json(feesGroup);
});
router.post("/create", async (req, res) => {
	const { name, amount, school_section } = req.body;
	const created = await prisma.feesGroup.create({
		data: {
			id: nanoid(7),
			name,
			amount,
			school_section,
		},
	});
	res.json(created);
});
router.post("/edit/:feesId", async (req, res) => {
	const { amount } = req.body;
	const edited = await prisma.feesGroup.update({
		where: {
			id: req.params.feesId,
		},
		data: { amount },
	});
	res.json(edited);
});

export default router;
