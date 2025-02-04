import { useState } from "react";
import axios from "@/config/axios";
import { userContext } from "@/context/User";
import React from "react";

export const useFetch = () => {
	const [loading, setLoading] = useState(false);
	const [data, setData] = useState([]);
	const fetch = async (url) => {
		setLoading(true);
		const getquery = await axios.get(url);
		setData(getquery.data);
		setLoading(false);
		return {
			data: getquery.data,
			headers: getquery.headers,
			status: getquery.status,
		};
	};

	return { loading, fetch, data };
};
export const useFetchSingle = () => {
	const [loading, setLoading] = useState(false);
	const [data, setData] = useState({});
	const fetch = async (url) => {
		setLoading(true);
		const getquery = await axios.get(url);
		setData(getquery.data);
		setLoading(false);
		return {
			data: getquery.data,
			headers: getquery.headers,
			status: getquery.status,
		};
	};

	return { loading, fetch, data };
};

export const usePostNormal = () => {
	const [loading, setLoading] = useState(false);
	const [data, setData] = useState([]);
	const post = async (url, postData) => {
		setLoading(true);
		const postquery = await axios.post(url, {
			...postData,
		});
		setData(postquery.data);
		setLoading(false);
		return {
			data: postquery.data,
			headers: postquery.headers,
			status: postquery.status,
		};
	};
	return { loading, post, data };
};
export const usePost = () => {
	const { user } = React.useContext(userContext);
	const [loading, setLoading] = useState(false);
	const [data, setData] = useState([]);
	const post = async (url, postData) => {
		setLoading(true);
		const postquery = await axios.post(url, {
			...postData,
			createdById: user?.id,
			updatedById: user?.id,
		});
		setData(postquery.data);
		setLoading(false);
		return {
			data: postquery.data,
			headers: postquery.headers,
			status: postquery.status,
		};
	};
	return { loading, post, data };
};
export const useEdit = () => {
	const { user } = React.useContext(userContext);
	const [loading, setLoading] = useState(false);
	const [data, setData] = useState([]);
	const post = async (url, postData) => {
		setLoading(true);
		const postquery = await axios.post(url, {
			...postData,
			updatedById: user?.id,
		});
		setData(postquery.data);
		setLoading(false);
		return {
			data: postquery.data,
			headers: postquery.headers,
			status: postquery.status,
		};
	};
	return { loading, post, data };
};

// export const useDelete = () => {
// 	const [loading, setLoading] = useState(false);
// 	const [data, setData] = useState([]);
// 	const deleteData = async (url) => {
// 		setLoading(true);
// 		const deletequery = await axios.delete(url);
// 		setData(deletequery.data);
// 		setLoading(false);
// 		return {
// 			data: deletequery.data,
// 			headers: deletequery.headers,
// 			status: deletequery.status,
// 		};
// 	};
// 	return { loading, deleteData, data };
// };

// export const useUpload = () => {
// 	const [loading, setLoading] = useState(false);
// 	const [data, setData] = useState([]);
// 	const upload = async (url, uploadData) => {
// 		// setLoading(true);
// 		const formData = new FormData();
// 		for (let i = 0; i < uploadData.length; i++) {
// 			console.log(uploadData[i]);
// 		}
// 		// console.log(formData);
// 		// const uploads = await axios.post(url, uploadData, {
// 		// 	headers: {
// 		// 		"Content-Type": "multipart/form-data",
// 		// 	},
// 		// });
// 		// setData(uploads.data);
// 		// setLoading(false);
// 		// return {
// 		// 	data: uploads.data,
// 		// 	headers: uploads.headers,
// 		// 	status: uploads.status,
// 		// };
// 	};
// 	return { loading, upload, data };
// };
