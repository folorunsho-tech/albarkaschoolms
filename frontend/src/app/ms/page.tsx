"use client";
import React from "react";
import { userContext } from "@/context/User";
const Dashboard = () => {
	const { user } = React.useContext(userContext);

	return (
		<section className='bg-white p-3 rounded-md flex flex-col items-center h-2/3 gap-6'>
			<h2 className='text-5xl text-center'>
				Welcome back {user?.username} !!!
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
		</section>
	);
};

export default Dashboard;
