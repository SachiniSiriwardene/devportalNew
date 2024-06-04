FROM ghcr.io/graalvm/native-image-community:22.0.1 as build

WORKDIR /app/build

COPY ./target/bin/devportal.jar .

RUN native-image -jar devportal.jar -H:Name=devportal --no-fallback -H:+StaticExecutableWithDynamicLibC

FROM gcr.io/distroless/base

WORKDIR /home/ballerina

EXPOSE 8080
COPY --from=build /app/build/devportal .

CMD ["./devportal.jar"]
