import React from "react";
import Link from "next/link";
import { usePathname } from "next/navigation";
import { IconHome } from "@tabler/icons-react";

const NavMenu = ({ menu = [] }: any) => {
	const url = usePathname();
	const currPath = url.split("/");
	return (
		<nav className='flex flex-wrap border-b bg-white'>
			<Link
				className='flex text-sm gap-3 items-center transition duration-300 ease-in-out data-[active]:font-semibold text-gray-700 data-[active]:bg-blue-200 data-[active]:text-blue-500 hover:bg-gray-100 hover:text-black hover:font-semibold p-3 '
				data-active={`/ms` === url || undefined}
				href={`/ms`}
			>
				<IconHome stroke={1.5} />
				<span>Home</span>
			</Link>
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
		</nav>
	);
};

export default NavMenu;
