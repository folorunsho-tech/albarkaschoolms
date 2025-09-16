import React from "react";
import Link from "next/link";
import { usePathname } from "next/navigation";
import { IconHome, IconLogout } from "@tabler/icons-react";
import { useRouter } from "next/navigation";
import axios from "@/config/axios";
import FlyOutMenu from "./FlyOutMenu";

const NavMenu = ({ menu = [] }: any) => {
	const url = usePathname();
	const currPath = url.split("/");

	const router = useRouter();
	return (
		<nav className='flex flex-wrap border-b bg-white '>
			<Link
				className='hidden md:flex text-sm gap-3 items-center transition duration-300 ease-in-out data-[active]:font-semibold text-gray-700 data-[active]:bg-blue-200 data-[active]:text-blue-500 hover:bg-gray-100 hover:text-black hover:font-semibold p-3 '
				data-active={`/ms` === url || undefined}
				href={`/ms`}
			>
				<IconHome stroke={1.5} />
				<span>Home</span>
			</Link>
			<div className='hidden md:flex'>
				{menu.map(
					(item: any) =>
						item?.shown && (
							<Link
								className='flex text-sm gap-3 items-center transition duration-300 ease-in-out data-[active]:font-semibold text-gray-700 data-[active]:bg-blue-200 data-[active]:text-blue-500 hover:bg-gray-100 hover:text-black hover:font-semibold p-3 '
								data-active={
									item?.link.toLowerCase() === currPath[2] || undefined
								}
								href={`/ms/${item?.link}`}
								key={item?.label}
							>
								<item.icon className='' stroke={1.5} />
								<span>{item?.label}</span>
							</Link>
						)
				)}
			</div>
			<div className='flex items-center justify-between md:hidden w-full px-3'>
				<FlyOutMenu menu={menu} />
				<button
					className='flex cursor-pointer gap-3 items-center transition duration-300 ease-in-out text-sm bg-red-500 text-white p-2 py-1 rounded-sm font-medium hover:bg-red-200 hover:text-red-700'
					onClick={async () => {
						await axios.post("/auth/logout");
						router.push("/login");
					}}
				>
					<IconLogout className='' stroke={1.5} />
					<span>Logout</span>
				</button>
			</div>
		</nav>
	);
};

export default NavMenu;
