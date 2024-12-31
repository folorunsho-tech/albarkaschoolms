"use client";
import NavMenu from "@/components/NavMenu";
import TopBar from "@/components/TopBar";
import React, { useEffect } from "react";

import {
	IconUsers,
	IconReportAnalytics,
	IconSettings,
	IconBuilding,
	// IconCashRegister,
	IconSchool,
	IconArrowsTransferUpDown,
	IconUserCheck,
	IconDatabaseExport,
	IconFileInvoice,
} from "@tabler/icons-react";
import { useCookies } from "next-client-cookies";
import { useRouter } from "next/navigation";
import { userContext } from "@/context/User";
export default function AppLayout({ params, children }: any) {
	const { setUser, user } = React.useContext(userContext);
	const cookies: any = useCookies().get("albarkaschoolms");
	const router = useRouter();
	const { username }: any = React.use(params);
	const permisions = user?.permissions;
	const data = [
		{
			link: "students",
			label: "Students",
			icon: IconSchool,
			shown: permisions?.students?.view,
		},
		{
			link: "staffs",
			label: "Staffs",
			icon: IconUsers,
			shown: permisions?.staffs?.view,
		},
		{
			link: "results",
			label: "Results",
			icon: IconReportAnalytics,
			shown: permisions?.results?.view,
		},
		{
			link: "statement",
			label: "Statement of results",
			icon: IconFileInvoice,
			shown: permisions?.statement,
		},
		// {
		// 	link: "payments",
		// 	label: "Payments",
		// 	icon: IconCashRegister,
		// 	shown: permisions?.payments?.view,
		// },
		{
			link: "classes",
			label: "Classes",
			icon: IconBuilding,
			shown: permisions?.classes?.view,
		},
		{
			link: "staffspromotions",
			label: "Staffs Promotions",
			icon: IconArrowsTransferUpDown,
			shown: permisions?.staffPromotions,
		},
		{
			link: "studentspromotions",
			label: "Students Promotions",
			icon: IconArrowsTransferUpDown,
			shown: permisions?.studentPromotions,
		},
		{
			link: "accounts",
			label: "Accounts",
			icon: IconUserCheck,
			shown: permisions?.accounts,
		},
		{
			link: "settings",
			label: "Settings",
			icon: IconSettings,
			shown: permisions?.settings,
		},
		{
			link: "backup",
			label: "Backup",
			icon: IconDatabaseExport,
			shown: permisions?.backup,
		},
	];
	useEffect(() => {
		if (cookies == undefined) {
			router.push("/");
		} else {
			setUser(JSON.parse(cookies));
		}
	}, []);
	return (
		<section className='h-full'>
			<div className='w-full'>
				<TopBar />
				<NavMenu menu={data} username={username} />
			</div>
			<main className=' py-2 h-screen'>{children}</main>
		</section>
	);
}
