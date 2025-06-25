"use client";
import NavMenu from "@/components/NavMenu";
import TopBar from "@/components/TopBar";
import React, { useEffect } from "react";

import {
	IconUsers,
	IconReportAnalytics,
	IconBuilding,
	IconCashRegister,
	IconSchool,
	IconArrowsTransferUpDown,
	IconUserCheck,
	IconFileInvoice,
} from "@tabler/icons-react";
import { userContext } from "@/context/User";
export default function AppLayout({ params, children }: any) {
	const { permissions } = React.useContext(userContext);
	const { username }: any = React.use(params);
	const data = [
		{
			link: "students",
			label: "Students",
			icon: IconSchool,
			shown: permissions?.students?.view,
		},
		{
			link: "staffs",
			label: "Staffs",
			icon: IconUsers,
			shown: permissions?.staffs?.view,
		},
		{
			link: "results",
			label: "Results",
			icon: IconReportAnalytics,
			shown: permissions?.results?.view,
		},
		{
			link: "statement",
			label: "Statement of results",
			icon: IconFileInvoice,
			shown: permissions?.statement,
		},
		{
			link: "transactions",
			label: "Payments",
			icon: IconCashRegister,
			shown: permissions?.payments?.view,
		},
		{
			link: "classes",
			label: "Classes",
			icon: IconBuilding,
			shown: permissions?.classes?.view,
		},
		// {
		// 	link: "staffspromotions",
		// 	label: "Staffs Promotions",
		// 	icon: IconArrowsTransferUpDown,
		// 	shown: permissions?.staffPromotions,
		// },
		{
			link: "studentspromotions",
			label: "Students Promotions",
			icon: IconArrowsTransferUpDown,
			shown: permissions?.studentPromotions,
		},
		{
			link: "accounts",
			label: "Accounts",
			icon: IconUserCheck,
			shown: permissions?.accounts,
		},
	];

	return (
		<section className='h-full'>
			<div className='w-full'>
				<TopBar />
				<NavMenu menu={data} />
			</div>
			<main className=' py-2 h-screen '>{children}</main>
		</section>
	);
}
