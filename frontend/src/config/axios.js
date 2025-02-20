import axios from "axios";
const instance = axios.create({
	baseURL: process.env.NEXT_PUBLIC_SERVER_API,
	responseType: "json",

	validateStatus: function (status) {
		return status;
	},
});
export default instance;
