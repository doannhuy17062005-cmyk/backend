# Stage 1: Build - Sử dụng Maven với JDK 21
FROM maven:3.9.6-eclipse-temurin-21 AS build
WORKDIR /app

# Copy các file cấu hình và code
COPY pom.xml .
COPY src ./src

# Build dự án
RUN mvn clean package -DskipTests

# Stage 2: Run - Sử dụng JRE 21 để chạy
FROM eclipse-temurin:21-jre-alpine
WORKDIR /app

# Copy file jar đã build từ Stage 1
# Lưu ý: Kiểm tra xem tên file jar trong thư mục target là gì, thường là [tên-dự-án]-[phiên-bản].jar
COPY --from=build /app/target/*.jar app.jar

EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]