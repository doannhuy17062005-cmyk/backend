FROM eclipse-temurin:17-jdk

WORKDIR /app

# Copy toàn bộ source
COPY . .

# Build bằng Maven system (vì bạn đã cài mvn)
RUN mvn clean package -DskipTests

# Render dùng port 8080
EXPOSE 8080

# Chạy Spring Boot
CMD ["java", "-jar", "target/*.jar"]
