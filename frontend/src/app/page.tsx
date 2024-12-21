"use client";
import {
	TextInput,
	PasswordInput,
	Paper,
	Title,
	Container,
	Button,
	LoadingOverlay,
} from "@mantine/core";
import { useForm } from "react-hook-form";
import { usePost } from "@/hooks/useQueries";
import { bake_cookie, read_cookie } from "sfcookies";
import { useRouter } from "next/navigation";
import { notifications } from "@mantine/notifications";
import { IconX, IconServerOff } from "@tabler/icons-react";
import axios from "@/config/axios";
import { userContext } from "@/context/User";
import React from "react";
export default function Login() {
	const { setUser } = React.useContext(userContext);
	const router = useRouter();
	const { handleSubmit, register } = useForm();
	const { post, loading } = usePost();
	const onSubmit = async (values: any) => {
		const res = await post("/auth/login", {
			...values,
		});
		if (res?.status === 200) {
			bake_cookie("alabrkaschoolms", {
				...res?.data?.user,
				authId: res?.data?.authId,
			});
			const read = read_cookie("alabrkaschoolms");
			setUser(read);
			axios.post("/backup/generate").then((d) => {
				console.log(d.status);
			});
			notifications.show({
				id: "AuthLogin",
				withCloseButton: false,
				position: "top-left",
				onClose: () => {
					router.push(`/${res?.data?.user?.username}/`);
				},
				autoClose: 500,
				withBorder: true,
				className: "w-max absolute top-0",
				title: "Login successful !!!",
				message: "Redirecting you to the homepage...",
				color: "teal",
				loading: true,
			});
		} else if (res?.status === 404) {
			notifications.show({
				id: "AuthInvalid",
				withCloseButton: true,
				position: "top-left",
				autoClose: 800,
				withBorder: true,
				className: "w-max absolute top-0",
				title: "Login error !!!",
				message:
					"Invalid credentials or account does not exist. Kindly contact the Principal / HM for correction",
				color: "red",
				icon: <IconX />,
			});
		} else if (res?.status === 401) {
			notifications.show({
				id: "Authunauthorized",
				withCloseButton: true,
				position: "top-left",
				autoClose: 800,
				withBorder: true,
				className: "w-max absolute top-0",
				title: "Unauthorized!!!",
				message:
					"User not currently allowed to login. Kindly contact the Principal / HM for correction",
				color: "red",
				icon: <IconX />,
			});
		} else {
			notifications.show({
				id: "AuthServerError",
				withCloseButton: true,
				position: "top-left",
				autoClose: 800,
				withBorder: true,
				className: "w-max absolute top-0",
				title: "Server error !!!",
				message:
					"Internal server error. Kindly contact the Principal / HM for correction",
				color: "red",
				icon: <IconServerOff />,
			});
		}
	};
	return (
		<Container className='my-auto  p-4' size={420} my={100}>
			<Title ta='center'>Welcome back!</Title>
			<Paper
				withBorder
				shadow='md'
				p={30}
				mt={30}
				radius='md'
				className='relative'
			>
				<form onSubmit={handleSubmit(onSubmit)}>
					<TextInput
						label='Username'
						placeholder='username...'
						{...register("username")}
					/>
					<PasswordInput
						label='Password'
						placeholder='Your password'
						mt='md'
						{...register("password")}
					/>

					<Button type='submit' fullWidth mt='xl'>
						Sign in
					</Button>
				</form>
			</Paper>
			<LoadingOverlay visible={loading} />
		</Container>
	);
}
