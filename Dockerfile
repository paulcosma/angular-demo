FROM node:8

# Create app directory
WORKDIR /usr/src/app

# Install Yarn
RUN apt-get update \
    && apt-get -y install yarn

# add `/usr/src/app/node_modules/.bin` to $PATH
ENV PATH /usr/src/app/node_modules/.bin:$PATH

# Install app dependencies
# A wildcard is used to ensure both package.json AND package-lock.json are copied
# where available (npm@5+)
COPY package*.json ./
COPY yarn*.* ./

RUN yarn install
# If you are building your code for production. The build artifacts will be stored in the dist/ directory
#RUN ng build --prod

RUN npm install -g @angular/cli
#    && npm link @angular/cli

#RUN npm install
# If you are building your code for production
# RUN npm install --only=production

# Bundle app source
COPY . .

EXPOSE 4200

# Start App
CMD [ "ng", "serve", "--host", "0.0.0.0" ]
