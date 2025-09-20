import axios from "axios";

const api = axios.create({
	baseURL: process.env.NEXT_PUBLIC_SERVER,
	responseType: "json",
	timeout: 5000,
	withCredentials: true,
	validateStatus: function (status: number) {
		return status < 510; // Resolve only if the status code is less than 500
	},
	//
});
export default api;
