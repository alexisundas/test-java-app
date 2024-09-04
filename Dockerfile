#Official JDK image from Docker Hub
FROM cgr.dev/chainguard/jdk

#Set the Working Directory
WORKDIR "/app"
#Copy the Jar file into the Container
COPY "target/WebsiteCounter-0.0.1-SNAPSHOT.jar" "app.jar"
#Expose the port
EXPOSE 8080

#CMD to run the JAR File
ENTRYPOINT ["java", "-jar", "app.jar"]

