"use client";
import React, { useEffect, useState } from "react";
import PaginatedTable from "@/components/PaginatedTable";
import { useEdit, useFetch } from "@/hooks/useQueries";
import {
	Table,
	NumberFormatter,
	Select,
	TextInput,
	Text,
	Button,
	NumberInput,
	LoadingOverlay,
	Drawer,
} from "@mantine/core";

import chunk from "@/libs/chunk";
import moment from "moment";
import { sessions } from "@/libs/sessions";
import { useDisclosure } from "@mantine/hooks";
import { userContext } from "@/context/User";

const Reversed = () => {
	const { user } = React.useContext(userContext);
	const [opened, { open, close }] = useDisclosure(false);

	const permission = user?.permissions?.payments;
	const { loading, data, fetch } = useFetch();
	const { post, loading: pLoading } = useEdit();
	const [queryData, setQueryData] = useState(data);
	const [sortedData, setSortedData] = useState([]);
	const [searchedData, setSearchedData] = useState([]);
	const [payments, setPayments] = useState([]);
	const [paymentsList, setPaymentsList] = useState([]);

	const [toCancel, setToCancel] = useState<any>(null);
	const headers = [
		"id",
		"addmission no.",
		"student name",
		"method",
		"teller no",
		"total",
		"paid",
		"term - session",
		"Date cancelled",
	];

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
			<Table.Td>{moment(row?.updatedAt).format("MMMM Do YYYY")}</Table.Td>
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
			<Table.Td>{moment(row?.updatedAt).format("MMMM Do YYYY")}</Table.Td>
		</Table.Tr>
	));
	useEffect(() => {
		const getAll = async () => {
			const { data: notCancelled } = await fetch("/payments");
			const { data } = await fetch("/payments/reversed");
			const sortedpayments = notCancelled?.map((not: any) => {
				return {
					value: not?.payment_id,
					label: `${not?.payment_id} - ${not?.item}`,
				};
			});
			setPayments(notCancelled);
			setPaymentsList(sortedpayments);
			setQueryData(data);
			const paginated: any[] = chunk(data, 50);
			setSortedData(paginated[0]);
		};

		getAll();
	}, []);

	return (
		<section className='flex flex-col gap-4 p-3 bg-white'>
			<div className='flex justify-between mt-2'>
				<h2 className='font-bold text-xl text-blue-700'>Cancelled Payments</h2>
				<div className='flex gap-3 items-center'>
					{permission?.create && (
						<Button
							color='red'
							onClick={() => {
								open();
							}}
						>
							Cancel a payment
						</Button>
					)}
				</div>
			</div>
			<Drawer
				opened={opened}
				onClose={() => {
					setToCancel(null);
					close();
				}}
				title='Cancel a payment'
				className='flex flex-col gap-4'
			>
				<form
					className='flex flex-col gap-6'
					onSubmit={async (e) => {
						e.preventDefault();
						await post(`payments/reverse/${toCancel?.payment_id}`);
						setToCancel(null);
						const { data } = await fetch("/payments/reversed");
						const paginated: any[] = chunk(data, 50);
						setSortedData(paginated[0]);
					}}
				>
					<Select
						checkIconPosition='right'
						label='Payment id'
						placeholder='Select payment to reverse'
						data={paymentsList}
						searchable
						onChange={(value: string | null) => {
							const found: any = payments?.find(
								(payment: any) => payment?.payment_id == value
							);

							setToCancel(found);
						}}
					/>
					{toCancel !== null ? (
						<div className='flex flex-col gap-4'>
							<div className='flex flex-wrap gap-3'>
								<Text>
									Student's name - Admission No:{" "}
									<i>
										{toCancel?.student?.first_name}{" "}
										{toCancel?.student?.last_name} -{" "}
										{toCancel?.student?.admission_no}
									</i>
								</Text>
								<Text>
									Student's Class:
									<i>{toCancel?.student?.class} </i>
								</Text>
							</div>
							<section className='flex gap-3'>
								<Select
									checkIconPosition='right'
									label='Term'
									placeholder='Select term'
									data={["1st term", "2nd term", "3rd term"]}
									defaultValue={toCancel?.term}
									disabled
								/>
								<Select
									checkIconPosition='right'
									label='Session'
									data={sessions}
									placeholder='Select session'
									disabled
									allowDeselect={false}
									defaultValue={toCancel?.session}
								/>
							</section>

							<section>
								<div className='flex justify-between items-center'>
									<Text fw={600}>Payment item</Text>
									<Text fw={600}>
										Balance:{" "}
										<NumberFormatter
											prefix='N '
											value={toCancel?.total - toCancel?.paid}
											thousandSeparator
										/>
									</Text>
								</div>

								<NumberInput
									prefix='N '
									thousandSeparator
									min={0}
									max={toCancel?.total}
									defaultValue={toCancel?.paid}
									hideControls
									label='Amount paid'
									disabled
								/>
								<Select
									checkIconPosition='right'
									label='Payment method'
									disabled
									data={["Cash", "UBA", "BMFB", "BMFB (PTA)", "Keystone Bank"]}
									defaultValue={toCancel?.payment_method}
								/>
								{toCancel?.payment_method !== "Cash" && (
									<TextInput
										mt={10}
										defaultValue={toCancel?.teller_no}
										label='Teller no'
										disabled
									/>
								)}
							</section>
							<LoadingOverlay visible={pLoading} />
						</div>
					) : (
						<div className='flex justify-center items-center h-32'>
							Selct payment to cancel
						</div>
					)}
					<div className='flex gap-4 items-center self-end mt-4'>
						<Button
							color='black'
							onClick={() => {
								close();
							}}
						>
							Close
						</Button>
						<Button color='red' type='submit'>
							Cancel Payment
						</Button>
					</div>
				</form>
			</Drawer>
			<div className=' p-2'>
				<PaginatedTable
					depth='student'
					showlast={false}
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
		</section>
	);
};

export default Reversed;
