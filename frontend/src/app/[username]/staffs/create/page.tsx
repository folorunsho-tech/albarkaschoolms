"use client";
import {
	Button,
	TextInput,
	Group,
	Select,
	MultiSelect,
	LoadingOverlay,
	NumberInput,
} from "@mantine/core";
import { IconArrowNarrowLeft } from "@tabler/icons-react";
import React, { useState } from "react";
import { DateInput } from "@mantine/dates";
import { useRouter } from "next/navigation";
import { useForm } from "react-hook-form";
import { useFetch, usePost } from "@/hooks/useQueries";
import { useDisclosure } from "@mantine/hooks";

const CreateStaff = () => {
	const [date_of_birth, setDOB] = useState<Date | null>(null);
	const [date_of_emp, setDOE] = useState<Date | null>(new Date());
	const [visible, { open, close }] = useDisclosure(false);
	const { post } = usePost();
	const [section, setSection] = useState("");
	const [sex, setSex] = useState("");
	const [empid, setEmpId] = useState("");
	const [grade_level, setGradeLevel] = useState(0);
	const [first_app, setFApp] = useState("");
	const [app, setApp] = useState<any>({});
	const [religion, setReligion] = useState("");
	const [marital_status, setMarital_status] = useState("");
	const [subjects, setSubjects] = useState([]);
	const [appList, setAppList] = useState([]);
	const [appFList, setAppFList] = useState([]);
	const [FappList, setFAppList] = useState([]);
	const [subjectList, setSubjectList] = useState([]);
	const { register, handleSubmit, reset } = useForm();
	const { fetch } = useFetch();
	const router = useRouter();
	const getAll = async () => {
		const { data: subs } = await fetch("/subjects");
		const { data: apps } = await fetch("/appointments");
		const { data: empno } = await fetch("/staffs/empid");
		const sortedApp: any = apps.map((app: any) => {
			return {
				value: app.id,
				label: `${app.name} - ${app.school_section}`,
			};
		});
		const sortedFApp: any = apps.map((app: any) => {
			return `${app.name} - ${app.school_section}`;
		});
		const sortedSubject: any = subs.map((sub: any) => {
			return {
				value: sub.id,
				label: sub.name,
			};
		});
		const added = empno.substring(3);
		setEmpId(`EMP${Number(added) + 1}`);
		setSubjectList(sortedSubject);
		setAppList(sortedApp);
		setAppFList(sortedApp);
		setFAppList(sortedFApp);
		setDOE(new Date());
	};
	React.useEffect(() => {
		getAll();
	}, []);

	const filterApps = (section: string) => {
		if (section === "All") {
			setAppList(appFList);
		} else {
			const filtered = appFList.filter((ap: any) => {
				return ap?.label?.includes(section);
			});
			setAppList(filtered);
		}
	};
	const onSubmit = async (values: any) => {
		open();
		await post("/staffs/create", {
			school_section: section,
			sex,
			religion,
			subjects,
			appointed_as: first_app,
			curr_appointment_id: app?.value,
			marital_status,
			date_of_emp,
			grade_level,
			date_of_birth,
			...values,
		});
		setDOB(null);
		setDOE(null);
		setSection("");
		setSex("");
		setGradeLevel(0);
		setApp({});
		setReligion("");
		setMarital_status("");
		setSubjects([]);
		reset();
		getAll();
		close();
	};
	return (
		<section className='space-y-6 bg-white p-4'>
			<div className='flex justify-between items-center'>
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
				<Select
					checkIconPosition='right'
					className='w-70'
					data={["All", "Nursery and Primary", "Secondary"]}
					allowDeselect={false}
					value={section}
					label='School section'
					nothingFoundMessage='Nothing found...'
					placeholder='Pick a school section'
					onChange={(value: any) => {
						setSection(value);
						filterApps(value);
					}}
				/>
			</div>

			<form onSubmit={handleSubmit(onSubmit)} className='space-y-10'>
				{section ? (
					<div className='flex gap-6 flex-wrap relative'>
						<TextInput
							className='w-32'
							label='Empid'
							placeholder='Input Empid'
							defaultValue={empid}
							required
							{...register("empid")}
						/>
						<DateInput
							label='Date of employment'
							clearable
							placeholder='Pick date of employment'
							className='w-48'
							value={date_of_emp}
							onChange={setDOE}
						/>
						<TextInput
							className='w-52'
							label='First name'
							placeholder='Input first name'
							required
							{...register("first_name", { required: true })}
						/>{" "}
						<TextInput
							className='w-52'
							label='Surname'
							placeholder='Input last name'
							required
							{...register("last_name", { required: true })}
						/>
						<DateInput
							label='Date of birth'
							clearable
							placeholder='Pick date of birth'
							className='w-44'
							value={date_of_birth}
							onChange={setDOB}
						/>
						<Select
							checkIconPosition='right'
							label='Sex'
							placeholder='Select sex'
							data={["Male", "Female"]}
							nothingFoundMessage='Nothing found...'
							className='w-32'
							value={sex}
							onChange={(value: any) => {
								setSex(value);
							}}
						/>
						<Select
							checkIconPosition='right'
							label='Religion'
							placeholder='Select religion'
							data={["Islam", "Christianity", "Others"]}
							value={religion}
							nothingFoundMessage='Nothing found...'
							className='w-36'
							onChange={(value: any) => {
								setReligion(value);
							}}
						/>
						<Select
							checkIconPosition='right'
							label='Marital Status'
							placeholder='Select marital status'
							data={["Single", "Married"]}
							value={marital_status}
							nothingFoundMessage='Nothing found...'
							className='w-38'
							onChange={(value: any) => {
								setMarital_status(value);
							}}
						/>
						<TextInput
							className='w-[29.8rem]'
							label='Address'
							placeholder='Input address'
							{...register("address")}
						/>
						<TextInput
							className='w-[12rem]'
							label='Telephone'
							placeholder='Input telephone'
							{...register("telephone")}
						/>
						<TextInput
							className='w-[8rem]'
							label='State of origin'
							placeholder='State of origin'
							{...register("state_of_origin")}
						/>
						<TextInput
							className='w-[8rem]'
							label='L.G.A'
							placeholder='L.G.A'
							{...register("lga")}
						/>
						<TextInput
							className='w-[18rem]'
							label='Qualification'
							placeholder='Input qualification'
							{...register("qualification")}
						/>
						<NumberInput
							className='w-[5rem]'
							label='Grade level'
							placeholder='Grade level'
							allowLeadingZeros={false}
							allowDecimal={false}
							allowNegative={false}
							value={grade_level}
							onChange={(value: any) => {
								setGradeLevel(value);
							}}
						/>
						<Select
							checkIconPosition='right'
							className='w-70'
							data={FappList}
							searchable
							clearable
							value={first_app}
							label='Appointed as'
							nothingFoundMessage='Nothing found...'
							placeholder='Pick an appointment'
							onChange={(value: any) => {
								setFApp(value);
							}}
						/>
						<Select
							checkIconPosition='right'
							className='w-70'
							data={appList}
							searchable
							clearable
							label="Staff's current appointment"
							nothingFoundMessage='Nothing found...'
							placeholder='Pick an appointment'
							onChange={(value: any) => {
								const found: any = appList.find(
									(app: any) => app.value == value
								);
								setApp(found);
							}}
						/>
						<TextInput
							className='w-[8rem]'
							label='Salary'
							placeholder='Input salary'
							defaultValue={app?.salary}
							{...register("salary")}
						/>
						<MultiSelect
							checkIconPosition='right'
							className='w-full'
							data={subjectList}
							searchable
							clearable
							label='Assign subjects to staff'
							nothingFoundMessage='Nothing found...'
							placeholder='Pick a subject'
							hidePickedOptions
							onChange={(value: any) => {
								const subs = value.map((sub: any) => {
									return {
										id: sub,
									};
								});
								setSubjects(subs);
							}}
						/>
					</div>
				) : (
					<div className='flex justify-center items-center h-52 font-bold text-xl'>
						<h2>Choose a school section to add staff to</h2>
					</div>
				)}
				<Group>
					<Button
						onClick={() => {
							router.back();
						}}
					>
						Cancel
					</Button>
					<Button disabled={section === ""} color='teal' type='submit'>
						Add staff
					</Button>
				</Group>
				<LoadingOverlay
					visible={visible}
					zIndex={1000}
					overlayProps={{ radius: "sm", blur: 2 }}
				/>
			</form>
		</section>
	);
};

export default CreateStaff;
