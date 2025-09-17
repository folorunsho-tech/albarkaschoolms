import express from "express";
import dotenv from "dotenv";
import cors from "cors";
import auth from "./routes/auth.js";
import accounts from "./routes/accounts.js";
import subjects from "./routes/subjects.js";
import feesgroup from "./routes/feesgroup.js";
import classes from "./routes/classes.js";
import payments from "./routes/payments.js";
import debtors from "./routes/debtors.js";
import transactions from "./routes/transactions.js";
import promotions from "./routes/promotions.js";
import demotions from "./routes/demotions.js";
import students from "./routes/students.js";
import fca from "./routes/fca.js";
import sca from "./routes/sca.js";
import exams from "./routes/exams.js";
import statements from "./routes/statements.js";
import disengagements from "./routes/disengagements.js";
import cookieParser from "cookie-parser";
import { errorHandler } from "./middlewares/errorHandler.js";
import { authMiddleware } from "./middlewares/authMiddleware.js";
const app = express();
dotenv.config();
app.use(express.json());
app.use(errorHandler);
app.use(express.urlencoded({ extended: true }));
app.use(cookieParser());
app.use(
	cors({
		credentials: true,
		origin: process.env.ORIGIN,
	})
);
app.use("/api/auth", auth);
app.use("/api/subjects", authMiddleware, subjects);
app.use("/api/feesgroup", authMiddleware, feesgroup);
app.use("/api/accounts", authMiddleware, accounts);
app.use("/api/classes", authMiddleware, classes);
app.use("/api/payments", authMiddleware, payments);
app.use("/api/debtors", authMiddleware, debtors);
app.use("/api/transactions", authMiddleware, transactions);
app.use("/api/promotions", authMiddleware, promotions);
app.use("/api/demotions", authMiddleware, demotions);
app.use("/api/students", authMiddleware, students);
app.use("/api/fca", authMiddleware, fca);
app.use("/api/sca", authMiddleware, sca);
app.use("/api/exams", authMiddleware, exams);
app.use("/api/statements", authMiddleware, statements);
app.use("/api/disengagements", authMiddleware, disengagements);

const PORT = process.env.PORT || 5000;

app.get("/", (req, res) => res.send("Backend running"));

app.listen(PORT, "0.0.0.0", () => {
	console.log(`🚀 Server running on port ${PORT}`);
});
