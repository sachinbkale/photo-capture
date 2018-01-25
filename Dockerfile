FROM java:openjdk-8
ADD keystore.p12 /
RUN mkdir -p /images-upload /log /code 

FROM maven:3.5-jdk-8-alpine
RUN wget -q https://services.gradle.org/distributions/gradle-3.3-bin.zip \
    && unzip gradle-3.3-bin.zip -d . \
    && rm gradle-3.3-bin.zip
ENV GRADLE_HOME /gradle-3.3
ENV PATH $PATH:/gradle-3.3/bin

#WORKDIR /code
#ADD pom.xml /code/pom.xml

#ADD src /code/src
#RUN ["mvn", "dependency:resolve"]
#RUN ["mvn", "verify"]

WORKDIR /photo-capture

RUN gradle build

#ADD build/libs/photo-capture-0.0.1-SNAPSHOT.jar /photo-capture.jar
#ADD target/photo-capture-1.0-jar-with-dependencies.jar photo-capture.jar
#RUN bash -c 'touch /photo-capture.jar'
#ENTRYPOINT ["java", "-Djava.security.egd=file:/dev/./urandom", "-jar", "/photo-capture.jar"]

#CMD ["java", "-cp", "target/photo-capture-0.0.1-SNAPSHOT.jar","com.cronos.posidon.CronosWebApplication"]
ADD photo-capture-0.0.1-SNAPSHOT.jar photo-capture.jar
RUN bash -c 'touch /photo-capture.jar'
ENTRYPOINT ["java", "-Djava.security.egd=file:/dev/./urandom", "-jar", "/photo-capture.jar"]
EXPOSE 80
EXPOSE 8080
EXPOSE 8443
