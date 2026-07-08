# Stage 1: Install dependencies and build the app in a full environment.

# Use the full Node.js 20 image and alias it
FROM node:20 AS builder

# Set working dir inside the container 
WORKDIR /app

# Copy only package files first (utilizng Docker's caching mechanism)
COPY package*.json ./

# Install all project dependencies into the node_modules folde
RUN npm install

# Copy the remaining project source code from the host machine to the container
COPY . .


# Stage 2: Production, containing only what's necessary for runtime

# Switch to a smaller image
FROM node:20-slim

# Update the package manager, install basic system utilities
RUN apt-get update && \
    apt-get install -y \
    ca-certificates \
    bash \
    vim \
    procps \
    curl && \
    rm -rf /var/lib/apt/lists/*


# Create a new system group and user
RUN groupadd -g 1500 user && \
    useradd -m -u 1500 -g 1500 user


# Set working to the new user's home dir
WORKDIR /home/user/app

# Copy the built code and node_modules directly from the "builder" stage
COPY --from=builder /app /home/user/app

# Change file ownership the the new user
RUN chown -R user:user /home/user/app

# Instruct Docker to run all instructions under the new user
USER user

# Declare that the application listens on port 8080 inside the container
EXPOSE 8080

# The default command to execute when the container starts - runs the start.sh script using bash
CMD ["bash", "/home/user/app/start.sh"]

