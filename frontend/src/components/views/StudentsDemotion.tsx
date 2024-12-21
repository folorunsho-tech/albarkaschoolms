"use client";
import React, { useEffect, useState } from "react";
import PaginatedTable from "@/components/PaginatedTable";
import { Table } from "@mantine/core";
import { useFetch } from "@/hooks/useQueries";
import chunk from "@/libs/chunk";
import moment from "moment";
const StudentsDemotion = ({ id }: { id: string | null }) => {
	const headers = [
		"Admission No.",
		"Student name",
		"demotion from",
		"demotion to",
		"demoted On",
	];
	const { loading, fetch, data } = useFetch();
	const [queryData, setQueryData] = useState(data);
	const [sortedData, setSortedData] = useState([]);
	const [searchedData, setSearchedData] = useState([]);

	const rows = sortedData?.map((row: any, index: number) => (
		<Table.Tr key={row?.id}>
			<Table.Td>{index + 1}</Table.Td>
			<Table.Td>{row?.student?.admission_no}</Table.Td>
			<Table.Td>
				{row?.student?.first_name} {row?.student?.last_name}
			</Table.Td>
			<Table.Td>{row?.from}</Table.Td>
			<Table.Td>{row?.to?.name}</Table.Td>
			<Table.Td>{moment(row?.demotedOn).format("MMMM Do YYYY")}</Table.Td>
		</Table.Tr>
	));
	const searchedRows = searchedData?.map((row: any, index: number) => (
		<Table.Tr key={row?.id}>
			<Table.Td>{index + 1}</Table.Td>
			<Table.Td>{row?.student?.admission_no}</Table.Td>
			<Table.Td>
				{row?.student?.first_name} {row?.student?.last_name}
			</Table.Td>
			<Table.Td>{row?.from}</Table.Td>
			<Table.Td>{row?.to?.name}</Table.Td>
			<Table.Td>{moment(row?.demotedOn).format("MMMM Do YYYY")}</Table.Td>
		</Table.Tr>
	));

	useEffect(() => {
		async function getData() {
			const { data } = await fetch(`/demotions/students/${id}`);
			setQueryData(data);
			const paginated: any[] = chunk(data, 50);
			setSortedData(paginated[0]);
		}
		getData();
	}, []);

	return (
		<section>
			<PaginatedTable
				depth='student'
				showlast={false}
				showSearch={false}
				rows={rows}
				searchedRows={searchedRows}
				data={queryData}
				headers={headers}
				placeholder='Search by staff name or employment id'
				setSortedData={setSortedData}
				setSearchedData={setSearchedData}
				loading={loading}
				count={queryData.length}
			/>
		</section>
	);
};

export default StudentsDemotion;
