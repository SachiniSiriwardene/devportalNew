FROM ballerina/ballerina
USER root    
WORKDIR /home/ballerina
EXPOSE 8080
COPY . .
CMD bal run ./target/bin/devportal.jar
