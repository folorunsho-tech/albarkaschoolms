import React from "react";
import { useEffect, useState } from "react";
import PaginatedTable from "@/components/PaginatedTable";
import { useFetch } from "@/hooks/useQueries";
import { Table, ActionIcon } from "@mantine/core";
import { IconPencil } from "@tabler/icons-react";
import chunk from "@/libs/chunk";
import moment from "moment";
import Link from "next/link";
import ResultsFilter from "../filters/ResultsFilter";
import { userContext } from "@/context/User";
import { useDisclosure } from "@mantine/hooks";
const Fca = () => {
	const { user } = React.useContext(userContext);
	const headers = [
		"Admission no",
		"Student name",
		"Student class",
		"Session - Term",
		"Subject",
		"Score",
		"Uploaded on",
	];
	const { loading, data, fetch } = useFetch();
	const [queryData, setQueryData] = useState(data);
	const [sortedData, setSortedData] = useState([]);
	const [searchedData, setSearchedData] = useState([]);
	const [filterCount, setFilterCount] = useState(0);
	const [opened, { toggle }] = useDisclosure();
	const rows = sortedData?.map((row, index) => (
		<Table.Tr key={row?.id + index}>
			<Table.Td>{index + 1}</Table.Td>
			<Table.Td>{row?.student?.admission_no}</Table.Td>
			<Table.Td>
				{row?.student?.first_name} {row?.student?.last_name}
			</Table.Td>
			<Table.Td>{row?.class?.name}</Table.Td>
			<Table.Td>
				{row?.term} - {row?.session}
			</Table.Td>
			<Table.Td>{row?.subject?.name}</Table.Td>
			<Table.Td>{row?.score}</Table.Td>
			<Table.Td>{moment(row?.updatedAt).format("MMMM Do YYYY")}</Table.Td>
			<Table.Td className='flex items-center gap-3 '>
				<Link href={`results/sca/edit?id=${row?.id}`}>
					<ActionIcon variant='outline' color='green' aria-label='action menu'>
						<IconPencil style={{ width: "70%", height: "70%" }} stroke={2} />
					</ActionIcon>
				</Link>
			</Table.Td>
		</Table.Tr>
	));
	const searchedRows = searchedData?.map((row, index) => (
		<Table.Tr key={row?.id + index}>
			<Table.Td>{index + 1}</Table.Td>
			<Table.Td>{row?.student?.admission_no}</Table.Td>
			<Table.Td>
				{row?.student?.first_name} {row?.student?.last_name}
			</Table.Td>
			<Table.Td>{row?.class?.name}</Table.Td>
			<Table.Td>
				{row?.term} - {row?.session}
			</Table.Td>
			<Table.Td>{row?.subject?.name}</Table.Td>
			<Table.Td>{row?.score}</Table.Td>
			<Table.Td>{moment(row?.updatedAt).format("MMMM Do YYYY")}</Table.Td>
			<Table.Td className='flex items-center gap-3 '>
				<Link href={`results/sca/edit?id=${row?.id}`}>
					<ActionIcon variant='outline' color='green' aria-label='action menu'>
						<IconPencil style={{ width: "70%", height: "70%" }} stroke={2} />
					</ActionIcon>
				</Link>
			</Table.Td>
		</Table.Tr>
	));
	useEffect(() => {
		async function getAll() {
			const { data } = await fetch(`/sca/byid/${user?.id}`);
			setQueryData(data);

			const paginated = chunk(data, 50);
			setSortedData(paginated[0]);
		}
		getAll();
	}, []);
	return (
		<section className='p-3 bg-white space-y-6'>
			<div className='flex justify-between mt-2'>
				<h2 className='font-bold text-xl text-blue-700'>2nd C.A Results</h2>
				<div className='flex w-1/3 justify-between  items-center'>
					<button
						onClick={() => {
							toggle();
						}}
						className='flex items-center hover:bg-gray-600 transition duration-150 bg-gray-500 w-20 justify-between divide-x-2 rounded-md text-white shadow-sm inset-2'
					>
						<span className='p-1'>Filters</span>
						<span className='p-1 rounded-e-md bg-gray-300'>
							{filterCount == 0 ? "None" : filterCount}
						</span>
					</button>
					<Link
						href={`results/sca`}
						className='bg-teal-500 text-white hover:bg-teal-700 px-4 py-2 rounded-sm transition duration-200 ease-linear'
					>
						Add a new 2nd C.A result
					</Link>
				</div>
			</div>
			{opened && (
				<ResultsFilter
					setQueryData={setQueryData}
					setSortedData={setSortedData}
					queryData={queryData}
					resultType='sca'
					sortedData={sortedData}
					setFilterCount={setFilterCount}
				/>
			)}
			<PaginatedTable
				depth='student'
				showlast={false}
				showSearch
				rows={rows}
				searchedRows={searchedRows}
				data={queryData}
				headers={headers}
				placeholder='Search by student name or admission no'
				setSortedData={setSortedData}
				setSearchedData={setSearchedData}
				loading={loading}
				count={queryData?.length}
			/>
		</section>
	);
};

export default Fca;