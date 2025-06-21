import mysqldump from "mysqldump";
import express from "express";

const router = express.Router();
router.get("/download", (req, res) => {
	const filePath = "../backup/school-backup.sql";
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
			dumpToFile: "/albarka_backup/school-backuptest123.sql",
		});
		res.status(200).json({
			message: "Database succesfully backed-up",
		});
	} catch (error) {
		res.status(500).json(error);
	}
});

export default router;
