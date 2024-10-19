# Base Image
# Use the official Ruby 3.1.2 slim version as the base image for a lightweight container
FROM ruby:3.1.2-slim

# Set working directory
# Set the working directory inside the container to /myapp
WORKDIR /myapp

# Install dependencies
# Update the package list and install necessary packages for building Ruby gems and running the app
RUN apt-get update && apt-get install -y \
  build-essential \ 
  libsqlite3-dev \
  nodejs \      
  yarn \             
  entr               

# Copy Gemfile and Gemfile.lock first to take advantage of Docker caching
# Copy Gemfile and Gemfile.lock to the working directory in the container
COPY Gemfile Gemfile.lock ./
# Install Ruby gems defined in the Gemfile
RUN bundle install

# Copy the entire app
# Copy the rest of the application code into the container
COPY . .

# Expose the app port
# Specify that the container listens on port 3000 at runtime
EXPOSE 3000

# Allow hot-reloading for development
# Start the Rails server, removing the server PID file if it exists to prevent startup issues
CMD ["bash", "-c", "rm -f tmp/pids/server.pid && rails server -b 0.0.0.0 -p 3000"]
