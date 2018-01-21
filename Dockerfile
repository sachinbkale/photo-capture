FROM java:openjdk-8
ADD keystore.p12 /
RUN mkdir -p /images-upload/ /log
#ADD build/libs/photo-capture-0.0.1-SNAPSHOT.jar /photo-capture.jar
ADD target/photo-capture-0.0.1-SNAPSHOT.jar /photo-capture.jar
ENTRYPOINT ["java", "-Djava.security.egd=file:/dev/./urandom", "-jar", "/photo-capture.jar"]
EXPOSE 80
EXPOSE 8080
EXPOSE 8443
