FROM java
VOLUME /tmp
RUN mkdir -p /images-upload /log
ADD keystore.p12 ./
ADD ./build/libs/photo-capture-0.0.1-SNAPSHOT.jar ./photo-capture-0.0.1-SNAPSHOT.jar
#RUN bash -c 'touch /photo-capture.jar'
ENTRYPOINT ["java","-Djava.security.egd=file:/dev/./urandom","-jar","/photo-capture-0.0.1-SNAPSHOT.jar"]

EXPOSE 80
EXPOSE 8080
EXPOSE 8443
