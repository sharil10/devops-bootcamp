# Stage 1: Build stage
FROM node:20 AS build
WORKDIR /app
COPY . .
RUN npm clean-install
RUN npm run build

# Stage 2: Production stage (Ini sahaja menjadi image akhir)
FROM nginx:alpine
COPY --from=build /app/dist /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
