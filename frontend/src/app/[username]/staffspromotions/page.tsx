"use client";
import React from "react";
import { Tabs } from "@mantine/core";
import StaffPromo from "@/components/promotions/Staff";
import StaffDemo from "@/components/demotions/Staff";

const StaffsPromotions = () => {
	return (
		<Tabs defaultValue='promotions' color='teal' keepMounted={false} p={4}>
			<Tabs.List fw={600}>
				<Tabs.Tab value='promotions'>Promotions</Tabs.Tab>
				<Tabs.Tab value='demotions'>Demotions</Tabs.Tab>
			</Tabs.List>

			<Tabs.Panel value='promotions'>
				<StaffPromo />
			</Tabs.Panel>

			<Tabs.Panel value='demotions'>
				<StaffDemo />
			</Tabs.Panel>
		</Tabs>
	);
};

export default StaffsPromotions;
