FROM java:openjdk-8
ADD keystore.p12 /
RUN mkdir -p /images-upload/ /log
FROM maven:3.5-jdk-8-alpine
WORKDIR /code
ADD pom.xml /code/pom.xml
RUN ["mvn", "dependency:resolve"]
RUN ["mvn", "verify"]
ADD src /code/src
RUN ["mvn", "package"]
#ADD build/libs/photo-capture-0.0.1-SNAPSHOT.jar /photo-capture.jar
ADD target/photo-capture-0.0.1-SNAPSHOT.jar photo-capture.jar
RUN bash -c 'touch /photo-capture.jar'
ENTRYPOINT ["java", "-Djava.security.egd=file:/dev/./urandom", "-jar", "/photo-capture.jar"]
EXPOSE 80
EXPOSE 8080
EXPOSE 8443
