import { nanoid } from "nanoid";
import express from "express";
const router = express.Router();
import prisma from "../lib/prisma.js";
router.get("/", async (req, res) => {
    try {
        const subjects = await prisma.subjects.findMany({
            include: {
                _count: {
                    select: {
                        Classes: true,
                    },
                },
            },
            orderBy: {
                name: "asc",
            },
        });
        res.json(subjects);
    }
    catch (error) {
        res.status(500).json(error);
        console.log(error);
    }
});
router.get("/:subjectId", async (req, res) => {
    try {
        const subject = await prisma.subjects.findUnique({
            where: {
                id: req.params.subjectId,
            },
        });
        res.json(subject);
    }
    catch (error) {
        res.status(500).json(error);
        console.log(error);
    }
});
router.post("/create", async (req, res) => {
    try {
        const { name } = req.body;
        const created = await prisma.subjects.create({
            data: {
                id: nanoid(7),
                name,
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
        const created = await prisma.subjects.createMany({
            data: [...req.body],
        });
        res.json(created);
    }
    catch (error) {
        res.status(500).json(error);
        console.log(error);
    }
});
router.post("/edit/:subjectId", async (req, res) => {
    const { name } = req.body;
    try {
        const edited = await prisma.subjects.update({
            where: {
                id: req.params.subjectId,
            },
            data: name,
        });
        res.json(edited);
    }
    catch (error) {
        res.status(500).json(error);
        console.log(error);
    }
});
export default router;
