const { createHash } = await import("node:crypto");
import { Router } from "express";
import { PrismaClient } from "@prisma/client";
const prisma = new PrismaClient();
const router = Router();

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
			select: {
				permissions: true,
				id: true,
				active: true,
				empid: true,
				name: true,
				username: true,
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
		if (user?.active === true) {
			const authUserHis = await prisma.authHistory.create({
				data: {
					account_id: user.id,
					logged_in_at: new Date(),
				},
			});
			res.status(200).json({
				user,
				message: {
					success: "Login successful",
					error: "",
				},
				authId: authUserHis.id,
			});
		} else if (!user) {
			res.status(404).json({
				user: null,
				message: {
					success: "",
					error: "Invalid credentials",
				},
			});
		} else if (user?.active === false) {
			res.status(401).json({
				user: null,
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
	res.json({
		message: "Logged out",
	});
});

export default router;
