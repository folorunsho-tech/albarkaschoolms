import express from "express";
const router = express.Router();
import prisma from "../lib/prisma.js";
// import { PrismaClient } from "@prisma/client";
// const prisma = new PrismaClient();
router.get("/", async (req, res) => {
	const staffs = await prisma.staffs.findMany({
		where: {
			active: true,

			NOT: [{ empid: "EMP0000" }, { empid: "EMP0001" }],
		},
		include: {
			curr_appointment: {
				select: {
					name: true,
					school_section: true,
				},
			},
		},
		orderBy: {
			empid: "asc",
		},
	});
	res.json(staffs);
});
router.get("/acct", async (req, res) => {
	const staffs = await prisma.staffs.findMany({
		where: {
			active: true,
			account: {
				is: null,
			},
			NOT: [{ empid: "EMP0000" }, { empid: "EMP0001" }],
		},
		include: {
			curr_appointment: {
				select: {
					name: true,
					school_section: true,
				},
			},
		},
		orderBy: {
			empid: "asc",
		},
	});
	res.json(staffs);
});
router.get("/empid", async (req, res) => {
	try {
		const list = await prisma.staffs.findMany({
			select: {
				empid: true,
			},
			orderBy: {
				empid: "asc",
			},
		});
		res.json(list[list.length - 1].empid);
	} catch (error) {
		res.status(500).json(error);
	}
});
router.get("/:staffId", async (req, res) => {
	const staff = await prisma.staffs.findUnique({
		where: {
			empid: req.params.staffId,
		},
		include: {
			curr_appointment: {
				select: {
					name: true,
					school_section: true,
				},
			},
			subjects: true,
			class_assigned: true,
			Promotions: true,
			Demotions: true,
			Disengagemnets: true,
		},
	});
	res.json(staff);
});
router.get("/:staffId/subjects", async (req, res) => {
	const staff = await prisma.staffs.findUnique({
		where: {
			empid: req.params.staffId,
		},
		include: {
			curr_appointment: {
				select: {
					name: true,
					school_section: true,
				},
			},
			subjects: true,
		},
	});
	res.json(staff);
});
router.post("/create", async (req, res) => {
	const {
		address,
		appointed_as,
		curr_appointment_id,
		date_of_birth,
		date_of_emp,
		empid,
		first_name,
		last_name,
		lga,
		marital_status,
		qualification,
		religion,
		salary,
		school_section,
		sex,
		state_of_origin,
		telephone,
		subjects,
		grade_level,
		createdById,
	} = req.body;

	try {
		const found = await prisma.staffs.findUnique({
			where: {
				empid,
			},
		});
		if (found) {
			res.status(400).json("already exist");
		} else {
			const created = await prisma.staffs.create({
				data: {
					empid,
					address,
					appointed_as,
					curr_appointment_id,
					date_of_birth,
					date_of_emp,
					empid,
					first_name,
					last_name,
					lga,
					marital_status,
					qualification,
					religion,
					salary,
					school_section,
					sex,
					state_of_origin,
					telephone,
					grade_level,
					createdById,
					subjects: {
						connect: subjects,
					},
				},
			});
			res.json(created);
		}
	} catch (error) {
		res.status(500).json(error);
		console.log(error);
	}
});
router.post("/edit/:staffId", async (req, res) => {
	const {
		address,
		appointed_as,
		curr_appointment_id,
		date_of_birth,
		date_of_emp,
		first_name,
		last_name,
		lga,
		marital_status,
		qualification,
		religion,
		salary,
		school_section,
		sex,
		state_of_origin,
		telephone,
		subjects,
		grade_level,
		updatedById,
	} = req.body;
	const edited = await prisma.staffs.update({
		where: {
			empid: req.params.staffId,
		},
		data: {
			address,
			appointed_as,
			curr_appointment_id,
			date_of_birth,
			date_of_emp,
			first_name,
			last_name,
			lga,
			marital_status,
			qualification,
			religion,
			salary,
			school_section,
			sex,
			state_of_origin,
			telephone,
			grade_level,
			updatedById,
			subjects: {
				set: [],
				connect: subjects,
			},
		},
	});
	res.json(edited);
});
router.post("/many", async (req, res) => {
	const created = await prisma.staffs.createMany({
		data: [...req.body],
	});
	res.json(created);
});
export default router;
