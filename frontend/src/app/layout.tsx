import "@mantine/core/styles.css";
import "@mantine/dates/styles.css";
import { MantineProvider } from "@mantine/core";
import { ModalsProvider } from "@mantine/modals";
import { Notifications } from "@mantine/notifications";
import { DatesProvider } from "@mantine/dates";
import "./globals.css";
import dayjs from "dayjs";
import customParseFormat from "dayjs/plugin/customParseFormat";
import { UserProvider } from "@/context/User";
import { CookiesProvider } from "next-client-cookies/server";
import { Metadata } from "next";

export const metadata: Metadata = {
	title: "Albarka SMS",
	description: "Albarka School Management System.",
};
dayjs.extend(customParseFormat);
export default function RootLayout({
	children,
}: Readonly<{
	children: React.ReactNode;
}>) {
	return (
		<html lang='en'>
			<body suppressHydrationWarning={true} className='bg-gray-200'>
				<CookiesProvider>
					<MantineProvider>
						<Notifications autoClose={3000} className='absolute top-0 left-1' />
						<ModalsProvider>
							<DatesProvider
								settings={{ consistentWeeks: true, timezone: "UTC" }}
							>
								<UserProvider>{children}</UserProvider>
							</DatesProvider>
						</ModalsProvider>
					</MantineProvider>
				</CookiesProvider>
			</body>
		</html>
	);
}
