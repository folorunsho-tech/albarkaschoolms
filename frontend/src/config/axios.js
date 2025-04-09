import axios from "axios";
import { redirect } from "next/navigation";
import { read_cookie } from "sfcookies";
const api = axios.create({
	baseURL: process.env.NEXT_PUBLIC_SERVER_API,
	responseType: "json",
	timeout: 5000,
	validateStatus: function (status) {
		return status < 510; // Resolve only if the status code is less than 500
	},
	//
});
api.interceptors.request.use((config) => {
	const returned =
		typeof window !== "undefined" ? read_cookie("albarkaschoolms") : null;
	if (returned) {
		config.headers.Authorization = returned?.token;
		config.headers["Content-Type"] = "application/json";
	}
	return config;
});
api.interceptors.response.use((response) => {
	if (response.status === 401) {
		// Redirect to login page if unauthorized
		redirect("/");
	}
	return response;
});
export default api;
