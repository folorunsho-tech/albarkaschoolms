"use client";
import PaymentsFilter from "@/components/filters/PaymentFilter";
import PaymentLoader from "@/components/PaymentLoader";
import { usePostNormal } from "@/hooks/useQueries";
import { Button } from "@mantine/core";
import { IconArrowNarrowLeft } from "@tabler/icons-react";
import { useRouter } from "next/navigation";
import { useState } from "react";

const page = () => {
	const router = useRouter();
	const { post, loading } = usePostNormal();
	const [queryData, setQueryData] = useState<any[]>([]);

	return (
		<main className='bg-white p-2 divide-y-4'>
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
				<PaymentLoader
					link='/payments'
					post={post}
					// loadCriteria='Sex'
					setQueryData={setQueryData}
				/>
			</section>

			<PaymentsFilter data={queryData} loading={loading} />
		</main>
	);
};

export default page;
