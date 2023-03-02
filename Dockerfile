ARG NUXEO_VERSION=2021.34.6
FROM nuxeo:${NUXEO_VERSION}

USER 0 
COPY saml2-authentication-2021.33.9.zip .
COPY nuxeo-web-ui-3.0.19.zip .
COPY nuxeo-retention-2021.2.1.zip .
COPY amazon-s3-online-storage-2021.33.9.zip .

RUN rm docker-entrypoint.sh

COPY docker-entrypoint.sh .
COPY nuxeo.conf .

## Copy and add the required packages

RUN mkdir /opt/nuxeo/addons
#RUN rm /etc/nuxeo/nuxeo.conf 
RUN mv nuxeo.conf /etc/nuxeo
RUN mv saml2-authentication-2021.33.9.zip nuxeo-web-ui-3.0.19.zip nuxeo-retention-2021.2.1.zip amazon-s3-online-storage-2021.33.9.zip  /opt/nuxeo/addons/

##Install packages
RUN mkdir libre_office
COPY libreoffice_7.5.0.3.zip libre_office/
RUN unzip libre_office/libreoffice_7.5.0.3.zip -d /libre_office
RUN yum -y localinstall /libre_office/*.rpm --skip-broken 
RUN rm -rf /libre_office
RUN yum -y install ImageMagick ufraw poppler-utils libwpd-tools ghostscript exiftool

USER 900
