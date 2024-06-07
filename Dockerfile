FROM ghcr.io/graalvm/native-image-community:22.0.1 as build

WORKDIR /app/build

COPY ./target/bin/devportal.jar .

RUN native-image -jar devportal.jar --no-fallback

FROM debian:stable-slim

WORKDIR /home/ballerina

EXPOSE 8080
COPY --from=build /app/build/devportal .

CMD ["sh", "-c", "echo 'Executing the devportal backend' && ./devportal"]

