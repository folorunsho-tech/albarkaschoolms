import { nanoid } from "nanoid";
import express from "express";
const router = express.Router();
import prisma from "../lib/prisma.js";
router.get("/", async (req, res) => {
    try {
        const feesGroup = await prisma.feesGroup.findMany({
            include: { classes: true },
        });
        res.json(feesGroup);
    }
    catch (error) {
        res.status(500).json(error);
        console.log(error);
    }
});
router.get("/:id", async (req, res) => {
    try {
        const feesGroup = await prisma.feesGroup.findUnique({
            where: { id: req.params.id },
            include: { classes: true },
        });
        res.json(feesGroup);
    }
    catch (error) {
        res.status(500).json(error);
        console.log(error);
    }
});
router.post("/create", async (req, res) => {
    const { name, amount, classes } = req.body;
    try {
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
    }
    catch (error) {
        res.status(500).json(error);
        console.log(error);
    }
});
router.post("/many", async (req, res) => {
    try {
        const created = await prisma.feesGroup.createMany({
            data: [...req.body],
        });
        res.json(created);
    }
    catch (error) {
        res.status(500).json(error);
        console.log(error);
    }
});
router.post("/edit/:feesId", async (req, res) => {
    const { amount, classes } = req.body;
    try {
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
    }
    catch (error) {
        res.status(500).json(error);
        console.log(error);
    }
});
export default router;
