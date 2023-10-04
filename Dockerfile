# Use an official Node.js runtime as a base image
FROM node:14

# Create a directory for your app
RUN mkdir /app

# Set the working directory to /app
WORKDIR /app

# Copy package.json and package-lock.json to the container
COPY package*.json ./

# Install PM2 globally
RUN npm install pm2 -g

# Install application dependencies
RUN npm install

# Copy the rest of the application source code to the container
COPY . .

# Expose the port your Express.js application will run on (assuming it's 3000)
EXPOSE 3000

# Install Nginx
RUN apt-get update && apt-get install -y nginx

# Copy your custom Nginx configuration file into the sites-available directory
COPY my-nginx.conf /etc/nginx/sites-available/

# Create a symbolic link to enable your custom Nginx configuration
RUN ln -s /etc/nginx/sites-available/my-nginx.conf /etc/nginx/sites-enabled/

# Start your Node.js application using PM2
CMD ["pm2-runtime", "app.js"]

