FROM node:14

# Create app directory
WORKDIR /usr/src/app
RUN chown -R 1000:1000 /usr/src/app
# Run as a basic bob
USER 1000:1000

COPY package.json .
COPY package-lock.json .
RUN npm ci
COPY index.js .
CMD [ "node", "index.js" ]




