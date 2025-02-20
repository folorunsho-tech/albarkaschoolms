import { useState } from "react";
import axios from "@/config/axios";
import { userContext } from "@/context/User";
import React from "react";
import { notifications } from "@mantine/notifications";
const showNotification = (status) => {
	if (status == 200) {
		notifications.show({
			title: "Success !!!",
			message: "Sucessfull",
			color: "green",
		});
	} else if (status == 400) {
		notifications.show({
			title: "Error !!!",
			message: "Data alredy exist",
			color: "orange",
		});
	} else if (status == 404) {
		notifications.show({
			title: "Error !!!",
			message: "Error encountered",
			color: "red",
		});
	} else {
		notifications.show({
			title: "Server Error !!!",
			message: "Seems the server is having issues",
			color: "red",
		});
	}
};
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
			// updatedById: user?.id,
		});
		setData(postquery.data);
		setLoading(false);
		showNotification(postquery.status);
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
		showNotification(postquery.status);
		return {
			data: postquery.data,
			headers: postquery.headers,
			status: postquery.status,
		};
	};
	return { loading, post, data };
};
