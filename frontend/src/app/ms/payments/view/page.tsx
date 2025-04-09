"use client";
import React, { useEffect, useState } from "react";
import { Button, LoadingOverlay, Tabs, Text } from "@mantine/core";
import {
	IconArrowDown,
	IconArrowNarrowLeft,
	IconHistory,
	IconPrinter,
} from "@tabler/icons-react";
import { useRouter, useSearchParams } from "next/navigation";
import { useFetchSingle } from "@/hooks/useQueries";
import { useReactToPrint } from "react-to-print";
import TransactionHistory from "@/components/payments/TransactionHistory";
import CurrentTnx from "@/components/payments/CurrentTnx";
const View = () => {
	const searchParams = useSearchParams();
	const id = searchParams.get("id");
	const { fetch, loading } = useFetchSingle();
	const [queryData, setQueryData] = useState<any>(null);
	const router = useRouter();
	const [docName, setDocName] = React.useState<any>("");
	const contentRef = React.useRef(null);
	const reactToPrintFn: any = useReactToPrint({
		contentRef,
		documentTitle: docName,
	});
	useEffect(() => {
		const getTnx = async () => {
			const { data } = await fetch(`/transactions/${id}`);
			setDocName(`TNXID - ${data?.tnxId} - ${data?.student?.admission_no}`);

			setQueryData(data);
		};
		getTnx();
	}, []);

	return (
		<main className=''>
			<section className='flex justify-between p-3'>
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
				<h3 className='italic'>
					Viewing tnxId: <b>{id}</b>
				</h3>
			</section>
			<section className='bg-white'>
				<Tabs defaultValue='current' keepMounted={false}>
					<Tabs.List>
						<Tabs.Tab value='current' leftSection={<IconArrowDown />}>
							Current State
						</Tabs.Tab>
						<Tabs.Tab value='history' leftSection={<IconHistory />}>
							Transaction History
						</Tabs.Tab>
					</Tabs.List>

					<Tabs.Panel value='current'>
						<CurrentTnx id={id} />
					</Tabs.Panel>

					<Tabs.Panel value='history'>
						<TransactionHistory id={id} />
					</Tabs.Panel>
				</Tabs>
			</section>
			<LoadingOverlay visible={loading} />
		</main>
	);
};

export default View;
