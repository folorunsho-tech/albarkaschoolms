"use client";
import React, { useEffect, useState } from "react";
import {
	Button,
	TextInput,
	Tabs,
	rem,
	Select,
	LoadingOverlay,
	Text,
	NumberFormatter,
	Table,
	ScrollArea,
	ActionIcon,
	NumberInput,
} from "@mantine/core";
import { useRouter } from "next/navigation";
import {
	IconArrowNarrowLeft,
	IconCashRegister,
	IconHistory,
	IconPrinter,
	IconReceipt,
} from "@tabler/icons-react";
import { useFetch, usePost } from "@/hooks/useQueries";
import { sessions, currSession, currTerm } from "@/libs/sessions";
import PaymentsHistory from "@/components/views/PaymentsHistory";
const MakePayments = () => {
	const { fetch } = useFetch();
	const router = useRouter();
	const [session, setSession] = useState("");
	const [term, setTerm] = useState<string | undefined>("");
	const [student, setStudent] = useState<any>({});
	const [students, setStudents] = useState<any[]>([]);
	const [fees, setFees] = useState<any[]>([]);
	const [status, setStatus] = useState("Unpaid");
	const [studentsList, setStudentsList] = useState<any[]>([]);
	const [feesList, setFeesList] = useState<any[]>([]);
	const [paymentItem, setPaymentItem] = useState<any>({});
	const [transactions, setTransactions] = useState<any[]>([]);
	const [payment_method, setPayment_method] = useState("Cash");
	const [teller_no, setTeller_no] = useState("");
	const [paid, setPaid] = useState(0);
	const [enablePrint, setEnablePrint] = useState(false);
	const { post, loading } = usePost();
	const balance = Number(paymentItem?.amount) - paid;
	useEffect(() => {
		const getAll = async () => {
			const { data } = await fetch("/students");
			const { data: fees } = await fetch("/feesgroup");
			const sortedStudents = data?.map((s: any) => {
				return {
					value: s.admission_no,
					label: `${s.admission_no} - ${s.first_name} ${s.last_name}`,
				};
			});
			const sortedFees = fees?.map((fee: any) => {
				return {
					label: `${fee?.name} - ${fee?.amount} - ${fee?.school_section}`,
					value: fee?.id,
				};
			});
			setStudents(data);
			setFees(fees);
			setStudentsList(sortedStudents);
			setFeesList(sortedFees);
			setSession(currSession);
			setTerm(currTerm);
		};
		getAll();
	}, []);
	useEffect(() => {
		setTransactions([]);
	}, [student?.admission_no]);
	useEffect(() => {
		if (paid == Number(paymentItem?.amount)) {
			setStatus("Paid");
		} else if (paid > 0) {
			setStatus("Partly paid");
		} else if (paid == 0) {
			setStatus("Unpaid");
		}
	}, [balance]);
	const iconStyle = { width: rem(15), height: rem(15) };

	const getStatusColor = (status: string) => {
		if (status === "Partly paid") {
			return "orange";
		} else if (status === "Paid") {
			return "green";
		} else {
			return "red";
		}
	};
	const submit = async () => {
		const { data } = await post("/payments/create", {
			paid,
			total: Number(paymentItem?.amount),
			status,
			session,
			class: student?.curr_class?.name,
			term,
			payment_method,
			student_id: student?.id,
			teller_no,
			section: paymentItem?.school_section,
			item: paymentItem?.name,
		});
		setTransactions([data, ...transactions]);
		setEnablePrint(true);
	};
	return (
		<section className='w-full p-3'>
			<div className='flex justify-between pr-12'>
				<Button
					leftSection={
						<IconArrowNarrowLeft
							size={25}
							onClick={() => {
								router.back();
							}}
						/>
					}
					onClick={() => {
						router.back();
					}}
				>
					Go back
				</Button>
				<Button
					color='teal'
					leftSection={<IconPrinter size={25} />}
					disabled={!enablePrint}
				>
					Print reciept
				</Button>
			</div>
			<section className='bg-white p-3 space-y-3 mt-3 h-[40rem]'>
				<div className='flex items-center gap-2 justify-between'>
					<Select
						checkIconPosition='right'
						label='Select a student'
						placeholder='Search for student by admission no'
						data={studentsList}
						onDropdownOpen={async () => {
							const { data } = await fetch("/students");

							const sortedStudents = data?.map((s: any) => {
								return {
									value: s.admission_no,
									label: `${s.admission_no} - ${s.first_name} ${s.last_name}`,
								};
							});

							setStudents(data);

							setStudentsList(sortedStudents);
						}}
						searchable
						allowDeselect={false}
						nothingFoundMessage='Nothing found...'
						className='w-[25rem]'
						onChange={(value: any) => {
							const found: any = students.find(
								(s: any) => s.admission_no == value
							);
							setStudent(found);
						}}
					/>
					<div className='flex gap-2 flex-wrap justify-end'>
						<Text size='sm'>
							Guardian / Parent name: <b>{student?.guardian_name}</b>
						</Text>
						<Text size='sm'>
							Guardian / Parent telephone: <b>{student?.guardian_telephone}</b>
						</Text>
						<Text size='sm'>
							Class: <b>{student?.curr_class?.name}</b>
						</Text>
						<Text size='sm'>
							Sex: <b>{student?.sex}</b>
						</Text>
					</div>
				</div>
				{student?.admission_no ? (
					<Tabs defaultValue='make_payment' keepMounted={false}>
						<Tabs.List>
							<Tabs.Tab
								value='make_payment'
								leftSection={<IconCashRegister style={iconStyle} />}
							>
								Make payment
							</Tabs.Tab>
							<Tabs.Tab
								value='history'
								leftSection={<IconHistory style={iconStyle} />}
							>
								Payments history
							</Tabs.Tab>
						</Tabs.List>

						<Tabs.Panel value='make_payment' className='relative'>
							<form
								className='flex justify-between'
								onSubmit={(e) => {
									e.preventDefault();
									submit();
								}}
							>
								<section className='space-y-4'>
									<div className='flex gap-6 mt-3'>
										<Select
											checkIconPosition='right'
											label='Term'
											placeholder='Select term'
											data={["1st term", "2nd term", "3rd term"]}
											allowDeselect={false}
											value={term}
											searchable
											nothingFoundMessage='Nothing found...'
											className='w-[8rem]'
											onChange={(value: any) => {
												setTerm(value);
											}}
										/>
										<Select
											checkIconPosition='right'
											label='Session'
											placeholder='Select session'
											data={sessions}
											searchable
											allowDeselect={false}
											value={session}
											nothingFoundMessage='Nothing found...'
											className='w-[9rem]'
											onChange={(value: any) => {
												setSession(value);
											}}
										/>
										<Button
											className='pointer-events-none self-end'
											color={getStatusColor(status)}
										>
											{status}
										</Button>
									</div>
									<div className='flex items-center gap-3'>
										<Select
											checkIconPosition='right'
											label='Add payment item'
											placeholder='Search for payment by name or school section to add'
											data={feesList}
											searchable
											allowDeselect={false}
											nothingFoundMessage='Nothing found...'
											className='w-[24rem]'
											onChange={(value: any) => {
												const found: any = fees?.find(
													(fee: any) => fee?.id == value
												);
												setPaymentItem(found);
											}}
										/>
									</div>
									<div className='flex gap-4'>
										<NumberInput
											prefix='N '
											thousandSeparator
											value={paid}
											min={0}
											max={Number(paymentItem?.amount)}
											defaultValue={0}
											hideControls
											allowDecimal={false}
											allowNegative={false}
											error={
												paid > Number(paymentItem?.amount)
													? "Amount paid can not be less than or greater than total"
													: false
											}
											onChange={(value: any) => {
												setPaid(Number(value));
											}}
											label='Amount paid'
											className='w-32'
										/>
										<Select
											checkIconPosition='right'
											label='Select payment method'
											placeholder='Select payment method'
											data={[
												"Cash",
												"UBA",
												"BMFB",
												"BMFB (PTA)",
												"Keystone Bank",
											]}
											allowDeselect={false}
											searchable
											value={payment_method}
											nothingFoundMessage='Nothing found...'
											onChange={(value: any) => {
												setPayment_method(value);
											}}
										/>
									</div>
									{payment_method !== "Cash" && (
										<TextInput
											value={teller_no}
											onChange={(e) => {
												setTeller_no(e.currentTarget.value);
											}}
											label='Teller no'
										/>
									)}
									<div className='flex gap-4 items-center'>
										<Button
											color='black'
											onClick={() => {
												router.back();
											}}
										>
											Cancel
										</Button>
										<Button color='teal' type='submit'>
											Make payment
										</Button>
									</div>
								</section>
								<section className='w-2/4'>
									<div className='flex justify-between items-center my-4 pr-12'>
										<Text fw={600}>Transactions</Text>
										<Text fw={600}>
											Date: {new Date().toLocaleDateString()}
										</Text>
									</div>
									<ScrollArea h={500}>
										<Table verticalSpacing='sm'>
											<Table.Thead className='bg-gray-300'>
												<Table.Tr>
													<Table.Th>Name</Table.Th>
													<Table.Th>Amount</Table.Th>
													<Table.Th>Paid</Table.Th>
													<Table.Th>Balance</Table.Th>
													<Table.Th>Status</Table.Th>
												</Table.Tr>
											</Table.Thead>
											<Table.Tbody>
												{transactions?.map((transaction, index) => (
													<Table.Tr key={transaction?.payment_id + index}>
														<Table.Td>
															{transaction?.item} - {transaction?.section}
														</Table.Td>
														<Table.Td>
															<NumberFormatter
																prefix='N '
																value={transaction?.total}
																thousandSeparator
															/>
														</Table.Td>
														<Table.Td>
															<NumberFormatter
																prefix='N '
																value={transaction?.paid}
																thousandSeparator
															/>
														</Table.Td>
														<Table.Td>
															<NumberFormatter
																prefix='N '
																value={
																	Number(transaction?.total) -
																	Number(transaction?.paid)
																}
																thousandSeparator
															/>
														</Table.Td>
														<Table.Td>
															<Button
																className='pointer-events-none'
																color={getStatusColor(transaction?.status)}
															>
																{transaction?.status}
															</Button>
														</Table.Td>
														<Table.Td></Table.Td>
														<Table.Td>
															<ActionIcon variant='filled' color='violet'>
																<IconReceipt onClick={() => {}} />
															</ActionIcon>
														</Table.Td>
													</Table.Tr>
												))}
											</Table.Tbody>
										</Table>
									</ScrollArea>
								</section>
							</form>
							<LoadingOverlay visible={loading} />
						</Tabs.Panel>

						<Tabs.Panel value='history'>
							<PaymentsHistory student={student} />
						</Tabs.Panel>
					</Tabs>
				) : (
					<h2 className='text-center font-semibold text-xl pt-[100px]'>
						Select a student to make payment for
					</h2>
				)}
			</section>
		</section>
	);
};

export default MakePayments;
