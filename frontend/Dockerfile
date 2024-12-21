# Backend Dockerfile

# Step 1: Use the official Node.js image
FROM node:latest

# Step 2: Set working directory inside the container
WORKDIR /school-client

# Step 3: Copy package.json and package-lock.json
COPY package*.json ./

# Step 4: Install dependencies
RUN npm install --force

# Step 5: Copy the rest of the app's source code
COPY . .

# Step 6: Build the React app for production
RUN npm run build

# Step 6: Expose the port the app runs on
EXPOSE 3000

# Step 7: Command to run the app
CMD ["npm", "start"]