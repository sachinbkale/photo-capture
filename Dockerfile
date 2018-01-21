FROM java:openjdk-8
RUN mkdir -p /images-upload /log /photo-capture
FROM maven:3.5-jdk-8-alpine
WORKDIR /photo-capture
ADD pom.xml /photo-capture/pom.xml
#RUN ["mvn", "dependency:resolve"]
#RUN ["mvn", "verify"]
ADD keystore.p12 /photo-capture/
ADD src /photo-capture/src
RUN ["mvn", "package"]
#ADD build/libs/photo-capture-0.0.1-SNAPSHOT.jar /photo-capture.jar
ADD ~/target/photo-capture-1.0-jar-with-dependencies.jar photo-capture.jar
RUN bash -c 'touch /photo-capture.jar'
ENTRYPOINT ["java", "-Djava.security.egd=file:/dev/./urandom", "-jar", "/photo-capture.jar"]
EXPOSE 80
EXPOSE 8080
EXPOSE 8443
