"use client";
import {
	Button,
	TextInput,
	Group,
	Select,
	MultiSelect,
	LoadingOverlay,
	NumberInput,
	Text,
} from "@mantine/core";
import { IconArrowNarrowLeft } from "@tabler/icons-react";
import React, { useState } from "react";
import { DatePickerInput } from "@mantine/dates";
import { useRouter, useSearchParams } from "next/navigation";
import { useForm } from "react-hook-form";
import { useFetch, useEdit } from "@/hooks/useQueries";
import { useDisclosure } from "@mantine/hooks";

const EditStaff = () => {
	const [date_of_birth, setDOB] = useState<Date | null>(null);
	const [date_of_emp, setDOE] = useState<Date | null>(null);
	const [visible, { open, close }] = useDisclosure(false);
	const { post } = useEdit();
	const [section, setSection] = useState("");
	const [sex, setSex] = useState("");
	const [address, setAddress] = useState("");
	const [first_name, setFirst_name] = useState("");
	const [last_name, setlast_name] = useState("");
	const [lga, setLga] = useState("");
	const [qualification, setQualification] = useState("");
	const [salary, setSalary] = useState("");
	const [state_of_origin, setState_of_origin] = useState("");
	const [telephone, setTelephone] = useState("");
	const [grade_level, setGradeLevel] = useState(0);
	const [first_app, setFApp] = useState("");
	const [appId, setAppId] = useState("");
	const [app, setApp] = useState<any>({});
	const [religion, setReligion] = useState("");
	const [marital_status, setMarital_status] = useState("");
	const [emp_status, setEmp_status] = useState("");
	const [subjects, setSubjects] = useState([]);
	const [appList, setAppList] = useState([]);
	const [subjectList, setSubjectList] = useState([]);
	const [FappList, setFAppList] = useState([]);
	const [staff, setStaff] = useState<any>({});
	const { handleSubmit } = useForm();
	const { fetch } = useFetch();
	const router = useRouter();
	const searchParams = useSearchParams();
	const id = searchParams.get("id");

	React.useEffect(() => {
		const getAll = async () => {
			const { data: staff } = await fetch(`/staffs/${id}`);
			const { data: subs } = await fetch("/subjects");
			const { data: apps } = await fetch("/appointments");

			const sortedApp: any = apps.map((app: any) => {
				return {
					value: app.id,
					label: `${app.name} - ${app.school_section}`,
				};
			});

			const sortedSubject: any = subs.map((sub: any) => {
				return {
					value: sub.id,
					label: sub.name,
				};
			});
			const sortedFApp: any = apps.map((app: any) => {
				return `${app.name} - ${app.school_section}`;
			});
			setFAppList(sortedFApp);

			setSubjectList(sortedSubject);
			setAppList(sortedApp);
			setStaff(staff);
			setDOE(new Date(staff?.date_of_emp));
			setDOB(new Date(staff?.date_of_birth));
			setSex(staff?.sex);
			setAddress(staff?.address);
			setFirst_name(staff?.first_name);
			setlast_name(staff?.last_name);
			setLga(staff?.lga);
			setQualification(staff?.qualification);
			setSalary(staff?.salary);
			setTelephone(staff?.telephone);
			setState_of_origin(staff?.state_of_origin);
			setReligion(staff?.religion);
			setFApp(staff?.appointed_as);
			setAppId(staff?.curr_appointment_id);
			setApp(
				sortedApp.find((app: any) => app.value == staff?.curr_appointment_id)
			);
			setGradeLevel(staff?.grade_level);
			setEmp_status(staff?.emp_status);
			setMarital_status(staff?.marital_status);
			setSection(staff?.school_section);
			setSubjects(
				staff?.subjects.map((sub: any) => {
					return sub.id;
				})
			);
		};
		getAll();
	}, []);
	const onSubmit = async () => {
		open();
		await post(`/staffs/edit/${id}`, {
			school_section: section,
			sex,
			religion,
			emp_status,
			subjects: subjects.map((sub) => {
				return {
					id: sub,
				};
			}),
			appointed_as: first_app,
			curr_appointment_id: appId,
			marital_status,
			date_of_emp,
			grade_level,
			date_of_birth,
			first_name,
			last_name,
			address,
			telephone,
			state_of_origin,
			lga,
			qualification,
			salary,
		});

		close();
		router.back();
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
					data={[
						"All",
						"Pre-nursery",
						"Nursery",
						"Primary",
						"Primary and Secondary",
						"Secondary",
						"JSS",
						"SSS",
					]}
					searchable
					clearable
					value={section}
					label='School section'
					nothingFoundMessage='Nothing found...'
					placeholder='Pick a school section'
					onChange={(value: any) => {
						setSection(value);
					}}
				/>
			</div>

			<form onSubmit={handleSubmit(onSubmit)} className='space-y-10'>
				<div className='flex gap-6 flex-wrap relative'>
					<TextInput
						className='w-32'
						label='Empid'
						placeholder='Input Empid'
						defaultValue={staff?.empid}
						disabled
					/>
					<DatePickerInput
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
						value={first_name}
						onChange={(event) => setFirst_name(event.currentTarget.value)}
					/>
					<TextInput
						className='w-52'
						label='Last name'
						placeholder='Input last name'
						value={last_name}
						onChange={(event) => setlast_name(event.currentTarget.value)}
					/>
					<div className='flex flex-col gap-2'>
						<Text className='font-semibold text-sm'>Passport</Text>
						{/* <ImageUploader setFiles={setFiles} files={files} /> */}
					</div>
					<DatePickerInput
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
						clearable
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
						clearable
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
						clearable
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
						value={address}
						onChange={(event) => setAddress(event.currentTarget.value)}
					/>
					<TextInput
						className='w-[12rem]'
						label='Telephone'
						placeholder='Input telephone'
						value={telephone}
						onChange={(event) => setTelephone(event.currentTarget.value)}
					/>
					<TextInput
						className='w-[8rem]'
						label='State of origin'
						placeholder='State of origin'
						value={state_of_origin}
						onChange={(event) => setState_of_origin(event.currentTarget.value)}
					/>
					<TextInput
						className='w-[8rem]'
						label='L.G.A'
						placeholder='L.G.A'
						value={lga}
						onChange={(event) => setLga(event.currentTarget.value)}
					/>
					<TextInput
						className='w-[18rem]'
						label='Qualification'
						placeholder='Input qualification'
						value={qualification}
						onChange={(event) => setQualification(event.currentTarget.value)}
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
						value={appId}
						label="Staff's current appointment"
						nothingFoundMessage='Nothing found...'
						placeholder='Pick an appointment'
						onChange={(value: any) => {
							const app: any = appList.find((a: any) => a.value == value);
							setAppId(value);
							setApp(app);
						}}
					/>
					<TextInput
						className='w-[8rem]'
						label='Salary'
						placeholder='Input salary'
						value={salary}
						autoComplete='salary'
						onChange={(event) => setSalary(event.currentTarget.value)}
					/>

					<MultiSelect
						checkIconPosition='right'
						className='w-full'
						data={subjectList}
						searchable
						clearable
						value={subjects}
						label='Assign subjects to staff'
						nothingFoundMessage='Nothing found...'
						placeholder='Pick a subject'
						hidePickedOptions
						onChange={(value: any) => {
							setSubjects(value);
						}}
					/>
				</div>
				<Group>
					<Button
						onClick={() => {
							router.back();
						}}
					>
						Cancel
					</Button>
					<Button color='teal' type='submit'>
						Update staff
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

export default EditStaff;
