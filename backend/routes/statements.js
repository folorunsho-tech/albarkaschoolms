import express from "express";
const router = express.Router();
import prisma from "../lib/prisma.js";
router.post("/byStudent/:student_id", async (req, res) => {
    const { session, term, classId } = req.body;
    try {
        const subjects = await prisma.subjects.groupBy({
            by: ["name"],
            where: {
                FCAResults: {
                    some: {
                        session,
                        term,
                        student_id: req.params.student_id,
                        class_id: classId,
                        score: {
                            not: null,
                        },
                    },
                },
            },
        });
        const results = await prisma.students.findUnique({
            where: {
                id: req.params.student_id,
            },
            include: {
                FCAResults: {
                    where: {
                        session,
                        term,
                        class_id: classId,
                    },
                    select: {
                        id: true,
                        subject: {
                            select: {
                                name: true,
                            },
                        },
                        score: true,
                    },
                    orderBy: {
                        subject: {
                            name: "asc",
                        },
                    },
                },
                SCAResults: {
                    where: {
                        session,
                        term,
                        class_id: classId,
                    },
                    select: {
                        id: true,
                        subject: {
                            select: {
                                name: true,
                            },
                        },
                        score: true,
                    },
                    orderBy: {
                        subject: {
                            name: "asc",
                        },
                    },
                },
                ExamResults: {
                    where: {
                        session,
                        term,
                        class_id: classId,
                    },
                    select: {
                        id: true,
                        subject: {
                            select: {
                                name: true,
                            },
                        },
                        score: true,
                    },
                    orderBy: {
                        subject: {
                            name: "asc",
                        },
                    },
                },
            },
        });
        res.json({ results, subjects });
    }
    catch (error) {
        res.status(500).json(error);
        console.log(error);
    }
});
router.post("/byClass/:classId", async (req, res) => {
    const { session, term } = req.body;
    try {
        const results = await prisma.classes.findMany({
            where: {
                id: req.params.classId,
            },
            include: {
                Students: true,
                FCAResults: {
                    where: {
                        session,
                        term,
                    },
                    select: {
                        id: true,
                        subject: true,
                        student: true,
                        student_id: true,
                        score: true,
                        session: true,
                        term: true,
                    },
                },
                SCAResults: {
                    where: {
                        session,
                        term,
                    },
                    select: {
                        id: true,
                        subject: true,
                        student: true,
                        student_id: true,
                        score: true,
                        session: true,
                        term: true,
                    },
                },
                ExamResults: {
                    where: {
                        session,
                        term,
                    },
                    select: {
                        id: true,
                        subject: true,
                        student: true,
                        student_id: true,
                        score: true,
                        session: true,
                        term: true,
                    },
                },
            },
        });
        res.json(results);
    }
    catch (error) {
        res.status(500).json(error);
        console.log(error);
    }
});
export default router;
