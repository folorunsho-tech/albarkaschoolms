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
import promotions from "./routes/promotions.js";
import demotions from "./routes/demotions.js";
import staffs from "./routes/staffs.js";
import students from "./routes/students.js";
import fca from "./routes/fca.js";
import sca from "./routes/sca.js";
import exams from "./routes/exams.js";
import statements from "./routes/statements.js";
import disengagements from "./routes/disengagements.js";
const app = express();
const port = 5000;
config();
app.use(express.json());
app.use(cors());
app.use("/auth", auth);
app.use("/appointments", appointments);
app.use("/subjects", subjects);
app.use("/feesgroup", feesgroup);
app.use("/accounts", accounts);
app.use("/backup", backup);
app.use("/classes", classes);
app.use("/payments", payments);
app.use("/promotions", promotions);
app.use("/demotions", demotions);
app.use("/staffs", staffs);
app.use("/students", students);
app.use("/fca", fca);
app.use("/sca", sca);
app.use("/exams", exams);
app.use("/statements", statements);
app.use("/disengagements", disengagements);
app.get("/", (req, res) => {
	res.send("<h2>Welcome</h2>");
});
app.listen(port, () => {
	console.log(`Albarka server listening on port ${port}`);
});