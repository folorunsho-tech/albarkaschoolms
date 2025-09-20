import axios from "@/config/axios";
import { NextRequest, NextResponse } from "next/server";

export async function verifyToken(req: NextRequest) {
	try {
		const { data } = await axios.get("/auth/me");
		console.log(data);
		return data;
	} catch (error) {
		return NextResponse.json(
			{ error: "Invalid token" },
			{ status: 401, headers: { "Content-Type": "application/json" } }
		);
	}
}
