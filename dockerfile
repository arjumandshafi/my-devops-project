# Dockerfile

# Step 1: Build the React app
FROM node:18-alpine as builder

WORKDIR /app

# Copy only the package files first for layer caching
COPY package*.json ./

RUN npm install

# Copy the rest of the source code and build
COPY . .

RUN npm run build

# Step 2: Serve the app using a lightweight server
FROM node:18-alpine as production

WORKDIR /app

# Copy built assets from the previous stage
COPY --from=builder /app/build ./build

# Install serve to serve the build
RUN npm install -g serve

# Expose the port
EXPOSE 3000

# Start the app
CMD ["serve", "-s", "build", "-l", "3000"]

