# ===============================
# BUILD STAGE
# ===============================
FROM eclipse-temurin:17-jdk AS build

WORKDIR /app

# Copy toàn bộ source
COPY . .

# Cấp quyền cho Maven Wrapper
RUN chmod +x mvnw

# Build Spring Boot (skip test)
RUN ./mvnw clean package -DskipTests


# ===============================
# RUN STAGE
# ===============================
FROM eclipse-temurin:17-jre

WORKDIR /app

# Copy file jar đã build
COPY --from=build /app/target/*.jar app.jar

# Port Spring Boot (đổi nếu app.properties khác)
EXPOSE 8081

# Chạy ứng dụng
ENTRYPOINT ["java", "-jar", "app.jar"]
