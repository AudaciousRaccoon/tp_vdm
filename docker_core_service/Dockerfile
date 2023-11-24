FROM ubuntu

COPY verif_ping.service /etc/systemd/system

COPY verif_ping /usr/bin

COPY verif_ping.conf /etc

COPY html.sh /usr/bin

RUN mkdir /var/vdm
RUN mkdir /var/www/html/vdm -p
RUN apt update && apt install iputils-ping -y

CMD "verif_ping"
