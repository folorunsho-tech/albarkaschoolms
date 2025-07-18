import React from "react";
import { useReactToPrint } from "react-to-print";
import PrintHeader from "@/components/PrintHeader";
import { IconPrinter } from "@tabler/icons-react";
import { Button, LoadingOverlay, ScrollAreaAutosize } from "@mantine/core";
import getGrade from "@/libs/getGrade";
import { usePostNormal } from "@/hooks/useQueries";

const Result = ({
	session,
	term,
	selectedClass,
	selectedStudent,
	student,
	fetchResult,
	resumption,
}: {
	session: string;
	term: string;
	selectedClass: any;
	selectedStudent: any | null;
	student: any | null;
	fetchResult: boolean;
	resumption: string | null;
}) => {
	const { post } = usePostNormal();
	const [loading, setLoading] = React.useState<boolean>(false);
	const [perc, setPerc] = React.useState<number>(0);
	const [statement, setStatement] = React.useState<any>("");
	const [docName, setDocName] = React.useState<any>("");
	const contentRef = React.useRef(null);
	const reactToPrintFn: any = useReactToPrint({
		contentRef,
		documentTitle: docName,
	});
	const getStudent = async () => {
		setLoading(true);

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
			name: `${student?.last_name} ${student?.first_name}`,

			admission_no: student?.admission_no,
			generated: generated.sort((a, b) =>
				a?.name?.toLowerCase() < b?.name?.toLowerCase() ? -1 : 1
			),
		});
		const total = generated?.reduce((prev: number, curr: { total: number }) => {
			return prev + curr.total;
		}, 0);
		const calculated = ((total / (subs.length * 100)) * 100).toFixed(2);

		setPerc(calculated !== "NaN" ? parseFloat(calculated) : 0);
		setDocName(data?.admission_no);
		setLoading(false);
	};
	React.useEffect(() => {
		if (fetchResult && selectedStudent) {
			getStudent();
		}
	}, [fetchResult]);
	return (
		<div className='relative flex flex-col gap-3'>
			<Button
				onClick={reactToPrintFn}
				disabled={!selectedStudent}
				className='self-end w-max'
				leftSection={<IconPrinter />}
			>
				Print statement
			</Button>
			<ScrollAreaAutosize>
				<section className='px-4 pb-2 prints' ref={contentRef}>
					<header className='space-y-2 mb-2'>
						<PrintHeader />
						<div className='flex gap-4 justify-between text-sm w-4/5'>
							<p>
								Session: <span className='font-semibold italic'>{session}</span>
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
									<span className='font-semibold italic underline underline-offset-1'>
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
								<span className='font-semibold italic'>{statement?.name}</span>
							</p>
							<p>
								Percentage:{" "}
								<span className='font-semibold italic'>{perc} %</span>
							</p>
						</div>
					</header>
					<table className='printable text-sm '>
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
			</ScrollAreaAutosize>
			<LoadingOverlay visible={loading} />
		</div>
	);
};

export default Result;
