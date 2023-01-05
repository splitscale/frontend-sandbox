FROM openjdk:17

WORKDIR /fordastore/web

COPY -r .next /fordastore/web/

EXPOSE 3000

CMD ["java", "-jar", "api-0.0.1-SNAPSHOT.jar"]