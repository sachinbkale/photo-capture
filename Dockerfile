FROM java
VOLUME /tmp
RUN mkdir -p /images-upload/ /log/ 

RUN wget -q https://services.gradle.org/distributions/gradle-3.3-bin.zip \
    && unzip gradle-3.3-bin.zip -d /opt \
    && rm gradle-3.3-bin.zip

ENV GRADLE_HOME /opt/gradle-3.3
ENV PATH $PATH:/opt/gradle-3.3/bin


WORKDIR /.
COPY . /code/

RUN ["gradle", "build"]

RUN bash -c 'touch /code/photo-capture-0.0.1-SNAPSHOT.jar'
COPY build/libs/photo-capture-0.0.1-SNAPSHOT.jar /code/photo-capture-0.0.1-SNAPSHOT.jar
COPY keystore.p12 /
ENTRYPOINT ["java","-Djava.security.egd=file:/dev/./urandom","-jar","/code/photo-capture-0.0.1-SNAPSHOT.jar"]

EXPOSE 80
EXPOSE 8080
EXPOSE 8443
