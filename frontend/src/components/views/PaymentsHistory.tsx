import React, { useEffect, useState } from "react";
import PaginatedTable from "../PaginatedTable";
import { ActionIcon, NumberFormatter, Table } from "@mantine/core";
import moment from "moment";
import chunk from "@/libs/chunk";
import { IconReceipt } from "@tabler/icons-react";
import { useFetch } from "@/hooks/useQueries";
import { useReactToPrint } from "react-to-print";

const PaymentsHistory = ({ student }: { student: any }) => {
	const headers = [
		"id",
		"addmission no.",
		"student name",
		"method",
		"teller no",
		"total",
		"paid",
		"term - session",
		"status",
		"Date",
	];
	const getStatusColor = (status: string) => {
		if (status === "Partly paid") {
			return "bg-orange-500 text-white";
		} else if (status === "Paid") {
			return "bg-green-500 text-white";
		} else if (status === "Unpaid") {
			return "bg-red-500 text-white";
		} else if (status === "Cancelled") {
			return "bg-red-500 text-white";
		}
	};
	const contentRef = React.useRef(null);
	const reactToPrintFn: any = useReactToPrint({ contentRef });
	const { loading, data, fetch } = useFetch();
	const [queryData, setQueryData] = useState(data);
	const [sortedData, setSortedData] = useState([]);
	const [searchedData, setSearchedData] = useState([]);
	const rows = sortedData?.map((row: any, index: number) => (
		<Table.Tr key={row?.payment_id}>
			<Table.Td>{index + 1}</Table.Td>
			<Table.Td>{row?.payment_id}</Table.Td>
			<Table.Td>{row?.student?.admission_no}</Table.Td>
			<Table.Td>
				{row?.student?.first_name} {row?.student?.last_name}
			</Table.Td>
			<Table.Td>{row?.payment_method}</Table.Td>
			<Table.Td>{row?.teller_no}</Table.Td>
			<Table.Td>
				<NumberFormatter prefix='N ' value={row?.total} thousandSeparator />
			</Table.Td>
			<Table.Td>
				<NumberFormatter prefix='N ' value={row?.paid} thousandSeparator />
			</Table.Td>
			<Table.Td>
				{row?.term} - {row?.session}
			</Table.Td>
			<Table.Td className={getStatusColor(row?.status)}>{row?.status}</Table.Td>
			<Table.Td>{moment(row?.createdAt).format("MMMM Do YYYY")}</Table.Td>
			<Table.Td className='flex items-center gap-3 '>
				<ActionIcon
					variant='outline'
					aria-label='action menu'
					onClick={reactToPrintFn}
				>
					<IconReceipt style={{ width: "70%", height: "70%" }} stroke={2} />
				</ActionIcon>
			</Table.Td>
		</Table.Tr>
	));
	const searchedRows = searchedData?.map((row: any, index: number) => (
		<Table.Tr key={row?.payment_id}>
			<Table.Td>{index + 1}</Table.Td>
			<Table.Td>{row?.payment_id}</Table.Td>
			<Table.Td>{row?.student?.admission_no}</Table.Td>
			<Table.Td>
				{row?.student?.first_name} {row?.student?.last_name}
			</Table.Td>
			<Table.Td>{row?.payment_method}</Table.Td>
			<Table.Td>{row?.teller_no}</Table.Td>
			<Table.Td>
				<NumberFormatter prefix='N ' value={row?.total} thousandSeparator />
			</Table.Td>
			<Table.Td>
				<NumberFormatter prefix='N ' value={row?.paid} thousandSeparator />
			</Table.Td>
			<Table.Td>
				{row?.term} - {row?.session}
			</Table.Td>
			<Table.Td className={getStatusColor(row?.status)}>{row?.status}</Table.Td>
			<Table.Td>{moment(row?.createdAt).format("MMMM Do YYYY")}</Table.Td>
			<Table.Td className='flex items-center gap-3 '>
				<ActionIcon variant='outline' aria-label='action menu'>
					<IconReceipt style={{ width: "70%", height: "70%" }} stroke={2} />
				</ActionIcon>
			</Table.Td>
		</Table.Tr>
	));
	useEffect(() => {
		const getHis = async () => {
			const { data } = await fetch(`/payments/history/${student?.id}`);
			setQueryData(data);
			const paginated: any[] = chunk(data, 50);
			setSortedData(paginated[0]);
		};
		getHis();
	}, [student]);

	return (
		<>
			<PaginatedTable
				depth='student'
				showlast
				showSearch={false}
				rows={rows}
				searchedRows={searchedRows}
				data={queryData}
				headers={headers}
				placeholder='Search by student name or admission no'
				setSortedData={setSortedData}
				setSearchedData={setSearchedData}
				loading={loading}
				count={queryData.length}
			/>
			<section style={{ display: "none" }}>
				<div ref={contentRef}>
					<h2
						style={{
							width: 218,
							height: 100,
						}}
					>
						testing
					</h2>
				</div>
			</section>
		</>
	);
};

export default PaymentsHistory;
