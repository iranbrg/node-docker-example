# Dependencies installation stage (also delelopment environment)
FROM node:16-alpine AS dev

WORKDIR /app

COPY package*.json ./
RUN npm install

COPY prisma/schema.prisma ./prisma/
RUN npx prisma generate

COPY src ./src

# Build stage
FROM dev AS builder

COPY tsconfig.json ./
RUN npm run build

# Run stage (also production environment)
FROM node:16-alpine AS prod

WORKDIR /app

COPY --from=builder /app/package*.json ./
RUN npm install --only=production

COPY --from=builder /app/dist ./dist

ENV PORT 3000

EXPOSE ${PORT}

CMD ["node", "dist/server.js"]
