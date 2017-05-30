FROM iam6a64/splunk-test:v1

ENV SPLUNK_USER splunk
# ENV SPLUNK_APP_INSPECT_VERSION 1.4.1.88



#Test and build Funct App
RUN git clone https://github.com/jdeer0618/funct.git /tmp/funct/ \
    && git clone https://github.com/jdeer0618/splunk-extras.git /tmp/splunk-extras \
    && cp -r /tmp/funct/src/ /opt/splunk/etc/apps/funct/ \
    && chown -R ${SPLUNK_USER}:${SPLUNK_USER} /opt/splunk/etc/apps/funct/ \
    && mv /tmp/splunk-extras/files/default-mode.conf /opt/splunk/etc/system/local/default-mode.conf \
    && mv /tmp/splunk-extras/files/splunk-launch.conf /opt/splunk/etc/splunk-launch.conf \
    && touch /opt/splunk/etc/.ui_login
    # && pip install /opt/inspect/splunk-appinspect-${SPLUNK_APP_INSPECT_VERSION}.tar.gz

# Add apps
# ADD ./apps/*.tgz /opt/splunk/etc/apps/

# COPY ./apps/app-inspect/splunk-appinspect-${SPLUNK_APP_INSPECT_VERSION}.tar.gz /opt/inpsect/splunk-appinspect-${SPLUNK_APP_INSPECT_VERSION}.tar.gz
