FROM java
VOLUME /tmp
RUN mkdir -p /images-upload /log /jar
ADD keystore.p12 /
ADD photo-capture.jar /photo-capture.jar
#RUN bash -c 'touch /photo-capture.jar'
ENTRYPOINT ["java","-Djava.security.egd=file:/dev/./urandom","-jar","/photo-capture.jar"]

EXPOSE 80
EXPOSE 8080
EXPOSE 8443
