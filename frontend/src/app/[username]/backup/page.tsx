"use client";
import React from "react";
import { Button, Loader, Tabs, rem } from "@mantine/core";
import {
	IconDatabaseExport,
	IconDatabaseImport,
	IconDownload,
	IconX,
	IconCheck,
} from "@tabler/icons-react";
import axios from "@/config/axios";
import { notifications } from "@mantine/notifications";
import { FileInput } from "@mantine/core";
const Backup = () => {
	const [backingUp, setbackingUp] = React.useState(false);
	const [restoring, setRestoring] = React.useState(false);
	const [file, setFile] = React.useState<File | null>(null);
	const iconStyle = { width: rem(20), height: rem(20) };
	const server = "http://localhost:5000";
	const showBackedUp = (status: number) => {
		if (status == 200) {
			notifications.show({
				id: "BackedSucc",
				withCloseButton: true,
				autoClose: 1000,
				withBorder: true,
				className: "w-max absolute top-0  left-0",
				title: "Success !!!",
				message: "Successfully backed up !!!",
				color: "green",
				icon: <IconCheck />,
			});
		} else {
			notifications.show({
				id: "BackedErr",
				withCloseButton: true,
				autoClose: 1000,
				withBorder: true,
				className: "w-max absolute top-0  left-0",
				title: "Error!!!",
				message: "Error Backing up Database!!!",
				color: "red",
				icon: <IconX />,
			});
		}
	};
	const showRestored = (status: number) => {
		if (status == 200) {
			notifications.show({
				id: "RestoredSucc",
				withCloseButton: true,
				autoClose: 1000,
				withBorder: true,
				className: "w-max absolute top-0  left-0",
				title: "Success !!!",
				message: "Successfully restored Database !!!",
				color: "green",
				icon: <IconCheck />,
			});
		} else {
			notifications.show({
				id: "RestoredErr",
				withCloseButton: true,
				autoClose: 1000,
				withBorder: true,
				className: "w-max absolute top-0  left-0",
				title: "Error!!!",
				message: "Error restoring Database !!!",
				color: "red",
				icon: <IconX />,
			});
		}
	};
	return (
		<section className='py-2'>
			<Tabs
				className='bg-white'
				color='teal'
				defaultValue='generate'
				keepMounted={false}
			>
				<Tabs.List grow justify='justify-betwenn'>
					<Tabs.Tab
						value='generate'
						leftSection={<IconDatabaseExport style={iconStyle} />}
					>
						Generate Backup
					</Tabs.Tab>
					<Tabs.Tab
						value='restore'
						leftSection={<IconDatabaseImport style={iconStyle} />}
					>
						Restore Backup
					</Tabs.Tab>
				</Tabs.List>

				<Tabs.Panel value='generate' className='p-2 flex flex-col gap-6'>
					<div className='flex gap-4 items-end'>
						<Button
							disabled={backingUp}
							onClick={async () => {
								setbackingUp(true);
								const res = await axios.post("/backup/generate");
								setbackingUp(false);
								showBackedUp(res?.status);
							}}
						>
							Generate backup
						</Button>
						{backingUp && (
							<i className='flex gap-1 items-center'>
								<Loader color='blue' size='md' type='dots' /> Generating
								backup...
							</i>
						)}
					</div>
					<a href={server + "/backup/download"}>
						<Button
							color='teal'
							leftSection={<IconDownload style={iconStyle} />}
						>
							Download backup
						</Button>
					</a>
				</Tabs.Panel>

				<Tabs.Panel value='restore' className='p-2'>
					<form
						className='flex gap-6 items-end'
						encType='multipart/form-data'
						onSubmit={async (e) => {
							e.preventDefault();
							const restoreData: any = new FormData();
							restoreData.append("restore", file);
							setRestoring(true);
							const res = await axios.post("/backup/restore", restoreData, {
								headers: { "Content-Type": "multipart/form-data" },
							});
							setRestoring(false);
							showRestored(res?.status);
						}}
					>
						<FileInput
							label='Back-up file to restore'
							placeholder='Click select backup file to restore'
							size='sm'
							value={file}
							name='restore'
							onChange={setFile}
						/>
						<Button disabled={restoring} type='submit'>
							Restore backup
						</Button>
						{restoring && <Loader color='teal' size='md' type='dots' />}
					</form>
				</Tabs.Panel>
			</Tabs>
		</section>
	);
};

export default Backup;
