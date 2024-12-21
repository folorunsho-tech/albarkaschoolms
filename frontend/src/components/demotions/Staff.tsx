"use client";
import React, { useEffect, useState } from "react";
import PaginatedTable from "@/components/PaginatedTable";
import { useFetch, usePost } from "@/hooks/useQueries";
import {
	Table,
	Text,
	NumberFormatter,
	Button,
	Drawer,
	TextInput,
	Select,
	ComboboxItem,
	OptionsFilter,
} from "@mantine/core";

import chunk from "@/libs/chunk";
import moment from "moment";
import { useDisclosure } from "@mantine/hooks";
import { useForm } from "react-hook-form";
import { userContext } from "@/context/User";

const Staff = () => {
	const { user } = React.useContext(userContext);
	const { handleSubmit } = useForm();
	const { loading, data, fetch } = useFetch();
	const { post } = usePost();
	const headers = [
		"EMP No.",
		"Staff name",
		"demoted from",
		"prev salary",
		"demoted to",
		"current salary",
		"demoted On",
	];
	const [selectedStaffId, setSelectedStaffId] = useState("");
	const [selectedAppID, setSelectedAppID] = useState("");
	const [staffSelectData, setStaffSelectData] = useState([]);
	const [staffsList, setStaffsList] = useState([]);
	const [appSelectData, setAppSelectData] = useState([]);
	const [appointments, setAppointments] = useState([]);
	const [selectedStaff, setSelectedStaff] = useState<any>({});
	const [selectedApp, setSelectedApp] = useState<any>({});
	const [queryData, setQueryData] = useState(data);
	const [sortedData, setSortedData] = useState([]);
	const [searchedData, setSearchedData] = useState([]);
	const [opened, { open, close }] = useDisclosure(false);
	const [new_salary, setNewSalary] = useState("");
	const rows = sortedData?.map((row: any, index: number) => (
		<Table.Tr key={row?.id}>
			<Table.Td>{index + 1}</Table.Td>
			<Table.Td>{row?.empid}</Table.Td>
			<Table.Td>
				{row?.staff?.first_name} {row?.staff?.last_name}
			</Table.Td>
			<Table.Td>
				{row?.from} - {row?.from_section}
			</Table.Td>
			<Table.Td>
				<NumberFormatter
					prefix='N '
					value={row?.prev_salary}
					thousandSeparator
				/>
			</Table.Td>
			<Table.Td>
				{row?.to?.name} - {row?.to?.school_section}
			</Table.Td>
			<Table.Td>
				<NumberFormatter
					prefix='N '
					value={row?.curr_salary}
					thousandSeparator
				/>
			</Table.Td>
			<Table.Td>{moment(row?.demotedOn).format("MMMM Do YYYY")}</Table.Td>
		</Table.Tr>
	));
	const searchedRows = searchedData?.map((row: any, index: number) => (
		<Table.Tr key={row?.id}>
			<Table.Td>{index + 1}</Table.Td>
			<Table.Td>{row?.empid}</Table.Td>
			<Table.Td>
				{row?.staff?.first_name} {row?.staff?.last_name}
			</Table.Td>
			<Table.Td>
				{row?.from} - {row?.from_section}
			</Table.Td>
			<Table.Td>
				<NumberFormatter
					prefix='N '
					value={row?.prev_salary}
					thousandSeparator
				/>
			</Table.Td>
			<Table.Td>
				{row?.to?.name} - {row?.to?.school_section}
			</Table.Td>
			<Table.Td>
				<NumberFormatter
					prefix='N '
					value={row?.curr_salary}
					thousandSeparator
				/>
			</Table.Td>
			<Table.Td>{moment(row?.demotedOn).format("MMMM Do YYYY")}</Table.Td>
		</Table.Tr>
	));
	useEffect(() => {
		const getAll = async () => {
			const { data } = await fetch("/demotions/staffs");
			const { data: staffs } = await fetch("/staffs");
			const { data: appointmentsList } = await fetch("/appointments");
			setQueryData(data);
			const sortedStaff: any = staffs.map((staff: any) => {
				return {
					value: staff.empid,
					label: `${staff.first_name} ${staff.last_name} - ${staff.empid}`,
				};
			});
			setStaffSelectData(sortedStaff);
			const sortedApp: any = appointmentsList.map((app: any) => {
				return {
					value: app.id,
					label: `${app.name} - ${app.school_section}`,
				};
			});
			setAppSelectData(sortedApp);
			setStaffsList(staffs);
			setAppointments(appointmentsList);

			const paginated: any[] = chunk(data, 50);
			setSortedData(paginated[0]);
		};

		getAll();
	}, []);
	const optionsFilter: OptionsFilter = ({ options, search }) => {
		const searched = search.toLowerCase().trim();
		return (options as ComboboxItem[]).filter(
			(option) =>
				option?.label.includes(searched) || option?.value.includes(searched)
		);
	};
	const optionsAFilter: OptionsFilter = ({ options, search }) => {
		const searched = search.toLowerCase().trim();
		return (options as ComboboxItem[]).filter(
			(option) =>
				option?.label.includes(searched) || option?.value.includes(searched)
		);
	};

	return (
		<section className='flex flex-col gap-4 p-3 bg-white'>
			<div className='flex justify-between mt-2'>
				<h2 className='font-bold text-xl text-blue-700'>Staffs Demotion</h2>
				<div className='flex gap-3 items-center'>
					<Button
						disabled={!user?.permissions?.staffs?.create}
						onClick={() => {
							open();
						}}
						className='bg-red-500 text-white hover:bg-red-700 px-4 py-2 rounded-sm transition duration-200 ease-linear'
					>
						Make a new demotion
					</Button>
				</div>
			</div>
			<Drawer
				offset={8}
				radius='md'
				opened={opened}
				onClose={() => {
					setSelectedStaff({});
					setSelectedApp({});
					setNewSalary("");
					close();
				}}
				title='Make a demotion'
			>
				<form
					onSubmit={handleSubmit(async () => {
						await post("/demotions/staffs/create", {
							staff_id: selectedStaff?.empid,
							from: selectedStaff?.curr_appointment?.name,
							from_section: selectedStaff?.curr_appointment?.school_section,
							to_section: selectedApp?.school_section,
							prev_salary: selectedStaff?.salary,
							curr_salary: new_salary,
							to_id: selectedApp?.id,
						});
						const { data } = await fetch("/demotions/staffs");

						const paginated: any[] = chunk(data, 50);
						setSortedData(paginated[0]);
						setNewSalary("");
						setSelectedApp({});
						close();
					})}
					className='flex flex-col gap-4'
				>
					<Select
						required
						checkIconPosition='right'
						label='Staff to demote'
						placeholder='Select a staff'
						data={staffSelectData}
						searchable
						nothingFoundMessage='Nothing found...'
						filter={optionsFilter}
						value={selectedStaffId}
						onChange={(value: any) => {
							setSelectedStaffId(value);
							const staff: any = staffsList.find(
								(s: any) =>
									s.first_name == value ||
									s.last_name == value ||
									s.empid == value
							);
							setSelectedStaff(staff);
						}}
					/>
					{selectedStaff?.empid && (
						<>
							<Text>
								Current Appointment:{" "}
								<b>
									{selectedStaff?.curr_appointment?.name} -{" "}
									{selectedStaff?.curr_appointment?.school_section}
								</b>
							</Text>
							<Text>
								Current Salary:{" "}
								<NumberFormatter
									prefix='N '
									value={selectedStaff?.salary || 0}
									thousandSeparator
								/>
							</Text>
							<Select
								checkIconPosition='right'
								label='Demoted to'
								placeholder='Select an appointment'
								data={appSelectData}
								searchable
								nothingFoundMessage='Nothing found...'
								filter={optionsAFilter}
								value={selectedAppID}
								onChange={(value: any) => {
									setSelectedAppID(value);
									const appointment: any = appointments.find(
										(app: any) => app.id == value
									);
									setNewSalary(appointment?.salary);
									setSelectedApp(appointment);
								}}
							/>

							<TextInput
								label='New salary'
								placeholder='New salary...'
								value={new_salary}
								onChange={(e) => {
									setNewSalary(e.currentTarget.value);
								}}
							/>
						</>
					)}
					<div className='flex gap-4 justify-end mt-3'>
						<Button
							onClick={() => {
								close();
								setSelectedStaff({});
								setSelectedApp({});
								setNewSalary("");
							}}
						>
							Cancel
						</Button>
						<Button
							disabled={!selectedApp?.id || !selectedStaff?.empid}
							type='submit'
							color='red'
						>
							Demote Staff
						</Button>
					</div>
				</form>
			</Drawer>
			<PaginatedTable
				depth='staff'
				showlast={false}
				showSearch
				rows={rows}
				searchedRows={searchedRows}
				data={queryData}
				headers={headers}
				placeholder='Search by staff name or employment id'
				setSortedData={setSortedData}
				setSearchedData={setSearchedData}
				loading={loading}
				count={queryData?.length}
			/>
		</section>
	);
};

export default Staff;
