"use client";
import React, { useEffect, useRef, useState } from "react";
import PaginatedTable from "@/components/PaginatedTable";
import { useFetch, usePost } from "@/hooks/useQueries";
import {
	Table,
	ActionIcon,
	Button,
	Drawer,
	TextInput,
	Select,
	NumberFormatter,
} from "@mantine/core";
import { IconPencil } from "@tabler/icons-react";
import { modals } from "@mantine/modals";
import chunk from "@/libs/chunk";
import { useDisclosure } from "@mantine/hooks";
import { useForm } from "react-hook-form";
const Subjects = () => {
	const { register, handleSubmit, reset } = useForm();
	const { loading, data, fetch } = useFetch();
	const { post } = usePost();
	const headers = ["ID", "name", "amount", "school section"];
	const [queryData, setQueryData] = useState(data);
	const [sortedData, setSortedData] = useState([]);

	const [searchedData, setSearchedData] = useState([]);
	const [value, setValue] = useState<string | null>("");
	const [opened, { open, close }] = useDisclosure(false);
	const eAmountRef = useRef<HTMLInputElement>(null);

	const openEditModal = (edata: any) => {
		modals.openConfirmModal({
			title: `Edit Fees group ${edata?.name} for ${edata?.school_section}`,
			centered: true,
			children: (
				<form className='flex flex-col gap-4'>
					<Select
						label='School section'
						placeholder='Pick a school section'
						checkIconPosition='right'
						value={edata?.school_section}
						disabled
						data={[
							"Pre-Nursery",
							"Nursery",
							"Primary",
							"Secondary",
							"JSS",
							"SSS",
						]}
					/>
					<TextInput
						label='Fee group name'
						disabled
						defaultValue={edata?.name}
						placeholder='fee group name...'
					/>

					<TextInput
						label='Fee group amount'
						leftSectionPointerEvents='none'
						leftSection='N'
						placeholder='fee group amount...'
						defaultValue={edata?.amount}
						ref={eAmountRef}
					/>
				</form>
			),
			labels: { confirm: "Update Fees Group", cancel: "Cancel" },
			confirmProps: { color: "teal", type: "submit" },
			onConfirm: async () => {
				await post(`/feesgroup/edit/${edata?.id}`, {
					amount: eAmountRef?.current?.value,
				});

				const { data } = await fetch("/feesgroup");
				setQueryData(data);
				const paginated: any[] = chunk(data, 50);
				setSortedData(paginated[0]);
			},
		});
	};

	const rows = sortedData?.map((row: any, index: number) => (
		<Table.Tr key={row?.id}>
			<Table.Td>{index + 1}</Table.Td>
			<Table.Td>{row?.id}</Table.Td>
			<Table.Td>{row?.name}</Table.Td>
			<Table.Td>
				<NumberFormatter prefix='N ' value={row?.amount} thousandSeparator />
			</Table.Td>
			<Table.Td>{row?.school_section}</Table.Td>

			<Table.Td className='flex items-center gap-3 '>
				<ActionIcon
					onClick={() => {
						openEditModal(row);
					}}
					variant='outline'
					color='green'
					aria-label='action menu'
				>
					<IconPencil style={{ width: "70%", height: "70%" }} stroke={2} />
				</ActionIcon>
			</Table.Td>
		</Table.Tr>
	));
	const searchedRows = searchedData?.map((row: any, index: number) => (
		<Table.Tr key={row?.id}>
			<Table.Td>{index + 1}</Table.Td>
			<Table.Td>{row?.id}</Table.Td>
			<Table.Td>{row?.name}</Table.Td>
			<Table.Td>
				<NumberFormatter prefix='N ' value={row?.amount} thousandSeparator />
			</Table.Td>
			<Table.Td>{row?.school_section}</Table.Td>

			<Table.Td className='flex items-center gap-3 '>
				<ActionIcon
					onClick={() => {
						openEditModal(row);
					}}
					variant='outline'
					color='green'
					aria-label='action menu'
				>
					<IconPencil style={{ width: "70%", height: "70%" }} stroke={2} />
				</ActionIcon>
			</Table.Td>
		</Table.Tr>
	));
	useEffect(() => {
		const getAll = async () => {
			const { data } = await fetch("/feesgroup");
			setQueryData(data);
			const paginated: any[] = chunk(data, 50);
			setSortedData(paginated[0]);
		};

		getAll();
	}, []);

	return (
		<section className='flex flex-col gap-4'>
			<div className='flex justify-between mt-2'>
				<h2 className='font-bold text-xl text-blue-700'>Fees group</h2>
				<div className='flex gap-3 items-center'>
					<Button
						onClick={() => {
							open();
						}}
						className='bg-teal-500 text-white hover:bg-teal-700 px-4 py-2 rounded-sm transition duration-200 ease-linear'
					>
						Add a new fees group
					</Button>
				</div>
			</div>
			<Drawer
				offset={8}
				radius='md'
				opened={opened}
				onClose={close}
				title='Add a new fees group'
			>
				<form
					onSubmit={handleSubmit(async (values) => {
						await post("/feesgroup/create", {
							name: values.name,
							amount: values.amount,
							school_section: value,
						});
						const { data } = await fetch("/feesgroup");
						setQueryData(data);
						const paginated: any[] = chunk(data, 50);
						setSortedData(paginated[0]);
						reset();
					})}
					className='flex flex-col gap-4'
				>
					<TextInput
						label='Fee group name'
						required
						placeholder='fee group name...'
						{...register("name")}
					/>
					<TextInput
						label='Fee group amount'
						leftSectionPointerEvents='none'
						leftSection='N'
						required
						placeholder='fee group amount...'
						{...register("amount")}
					/>
					<Select
						label='School section'
						placeholder='Pick a school section'
						checkIconPosition='right'
						value={value}
						onChange={setValue}
						required
						clearable
						data={[
							"All",
							"Pre-nursery",
							"Nursery",
							"Primary",
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
							Add new fees group
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
				placeholder='Search by fees name'
				setSortedData={setSortedData}
				setSearchedData={setSearchedData}
				loading={loading}
				count={queryData.length}
			/>
		</section>
	);
};

export default Subjects;
