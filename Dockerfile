#Distroless JDK image Chainguard
FROM cgr.dev/chainguard/jdk

#Set the Working Directory
WORKDIR "/app"
#Copy the Jar file into the Container
COPY "target/WebsiteCounter-*.jar" "app.jar"
#Expose the port
EXPOSE 8080

#CMD to run the JAR File
ENTRYPOINT ["java", "-jar", "app.jar"]

