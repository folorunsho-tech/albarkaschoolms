// import mysqldump from "mysqldump";
let count = 0;

export const cronDump = async () => {
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
		dumpToFile: "/albarka_backup/school-backup.sql",
	});
	count++;

	console.log(
		`Backup No ${count}, Back up done at ${new Date().toLocaleDateString(
			"en-US",
			{
				year: "numeric",
				month: "long",
				day: "numeric",
				hour: "2-digit",
				minute: "2-digit",
			}
		)}`
	);
};
import mysqldump from "mysqldump";

export const returnedDump = async () => {
	const db = await mysqldump({
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
		dumpToFile: "/albarka_backup/school-backup.sql",
	});
	return db;
};
