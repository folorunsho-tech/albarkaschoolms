# Use the official Node.js runtime as the base image
FROM node:24-alpine

# Set working directory
WORKDIR /app

# Install dependencies separately for better caching
COPY package*.json ./
RUN npm install --production

# Copy the rest of the code
COPY . .

# Generate Prisma client (must happen after code is copied)
RUN npx prisma generate

# Coolify sets PORT, so use it in your app
ENV PORT=5000
EXPOSE 5000

# Start app
CMD ["npm", "run", "start"]