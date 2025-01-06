import React from "react";
import { currSession, sessions } from "@/libs/sessions";
import { Button, Select, Text } from "@mantine/core";

const DataLoader = ({
	link,
	setQueryData,
	showReload = false,
	post,
}: {
	link: string;
	setQueryData: any;
	showReload?: Boolean;
	post: any;
}) => {
	const [session, setSession] = React.useState<string | null>(currSession);
	React.useEffect(() => {
		async function getAll() {
			const { data } = await post(link, { session });
			setQueryData(data);
		}
		getAll();
	}, [session]);
	return (
		<section className='flex gap-6 items-end'>
			<div className='flex items-end gap-2'>
				<Text className='font-semibold'>Load data by:</Text>
				<Select
					checkIconPosition='right'
					className=' pl-2'
					data={sessions}
					searchable
					allowDeselect={false}
					value={session}
					label='Session'
					nothingFoundMessage='Nothing found...'
					placeholder='Select a session'
					onChange={(value: any) => {
						setSession(value);
					}}
				/>
				<Text className='italic'>Session</Text>
			</div>
			{showReload && (
				<Button
					onClick={async () => {
						const { data } = await post(link, { session });
						setQueryData(data);
					}}
				>
					Reload data
				</Button>
			)}
		</section>
	);
};

export default DataLoader;
