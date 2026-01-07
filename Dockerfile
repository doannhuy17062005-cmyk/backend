# ===============================
# BUILD STAGE
# ===============================
FROM eclipse-temurin:17-jdk AS build

WORKDIR /app

# Copy toàn bộ source
COPY . .

# Cấp quyền cho Maven Wrapper
RUN chmod +x mvn

# Build Spring Boot (không chạy test)
RUN mvn clean package -DskipTests


# ===============================
# RUN STAGE
# ===============================
FROM eclipse-temurin:17-jre

WORKDIR /app

# Copy file jar đã build
COPY --from=build /app/target/*.jar app.jar

# Port mặc định Spring Boot
EXPOSE 8081

# Chạy ứng dụng
ENTRYPOINT ["java", "-jar", "app.jar"]
