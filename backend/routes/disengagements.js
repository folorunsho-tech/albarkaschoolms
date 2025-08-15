import express from "express";
const router = express.Router();
import prisma from "../lib/prisma.js";
router.get("/students", async (req, res) => {
    try {
        const dises = await prisma.disengagedstudent.findMany({
            include: {
                student: {
                    select: {
                        id: true,
                        admission_no: true,
                        first_name: true,
                        last_name: true,
                        admission_class: true,
                        date_of_admission: true,
                        curr_class: true,
                        sex: true,
                    },
                },
            },
        });
        res.json(dises);
    }
    catch (error) {
        res.status(500).json(error);
    }
});
router.post("/students/bysessionnterm", async (req, res) => {
    try {
        const dises = await prisma.disengagedstudent.findMany({
            where: {
                session: req.body.session,
                term: req.body.term,
            },
            include: {
                student: {
                    select: {
                        id: true,
                        admission_no: true,
                        first_name: true,
                        last_name: true,
                        admission_class: true,
                        date_of_admission: true,
                        curr_class: true,
                        sex: true,
                    },
                },
            },
        });
        res.json(dises);
    }
    catch (error) {
        res.status(500).json(error);
    }
});
router.post("/students/bysession", async (req, res) => {
    try {
        const dises = await prisma.disengagedstudent.findMany({
            where: {
                session: req.body.session,
            },
            include: {
                student: {
                    select: {
                        id: true,
                        admission_no: true,
                        first_name: true,
                        last_name: true,
                        admission_class: true,
                        date_of_admission: true,
                        curr_class: true,
                        sex: true,
                    },
                },
            },
        });
        res.json(dises);
    }
    catch (error) {
        res.status(500).json(error);
    }
});
router.get("/students/:students_id", async (req, res) => {
    try {
        const dises = await prisma.disengagedstudent.findMany({
            where: {
                student: {
                    id: req.params.students_id,
                },
            },
            include: {
                student: {
                    select: {
                        id: true,
                        admission_no: true,
                        first_name: true,
                        last_name: true,
                        admission_class: true,
                        date_of_admission: true,
                        curr_class: true,
                        sex: true,
                    },
                },
            },
        });
        res.json(dises);
    }
    catch (error) {
        res.status(500).json(error);
    }
});
router.post("/students", async (req, res) => {
    try {
        const dis = await prisma.disengagedstudent.create({
            data: { ...req.body },
            include: {
                student: true,
            },
        });
        if (dis.student_id)
            await prisma.students.update({
                where: {
                    id: dis.student_id,
                },
                data: {
                    active: false,
                },
            });
        res.json(dis);
    }
    catch (error) {
        res.status(500).json(error);
    }
});
export default router;
