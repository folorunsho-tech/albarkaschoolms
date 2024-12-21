import { useEffect, useState } from "react";
import {
	Table,
	ScrollArea,
	Text,
	TextInput,
	rem,
	keys,
	LoadingOverlay,
} from "@mantine/core";
import chunk from "@/libs/chunk";
import { IconSearch } from "@tabler/icons-react";
import { Pagination } from "@mantine/core";
function filterData(data: any[], search: string) {
	const query = search.toLowerCase().trim();
	return data.filter((item) =>
		keys(data[0]).some((key) => String(item[key]).toLowerCase().includes(query))
	);
}

const PaginatedTable = ({
	data,
	headers,
	setSortedData,
	setSearchedData,
	rows,
	searchedRows,
	placeholder = "Search by any field",
	loading,
	count,
	showSearch = true,
	showlast = true,
	depth = "",
}: {
	data: any[];
	headers: string[];
	setSortedData: any;
	setSearchedData: any;
	rows: any;
	searchedRows: any;
	placeholder: string;
	loading: boolean;
	count: number;
	showSearch: boolean;
	showlast: boolean;
	depth: string;
}) => {
	const mappedData = data.map((mDtata) => {
		return {
			...mDtata,
			...mDtata[depth],
		};
	});
	function sortData(
		data: any[],
		payload: { sortBy: keyof any | null; reversed: boolean; search: string }
	) {
		return filterData(mappedData, payload.search);
	}
	const [sortBy, setSortBy] = useState(null);
	const [search, setSearch] = useState("");
	const [reverseSortDirection] = useState(false);
	const [activePage, setPage] = useState(1);

	const handleSearchChange = (event: React.ChangeEvent<HTMLInputElement>) => {
		const { value } = event.currentTarget;
		setSearch(value);
		setSearchedData(
			sortData(data, {
				sortBy,
				reversed: reverseSortDirection,
				search: value,
			})
		);
	};
	useEffect(() => {
		const paginated: any[] = chunk(data, 50);
		setSortedData(paginated[activePage - 1]);
	}, [activePage]);
	return (
		<ScrollArea h={800}>
			{showSearch && (
				<TextInput
					placeholder={placeholder}
					mb='md'
					leftSection={
						<IconSearch
							style={{ width: rem(16), height: rem(16) }}
							stroke={1.5}
						/>
					}
					value={search}
					onChange={handleSearchChange}
				/>
			)}
			<Table
				verticalSpacing='xs'
				highlightOnHover
				layout='auto'
				withTableBorder
				striped
				className='relative '
				withColumnBorders
				withRowBorders
			>
				<Table.Tbody className='border-b'>
					<Table.Tr>
						<Table.Th>S/N</Table.Th>
						{headers.map((header, index) => (
							<Table.Th key={header + index}>{header}</Table.Th>
						))}
						{showlast && <Table.Th></Table.Th>}
					</Table.Tr>
				</Table.Tbody>
				{search === "" ? (
					<Table.Tbody>
						{rows?.length > 0 ? (
							rows
						) : (
							<Table.Tr>
								<Table.Td colSpan={headers.length + 1}>
									<Text fw={500} ta='center'>
										Nothing found
									</Text>
								</Table.Td>
							</Table.Tr>
						)}
					</Table.Tbody>
				) : (
					<Table.Tbody>
						{searchedRows?.length > 0 ? (
							searchedRows
						) : (
							<Table.Tr>
								<Table.Td colSpan={headers.length + 1}>
									<Text fw={500} ta='center'>
										Nothing found
									</Text>
								</Table.Td>
							</Table.Tr>
						)}
					</Table.Tbody>
				)}
			</Table>
			<LoadingOverlay visible={loading} />
			<div className='flex w-full justify-end'>
				<Pagination
					mt={20}
					total={count < 50 ? 1 : count / 50 + 1}
					value={activePage}
					onChange={(page) => {
						setPage(page);
					}}
				/>
			</div>
		</ScrollArea>
	);
};

export default PaginatedTable;
