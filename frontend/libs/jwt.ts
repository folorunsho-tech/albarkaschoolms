import axios from "@/config/axios";
import { NextRequest, NextResponse } from "next/server";

export async function verifyToken(req: NextRequest) {
	const token = req.cookies.get("token")?.value;
	if (!token)
		return new NextResponse(JSON.stringify({ error: "Access denied" }), {
			status: 401,
			headers: { "Content-Type": "application/json" },
		});
	try {
		const { data } = await axios.get("/auth/me");
		return data;
	} catch (error) {
		return NextResponse.json(
			{ error: "Invalid token" },
			{ status: 401, headers: { "Content-Type": "application/json" } }
		);
	}
}
