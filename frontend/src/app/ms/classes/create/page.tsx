"use client";
import {
	Button,
	TextInput,
	Group,
	Select,
	ComboboxItem,
	OptionsFilter,
	MultiSelect,
	LoadingOverlay,
} from "@mantine/core";
import { IconArrowNarrowLeft } from "@tabler/icons-react";
import React, { useState } from "react";
import { useRouter } from "next/navigation";
import { useFetch, usePost } from "@/hooks/useQueries";
import { useDisclosure } from "@mantine/hooks";
import { useForm } from "react-hook-form";
const Create = () => {
	const { register, handleSubmit, reset } = useForm();
	const [visible, { open, close }] = useDisclosure(false);
	const { post } = usePost();
	const [staffs, setStaffs] = useState([]);
	const [subjects, setSubjects] = useState<string[]>([]);
	const [subjectList, setSubjectList] = useState([]);
	const [teacherId, setTeacherId] = useState("");

	const { fetch } = useFetch();
	const router = useRouter();
	React.useEffect(() => {
		const getAll = async () => {
			const { data } = await fetch("/staffs");
			const { data: subs } = await fetch("/subjects");
			const sortedStaff: any = data.map((staff: any) => {
				return {
					value: staff.empid,
					label: `${staff.first_name} ${staff.last_name} - ${staff.empid}`,
				};
			});
			const sortedSubject: any = subs.map((sub: any) => {
				return {
					value: sub.id,
					label: sub.name,
				};
			});

			setStaffs(sortedStaff);
			setSubjectList(sortedSubject);
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
	const onSubmit = async (values: any) => {
		open();
		await post("/classes/create", {
			...values,
			teacher_id: teacherId,
			subjects: subjects.map((sub) => {
				return {
					id: sub,
				};
			}),
		});
		close();
		reset();
		// router.back();
	};

	return (
		<section className='space-y-6 bg-white py-3 px-6'>
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
			<form
				onSubmit={handleSubmit(onSubmit)}
				className='flex flex-col gap-6 relative'
			>
				<TextInput
					className='w-96'
					label='Class name'
					placeholder='Input class name'
					required
					{...register("name")}
				/>

				<Select
					checkIconPosition='right'
					label='Class teacher'
					placeholder='Assign a class teacher'
					data={staffs}
					searchable
					allowDeselect={false}
					nothingFoundMessage='Nothing found...'
					value={teacherId}
					className='w-96'
					filter={optionsFilter}
					onChange={(value: any) => {
						setTeacherId(value);
					}}
				/>
				<MultiSelect
					checkIconPosition='right'
					className='w-96'
					data={subjectList}
					searchable
					clearable
					value={subjects}
					label='Assign subjects to class'
					nothingFoundMessage='Nothing found...'
					placeholder='Pick a subject'
					hidePickedOptions
					onChange={(value: any) => {
						setSubjects(value);
					}}
				/>
				<Group>
					<Button
						onClick={() => {
							router.back();
						}}
					>
						Cancel
					</Button>
					<Button type='submit' color='teal'>
						Add class
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

export default Create;
