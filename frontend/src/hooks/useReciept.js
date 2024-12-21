import React, { useState } from "react";

const useReciept = (contentRef) => {
	const [printData, setPrintData] = useState(null);

	const print = (data) => {
		setPrintData(data);
		reactToPrintFn();
	};
	<section ref={contentRef}>{printData}</section>;
	return { print };
};

export default useReciept;
