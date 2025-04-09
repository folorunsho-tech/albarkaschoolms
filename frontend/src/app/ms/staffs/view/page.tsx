"use client";
import { useState, useEffect } from "react";
import { useRouter, useSearchParams } from "next/navigation";
import { useFetchSingle } from "@/hooks/useQueries";
import {
	LoadingOverlay,
	Card,
	ScrollArea,
	Text,
	Badge,
	Group,
	Avatar,
	NumberFormatter,
	Divider,
	Tabs,
	Button,
} from "@mantine/core";
import moment from "moment";
import PromotionHistory from "@/components/views/PromotionHistory";
import { IconArrowNarrowLeft } from "@tabler/icons-react";
import DemotionHistory from "@/components/views/DemotionHistory";

const ViewStaff = () => {
	const { loading, fetch } = useFetchSingle();
	const [staffData, setStaffData] = useState<any>({});
	const router = useRouter();
	const searchParams = useSearchParams();
	const id = searchParams.get("id");
	useEffect(() => {
		async function getStaff() {
			const { data } = await fetch(`/staffs/${id}`);
			setStaffData(data);
		}
		getStaff();
	}, []);

	return (
		<section className='space-y-4 p-3'>
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
			<section className='relative flex gap-3 w-full'>
				<Card
					shadow='sm'
					padding='lg'
					radius='md'
					withBorder
					className='w-1/4 h-[25rem] bg-white relative space-y-6'
				>
					<Card.Section className='bg-indigo-700 h-20 '>
						<Avatar
							className='absolute left-20 top-8 border border-indigo-500'
							size={80}
							src={staffData?.passport}
							alt='Norway'
						/>
					</Card.Section>
					<Group>
						<Text className='mx-auto mt-3 font-semibold'>
							{staffData?.first_name} {staffData?.last_name}
						</Text>
						<div className='flex items-center justify-between gap-2 w-full'>
							<Text c='dimmed' size='sm'>
								Empid
							</Text>
							<Text c='bold' size='sm'>
								{staffData?.empid}
							</Text>
						</div>
						<div className='flex items-center justify-between gap-2 w-full'>
							<Text c='dimmed' size='sm'>
								Employment status
							</Text>
							<Badge color={staffData?.active ? "teal" : "red"}>
								{staffData?.active ? "Active" : "Inactive"}
							</Badge>
						</div>

						<div className='flex items-center justify-between gap-2 w-full'>
							<Text c='dimmed' size='sm'>
								Telephone
							</Text>
							<Text c='bold' size='sm'>
								{staffData?.telephone}
							</Text>
						</div>
						<div className='flex items-center justify-between gap-2 w-full'>
							<Text c='dimmed' size='sm'>
								Grade level
							</Text>
							<Text c='bold' size='sm'>
								{staffData?.grade_level}
							</Text>
						</div>

						<div className='flex items-center justify-between gap-2 w-full'>
							<Text c='dimmed' size='sm'>
								Appointment
							</Text>
							<Text c='bold' size='sm'>
								{staffData?.curr_appointment?.name}
							</Text>
						</div>

						<div className='flex items-center justify-between gap-2 w-full'>
							<Text c='dimmed' size='sm'>
								School section
							</Text>
							<Text c='bold' size='sm'>
								{staffData?.school_section}
							</Text>
						</div>
					</Group>
				</Card>
				<Tabs
					className='w-full'
					color='teal'
					defaultValue='info'
					keepMounted={false}
				>
					<Tabs.List justify='justify-betwenn'>
						<Tabs.Tab value='info'>Info</Tabs.Tab>
						<Tabs.Tab value='promotions'>Promotion history</Tabs.Tab>
						<Tabs.Tab value='demotions'>Demotion history</Tabs.Tab>
					</Tabs.List>

					<Tabs.Panel value='info'>
						<ScrollArea
							// h={600}
							className='w-full bg-white rounded-sm px-3 py-4 shadow-sm'
						>
							<div className='flex items-center justify-between gap-2 w-full'>
								<Text c='dimmed' size='sm'>
									Date of employment
								</Text>
								<Text c='bold' size='sm'>
									{moment(staffData?.date_of_emp).format("MMMM Do YYYY")}
								</Text>
							</div>
							<Divider my='sm' />
							<div className='flex items-center justify-between gap-2 w-full'>
								<Text c='dimmed' size='sm'>
									Initial appointment
								</Text>
								<Text c='bold' size='sm'>
									{staffData?.appointed_as}
								</Text>
							</div>
							<Divider my='sm' />
							{staffData?.class_assigned?.length > 0 && (
								<>
									<div className='flex items-center justify-between gap-2 w-full'>
										<Text c='dimmed' size='sm'>
											Class assigned
										</Text>

										<Text c='bold' size='sm'>
											{staffData?.class_assigned[0].name}
										</Text>
									</div>
									<Divider my='sm' />
								</>
							)}
							<div className='flex items-center justify-between gap-2 w-full'>
								<Text c='dimmed' size='sm'>
									Subjects assigned
								</Text>
								<Text c='bold' size='sm'>
									{staffData?.subjects?.map((sub: any) => (
										<span key={sub.id}>{sub.name},</span>
									))}
								</Text>
							</div>
							<Divider my='sm' />
							<div className='flex items-center justify-between gap-2 w-full'>
								<Text c='dimmed' size='sm'>
									Qualification
								</Text>
								<Text c='bold' size='sm'>
									{staffData?.qualification}
								</Text>
							</div>
							<Divider my='sm' />
							<div className='flex items-center justify-between gap-2 w-full'>
								<Text c='dimmed' size='sm'>
									Salary
								</Text>
								<Text c='bold' size='sm'>
									<NumberFormatter
										prefix='N '
										value={staffData?.salary}
										thousandSeparator
									/>
								</Text>
							</div>
							<Divider my='sm' />
							<div className='flex items-center justify-between gap-2 w-full'>
								<Text c='dimmed' size='sm'>
									Date of birth
								</Text>
								<Text c='bold' size='sm'>
									{moment(staffData?.date_of_birth).format("MMMM Do YYYY")}
								</Text>
							</div>
							<Divider my='sm' />
							<div className='flex items-center justify-between gap-2 w-full'>
								<Text c='dimmed' size='sm'>
									Age
								</Text>
								<Text c='bold' size='sm'>
									{moment(staffData?.date_of_birth).fromNow(true)}
								</Text>
							</div>
							<Divider my='sm' />
							<div className='flex items-center justify-between gap-2 w-full'>
								<Text c='dimmed' size='sm'>
									Sex
								</Text>
								<Text c='bold' size='sm'>
									{staffData?.sex}
								</Text>
							</div>
							<Divider my='sm' />
							<div className='flex items-center justify-between gap-2 w-full'>
								<Text c='dimmed' size='sm'>
									Marital Status
								</Text>
								<Text c='bold' size='sm'>
									{staffData?.marital_status}
								</Text>
							</div>
							<Divider my='sm' />
							<div className='flex items-center justify-between gap-2 w-full'>
								<Text c='dimmed' size='sm'>
									Religion
								</Text>
								<Text c='bold' size='sm'>
									{staffData?.religion}
								</Text>
							</div>
							<Divider my='sm' />
							<div className='flex items-center justify-between gap-2 w-full'>
								<Text c='dimmed' size='sm'>
									State of origin
								</Text>
								<Text c='bold' size='sm'>
									{staffData?.state_of_origin}
								</Text>
							</div>
							<Divider my='sm' />
							<div className='flex items-center justify-between gap-2 w-full'>
								<Text c='dimmed' size='sm'>
									LGA
								</Text>
								<Text c='bold' size='sm'>
									{staffData?.lga}
								</Text>
							</div>
							<Divider my='sm' />
							<div className='flex items-center justify-between gap-2 w-full'>
								<Text c='dimmed' size='sm'>
									Address
								</Text>
								<Text c='bold' size='sm'>
									{staffData?.address}
								</Text>
							</div>
						</ScrollArea>
					</Tabs.Panel>

					<Tabs.Panel value='promotions' className='bg-white p-2'>
						<PromotionHistory empid={id} />
					</Tabs.Panel>
					<Tabs.Panel value='demotions' className='bg-white p-2'>
						<DemotionHistory empid={id} />
					</Tabs.Panel>
				</Tabs>
				<LoadingOverlay visible={loading} />
			</section>
		</section>
	);
};

export default ViewStaff;
