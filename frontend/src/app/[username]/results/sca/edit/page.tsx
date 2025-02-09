"use client";
import React from "react";
import { useRouter, useSearchParams } from "next/navigation";
import { useFetch, useEdit } from "@/hooks/useQueries";
import { Button, LoadingOverlay, NumberInput, Text } from "@mantine/core";
import { IconArrowNarrowLeft } from "@tabler/icons-react";

const EditSca = () => {
	const { loading, post } = useEdit();
	const router = useRouter();
	const searchParams = useSearchParams();
	const id = searchParams.get("id");
	const { fetch } = useFetch();
	const [queryData, setQueryData] = React.useState<any>(null);
	const [score, setScore] = React.useState<number | string>(0);
	React.useEffect(() => {
		async function getData() {
			const { data } = await fetch(`/sca/${id}`);
			setQueryData(data);
			setScore(data?.score);
		}
		getData();
	}, []);
	return (
		<form
			onSubmit={async (e) => {
				e.preventDefault();
				await post(`/sca/edit/${id}`, { score });
			}}
			className='flex flex-col gap-6 px-6 py-4'
		>
			<div className='flex gap-10 items-center '>
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
				<h2 className='text-lg text-indigo-600 font-semibold'>
					Editing {queryData?.subject?.name} 2nd C.A result for{" "}
					{queryData?.student?.first_name} {queryData?.student?.last_name} -{" "}
					{queryData?.student?.admission_no}
				</h2>
			</div>
			<div className='space-y-4'>
				<div className='flex gap-6 items-center'>
					<Text>
						Session : <b>{queryData?.session}</b>
					</Text>
					<Text>
						Term : <b>{queryData?.term}</b>
					</Text>
					<Text>
						Class : <b>{queryData?.class?.name}</b>
					</Text>
					<Text>
						Subject : <b>{queryData?.subject?.name}</b>
					</Text>
				</div>
				<NumberInput
					label='Score'
					value={score}
					max={20}
					className='w-20'
					onChange={(value) => {
						setScore(value);
					}}
				/>
			</div>
			<div className='flex gap-8'>
				<Button
					color='black'
					onClick={() => {
						router.back();
					}}
				>
					Cancel
				</Button>
				<Button disabled={score == queryData?.score} color='teal' type='submit'>
					Update result
				</Button>
			</div>
			<LoadingOverlay visible={loading} />
		</form>
	);
};

export default EditSca;
