FROM ubuntu

COPY verif_ping.service /etc/systemd/system

COPY verif_ping /usr/bin

COPY verif_ping.conf /etc

COPY html.sh /usr/bin

CMD "verif_ping"
