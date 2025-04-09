import React from "react";
import { Group, Text } from "@mantine/core";
import { IconLogout } from "@tabler/icons-react";
import { Avatar } from "@mantine/core";
import { userContext } from "@/context/User";
import axios from "@/config/axios";
import { IconSettings, IconDatabaseExport } from "@tabler/icons-react";
import Link from "next/link";
const TopBar = () => {
	const { user, logOut, authId } = React.useContext(userContext);
	return (
		<header className='p-3 py-2 border-b border-gray-300 bg-blue-500 flex justify-between items-center'>
			<h2 className='font-semibold pb-2 text-white'>Albarka School Wawa</h2>
			<Group className='' justify='space-between'>
				{user?.role == "admin" && (
					<Group justify='space-between' className='text-white'>
						<Link
							className='hover:text-teal-300 transition duration-200'
							href={`/ms/settings`}
						>
							<IconSettings stroke={2} />
						</Link>
						<Link
							className='hover:text-teal-300 transition duration-200'
							href={`/ms/backup`}
						>
							<IconDatabaseExport stroke={2} />
						</Link>
					</Group>
				)}
				<Group className='bg-indigo-100 p-1 px-4 rounded-md'>
					<Avatar
						radius='xl'
						src={user?.passport}
						name={user?.username}
						color='initials'
						variant='filled'
					/>

					<div style={{ flex: 1 }}>
						<Text size='sm' fw={500}>
							{user?.username} - {user?.staff?.school_section}
						</Text>

						<Text c='dimmed' size='xs'>
							{user?.name}
						</Text>
					</div>
				</Group>

				<button
					className='flex gap-3 items-center transition duration-300 ease-in-out text-sm bg-red-500 text-white p-2 py-1 rounded-sm font-medium hover:bg-red-200 hover:text-red-700'
					onClick={async () => {
						logOut();
						await axios.post("/auth/logout", { id: authId });
					}}
				>
					<IconLogout className='' stroke={1.5} />
					<span>Logout</span>
				</button>
			</Group>
		</header>
	);
};

export default TopBar;
