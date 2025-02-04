import { PrismaClient } from "@prisma/client";
const prisma = new PrismaClient().$extends({
	result: {
		students: {
			fullName: {
				needs: { first_name: true, last_name: true },
				compute(student) {
					return `${student.first_name} ${student.last_name}`;
				},
			},
		},
	},
});

export default prisma;
