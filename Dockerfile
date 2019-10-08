FROM gradle:latest

CMD mkdir /opr/beagle-framework
WORKDIR /opt/beagle-framework

COPY . .

RUN ./gradlew build

ENTRYPOINT java -jar build/libs/darwin-ui-sdk-1.0-SNAPSHOT.jar
