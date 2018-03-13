FROM openjdk:8

MAINTAINER sharpslinger

RUN apt-get update && apt-get install netcat -y

# Copy over files
COPY aem/* /aem/

WORKDIR /aem

# unpack, then install
RUN java -XX:MaxPermSize=256m -Xmx1024M -jar aem-quickstart-6.1.jar -unpack -r nosamplecontent
RUN chmod +x /aem/install-aem.sh
RUN chmod +x /aem/finalize.sh
RUN /aem/install-aem.sh

EXPOSE 4502 8000
ENTRYPOINT ["/aem/crx-quickstart/bin/quickstart"]

