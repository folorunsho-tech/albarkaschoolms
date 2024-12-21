import mysqldump from "mysqldump";
import express from "express";
import multer from "multer";
import { spawn } from "child_process";

const router = express.Router();
const storage = multer.diskStorage({
	destination: "/temp/",
	filename: function (req, file, cb) {
		cb(null, "restore.sql");
	},
});
const upload = multer({
	storage,
});

router.get("/download", (req, res) => {
	const filePath = "./db/backup/school-backup.sql";
	res.download(
		filePath,
		"school-backup.sql", // Remember to include file extension
		(err) => {
			if (err) {
				res.status(400).send({
					error: err,
					msg: "Problem downloading the file",
				});
			}
		}
	);
});
router.post("/generate", async (req, res) => {
	try {
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
			dumpToFile: "./db/backup/school-backup.sql",
		});
		res.status(200).json({
			message: "Database succesfully backed-up",
		});
	} catch (error) {
		res.status(500).json(error);
	}
});
router.post("/restore", upload.any(), (req, res) => {
	try {
		const restore = spawn("cmd.exe", [
			"mysql",
			` -ualbarkaschool -ptacheyon5567 albarkaschool < ./db/temp/restore.sql`,
		]);
		restore.stderr.on("data", function (data) {
			console.log("Error: " + data);
		});
		res.status(200).json({
			message: "Database succesfully restored",
		});
	} catch (error) {
		res.status(500).json(error);
	}
});

export default router;
