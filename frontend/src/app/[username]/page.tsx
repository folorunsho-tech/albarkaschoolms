"use client";
import React from "react";
import { NavLink } from "@mantine/core";
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
	IconLink,
} from "@tabler/icons-react";
import { useParams } from "next/navigation";
import { userContext } from "@/context/User";
const Dashboard = () => {
	const { user } = React.useContext(userContext);

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
	const params = useParams<{ username: string }>();
	return (
		<section className='bg-white p-3 rounded-md flex flex-col items-center h-2/3 gap-6'>
			<h2 className='text-5xl text-center'>
				Welcome back {params?.username} !!!
			</h2>
			<div className='flex gap-10 '>
				<p>
					Employment Id: <i className='font-semibold'>{user?.empid}</i>
				</p>
				<p>
					Name: <i className='font-semibold'>{user?.name}</i>
				</p>
				<p>
					Appointment:{" "}
					<i className='font-semibold'>{user?.staff?.curr_appointment?.name}</i>
				</p>
				<p>
					Operation Date:{" "}
					<i className='font-semibold'>{new Date().toLocaleDateString()}</i>
				</p>
			</div>
			{/* <div className='self-start ml-10'>
				<h3 className='text-lg font-bold'>Quick Links</h3>
				<div className='flex flex-wrap gap-2'>
					{data?.map((nav: any, index: number) => (
						<NavLink
							key={nav?.link + index}
							href={`/${params?.username}/${nav?.link}`}
							label={nav?.label}
							leftSection={<nav.icon className='' stroke={1.5} />}
							rightSection={<IconLink size='0.8rem' stroke={1.5} />}
							color='teal'
							variant='filled'
							className='w-max'
							active
							disabled={!nav?.shown}
						/>
					))}
				</div>
			</div> */}
		</section>
	);
};

export default Dashboard;
