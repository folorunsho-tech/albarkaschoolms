"use client";
import React, { useState } from "react";
import {
	Button,
	LoadingOverlay,
	Table,
	Tabs,
	rem,
	List,
	Text,
	Divider,
	Select,
} from "@mantine/core";
import {
	IconClipboardText,
	IconBooks,
	IconUsers,
	IconPencil,
	IconArrowNarrowLeft,
	IconPrinter,
} from "@tabler/icons-react";
import { useFetchSingle } from "@/hooks/useQueries";
import Link from "next/link";
import { useRouter, useSearchParams } from "next/navigation";
import PaginatedTable from "@/components/PaginatedTable";
import moment from "moment";
import chunk from "@/libs/chunk";
import PrintHeader from "@/components/PrintHeader";
import { sessions, currSession, currTerm } from "@/libs/sessions";
import { useReactToPrint } from "react-to-print";
import { DateInput } from "@mantine/dates";

const ViewClass = () => {
	const iconStyle = { width: rem(20), height: rem(20) };
	const { loading, data, fetch }: any = useFetchSingle();
	const [queryData, setQueryData] = useState([]);
	const [sortedData, setSortedData] = useState([]);
	const [searchedData, setSearchedData] = useState([]);
	const [session, setSession] = React.useState<any>("");
	const [term, setTerm] = React.useState<any>("");
	const [subject, setSubject] = React.useState<any>("");
	const [date, setDate] = React.useState<any>("");
	const searchParams = useSearchParams();
	const id = searchParams.get("id");
	const router = useRouter();
	const contentRef = React.useRef(null);
	const reactToPrintFn: any = useReactToPrint({
		contentRef,
	});
	const headers = [
		"admission no",
		"admission date",
		"name",
		"sex",
		"religion",
		"guardian name",
		"guardian telephone",
	];
	React.useEffect(() => {
		async function getAll() {
			const { data: curr_class } = await fetch(`/classes/${id}`);
			setQueryData(curr_class?.Students || []);
			const paginated: any[] = chunk(curr_class?.Students || [], 50);
			setSortedData(paginated[0]);
			setTerm(currTerm);
			setSession(currSession);
			setSubject(curr_class?.subjects[0]?.name);
			setDate(new Date());
		}
		getAll();
	}, []);

	const rows = sortedData?.map((row: any, index: number) => (
		<Table.Tr key={row?.admission_no}>
			<Table.Td>{index + 1}</Table.Td>
			<Table.Td>{row?.admission_no}</Table.Td>

			<Table.Td>
				{moment(row?.date_of_admission).format("MMMM Do YYYY")}
			</Table.Td>
			<Table.Td>
				{row?.first_name} {row?.last_name}
			</Table.Td>
			<Table.Td>{row?.sex}</Table.Td>
			<Table.Td>{row?.religion}</Table.Td>
			<Table.Td>{row?.guardian_name}</Table.Td>
			<Table.Td>{row?.guardian_telephone}</Table.Td>
			<Table.Td>{row?.admission_status}</Table.Td>
		</Table.Tr>
	));
	const searchedRows = searchedData?.map((row: any, index: number) => (
		<Table.Tr key={row?.admission_no}>
			<Table.Td>{index + 1}</Table.Td>
			<Table.Td>{row?.admission_no}</Table.Td>

			<Table.Td>
				{moment(row?.date_of_admission).format("MMMM Do YYYY")}
			</Table.Td>
			<Table.Td>
				{row?.first_name} {row?.last_name}
			</Table.Td>
			<Table.Td>{row?.sex}</Table.Td>
			<Table.Td>{row?.religion}</Table.Td>
			<Table.Td>{row?.guardian_name}</Table.Td>
			<Table.Td>{row?.guardian_telephone}</Table.Td>
			<Table.Td>{row?.admission_status}</Table.Td>
		</Table.Tr>
	));
	return (
		<section className='relative flex flex-col '>
			<div className='flex justify-between p-3'>
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
					leftSection={<IconPencil />}
					color='teal'
					href={`edit?id=${id}`}
					component={Link}
					className='w-max self-end'
				>
					Edit class info
				</Button>
			</div>
			<Tabs defaultValue='summary' color='teal'>
				<Tabs.List className=''>
					<Tabs.Tab
						value='summary'
						leftSection={<IconClipboardText style={iconStyle} />}
					>
						Summary
					</Tabs.Tab>
					<Tabs.Tab
						value='subjects'
						leftSection={<IconBooks style={iconStyle} />}
					>
						Subjects
					</Tabs.Tab>
					<Tabs.Tab
						value='students'
						leftSection={<IconUsers style={iconStyle} />}
					>
						Students
					</Tabs.Tab>
					<Tabs.Tab
						value='result-sheet'
						leftSection={<IconClipboardText style={iconStyle} />}
					>
						Result sheet
					</Tabs.Tab>
					<Tabs.Tab
						value='register'
						leftSection={<IconClipboardText style={iconStyle} />}
					>
						Class register
					</Tabs.Tab>
				</Tabs.List>

				<Tabs.Panel value='summary' className='bg-white p-3'>
					<div className='flex items-center justify-between'>
						<Text>Name</Text>
						<Text className='font-semibold'>{data?.name}</Text>
					</div>
					<Divider my='md' />
					<div className='flex items-center justify-between'>
						<Text>Class teacher name / empid</Text>
						<Text className='font-semibold'>
							{data?.teacher?.first_name} {data?.teacher?.last_name} /{" "}
							{data?.teacher?.empid}
						</Text>
					</div>
					<Divider my='md' />
					<div className='flex items-center justify-between'>
						<Text>Total number of subjects</Text>
						<Text className='font-semibold'>{data?._count?.subjects}</Text>
					</div>
					<Divider my='md' />
					<div className='flex items-center justify-between'>
						<Text>Total number of students</Text>
						<Text className='font-semibold'>{data?._count?.Students}</Text>
					</div>
				</Tabs.Panel>

				<Tabs.Panel
					value='subjects'
					className='space-y-3 overflow-y-auto bg-white p-3'
				>
					<div className='flex justify-between items-center'>
						<h2 className='text-xl'>Class subjects</h2>
						<h3 className='text-xl'>
							Total: <b>{data?.subjects?.length || 0}</b>
						</h3>
					</div>
					<List type='ordered' className='flex flex-col gap-1'>
						{data?.subjects?.map((s: any, index: number) => (
							<List.Item key={s.id}>
								<b>{index + 1}. </b>
								{s.name}
							</List.Item>
						))}
					</List>
				</Tabs.Panel>

				<Tabs.Panel value='students' className='bg-white p-3'>
					<PaginatedTable
						depth=''
						showlast={false}
						showSearch
						rows={rows}
						searchedRows={searchedRows}
						data={queryData}
						headers={headers}
						placeholder='Search by student admission no'
						setSortedData={setSortedData}
						setSearchedData={setSearchedData}
						loading={loading}
						count={queryData.length}
					/>
				</Tabs.Panel>
				<Tabs.Panel value='result-sheet' className='bg-white p-3'>
					<div className='flex gap-4'>
						<Select
							checkIconPosition='right'
							label='Session'
							placeholder='Select session'
							data={sessions}
							allowDeselect={false}
							searchable
							value={session}
							nothingFoundMessage='Nothing found...'
							onChange={(value: any) => {
								setSession(value);
							}}
						/>
						<Select
							checkIconPosition='right'
							label='Term'
							placeholder='Select term'
							data={["1st term", "2nd term", "3rd term"]}
							allowDeselect={false}
							value={term}
							nothingFoundMessage='Nothing found...'
							onChange={(value: any) => {
								setTerm(value);
							}}
						/>
						<Select
							checkIconPosition='right'
							label='Subject'
							placeholder='Select subject'
							data={data?.subjects?.map((sub: any) => {
								return {
									value: sub?.name,
								};
							})}
							allowDeselect={false}
							value={subject}
							nothingFoundMessage='Nothing found...'
							onChange={(value: any) => {
								setSubject(value);
							}}
						/>
						<Button
							onClick={reactToPrintFn}
							className='self-end w-max'
							leftSection={<IconPrinter />}
						>
							Print result sheet
						</Button>
					</div>
					<section ref={contentRef} className='p-2'>
						<header className='mb-2'>
							<PrintHeader />
							<h2 className='text-xl text-center font-semibold mb-2'>
								Result Sheet
							</h2>
							<div className='flex items-center gap-6'>
								<p>
									Session:{" "}
									<span className='font-semibold italic'>{session}</span>
								</p>
								<p>
									Term: <span className='font-semibold italic'>{term}</span>
								</p>
								<p>
									Class:{" "}
									<span className='font-semibold italic'>{data?.name}</span>
								</p>
								<p>
									Subject:{" "}
									<span className='font-semibold italic'>{subject}</span>
								</p>
							</div>
						</header>
						<table className='printable'>
							<thead>
								<tr>
									<th>S/N</th>
									<th>Admission No</th>
									<th>Name</th>
									<th>1st C.A</th>
									<th>2nd C.A</th>
									<th>Exam</th>
									<th>Total</th>
								</tr>
							</thead>
							<tbody>
								{queryData?.map((student: any, index: number) => (
									<tr key={student?.admission_no}>
										<td>{index + 1}</td>
										<td>{student?.admission_no}</td>
										<td>
											{student?.first_name} {student?.last_name}
										</td>
										<td></td>
										<td></td>
										<td></td>
										<td></td>
									</tr>
								))}
							</tbody>
						</table>
					</section>
				</Tabs.Panel>
				<Tabs.Panel value='register' className='bg-white p-3'>
					<div className='flex gap-4 items-end'>
						<Select
							checkIconPosition='right'
							label='Session'
							placeholder='Select session'
							data={sessions}
							allowDeselect={false}
							searchable
							value={session}
							nothingFoundMessage='Nothing found...'
							onChange={(value: any) => {
								setSession(value);
							}}
						/>
						<Select
							checkIconPosition='right'
							label='Term'
							placeholder='Select term'
							data={["1st term", "2nd term", "3rd term"]}
							allowDeselect={false}
							value={term}
							nothingFoundMessage='Nothing found...'
							onChange={(value: any) => {
								setTerm(value);
							}}
						/>
						<DateInput
							label='Date'
							allowDeselect={false}
							value={date}
							minDate={new Date("2010-09-01")}
						/>
						<Button
							onClick={reactToPrintFn}
							className='self-end w-max'
							leftSection={<IconPrinter />}
						>
							Print register
						</Button>
					</div>
					<section ref={contentRef} className='p-2 w-full'>
						<header className='mb-2 w-full'>
							<PrintHeader showDate={false} />
							<h2 className='text-xl text-center font-semibold mb-2'>
								Class Register
							</h2>
							<div className='flex items-center gap-6 w-full'>
								<p>
									Session:{" "}
									<span className='font-semibold italic'>{session}</span>
								</p>
								<p>
									Term: <span className='font-semibold italic'>{term}</span>
								</p>
								<p>
									Class:{" "}
									<span className='font-semibold italic'>{data?.name}</span>
								</p>
								<p className='justify-self-end'>
									Date:{" "}
									<span className='font-semibold italic'>
										{new Date(date).toLocaleDateString()}
									</span>
								</p>
								<p className='justify-self-end'>
									Class teacher's signature:{" "}
									<span className='font-semibold italic'>
										__________________
									</span>
								</p>
							</div>
						</header>
						<table className='printable'>
							<thead>
								<tr>
									<th>S/N</th>
									<th>Admission No</th>
									<th>Name</th>
									<th>Present</th>
									<th>Absent</th>
									<th>Absent Reason</th>
								</tr>
							</thead>
							<tbody>
								{queryData?.map((student: any, index: number) => (
									<tr key={student?.admission_no}>
										<td>{index + 1}</td>
										<td>{student?.admission_no}</td>
										<td>
											{student?.first_name} {student?.last_name}
										</td>
										<td></td>
										<td></td>
										<td></td>
									</tr>
								))}
							</tbody>
						</table>
					</section>
				</Tabs.Panel>
			</Tabs>
			<LoadingOverlay visible={loading} />
		</section>
	);
};

export default ViewClass;
