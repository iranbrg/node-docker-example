FROM node:16-alpine AS dev
WORKDIR /app
COPY package*.json tsconfig.json ./
RUN npm install
COPY src ./src

FROM dev AS builder
RUN npm run build

FROM node:16-alpine AS prod
WORKDIR /app
COPY --from=builder /app/package*.json ./
RUN npm install --only=production
COPY --from=builder /app/dist ./dist
ENV PORT 3000
EXPOSE ${PORT}
CMD ["node", "dist/server.js"]
