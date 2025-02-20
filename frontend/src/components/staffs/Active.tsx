"use client";
import React, { useEffect, useState } from "react";
import PaginatedTable from "@/components/PaginatedTable";
import Link from "next/link";
import { useFetch } from "@/hooks/useQueries";
import { Table, ActionIcon, NumberFormatter } from "@mantine/core";
import { IconEye, IconPencil } from "@tabler/icons-react";
import moment from "moment";

import { userContext } from "@/context/User";

const Active = () => {
	const { user } = React.useContext(userContext);
	const { loading, data, fetch } = useFetch();
	const headers = [
		"empid",
		"emp date",
		"name",
		"sex",
		"marital status",
		"appointment",
		"salary",
		"school section",
		"phone No",
		"religion",
	];

	const [queryData, setQueryData] = useState(data);
	const [sortedData, setSortedData] = useState([]);

	const permission = user?.permissions?.staffs;

	const rows = sortedData?.map((row: any, index: number) => (
		<Table.Tr key={row?.empid}>
			<Table.Td>{index + 1}</Table.Td>
			<Table.Td>{row?.empid}</Table.Td>

			<Table.Td>{moment(row?.date_of_emp).format("MMMM Do YYYY")}</Table.Td>
			<Table.Td>
				{row?.first_name} {row?.last_name}
			</Table.Td>
			<Table.Td>{row?.sex}</Table.Td>
			<Table.Td>{row?.marital_status}</Table.Td>
			<Table.Td>{row?.curr_appointment?.name}</Table.Td>
			<Table.Td>
				<NumberFormatter
					prefix='N '
					value={Number(row?.salary)}
					thousandSeparator
				/>
			</Table.Td>
			<Table.Td>{row?.school_section}</Table.Td>
			<Table.Td>{row?.telephone}</Table.Td>
			<Table.Td>{row?.religion}</Table.Td>
			<Table.Td className='flex items-center gap-1 '>
				<ActionIcon variant='outline' aria-label='action menu'>
					<Link
						href={`staffs/view?id=${row?.empid}`}
						className='flex justify-center'
					>
						<IconEye style={{ width: "70%", height: "70%" }} stroke={2} />
					</Link>
				</ActionIcon>
				<ActionIcon
					disabled={!permission?.edit}
					variant='outline'
					color='teal'
					aria-label='action menu'
				>
					<Link
						href={`staffs/edit?id=${row?.empid}`}
						className='flex justify-center'
					>
						<IconPencil style={{ width: "70%", height: "70%" }} stroke={2} />
					</Link>
				</ActionIcon>
			</Table.Td>
		</Table.Tr>
	));

	useEffect(() => {
		const getAll = async () => {
			const { data } = await fetch("/staffs");
			setQueryData(data);
		};

		getAll();
	}, []);
	return (
		<section className='flex flex-col gap-4 p-4 bg-white'>
			<div className='flex justify-between mt-2'>
				<h2 className='font-bold text-xl text-blue-700'>Active Staffs</h2>
				<div className='flex gap-3 items-center'>
					{/* <Button
						leftSection={<IconPrinter />}
						className='bg-indigo-500 text-white hover:bg-indigo-700 px-4 py-2 rounded-sm transition duration-200 ease-linear'
					>
						Print 
					</Button> */}
					{permission?.create && (
						<Link
							className='bg-teal-500 text-white hover:bg-teal-700 px-4 py-2 rounded-sm transition duration-200 ease-linear'
							href='staffs/create'
						>
							Add new staff
						</Link>
					)}
				</div>
			</div>

			<PaginatedTable
				depth='curr_appointment'
				showlast
				showSearch
				rows={rows}
				sortedData={sortedData}
				data={queryData}
				headers={headers}
				placeholder='Search by name or empid'
				setSortedData={setSortedData}
				loading={loading}
			/>
		</section>
	);
};

export default Active;
