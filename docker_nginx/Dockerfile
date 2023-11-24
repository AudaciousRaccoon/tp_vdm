FROM ubuntu

RUN mkdir /var/vdm

RUN apt update && apt install openssl nginx -y
RUN mkdir /etc/nginx/ssl
RUN openssl req -x509 -newkey rsa:4096 -keyout /etc/nginx/ssl/vdm.key -out /etc/nginx/ssl/vdm.crt -sha256 -days 3650 -nodes -subj "/C=FR/ST=Occiquitaine/L=Bordlouse/O=Les_gens_forts/OU=No_need_for_Loup/CN=KingEly"

COPY site_vdm.com /etc/nginx/sites-available
RUN ln -s /etc/nginx/sites-available/site_vdm.com /etc/nginx/sites-enabled/

COPY index.html /var/vdm

CMD ["nginx","-g","daemon off;"]
