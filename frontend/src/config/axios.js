import axios from "axios";
const instance = axios.create({
	baseURL: "http://localhost:5000",
	responseType: "json",

	validateStatus: function (status) {
		return status < 500; // Resolve only if the status code is less than 500
	},
});
export default instance;
