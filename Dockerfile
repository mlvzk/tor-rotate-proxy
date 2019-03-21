FROM alpine:3.9
RUN apk add tor \
	&& apk add haproxy

ENV RANGE_FROM=4100 RANGE_TO=4120

ADD haproxy.cfg /etc/haproxy/
ADD run /usr/bin/

RUN chmod +x /usr/bin/run \
	&& mkdir /var/run/tor && chown tor /var/run/tor \
	&& mkdir -p /var/db/tor && chown tor /var/db/tor \
	&& seq $RANGE_FROM $RANGE_TO | sed "s|^|/var/db/tor/|" | xargs mkdir -p \
	&& seq $RANGE_FROM $RANGE_TO | xargs -n 1 -I'{}' printf "  server 127.0.0.1:{} 127.0.0.1:{} check\n" >> /etc/haproxy/haproxy.cfg

EXPOSE 9100

ENTRYPOINT ["run"]
