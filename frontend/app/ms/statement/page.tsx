"use client";
import React from "react";
import { useFetch, usePostNormal } from "@/hooks/useQueries";
import { sessions } from "@/libs/sessions";
import { useRouter } from "next/navigation";
import { Select, Button } from "@mantine/core";
import { IconArrowNarrowLeft } from "@tabler/icons-react";
import { DatePickerInput } from "@mantine/dates";
import Result from "@/components/statements/Result";
import Outstanding from "@/components/statements/Outstanding";

const Statement = () => {
	const router = useRouter();
	const { fetch } = useFetch();
	const { post, loading } = usePostNormal();
	const [shown, setShown] = React.useState<"outstanding" | "init" | "result">(
		"init"
	);
	const [selectedClass, setSelectedClass] = React.useState<string | null>("");
	const [currClass, setCurrClass] = React.useState<{
		id: string;
		name: string;
		school_section: string;
	} | null>(null);
	const [resumption, setResumption] = React.useState<any | null>(null);
	const [selectedStudent, setSelectedStudent] = React.useState<string | null>(
		null
	);
	const [student, setStudent] = React.useState<{
		id: string;
		admission_no: string;
		first_name: string;
		last_name: string;
	} | null>(null);
	const [classList, setClasslist] = React.useState<
		{ value: string; label: string }[]
	>([]);
	const [classes, setClasses] = React.useState<
		{ id: string; name: string; school_section: string }[]
	>([]);
	const [classHistory, setClassHistory] = React.useState([]);
	const [classHist, setClassHist] = React.useState([]);
	const [session, setSession] = React.useState<any>("");
	const [term, setTerm] = React.useState<any>("");
	const [fetchResult, setFetchResult] = React.useState<boolean>(false);
	// const [outstandingFees, setOutstandingFees] = React.useState<
	// 	{
	// 		id: string;
	// 		price: number | string;
	// 		paid: number | string;
	// 		balance: number | string;
	// 		createdAt: string;
	// 		updatedAt: string;
	// 		transactionId: string;
	// 		year: string;
	// 		fee: string;
	// 	}[]
	// >([]);

	React.useEffect(() => {
		async function getData() {
			const { data } = await fetch("/classes/list");

			const sortedClass: any = data?.map((cl: any) => {
				return {
					value: cl?.id,
					label: cl?.name,
				};
			});
			const sortedClassess: any = data?.map((cl: any) => {
				return {
					id: cl?.id,
					name: cl?.name,
					school_section: cl?.school_section,
				};
			});
			setClasses(sortedClassess);
			setClasslist(sortedClass);
		}
		getData();
	}, []);

	React.useEffect(() => {
		if (selectedStudent) {
			const found: any = classHist?.find(
				(hist: { student_id: string }) =>
					hist?.student_id == selectedStudent?.split("?")[0].trim()
			);
			if (found) {
				setStudent(found?.student);
			}
		}
	}, [selectedStudent]);
	const handleSubmit = async (e: React.FormEvent) => {
		e.preventDefault();
		// const { data } = await post("/students/outstanding", {
		// 	session,
		// 	term,
		// 	className: currClass?.name,
		// 	studentId: selectedStudent?.split("?")[0],
		// });

		// if (data?.length > 0) {
		// 	setShown("outstanding");
		// 	const outstanding = data?.map(
		// 		(out: {
		// 			id: string;
		// 			price: number | string;
		// 			paid: number | string;
		// 			balance: number | string;
		// 			createdAt: string;
		// 			updatedAt: string;
		// 			transactionId: string;
		// 			year: string;
		// 			fee: { id: string; name: string } | null;
		// 		}) => {
		// 			return {
		// 				id: out.id,
		// 				price: out.price,
		// 				paid: out.paid,
		// 				balance: out.balance,
		// 				createdAt: out.createdAt,
		// 				updatedAt: out.updatedAt,
		// 				transactionId: out.transactionId,
		// 				year: out.year,
		// 				fee: out.fee?.name || "N/A",
		// 			};
		// 		}
		// 	);
		// 	setOutstandingFees(outstanding);
		// } else {

		// }
		setFetchResult(true);
		setShown("result");
	};
	const getClassHistory = async (classId: string | null) => {
		const { data } = await post(`/classes/${classId}/history`, { session });
		const sortedHistory: any = data?.map(({ student }: any, index: number) => {
			return {
				value: `${student?.id}?${index}`,
				label: `${student?.admission_no} - ${student?.first_name} ${student?.last_name}`,
			};
		});
		setClassHist(data);
		setClassHistory(sortedHistory);
	};
	return (
		<section className='space-y-2 p-2 px-4 pb-3 bg-white h-screen'>
			<header className='flex  justify-between w-full'>
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
				<h2>Statement of result</h2>
			</header>

			<form className='flex flex-wrap gap-4 items-end' onSubmit={handleSubmit}>
				<Select
					checkIconPosition='right'
					label='Session'
					placeholder='Select session'
					data={sessions}
					allowDeselect={false}
					searchable
					required
					className='w-36'
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
					searchable
					required
					className='w-36'
					data={["1st term", "2nd term", "3rd term"]}
					allowDeselect={false}
					value={term}
					nothingFoundMessage='Nothing found...'
					onChange={(value: any) => {
						setTerm(value);
					}}
				/>
				<Select
					required
					checkIconPosition='right'
					label='Student class'
					placeholder='Select a class'
					data={classList}
					className='w-36'
					disabled={!(session && term)}
					searchable
					allowDeselect={false}
					value={selectedClass}
					nothingFoundMessage='Nothing found...'
					onChange={(value) => {
						const foundClass: any = classes.find(
							(cl: { id: string; name: string; school_section: string }) =>
								cl.id === value
						);
						setCurrClass({
							id: foundClass?.id,
							name: foundClass?.name,
							school_section: foundClass?.school_section,
						});
						setSelectedClass(value);
						setSelectedStudent(null);
						getClassHistory(value);
					}}
				/>
				<Select
					required
					className='w-80'
					checkIconPosition='right'
					label='Select a student'
					placeholder='Select a student'
					disabled={!(session && term)}
					data={classHistory}
					searchable
					allowDeselect={false}
					value={selectedStudent}
					nothingFoundMessage='Nothing found...'
					onChange={(value: string | null) => {
						setSelectedStudent(value);
						setFetchResult(false);
					}}
				/>
				<DatePickerInput
					className='w-44'
					placeholder='resumption date'
					label='Resumption Date'
					value={resumption}
					required
					onChange={(value) => {
						setResumption(value);
					}}
				/>
				<Button type='submit' color='teal'>
					Generate
				</Button>
			</form>
			{shown == "init" && (
				<div className='text-xl flex font-semibold justify-center items-center w-full'>
					<h2>Select a student to generate statement of result for</h2>
				</div>
			)}
			{shown == "result" && (
				<Result
					session={session}
					term={term}
					selectedClass={currClass}
					selectedStudent={selectedStudent}
					fetchResult={fetchResult}
					resumption={resumption}
					student={student}
				/>
			)}

			{/* {shown == "outstanding" && (
				<Outstanding outstandingFees={outstandingFees} />
			)} */}
		</section>
	);
};

export default Statement;
