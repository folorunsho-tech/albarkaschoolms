"use client";
import React, { useEffect, useState } from "react";
import PaginatedTable from "@/components/PaginatedTable";
import { useFetch, usePost } from "@/hooks/useQueries";
import {
	Table,
	Button,
	Drawer,
	Select,
	TextInput,
	LoadingOverlay,
	ActionIcon,
} from "@mantine/core";
import { useDisclosure } from "@mantine/hooks";
import moment from "moment";
import chunk from "@/libs/chunk";
import { useForm } from "react-hook-form";
import { IconEye } from "@tabler/icons-react";
import Link from "next/link";
import { userContext } from "@/context/User";

const Disengaged = () => {
	const { user } = React.useContext(userContext);

	const { loading, data, fetch } = useFetch();
	const { loading: pLoading, post } = usePost();
	const [opened, { open, close }] = useDisclosure(false);
	const [selected, setSelected] = useState("");
	const [method, setMethod] = useState("");
	const [staffSelectData, setStaffSelectData] = useState([]);
	const headers = [
		"empid",
		"emp date",
		"name",
		"sex",
		"appointment",
		"school section",
		"phone No",
		"method",
		"reason",
		"employer comment",
		"date of disengagement",
	];

	const permission = user?.permissions?.staffs;

	const [queryData, setQueryData] = useState(data);
	const [sortedData, setSortedData] = useState([]);
	const [searchedData, setSearchedData] = useState([]);
	const { register, reset, handleSubmit } = useForm();
	const rows = sortedData?.map((row: any, index: number) => (
		<Table.Tr key={row?.staff?.empid + index}>
			<Table.Td>{index + 1}</Table.Td>
			<Table.Td>{row?.staff?.empid}</Table.Td>
			<Table.Td>
				{moment(row?.staff?.date_of_emp).format("MMMM Do YYYY")}
			</Table.Td>
			<Table.Td>
				{row?.staff?.first_name} {row?.staff?.last_name}
			</Table.Td>
			<Table.Td>{row?.staff?.sex}</Table.Td>
			<Table.Td>{row?.staff?.curr_appointment?.name}</Table.Td>
			<Table.Td>{row?.staff?.school_section}</Table.Td>
			<Table.Td>{row?.staff?.telephone}</Table.Td>
			<Table.Td>{row?.method_of_disengagement}</Table.Td>
			<Table.Td>{row?.reason}</Table.Td>
			<Table.Td>{row?.employer_comment}</Table.Td>
			<Table.Td>
				{moment(row?.date_of_disengagement).format("MMMM Do YYYY")}
			</Table.Td>
			<Table.Td className='flex items-center gap-1 '>
				<ActionIcon variant='outline' aria-label='action menu'>
					<Link
						href={`staffs/view?id=${row?.staff?.empid}`}
						className='flex justify-center'
					>
						<IconEye style={{ width: "70%", height: "70%" }} stroke={2} />
					</Link>
				</ActionIcon>
			</Table.Td>
		</Table.Tr>
	));
	const searchedRows = searchedData?.map((row: any, index: number) => (
		<Table.Tr key={row?.staff?.empid + index}>
			<Table.Td>{index + 1}</Table.Td>
			<Table.Td>{row?.staff?.empid}</Table.Td>

			<Table.Td>
				{moment(row?.staff?.date_of_emp).format("MMMM Do YYYY")}
			</Table.Td>
			<Table.Td>
				{row?.staff?.first_name} {row?.staff?.last_name}
			</Table.Td>
			<Table.Td>{row?.staff?.sex}</Table.Td>
			<Table.Td>{row?.staff?.curr_appointment?.name}</Table.Td>
			<Table.Td>{row?.staff?.school_section}</Table.Td>
			<Table.Td>{row?.staff?.telephone}</Table.Td>
			<Table.Td>{row?.method_of_disengagement}</Table.Td>
			<Table.Td>{row?.reason}</Table.Td>
			<Table.Td>{row?.employer_comment}</Table.Td>
			<Table.Td>
				{moment(row?.date_of_disengagement).format("MMMM Do YYYY")}
			</Table.Td>
			<Table.Td className='flex items-center gap-1 '>
				<ActionIcon variant='outline' aria-label='action menu'>
					<Link
						href={`staffs/view?id=${row?.staff?.empid}`}
						className='flex justify-center'
					>
						<IconEye style={{ width: "70%", height: "70%" }} stroke={2} />
					</Link>
				</ActionIcon>
			</Table.Td>
		</Table.Tr>
	));
	useEffect(() => {
		const getAll = async () => {
			const { data } = await fetch("/disengagements/staffs");
			const { data: staffs } = await fetch("/staffs");
			const sortedStaff: any = staffs.map((staff: any) => {
				return {
					value: staff.empid,
					label: `${staff.first_name} ${staff.last_name} - ${staff.empid}`,
				};
			});
			setQueryData(data);
			setStaffSelectData(sortedStaff);
			const paginated: any[] = chunk(data, 50);
			setSortedData(paginated[0]);
		};

		getAll();
	}, []);
	const onSubmit = async (data: any) => {
		await post(`/disengagements/staffs`, {
			...data,
			method_of_disengagement: method,
			staff_id: selected,
		});
		const { data: qData } = await fetch("/disengagements/staffs");
		const paginated: any[] = chunk(qData, 50);
		setSortedData(paginated[0]);

		setSelected("");
		reset();
	};
	return (
		<section className='flex flex-col gap-4 p-4 bg-white'>
			<div className='flex justify-between mt-2'>
				<h2 className='font-bold text-xl text-blue-700'>Disengaged Staffs</h2>
				<div className='flex gap-3 items-center'>
					{/* <Button
						leftSection={<IconPrinter />}
						className='bg-indigo-500 text-white hover:bg-indigo-700 px-4 py-2 rounded-sm transition duration-200 ease-linear'
					>
						Print
					</Button> */}
					<Button
						disabled={!permission?.create}
						onClick={() => {
							open();
						}}
						color='red'
					>
						Disengage Staff
					</Button>
				</div>
			</div>
			<Drawer
				opened={opened}
				onClose={() => {
					close();
					setSelected("");
					setMethod("");
					reset();
				}}
				title='Disengage a staff'
			>
				<form className='flex flex-col gap-4' onSubmit={handleSubmit(onSubmit)}>
					<Select
						required
						checkIconPosition='right'
						label='Staff to disengage'
						placeholder='Select a staff'
						data={staffSelectData}
						allowDeselect={false}
						searchable
						nothingFoundMessage='Nothing found...'
						onChange={(value: any) => {
							setSelected(value);
						}}
					/>
					{selected !== "" && (
						<section className='space-y-4'>
							<Select
								required
								checkIconPosition='right'
								label='Method of disengagement'
								placeholder='Select a method'
								allowDeselect={false}
								data={[
									"Sacked",
									"Left un-announced",
									"Left for another school",
									"Resignation",
									"NYSC POP",
								]}
								searchable
								nothingFoundMessage='Nothing found...'
								onChange={(value: any) => {
									setMethod(value);
								}}
							/>
							{method === "Sacked" && (
								<TextInput label='Sack reason' {...register("reason")} />
							)}
							<TextInput
								label="Employer's comment"
								{...register("employer_comment")}
							/>
						</section>
					)}
					<div className='flex gap-4 self-end'>
						<Button
							onClick={() => {
								close();
								setSelected("");
								setMethod("");
								reset();
							}}
							color='black'
						>
							Cancel
						</Button>
						<Button
							disabled={selected === "" || method === ""}
							type='submit'
							color='red'
						>
							Disengage
						</Button>
					</div>
				</form>
				<LoadingOverlay visible={pLoading} />
			</Drawer>
			<PaginatedTable
				depth='staff'
				showlast
				showSearch
				rows={rows}
				searchedRows={searchedRows}
				data={queryData}
				headers={headers}
				placeholder='Search by name or empid or appointment or school section or method or reason'
				setSortedData={setSortedData}
				setSearchedData={setSearchedData}
				loading={loading}
				count={queryData.length}
			/>
		</section>
	);
};

export default Disengaged;
