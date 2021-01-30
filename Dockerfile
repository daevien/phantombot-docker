# Base docker image
FROM openjdk:11-jre-slim
LABEL maintainer "Daevien <github@daevien.com>"

# environment variables
ARG PV=3.4.1
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

#RUN echo "cd phantombot && ./launch-service.sh" > /start-phantombot
COPY wrapper.sh /wrapper.sh
#RUN chmod a+x /start-phantombot
RUN chmod a+x /wrapper.sh

# Run
CMD /wrapper.sh


