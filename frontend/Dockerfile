# Use the official Node.js runtime as the base image
FROM node:lts-alpine3.21

# Set the working directory inside the container
WORKDIR /app

# Copy package.json and package-lock.json
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the application code
COPY . .

# Build the Next.js application
RUN npm run build

# Set environment variable
ENV NEXT_PUBLIC_SERVER_API=http://localhost:5000/api

# Expose the port the app runs on
EXPOSE 3000

# Start the application
CMD ["npm", "start"]