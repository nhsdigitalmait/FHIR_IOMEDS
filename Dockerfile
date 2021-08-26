FROM nhsdigitalmait/tkw-x:d737cf8
RUN useradd -rm -u 1000 service
RUN mkdir /home/service/data/ && chown service:service /home/service/data/
VOLUME /home/service/data
VOLUME /home/service/fhir
VOLUME /home/service/certs
COPY . /home/service/TKW/config/FHIR_IOMEDS
WORKDIR /home/service/TKW/config/FHIR_IOMEDS
RUN sh set-all-configurations.sh

ENV trustStore=default
ENV trustStorePassword=default
ENV keyStore=default
ENV keyStorePassword=default
USER service
CMD ["bash", "runtkwfhirvalidator.sh"]
