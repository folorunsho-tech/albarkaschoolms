"use client";
import { useContext, useEffect, useState } from "react";
import {
	TextInput,
	PasswordInput,
	Button,
	Checkbox,
	Select,
} from "@mantine/core";
import { LoadingOverlay } from "@mantine/core";
import { useRouter, useSearchParams } from "next/navigation";
import { IconArrowNarrowLeft } from "@tabler/icons-react";
import { useForm } from "react-hook-form";
import { useEdit, useFetch } from "@/hooks/useQueries";
import { userContext } from "@/context/User";

const Edit = () => {
	const { user } = useContext(userContext);
	const searchParams = useSearchParams();
	const id = searchParams.get("id");
	const { fetch } = useFetch();
	const { post, loading } = useEdit();
	const [students, setStudents] = useState({
		view: false,
		create: false,
		edit: false,
	});
	const [staffs, setStaffs] = useState({
		view: false,
		create: false,
		edit: false,
	});
	const [results, setResults] = useState({
		view: false,
		create: false,
		edit: false,
	});
	const [payments, setPayments] = useState({
		view: false,
		create: false,
		edit: false,
	});
	const [classes, setClasses] = useState({
		view: false,
		edit: false,
	});
	const [accounts, setAccounts] = useState(false);
	// const [staffPromotions, setStaffPromotions] = useState(false);
	const [studentPromotions, setStudentPromotions] = useState(false);
	const [statement, setStatement] = useState(false);
	const [name, setName] = useState("");
	const [username, setUsername] = useState("");
	const [password, setPassword] = useState("");
	const [role, setRole] = useState("");
	const { handleSubmit } = useForm();
	const router = useRouter();
	const onSubmit = async () => {
		await post(`/accounts/edit/${id}`, {
			name,
			username,
			password,
			role,
			permissions: {
				accounts,
				studentPromotions,
				// staffPromotions,
				classes,
				students,
				results,
				staffs,
				payments,
				statement,
			},
		});

		router.back();
	};
	useEffect(() => {
		const getAll = async () => {
			const { data } = await fetch(`/accounts/${id}`);
			setName(data?.name);
			setUsername(data?.username);
			setPassword(data?.password);
			setRole(data?.role);
			const permissions = data?.permissions;
			setAccounts(permissions?.accounts);
			// setStaffPromotions(permissions?.staffPromotions);
			setStudentPromotions(permissions?.studentPromotions);
			setClasses(permissions?.classes);
			setStudents(permissions?.students);
			setResults(permissions?.results);
			setStaffs(permissions?.staffs);
			setPayments(permissions?.payments);
			setStatement(permissions?.statement);
		};

		getAll();
	}, []);

	return (
		<section className='flex flex-col gap-4 relative p-3 bg-white'>
			<div className='flex gap-10 items-center'>
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
				<h2 className='font-bold text-xl text-blue-700'>
					Editing account for {name}
				</h2>
			</div>

			<form onSubmit={handleSubmit(onSubmit)} className='relative'>
				<div className=''>
					<section className='flex flex-col gap-6'>
						{user?.role == "admin" && (
							<Select
								className='w-80'
								checkIconPosition='right'
								label='Select account role'
								placeholder='Select a role'
								data={["admin", "user"]}
								value={role}
								allowDeselect={false}
								onChange={(value: any) => {
									setRole(value);
								}}
							/>
						)}
						<TextInput
							label='Name'
							placeholder='name...'
							autoComplete='name'
							className='w-80'
							value={name}
							disabled
							onChange={(e) => {
								setName(e.currentTarget.value);
							}}
						/>
						<TextInput
							label='Username'
							placeholder='username...'
							className='w-80'
							value={username}
							onChange={(e) => {
								setUsername(e.currentTarget.value);
							}}
						/>
						<PasswordInput
							label='Password'
							placeholder='Your password'
							className='w-80'
							value={password}
							onChange={(e) => {
								setPassword(e.currentTarget.value);
							}}
						/>
						<section className='space-y-2 mb-3'>
							<h2 className='text-md font-semibold'>Permissions:</h2>
							<div className='flex flex-wrap gap-4'>
								<div className='space-y-2'>
									<span className='flex gap-2'>
										<Checkbox
											checked={accounts}
											onChange={() => setAccounts(!accounts)}
										/>
										<h3 className='text-sm font-semibold'>Accounts</h3>
									</span>
								</div>
								<div className='space-y-2'>
									<span className='flex gap-2'>
										<Checkbox
											checked={studentPromotions}
											onChange={() => setStudentPromotions(!studentPromotions)}
										/>
										<h3 className='text-sm font-semibold'>
											Students Promotions
										</h3>
									</span>
								</div>
								{/* <div className='space-y-2'>
									<span className='flex gap-2'>
										<Checkbox
											checked={staffPromotions}
											onChange={() => setStaffPromotions(!staffPromotions)}
										/>
										<h3 className='text-sm font-semibold'>Staffs Promotions</h3>
									</span>
								</div> */}
								<div className='space-y-2'>
									<span className='flex gap-2'>
										<Checkbox
											checked={statement}
											onChange={() => setStatement(!statement)}
										/>
										<h3 className='text-sm font-semibold'>
											Statement of results
										</h3>
									</span>
								</div>
								<div className='space-y-2'>
									<span className='flex gap-2'>
										<Checkbox
											checked={classes.view && classes.edit}
											onChange={() => {
												setClasses({
													view: !classes.view,

													edit: !classes.edit,
												});
											}}
										/>
										<h3 className='text-sm font-semibold'>Classes</h3>
									</span>
									{/* <span className='flex gap-2 ml-4'>
										<Checkbox
											checked={classes.view}
											onChange={() =>
												setClasses((prev) => ({ ...prev, view: !prev.view }))
											}
										/>
										<h3 className='text-sm font-semibold'>View</h3>
									</span> */}

									<span className='flex gap-2 ml-4'>
										<Checkbox
											checked={classes.edit}
											onChange={() =>
												setClasses((prev) => ({ ...prev, edit: !prev.edit }))
											}
										/>
										<h3 className='text-sm font-semibold'>Edit</h3>
									</span>
								</div>
								<div className='space-y-2'>
									<span className='flex gap-2'>
										<Checkbox
											checked={
												students.view && students.create && students.edit
											}
											onChange={() => {
												setStudents({
													view: !students.view,
													create: !students.create,
													edit: !students.edit,
												});
											}}
										/>
										<h3 className='text-sm font-semibold'>Students</h3>
									</span>
									{/* <span className='flex gap-2 ml-4'>
										<Checkbox
											checked={students.view}
											onChange={() =>
												setStudents((prev) => ({ ...prev, view: !prev.view }))
											}
										/>
										<h3 className='text-sm font-semibold'>View</h3>
									</span> */}
									<span className='flex gap-2 ml-4'>
										<Checkbox
											checked={students.create}
											onChange={() =>
												setStudents((prev) => ({
													...prev,
													create: !prev.create,
												}))
											}
										/>
										<h3 className='text-sm font-semibold'>Create</h3>
									</span>
									<span className='flex gap-2 ml-4'>
										<Checkbox
											checked={students.edit}
											onChange={() =>
												setStudents((prev) => ({ ...prev, edit: !prev.edit }))
											}
										/>
										<h3 className='text-sm font-semibold'>Edit</h3>
									</span>
								</div>
								<div className='space-y-2'>
									<span className='flex gap-2'>
										<Checkbox
											checked={results.view && results.create && results.edit}
											onChange={() => {
												setResults({
													view: !results.view,
													create: !results.create,
													edit: !results.edit,
												});
											}}
										/>
										<h3 className='text-sm font-semibold'>Results</h3>
									</span>
									{/* <span className='flex gap-2 ml-4'>
										<Checkbox
											checked={results.view}
											onChange={() =>
												setResults((prev) => ({ ...prev, view: !prev.view }))
											}
										/>
										<h3 className='text-sm font-semibold'>View</h3>
									</span> */}
									<span className='flex gap-2 ml-4'>
										<Checkbox
											checked={results.create}
											onChange={() =>
												setResults((prev) => ({
													...prev,
													create: !prev.create,
												}))
											}
										/>
										<h3 className='text-sm font-semibold'>Create</h3>
									</span>
									<span className='flex gap-2 ml-4'>
										<Checkbox
											checked={results.edit}
											onChange={() =>
												setResults((prev) => ({ ...prev, edit: !prev.edit }))
											}
										/>
										<h3 className='text-sm font-semibold'>Edit</h3>
									</span>
								</div>
								<div className='space-y-2'>
									<span className='flex gap-2'>
										<Checkbox
											checked={staffs.view && staffs.create && staffs.edit}
											onChange={() => {
												setStaffs({
													view: !staffs.view,
													create: !staffs.create,
													edit: !staffs.edit,
												});
											}}
										/>
										<h3 className='text-sm font-semibold'>Staffs</h3>
									</span>
									{/* <span className='flex gap-2 ml-4'>
										<Checkbox
											checked={staffs.view}
											onChange={() =>
												setStaffs((prev) => ({ ...prev, view: !prev.view }))
											}
										/>
										<h3 className='text-sm font-semibold'>View</h3>
									</span> */}
									<span className='flex gap-2 ml-4'>
										<Checkbox
											checked={staffs.create}
											onChange={() =>
												setStaffs((prev) => ({
													...prev,
													create: !prev.create,
												}))
											}
										/>
										<h3 className='text-sm font-semibold'>Create</h3>
									</span>
									<span className='flex gap-2 ml-4'>
										<Checkbox
											checked={staffs.edit}
											onChange={() =>
												setStaffs((prev) => ({ ...prev, edit: !prev.edit }))
											}
										/>
										<h3 className='text-sm font-semibold'>Edit</h3>
									</span>
								</div>
								<div className='space-y-2'>
									<span className='flex gap-2'>
										<Checkbox
											checked={
												payments.view && payments.create && payments.edit
											}
											onChange={() => {
												setPayments({
													view: !payments.view,
													create: !payments.create,
													edit: !payments.edit,
												});
											}}
										/>
										<h3 className='text-sm font-semibold'>Payments</h3>
									</span>
									{/* <span className='flex gap-2 ml-4'>
										<Checkbox
											checked={payments.view}
											onChange={() =>
												setPayments((prev) => ({ ...prev, view: !prev.view }))
											}
										/>
										<h3 className='text-sm font-semibold'>View</h3>
									</span> */}
									<span className='flex gap-2 ml-4'>
										<Checkbox
											checked={payments.create}
											onChange={() =>
												setPayments((prev) => ({
													...prev,
													create: !prev.create,
												}))
											}
										/>
										<h3 className='text-sm font-semibold'>Create</h3>
									</span>
									<span className='flex gap-2 ml-4'>
										<Checkbox
											checked={payments.edit}
											onChange={() =>
												setPayments((prev) => ({ ...prev, edit: !prev.edit }))
											}
										/>
										<h3 className='text-sm font-semibold'>Edit</h3>
									</span>
								</div>
							</div>
						</section>
					</section>
				</div>
				<div className='flex items-center gap-6 mt-5 '>
					<Button
						onClick={() => {
							router.back();
						}}
						color='black'
					>
						Cancel
					</Button>
					<Button color='teal' type='submit'>
						Update account
					</Button>
				</div>
			</form>
			<LoadingOverlay visible={loading} />
		</section>
	);
};

export default Edit;
