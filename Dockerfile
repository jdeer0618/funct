FROM iam6a64/docker-splunk:latest

ENV SPLUNK_APP_INSPECT_VERSION 1.4.1.88

# Add apps
# ADD ./apps/*.tgz /opt/splunk/etc/apps/

#Test and build Funct App
RUN apt-get update && apt-get install -y git python-pip libxml2-dev libxslt-dev lib32z1-dev python-lxml
COPY ./apps/app-inspect/splunk-appinspect-${SPLUNK_APP_INSPECT_VERSION}.tar.gz /opt/inpsect/splunk-appinspect-${SPLUNK_APP_INSPECT_VERSION}.tar.gz
RUN git clone https://github.com/jdeer0618/funct.git /tmp/
#    && cp -r /tmp/funct/src /opt/splunk/etc/apps/funct \
#    && chown -R ${SPLUNK_USER}:${SPLUNK_USER} /opt/splunk/etc/apps/funct
# RUN pip install /opt/inspect/splunk-appinspect-${SPLUNK_APP_INSPECT_VERSION}.tar.gz


# Make some tweaks
COPY ./files/default-mode.conf /opt/splunk/etc/system/local/
RUN touch /opt/splunk/etc/.ui_login
