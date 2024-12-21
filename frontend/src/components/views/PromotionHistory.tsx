"use client";
import React, { useEffect, useState } from "react";
import PaginatedTable from "@/components/PaginatedTable";
import { Table, NumberFormatter } from "@mantine/core";

import chunk from "@/libs/chunk";
import moment from "moment";
import { useFetch } from "@/hooks/useQueries";

const Promotions = ({ empid }: { empid: string | null }) => {
	const headers = [
		"EMP No.",
		"Staff name",
		"promotion from",
		"prev salary",
		"promotion to",
		"current salary",
		"promoted On",
	];
	const { loading, fetch, data } = useFetch();
	const [queryData, setQueryData] = useState(data);
	const [sortedData, setSortedData] = useState([]);
	const [searchedData, setSearchedData] = useState([]);
	const rows = sortedData?.map((row: any, index: number) => (
		<Table.Tr key={row?.id}>
			<Table.Td>{index + 1}</Table.Td>
			<Table.Td>{row?.staff_id}</Table.Td>
			<Table.Td>
				{row?.staff?.first_name} {row?.staff?.last_name}
			</Table.Td>
			<Table.Td>{row?.from}</Table.Td>
			<Table.Td>
				<NumberFormatter
					prefix='N '
					value={row?.prev_salary}
					thousandSeparator
				/>
			</Table.Td>
			<Table.Td>{row?.to?.name}</Table.Td>
			<Table.Td>
				<NumberFormatter
					prefix='N '
					value={row?.curr_salary}
					thousandSeparator
				/>
			</Table.Td>
			<Table.Td>{moment(row?.promotedOn).format("MMMM Do YYYY")}</Table.Td>
		</Table.Tr>
	));
	const searchedRows = searchedData?.map((row: any, index: number) => (
		<Table.Tr key={row?.id}>
			<Table.Td>{index + 1}</Table.Td>
			<Table.Td>{row?.staff_id}</Table.Td>
			<Table.Td>
				{row?.staff?.first_name} {row?.staff?.last_name}
			</Table.Td>
			<Table.Td>{row?.from}</Table.Td>
			<Table.Td>
				<NumberFormatter
					prefix='N '
					value={row?.prev_salary}
					thousandSeparator
				/>
			</Table.Td>
			<Table.Td>{row?.to?.name}</Table.Td>
			<Table.Td>
				<NumberFormatter
					prefix='N '
					value={row?.curr_salary}
					thousandSeparator
				/>
			</Table.Td>
			<Table.Td>{moment(row?.promotedOn).format("MMMM Do YYYY")}</Table.Td>
		</Table.Tr>
	));
	useEffect(() => {
		async function getPromotion() {
			const { data } = await fetch(`/promotions/staffs/${empid}`);
			setQueryData(data);
			const paginated: any[] = chunk(data, 50);
			setSortedData(paginated[0]);
		}
		getPromotion();
	}, []);

	return (
		<section className='flex flex-col gap-4'>
			<PaginatedTable
				depth=''
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

export default Promotions;
