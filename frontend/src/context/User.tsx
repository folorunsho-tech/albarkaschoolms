/* eslint-disable @typescript-eslint/no-explicit-any */
"use client";
import { useFetchSingle } from "@/hooks/useQueries";
import { ReactNode, createContext, useEffect, useState } from "react";
import { useCookies } from "next-client-cookies";
import { redirect, useRouter } from "next/navigation";
import { delete_cookie } from "sfcookies";

const userContext = createContext<{
	user: any;
	authId: null | string;
	permissions: any;
	setUser: any;
	setPerm: any;
	setAuthId: any;
	setToken: any;
	logOut: any;
	token: null | string;
}>({
	user: null,
	authId: null,
	permissions: null,
	setUser: () => {},
	setPerm: () => {},
	setAuthId: () => {},
	setToken: () => {},
	logOut: () => {},
	token: null,
});
const UserProvider = ({ children }: { children: ReactNode }) => {
	const router = useRouter();
	const { fetch } = useFetchSingle();
	const [user, setUser] = useState<any>(null);
	const [token, setToken] = useState<null | string>(null);
	const [authId, setAuthId] = useState<any>(null);
	const [permissions, setPerm] = useState<any>(null);

	const getData = async (id: string) => {
		const { data } = await fetch(`/auth/${id}/basic`);
		setUser(data);
		setPerm(data?.permissions);
	};
	const cookies: any = useCookies();
	const gotten = cookies.get("albarkaschoolms");
	useEffect(() => {
		if (!gotten) {
			router.push("/");
		} else {
			const parsed = gotten ? JSON.parse(gotten) : null;
			setToken(parsed?.token);
			setAuthId(parsed?.authId);
			getData(parsed?.userId);
		}
	}, [authId, token, user, gotten]);
	const logOut = () => {
		delete_cookie("albarkaschoolms");
		redirect("/");
	};
	return (
		<userContext.Provider
			value={{
				user,
				setUser,
				permissions,
				setPerm,
				authId,
				setAuthId,
				token,
				setToken,
				logOut,
			}}
		>
			{children}
		</userContext.Provider>
	);
};

export { userContext, UserProvider };
