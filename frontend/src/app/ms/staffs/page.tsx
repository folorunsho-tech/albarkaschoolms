"use client";
import React from "react";
import { Tabs } from "@mantine/core";
import Active from "@/components/staffs/Active";
import Disengaged from "@/components/staffs/Disengaged";
const Staffs = () => {
	return (
		<Tabs defaultValue='active' color='teal' keepMounted={false} p={4}>
			<Tabs.List fw={600}>
				<Tabs.Tab value='active'>Active Staffs</Tabs.Tab>
				<Tabs.Tab value='disengaged'>Disengaged Staffs</Tabs.Tab>
			</Tabs.List>

			<Tabs.Panel value='active'>
				<Active />
			</Tabs.Panel>

			<Tabs.Panel value='disengaged'>
				<Disengaged />
			</Tabs.Panel>
		</Tabs>
	);
};

export default Staffs;
