# Use the official Node.js image as a base image
FROM node:18

# Set the working directory inside the container
WORKDIR /app

# Copy package.json and package-lock.json to the working directory
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the application code to the working directory
COPY . .

# Generate Prisma client
RUN npx prisma generate

# Deploy Prisma client
RUN npx prisma migrate deploy

# Seed Prisma client
RUN npx prisma db seed

# Build the NestJS application
RUN npm run build

# Expose the port the app runs on
EXPOSE 3000

# Define the command to run the application
CMD ["npm", "run", "start:prod"]


