FROM ubuntu

RUN useradd -m -d /var/vdm admin_vdm
RUN mkdir /var/vdm/.ssh

RUN apt update && apt install ssh proftpd proftpd-mod-crypto -y
RUN ssh-keygen -f /var/vdm/.ssh/id_rsa -N ""

COPY proftpd.conf /etc/proftpd
COPY modules.conf /etc/proftpd
COPY id_rsa.pub /var/vdm/.ssh/authorized_keys

RUN mkdir /etc/proftpd/keys

RUN ssh-keygen -e -f /var/vdm/.ssh/authorized_keys | sed "2d" > /etc/proftpd/keys/admin_vdm
RUN chown admin_vdm: /var/vdm
RUN chmod 444 /etc/proftpd/keys/admin_vdm



CMD ["proftpd","--nodaemon"]
