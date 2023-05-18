# Setup the base image for building
FROM node:19-alpine as builder

# Setup working directory
WORKDIR /home/app/frontend

# Copy pakcage dependency into the working directory
COPY package.json .

# Install all of the dependency files
RUN npm install

# Move all of the rest files into the working directory
COPY . .

# Build the application
RUN npm run build

# Setup the nginx server
FROM nginx

# Copy all of the files into the nginx directory
COPY --from=builder /home/app/frontend/build /usr/share/nginx/html
