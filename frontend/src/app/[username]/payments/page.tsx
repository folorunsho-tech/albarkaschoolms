"use client";
import Reversed from "@/components/payments/Reversed";
import TPayments from "@/components/payments/TPayments";
import { Tabs, rem } from "@mantine/core";
import { IconCashRegister, IconRestore } from "@tabler/icons-react";

function Payments() {
	const iconStyle = { width: rem(20), height: rem(20) };

	return (
		<Tabs defaultValue='payments' keepMounted={false} color='teal'>
			<Tabs.List>
				<Tabs.Tab
					value='payments'
					leftSection={<IconCashRegister style={iconStyle} />}
				>
					Payments
				</Tabs.Tab>
				<Tabs.Tab
					value='cancelled'
					leftSection={<IconRestore style={iconStyle} />}
				>
					Cancelled Payments
				</Tabs.Tab>
			</Tabs.List>

			<Tabs.Panel value='payments'>
				<TPayments />
			</Tabs.Panel>

			<Tabs.Panel value='cancelled'>
				<Reversed />
			</Tabs.Panel>
		</Tabs>
	);
}
export default Payments;
