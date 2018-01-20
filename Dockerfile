FROM java:8
VOLUME . /photo-capture:photo-capture
ADD build/libs/photo-capture-0.0.1-SNAPSHOT.jar photo-capture.jar
EXPOSE 80 8080 8443 2017
WORKDIR /photo-capture
ENV GRADLE_OPTS -Dorg.gradle.native=false
CMD ["./gradlew", "bootRun"]