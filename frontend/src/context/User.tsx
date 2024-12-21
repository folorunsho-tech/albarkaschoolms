"use client";
import { redirect } from "next/navigation";
import React, { ReactNode } from "react";
import { delete_cookie } from "sfcookies";
const userContext = React.createContext<any>({
	user: null,
	setUser: () => {},
});
const UserProvider = ({ children }: { children: ReactNode }) => {
	const [user, setUser] = React.useState();
	const logOut = () => {
		delete_cookie("albarkschoolms");
		redirect("/");
	};
	return (
		<userContext.Provider value={{ user, setUser, logOut }}>
			{children}
		</userContext.Provider>
	);
};

export { userContext, UserProvider };
