FROM node:18

WORKDIR /usr/src

COPY [".", "/usr/src/"]

RUN npm i -g @quasar/cli

WORKDIR /usr/src/quasar-project

RUN npm install

EXPOSE 8080

CMD ["quasar", "dev", ]
