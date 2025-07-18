import express from "express";
import { config } from "dotenv";
import cors from "cors";
import auth from "./routes/auth.js";
import accounts from "./routes/accounts.js";
import backup from "./routes/backup.js";
import appointments from "./routes/appointments.js";
import subjects from "./routes/subjects.js";
import feesgroup from "./routes/feesgroup.js";
import classes from "./routes/classes.js";
import payments from "./routes/payments.js";
import debtors from "./routes/debtors.js";
import transactions from "./routes/transactions.js";
import promotions from "./routes/promotions.js";
import demotions from "./routes/demotions.js";
import staffs from "./routes/staffs.js";
import students from "./routes/students.js";
import fca from "./routes/fca.js";
import sca from "./routes/sca.js";
import exams from "./routes/exams.js";
import statements from "./routes/statements.js";
import disengagements from "./routes/disengagements.js";
import { verifyToken } from "./middlewares/jwt.js";
import cron from "node-cron";
import { cronDump } from "./lib/dump.js";
import { ftp } from "./lib/ftp.js";
const app = express();
const port = 5000;
config();
app.use(express.json());
app.use(cors());
app.use("/api/auth", auth);
app.use("/api/backup", backup);
app.use("/api/appointments", verifyToken, appointments);
app.use("/api/subjects", verifyToken, subjects);
app.use("/api/feesgroup", verifyToken, feesgroup);
app.use("/api/accounts", verifyToken, accounts);
app.use("/api/classes", verifyToken, classes);
app.use("/api/payments", verifyToken, payments);
app.use("/api/debtors", verifyToken, debtors);
app.use("/api/transactions", verifyToken, transactions);
app.use("/api/promotions", verifyToken, promotions);
app.use("/api/demotions", verifyToken, demotions);
app.use("/api/staffs", verifyToken, staffs);
app.use("/api/students", verifyToken, students);
app.use("/api/fca", verifyToken, fca);
app.use("/api/sca", verifyToken, sca);
app.use("/api/exams", verifyToken, exams);
app.use("/api/statements", verifyToken, statements);
app.use("/api/disengagements", verifyToken, disengagements);

app.get("/", (req, res) => {
	res.send("<h2>Welcome</h2>");
});
app.listen(port, () => {
	console.log(`Albarka server listening on port ${port}`);
});
cron.schedule("*/30 * * * *", async () => {
	try {
		await cronDump();
		await ftp("./backup/school-backup.sql", "/school_backup/school-backup.sql");
	} catch (error) {
		console.log(error);
	}
});
