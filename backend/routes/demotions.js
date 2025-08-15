import { nanoid } from "nanoid";
import express from "express";
const router = express.Router();
import prisma from "../lib/prisma.js";
router.get("/students", async (req, res) => {
    try {
        const demotions = await prisma.studentsDemotions.findMany({
            orderBy: {
                demotedOn: "desc",
            },
            include: {
                student: true,
                to: true,
            },
        });
        res.json(demotions);
    }
    catch (error) {
        res.status(500).json(error);
    }
});
router.post("/students/bysession", async (req, res) => {
    const { session } = req.body;
    try {
        const demotions = await prisma.studentsDemotions.findMany({
            where: {
                session,
            },
            orderBy: {
                demotedOn: "desc",
            },
            include: {
                student: true,
                to: true,
            },
        });
        res.json(demotions);
    }
    catch (error) {
        res.status(500).json(error);
    }
});
router.post("/students/bysessionnterm", async (req, res) => {
    const { session, term } = req.body;
    try {
        const demotions = await prisma.studentsDemotions.findMany({
            where: {
                session,
                term,
            },
            orderBy: {
                demotedOn: "desc",
            },
            include: {
                student: true,
                to: true,
            },
        });
        res.json(demotions);
    }
    catch (error) {
        res.status(500).json(error);
    }
});
router.get("/students/:student_id", async (req, res) => {
    try {
        const demotions = await prisma.studentsDemotions.findMany({
            where: {
                student: {
                    id: req.params.student_id,
                },
            },
            orderBy: {
                demotedOn: "desc",
            },
            include: {
                student: true,
                to: true,
            },
        });
        res.json(demotions);
    }
    catch (error) {
        res.status(500).json(error);
    }
});
router.post("/students/create", async (req, res) => {
    const { session } = req.body;
    try {
        const created = await prisma.studentsDemotions.create({
            data: {
                id: nanoid(7),
                ...req.body,
            },
        });
        const updated = await prisma.students.update({
            where: {
                id: created.student_id,
            },
            data: {
                curr_class_id: created.to_id,
            },
        });
        const connectHistory = await prisma.classHistory.create({
            data: {
                student_id: updated?.id,
                class_id: updated?.curr_class_id,
                session,
            },
        });
        res.json({ created, connectHistory });
    }
    catch (error) {
        res.status(500).json(error);
    }
});
export default router;
