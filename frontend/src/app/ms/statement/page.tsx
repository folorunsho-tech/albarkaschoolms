"use client";
import React from "react";
import { useFetch, usePostNormal } from "@/hooks/useQueries";
import { sessions } from "@/libs/sessions";
import { useRouter } from "next/navigation";
import {
	Select,
	Button,
	LoadingOverlay,
	ScrollAreaAutosize,
} from "@mantine/core";
import { IconArrowNarrowLeft, IconPrinter } from "@tabler/icons-react";
import { useReactToPrint } from "react-to-print";
import PrintHeader from "@/components/PrintHeader";
import getGrade from "@/libs/getGrade";
import { DatePickerInput } from "@mantine/dates";

const Statement = () => {
	const router = useRouter();
	const { post, loading } = usePostNormal();
	const { fetch } = useFetch();
	const [loaded, setLoaded] = React.useState<Boolean>(false);
	const [selectedClass, setSelectedClass] = React.useState<any | null>(null);
	const [resumption, setResumption] = React.useState<any | null>(null);
	const [selectedStudent, setSelectedStudent] = React.useState<string | null>(
		null
	);
	const [queryData, setQueryData] = React.useState([]);
	const [classList, setClasslist] = React.useState([]);
	const [session, setSession] = React.useState<any>("");
	const [term, setTerm] = React.useState<any>("");
	const [perc, setPerc] = React.useState<any>("0");
	const [statement, setStatement] = React.useState<any>("");
	const [docName, setDocName] = React.useState<any>("");
	const contentRef = React.useRef(null);
	const reactToPrintFn: any = useReactToPrint({
		contentRef,
		documentTitle: docName,
	});
	React.useEffect(() => {
		async function getData() {
			const { data: classes } = await fetch("/classes/byStatement");

			const sortedClass: any = classes?.map((cl: any) => {
				return {
					value: cl?.id,
					label: cl?.name,
				};
			});
			setQueryData(classes);
			setClasslist(sortedClass);
		}
		getData();
	}, []);

	React.useEffect(() => {
		if (session !== "" && term !== "") {
			setSelectedStudent(null);
		}
	}, [session, term]);
	const getStudent = async () => {
		setLoaded(false);

		const { data } = await post(
			`/statements/byStudent/${selectedStudent?.split("-")[0]}`,
			{
				session,
				term,
				classId: selectedClass?.id,
			}
		);

		const subs: any[] = data?.subjects;
		const results = data?.results;
		const generated: any[] = [];
		subs?.forEach((sub: any) => {
			const fca = results?.FCAResults?.find(
				(result: any) => result?.subject?.name == sub?.name
			);
			const sca = results?.SCAResults?.find(
				(result: any) => result?.subject?.name == sub?.name
			);
			const exam = results?.ExamResults?.find(
				(result: any) => result?.subject?.name == sub?.name
			);
			generated.push({
				id: sub?.id,
				name: sub?.name,
				fca: `${fca?.score}`,
				sca: `${sca?.score}`,
				exam: `${exam?.score}`,
				total: `${fca?.score + sca?.score + exam?.score}`,
				grade: getGrade(
					fca?.score + sca?.score + exam?.score,
					selectedClass?.name
				),
			});
		});

		setStatement({
			name: `${results?.last_name} ${results?.first_name}`,

			admission_no: results?.admission_no,
			generated: generated.sort((a, b) =>
				a?.name?.toLowerCase() < b?.name?.toLowerCase() ? -1 : 1
			),
		});
		const total = generated?.reduce((prev: any, curr: any) => {
			return Number(prev) + Number(curr?.total);
		}, 0);
		const calculated = ((total / (subs.length * 100)) * 100).toFixed(2);
		setPerc(calculated);
		setDocName(data?.admission_no);
		setLoaded(true);
	};
	return (
		<section className='space-y-2 py-1 px-2'>
			<header className='flex justify-between w-full'>
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

			<form
				className='flex gap-4 items-end'
				onSubmit={(e) => {
					e.preventDefault();
					getStudent();
				}}
			>
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
					searchable
					allowDeselect={false}
					nothingFoundMessage='Nothing found...'
					onChange={(value: any) => {
						const found: any = queryData?.find((cl: any) => cl?.id == value);
						setSelectedClass(found);
						setSelectedStudent(null);
					}}
				/>
				<Select
					required
					className='w-72'
					checkIconPosition='right'
					label='Select a student'
					placeholder='Select a student'
					data={selectedClass?.ClassHistory?.map(
						({ student }: any, index: number) => {
							return {
								value: `${student?.id}-${index}`,
								label: `${student?.admission_no} - ${student?.first_name} ${student?.last_name}`,
							};
						}
					)}
					searchable
					allowDeselect={false}
					value={selectedStudent}
					nothingFoundMessage='Nothing found...'
					onChange={(value: string | null) => {
						setSelectedStudent(value);
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
			<div className='relative p-2 bg-white flex flex-col gap-3'>
				<Button
					onClick={reactToPrintFn}
					disabled={!selectedStudent}
					className='self-end w-max'
					leftSection={<IconPrinter />}
				>
					Print statement
				</Button>
				<ScrollAreaAutosize>
					{loaded ? (
						<section className='px-4 pb-2' ref={contentRef}>
							<header className='space-y-2 mb-2'>
								<PrintHeader />
								<div className='flex gap-4 justify-between text-sm w-4/5'>
									<p>
										Session:{" "}
										<span className='font-semibold italic'>{session}</span>
									</p>
									<p>
										Term: <span className='font-semibold italic'>{term}</span>
									</p>
									<p>
										Class:{" "}
										<span className='font-semibold italic'>
											{selectedClass?.name}
										</span>
									</p>
									{!selectedClass?.school_section?.includes("SS") && (
										<p>
											No in class:{" "}
											<span className='font-semibold italic'>________</span>
										</p>
									)}
									{resumption && (
										<p>
											School resumes on:{" "}
											<span className='font-semibold italic'>
												{new Date(resumption).toLocaleDateString()}
											</span>
										</p>
									)}
								</div>
								<div className='flex gap-2 justify-between text-sm w-3/4'>
									<p>
										Admission No:{" "}
										<span className='font-semibold italic'>
											{statement?.admission_no}
										</span>
									</p>
									<p>
										Student's Name:{" "}
										<span className='font-semibold italic'>
											{statement?.name}
										</span>
									</p>
									<p>
										Percentage:{" "}
										<span className='font-semibold italic'>{perc} %</span>
									</p>
								</div>
							</header>
							<table className='printable text-sm'>
								<thead>
									<tr>
										<th>S/N</th>
										<th>Subject</th>
										<th>1st-CA</th>
										<th>2nd-CA</th>
										<th>Exam</th>
										<th>Score</th>
										<th>Grade</th>
									</tr>
								</thead>
								<tbody>
									{statement?.generated?.map((state: any, index: number) => (
										<tr key={state?.name + index + 1}>
											<td>{index + 1}</td>
											<td>{state?.name}</td>
											<td>{state?.fca}</td>
											<td>{state?.sca}</td>
											<td>{state?.exam}</td>
											<td>{state?.total}</td>
											<td className='font-semibold'>{state?.grade}</td>
										</tr>
									))}
								</tbody>
							</table>
							<footer className='flex flex-col gap-6 text-sm '>
								<div className='space-y-4 mt-8'>
									<div className='flex justify-between w-full'>
										<p>
											Class teacher's remark
											__________________________________________________________________________
										</p>
										<p>Signature: _______________</p>
									</div>
									{selectedClass?.name?.includes("SS") ? (
										<div className='flex justify-between w-full'>
											<p>
												Principal's remark
												_____________________________________________________________________
											</p>
											<p>Signature: _______________</p>
										</div>
									) : (
										<div className='flex justify-between w-full'>
											<p>
												Head Master's remark
												_____________________________________________________________________
											</p>
											<p>Signature: _______________</p>
										</div>
									)}
								</div>
								<i>...Knowledge for greatness</i>
							</footer>
						</section>
					) : (
						<div className='text-xl flex font-semibold justify-center items-center w-full'>
							<h2>Select a student to generate statement of result for</h2>
						</div>
					)}
				</ScrollAreaAutosize>
				<LoadingOverlay visible={loading} />
			</div>
		</section>
	);
};

export default Statement;
