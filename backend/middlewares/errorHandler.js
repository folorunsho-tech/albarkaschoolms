// Custom Error Handling Middleware
export const errorHandler = (err, req, res, next) => {
	// Log the error for debugging purposes
	console.error(err);

	// Respond with an appropriate message
	res
		.status(500)
		.json("Oops! Something went wrong. Our team has been notified.");
};
