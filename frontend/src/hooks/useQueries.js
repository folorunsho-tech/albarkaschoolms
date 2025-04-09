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
	} else if (status == 401) {
		notifications.show({
			title: "Error !!!",
			message: "Access Denied",
			color: "red",
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
	const { token } = React.useContext(userContext);

	const [loading, setLoading] = useState(false);
	const [data, setData] = useState([]);
	const fetch = async (url) => {
		setLoading(true);
		const getquery = await axios.get(url, {
			headers: {
				Authorization: token,
			},
		});
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
	const { token } = React.useContext(userContext);

	const [loading, setLoading] = useState(false);
	const [data, setData] = useState({});
	const fetch = async (url) => {
		setLoading(true);
		const getquery = await axios.get(url, {
			headers: {
				Authorization: token,
			},
		});
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
	const { token } = React.useContext(userContext);
	const [loading, setLoading] = useState(false);
	const [data, setData] = useState([]);
	const post = async (url, postData) => {
		setLoading(true);
		const postquery = await axios.post(
			url,
			{
				...postData,
			},
			{
				headers: {
					Authorization: token,
				},
			}
		);
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
	const { user, token } = React.useContext(userContext);
	const [loading, setLoading] = useState(false);
	const [data, setData] = useState([]);
	const post = async (url, postData) => {
		setLoading(true);
		const postquery = await axios.post(
			url,
			{
				...postData,
				createdById: user?.id,
			},
			{
				headers: {
					Authorization: token,
				},
			}
		);
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
export const usePostMany = () => {
	const { user, token } = React.useContext(userContext);
	const [loading, setLoading] = useState(false);
	const [data, setData] = useState([]);
	const post = async (url, postData) => {
		setLoading(true);

		const postquery = await axios.post(
			url,
			{
				uploads: postData,
				createdById: user?.id,
			},
			{
				headers: {
					Authorization: token,
				},
			}
		);
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
	const { user, token } = React.useContext(userContext);
	const [loading, setLoading] = useState(false);
	const [data, setData] = useState([]);
	const post = async (url, postData) => {
		setLoading(true);
		const postquery = await axios.post(
			url,
			{
				...postData,
				updatedById: user?.id,
			},
			{
				headers: {
					Authorization: token,
				},
			}
		);
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
