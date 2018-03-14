FROM openjdk:8

MAINTAINER sharpslinger

RUN apt-get update && apt-get install netcat -y

# Copy over files
COPY aem/ /aem/

WORKDIR /aem

# clean up the line endings in the event these were Windows-edited
RUN sed -i 's/\r$//' /aem/finalize.sh /aem/install-aem.sh

# unpack, then install
RUN java -Xmx20148m -Xms1024m -XX:MaxPermSize=1024m -jar aem-quickstart-6.1.jar -unpack -r nosamplecontent
RUN chmod +x /aem/install-aem.sh /aem/finalize.sh
RUN /aem/install-aem.sh

EXPOSE 4502 8000
ENTRYPOINT ["/aem/crx-quickstart/bin/quickstart"]

