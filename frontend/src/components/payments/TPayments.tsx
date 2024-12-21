"use client";
import React, { useEffect, useRef, useState } from "react";
import PaginatedTable from "@/components/PaginatedTable";
import Link from "next/link";
import { useEdit, useFetch } from "@/hooks/useQueries";
import {
	Table,
	ActionIcon,
	NumberFormatter,
	Select,
	TextInput,
	Text,
	Button,
	NumberInput,
	Drawer,
} from "@mantine/core";
import { IconEye, IconPencil, IconReceipt } from "@tabler/icons-react";
import { modals } from "@mantine/modals";
import chunk from "@/libs/chunk";
import moment from "moment";
import { sessions } from "@/libs/sessions";
import { useDisclosure } from "@mantine/hooks";
import { userContext } from "@/context/User";

const TPayments = () => {
	const { user } = React.useContext(userContext);

	const permission = user?.permissions?.payments;

	const { loading, data, fetch } = useFetch();
	const { post } = useEdit();
	const [opened, { open, close }] = useDisclosure(false);
	const [eData, setEdata] = useState<any>({});
	const [ePaid, setEpaid] = useState(0);
	const [eStatus, setEstatus] = useState("");
	const tellerRef: any = useRef(null);
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
	const openViewModal = (edata: any) => {
		modals.openConfirmModal({
			title: `Viewing payment - ${edata?.payment_id} for ${edata?.student?.admission_no}`,
			children: (
				<section className='flex flex-col gap-2'>
					<section className='flex gap-3'>
						<Select
							checkIconPosition='right'
							label='Term'
							placeholder='Select term'
							data={["1st term", "2nd term", "3rd term"]}
							defaultValue={edata?.term}
							className='w-[6.5rem]'
							disabled
						/>
						<Select
							checkIconPosition='right'
							label='Session'
							data={sessions}
							placeholder='Select session'
							disabled
							allowDeselect={false}
							defaultValue={edata?.session}
							className='w-[7.5rem]'
						/>
						<div className='flex gap-4 items-center self-end'>
							<Text>Status: </Text>
							<Button
								className={`pointer-events-none ${getStatusColor(
									edata?.status
								)}`}
							>
								{edata?.status}
							</Button>
						</div>
					</section>

					<section>
						<div className='flex justify-between items-center'>
							<Text fw={600}>Payment item</Text>
							<Text fw={600}>
								Balance:{" "}
								<NumberFormatter
									prefix='N '
									value={edata?.total - edata?.paid}
									thousandSeparator
								/>
							</Text>
						</div>

						<NumberInput
							prefix='N '
							thousandSeparator
							min={0}
							max={edata?.total}
							defaultValue={edata?.paid}
							hideControls
							label='Amount paid'
							disabled
						/>
						<Select
							checkIconPosition='right'
							label='Payment method'
							disabled
							data={["Cash", "UBA", "BMFB", "BMFB (PTA)", "Keystone Bank"]}
							defaultValue={edata?.payment_method}
						/>
						{edata?.payment_method !== "Cash" && (
							<TextInput
								mt={10}
								defaultValue={edata?.teller_no}
								label='Teller no'
								disabled
							/>
						)}
					</section>
				</section>
			),
			labels: {
				cancel: "Cancel",
				confirm: "",
			},
			cancelProps: {
				className: "bg-black text-white transition duration-300",
			},
			confirmProps: {
				display: "none",
			},
		});
	};

	const [queryData, setQueryData] = useState(data);
	const [sortedData, setSortedData] = useState([]);
	const [searchedData, setSearchedData] = useState([]);
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
				<ActionIcon variant='outline' aria-label='action menu'>
					<IconReceipt style={{ width: "70%", height: "70%" }} stroke={2} />
				</ActionIcon>
				<ActionIcon
					variant='outline'
					color='teal'
					disabled={row?.status === "Cancelled" || !permission?.edit}
					aria-label='action menu'
					onClick={() => {
						setEdata(row);
						setEpaid(row?.paid);
						setEstatus(row?.status);
						open();
					}}
				>
					<IconPencil style={{ width: "70%", height: "70%" }} stroke={2} />
				</ActionIcon>
				<ActionIcon
					variant='outline'
					color='orange'
					aria-label='action menu'
					onClick={() => {
						openViewModal(row);
					}}
				>
					<IconEye style={{ width: "70%", height: "70%" }} stroke={2} />
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
				<ActionIcon
					variant='outline'
					color='teal'
					disabled={row?.status === "Cancelled"}
					aria-label='action menu'
					onClick={() => {
						setEdata(row);
						setEpaid(row?.paid);
						setEstatus(row?.status);
						open();
					}}
				>
					<IconPencil style={{ width: "70%", height: "70%" }} stroke={2} />
				</ActionIcon>
				<ActionIcon
					variant='outline'
					color='orange'
					aria-label='action menu'
					onClick={() => {
						openViewModal(row);
					}}
				>
					<IconEye style={{ width: "70%", height: "70%" }} stroke={2} />
				</ActionIcon>
			</Table.Td>
		</Table.Tr>
	));
	useEffect(() => {
		const getAll = async () => {
			const { data } = await fetch("/payments");
			setQueryData(data);
			const paginated: any[] = chunk(data, 50);
			setSortedData(paginated[0]);
		};

		getAll();
	}, []);
	useEffect(() => {
		if (ePaid === eData?.total) {
			setEstatus("Paid");
		} else if (ePaid > 0) {
			setEstatus("Partly paid");
		} else if (ePaid === 0) {
			setEstatus("Unpaid");
		}
	}, [ePaid]);
	return (
		<section className='flex flex-col gap-4 p-3 bg-white '>
			<div className='flex justify-between mt-2'>
				<h2 className='font-bold text-xl text-blue-700'>Payments</h2>
				<div className='flex gap-3 items-center'>
					{permission?.create && (
						<Link
							className='bg-teal-500 text-white hover:bg-teal-700 px-4 py-2 rounded-sm transition duration-200 ease-linear'
							href='payments/create'
						>
							Make a new payment
						</Link>
					)}
				</div>
			</div>
			<div className='p-2'>
				<PaginatedTable
					depth='student'
					showlast={true}
					showSearch
					rows={rows}
					searchedRows={searchedRows}
					data={queryData}
					headers={headers}
					placeholder='Search by student name or admission no or payment id'
					setSortedData={setSortedData}
					setSearchedData={setSearchedData}
					loading={loading}
					count={queryData.length}
				/>
			</div>
			<Drawer
				opened={opened}
				onClose={close}
				title={`Update payment - ${eData?.payment_id} for ${eData?.student?.admission_no}`}
				className='flex flex-col gap-4'
			>
				<form
					className='flex flex-col gap-2'
					onSubmit={async (e) => {
						e.preventDefault();
						await post(`/payments/edit/${eData?.payment_id}`, {
							status: eStatus,
							teller_no: tellerRef?.current?.value,
							paid: ePaid,
						});
						const { data } = await fetch("/payments");
						setQueryData(data);
						const paginated: any[] = chunk(data, 50);
						setSortedData(paginated[0]);
						close();
						setEpaid(0);
						setEstatus("");
					}}
				>
					<section className='flex gap-3'>
						<Select
							checkIconPosition='right'
							label='Term'
							placeholder='Select term'
							data={["1st term", "2nd term", "3rd term"]}
							defaultValue={eData?.term}
							className='w-[6.5rem]'
							disabled
						/>
						<Select
							checkIconPosition='right'
							label='Session'
							data={sessions}
							placeholder='Select session'
							disabled
							allowDeselect={false}
							defaultValue={eData?.session}
							className='w-[7.5rem]'
						/>
						<div className='flex gap-4 items-center'>
							<Text>Status: </Text>
							<Button
								className={`pointer-events-none ${getStatusColor(eStatus)}`}
							>
								{eStatus}
							</Button>
						</div>
					</section>

					<section className='flex flex-col gap-3'>
						<Select
							checkIconPosition='right'
							label='Payment method'
							disabled
							data={["Cash", "UBA", "BMFB", "BMFB (PTA)", "Keystone Bank"]}
							defaultValue={eData?.payment_method}
						/>
						{eData?.payment_method !== "Cash" && (
							<TextInput
								mt={10}
								defaultValue={eData?.teller_no}
								label='Teller no'
								ref={tellerRef}
							/>
						)}
						<NumberInput
							prefix='N '
							thousandSeparator
							min={0}
							max={eData?.total}
							defaultValue={eData?.paid}
							hideControls
							label='Amount paid'
							// ref={paidRef}
							error={
								ePaid > eData?.total
									? "Amount paid can not be less than or greater than total"
									: false
							}
							onChange={(value: any) => {
								setEpaid(value);
							}}
						/>

						<div className='flex justify-between items-center my-6'>
							<Text fw={600}>Payment item</Text>
							<Text fw={600}>
								Balance:{" "}
								<NumberFormatter
									prefix='N '
									value={eData?.total - eData?.paid}
									thousandSeparator
								/>
							</Text>
						</div>
					</section>
					<div className='flex gap-4 items-center self-end'>
						<Button
							color='black'
							onClick={() => {
								close();
							}}
						>
							Cancel
						</Button>
						<Button color='teal' type='submit'>
							Update payment
						</Button>
					</div>
				</form>
			</Drawer>
		</section>
	);
};

export default TPayments;
