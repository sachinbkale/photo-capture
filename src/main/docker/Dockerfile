FROM java:8
ADD keystore.p12 /
RUN mkdir -p /images-upload/ /log
VOLUME /opt

RUN wget -q https://services.gradle.org/distributions/gradle-3.3-bin.zip \
    && unzip gradle-3.3-bin.zip -d /opt \
    && rm gradle-3.3-bin.zip

ENV GRADLE_HOME /opt/gradle-3.3
ENV PATH $PATH:/opt/gradle-3.3/bin

ADD photo-capture-0.0.1-SNAPSHOT.jar photo-capture.jar
RUN bash -c 'touch /photo-capture.jar'
ENTRYPOINT ["java", "-Djava.security.egd=file:/dev/./urandom", "-jar", "/photo-capture.jar"]
EXPOSE 80
EXPOSE 8080
EXPOSE 8443