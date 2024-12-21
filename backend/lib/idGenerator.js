import { PrismaClient } from "@prisma/client";
const prisma = new PrismaClient();

export const invoiceIdGen = async () => {
	let id = `PM${Math.round(Math.random() * 100000)}`;
	const payment = await prisma.payments.findUnique({
		where: {
			payment_id: id,
		},
	});
	if (payment?.payment_id) {
		invoiceIdGen();
	}
	return id;
};
