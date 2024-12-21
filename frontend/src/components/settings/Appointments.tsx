"use client";
import React, { useEffect, useState } from "react";
import PaginatedTable from "@/components/PaginatedTable";
import { useFetch, usePost } from "@/hooks/useQueries";
import { Table, Button, Drawer, TextInput, Select } from "@mantine/core";

import chunk from "@/libs/chunk";
import { useDisclosure } from "@mantine/hooks";
import { useForm } from "react-hook-form";
const Appointments = () => {
	const { register, handleSubmit, reset } = useForm();
	const { loading, data, fetch } = useFetch();
	const { post } = usePost();
	const headers = ["ID", "name", "school section"];
	const [queryData, setQueryData] = useState(data);
	const [sortedData, setSortedData] = useState([]);
	const [searchedData, setSearchedData] = useState([]);
	const [value, setValue] = useState<string | null>("");
	const [opened, { open, close }] = useDisclosure(false);

	const rows = sortedData?.map((row: any, index: number) => (
		<Table.Tr key={row?.id}>
			<Table.Td>{index + 1}</Table.Td>
			<Table.Td>{row?.id}</Table.Td>
			<Table.Td>{row?.name}</Table.Td>

			<Table.Td>{row?.school_section}</Table.Td>
		</Table.Tr>
	));
	const searchedRows = searchedData?.map((row: any, index: number) => (
		<Table.Tr key={row?.id}>
			<Table.Td>{index + 1}</Table.Td>
			<Table.Td>{row?.id}</Table.Td>
			<Table.Td>{row?.name}</Table.Td>

			<Table.Td>{row?.school_section}</Table.Td>
		</Table.Tr>
	));
	useEffect(() => {
		const getAll = async () => {
			const { data } = await fetch("/appointments");
			setQueryData(data);
			const paginated: any[] = chunk(data, 50);
			setSortedData(paginated[0]);
		};

		getAll();
	}, []);
	return (
		<section className='flex flex-col gap-4'>
			<div className='flex justify-between mt-2'>
				<h2 className='font-bold text-xl text-blue-700'>Appointments</h2>
				<div className='flex gap-3 items-center'>
					<Button
						onClick={() => {
							open();
						}}
						className='bg-teal-500 text-white hover:bg-teal-700 px-4 py-2 rounded-sm transition duration-200 ease-linear'
					>
						Add a new appointment
					</Button>
				</div>
			</div>
			<Drawer
				offset={8}
				radius='md'
				opened={opened}
				onClose={close}
				title='Add a new appointment'
			>
				<form
					onSubmit={handleSubmit(async (data) => {
						await post(`/appointments/create`, {
							...data,
							school_section: value,
						});
						const { data: apps } = await fetch("/appointments");
						setQueryData(apps);
						const paginated: any[] = chunk(apps, 50);
						setSortedData(paginated[0]);
						reset();
					})}
					className='flex flex-col gap-4'
				>
					<TextInput
						label='Appointment name'
						required
						placeholder='Appointment name...'
						{...register("name")}
					/>

					<Select
						label='School section'
						placeholder='Pick a school section'
						checkIconPosition='right'
						value={value}
						onChange={setValue}
						required
						data={[
							"All",
							"Pre-nursery",
							"Nursery",
							"Primary",
							"Nursery and Primary",
							"Secondary",
							"JSS",
							"SSS",
						]}
					/>
					<div className='flex gap-4 justify-end mt-3'>
						<Button
							onClick={() => {
								close();
							}}
						>
							Cancel
						</Button>
						<Button type='submit' color='teal'>
							Add new appointment
						</Button>
					</div>
				</form>
			</Drawer>
			<PaginatedTable
				depth=''
				showlast
				showSearch
				rows={rows}
				searchedRows={searchedRows}
				data={queryData}
				headers={headers}
				placeholder='Search by appointment name or school section'
				setSortedData={setSortedData}
				setSearchedData={setSearchedData}
				loading={loading}
				count={queryData.length}
			/>
		</section>
	);
};

export default Appointments;
