# Base docker image
FROM openjdk:11-jre-slim
#FROM lpicanco/java11-alpine
LABEL maintainer "Daevien <github@daevien.com>"

# environment variables
ARG PV=3.2.0
ARG DATE="`/bin/date +\%Y-\%m-\%d-\%H_\%M_\%S_\%3N`"

# Install Dependencies
RUN apt update && apt install -y bash curl wget unzip cron dirmngr

# phantombot installation
RUN mkdir -p /root/tmp && \
        cd /root/tmp && \
        wget https://github.com/PhantomBot/PhantomBot/releases/download/v${PV}/PhantomBot-${PV}.zip && \
        unzip PhantomBot-${PV}.zip && \
        rm PhantomBot-${PV}.zip && \
        mkdir /phantombot && \
        mv PhantomBot-${PV}/* /phantombot && \
        chmod u+x /phantombot/launch-service.sh /phantombot/launch.sh /phantombot/java-runtime-linux/bin/java

# remove leftovers
RUN cd && \
        rm -rf /root/tmp

# backup
#RUN echo "#!/bin/sh" > /etc/cron.daily/phantom
#RUN echo "37 2 */1 * *  umask 0007;/bin/tar --exclude 'phantombot/web' --exclude 'phantombot/lib' -cjf /backup/${DATE}.tar.bz2 /phantombot >> /backup/backup_phantombot.log 2>&1" >> /var/spool/cron/crontabs/root
#RUN chmod a+x /var/spool/cron/crontabs/root

# Cron job + wrapper script
#RUN echo "crond" > /start-crond
#RUN systemctl enable cron ; systemctl start cron

RUN echo "cd phantombot && ./launch-service.sh" > /start-phantombot
COPY wrapper.sh /wrapper.sh
#RUN chmod a+x /start-crond
RUN chmod a+x /start-phantombot
RUN chmod a+x /wrapper.sh

# Run
CMD /wrapper.sh
