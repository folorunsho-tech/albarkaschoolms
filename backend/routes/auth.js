const { createHash } = await import("node:crypto");
import { Router } from "express";
import prisma from "../lib/prisma.js";
// import { PrismaClient } from "@prisma/client";
// const prisma = new PrismaClient();
import mysqldump from "mysqldump";
const router = Router();
import jwt from "jsonwebtoken";

const hashpass = (password) => {
	return createHash("sha256").update(password).digest("hex");
};

router.post("/login", async (req, res) => {
	const { username, password } = req.body;
	const hashedPass = hashpass(password);
	try {
		const user = await prisma.accounts.findFirst({
			where: {
				username,
				passHash: hashedPass,
			},
		});
		if (user?.active === true) {
			const token = jwt.sign({ userId: user.id }, process.env.SECRET);
			const authUserHis = await prisma.authHistory.create({
				data: {
					account_id: user.id,
					logged_in_at: new Date(),
				},
			});
			res.status(200).json({ token, authId: authUserHis?.id, userId: user.id });
		} else if (!user) {
			res.status(404).json({
				message: {
					success: "",
					error: "Invalid credentials",
				},
			});
		} else if (user?.active === false) {
			res.status(401).json({
				message: {
					success: "",
					error: "Unauthorized",
				},
			});
		}
	} catch (error) {
		res.status(500).json({
			message: {
				success: "",
				error: "Server Error",
			},
		});
	}
});
router.post("/revoke/:accId", async (req, res) => {
	const updated = await prisma.accounts.update({
		where: {
			id: req.params.accId,
		},
		data: {
			active: false,
		},
	});
	res.json(updated);
});

router.post("/allow/:accId", async (req, res) => {
	const updated = await prisma.accounts.update({
		where: {
			id: req.params.accId,
		},
		data: {
			active: true,
		},
	});
	res.json(updated);
});

router.post("/logout", async (req, res) => {
	const { id } = req.body;

	await prisma.authHistory.update({
		where: { id },
		data: {
			logged_out_at: new Date(),
			auth_status: "Logged-out",
		},
	});
	await mysqldump({
		connection: {
			host: process.env.DB_HOST,
			port: process.env.DB_PORT,
			user: process.env.DB_USER,
			password: process.env.DB_PASS,
			database: process.env.DB_NAME,
			charset: "utf8",
		},
		dump: {
			schema: {
				table: {
					dropIfExist: true,
				},
			},
		},
		dumpToFile: "../db/backup/school-backup.sql",
	});
	res.json({
		message: "Logged out",
	});
});

router.get("/:account_id/basic", async (req, res) => {
	try {
		const found = await prisma.accounts.findUnique({
			where: {
				id: req.params.account_id,
			},
			select: {
				permissions: true,
				id: true,
				active: true,
				empid: true,
				name: true,
				username: true,
				role: true,
				staff: {
					select: {
						curr_appointment: {
							select: {
								name: true,
							},
						},
						school_section: true,
					},
				},
			},
		});
		res.status(200).json(found);
	} catch (error) {
		res.status(500).json(error);
	}
});

export default router;
