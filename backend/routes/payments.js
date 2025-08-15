import express from "express";
const router = express.Router();
import prisma from "../lib/prisma.js";
router.get("/", async (req, res) => {
    try {
        const payments = await prisma.payment.findMany({
            include: {
                transaction: {
                    include: {
                        student: true,
                    },
                },
                tnxItem: true,
                createdBy: {
                    select: {
                        username: true,
                    },
                },
            },
            orderBy: {
                tnxId: "asc",
            },
        });
        res.json(payments);
    }
    catch (error) {
        res.status(500).json(error);
        console.log(error);
    }
});
router.post("/bydate", async (req, res) => {
    const { from, to } = req.body;
    try {
        const found = await prisma.payment.findMany({
            where: {
                AND: [
                    {
                        createdAt: {
                            gte: new Date(new Date(from).setUTCHours(0, 0, 0, 0)),
                        },
                    },
                    {
                        createdAt: {
                            lte: new Date(new Date(to).setUTCHours(23, 59, 59, 999)),
                        },
                    },
                ],
            },
            include: {
                transaction: {
                    include: {
                        student: true,
                    },
                },
                tnxItem: true,
                createdBy: {
                    select: {
                        username: true,
                    },
                },
            },
            orderBy: {
                tnxId: "asc",
            },
        });
        res.status(200).json(found);
    }
    catch (error) {
        res.status(500).json(error);
        console.log(error);
    }
});
router.post("/bysession", async (req, res) => {
    const { session } = req.body;
    try {
        const found = await prisma.payment.findMany({
            where: {
                session,
            },
            include: {
                transaction: {
                    include: {
                        student: true,
                    },
                },
                tnxItem: true,
                createdBy: {
                    select: {
                        username: true,
                    },
                },
            },
            orderBy: {
                tnxId: "asc",
            },
        });
        res.status(200).json(found);
    }
    catch (error) {
        res.status(500).json(error);
        console.log(error);
    }
});
router.post("/bysessionnterm", async (req, res) => {
    const { session, term } = req.body;
    try {
        const found = await prisma.payment.findMany({
            where: {
                session,
                term,
            },
            include: {
                transaction: {
                    include: {
                        student: true,
                    },
                },
                tnxItem: true,
                createdBy: {
                    select: {
                        username: true,
                    },
                },
            },
            orderBy: {
                tnxId: "asc",
            },
        });
        res.status(200).json(found);
    }
    catch (error) {
        res.status(500).json(error);
        console.log(error);
    }
});
export default router;
