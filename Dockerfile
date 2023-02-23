# we create a builder phase. It includes everything within it
FROM node:19-alpine as builder

WORKDIR '/app'
COPY package.json .
RUN npm install
COPY ./ /app
RUN npm run build

# /app/build <--- includes all the files which we care about. It will be created with npm run build

FROM nginx
# This is copying something from a different stage. And we specify 1. what we want to copy 2. where we want to copy (this information is from hub.docker nginx)
# We specify that the /app/build is from the builder app
COPY --from=builder /app/build /usr/share/nginx/html

# When we start the nginx container we don´t need to add further commands. This will happen automatically with using the nginx image