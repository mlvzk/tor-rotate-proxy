FROM alpine
RUN apk add tor \
	&& apk add haproxy

ENV RANGE_FROM 4100
ENV RANGE_TO 4200

ADD haproxy.conf start.sh /
RUN chmod +x /start.sh
RUN mkdir /var/run/tor && chown tor /var/run/tor
RUN mkdir -p /var/db/tor && chown tor /var/db/tor

RUN seq $RANGE_FROM $RANGE_TO | xargs -n 1 mkdir -p /var/db/tor/$1
RUN seq $RANGE_FROM $RANGE_TO | xargs -n 1 -I'{}' echo "  server 127.0.0.1:{} 127.0.0.1:{} check" >> haproxy.conf

EXPOSE 9100

ENTRYPOINT ["/start.sh"]
