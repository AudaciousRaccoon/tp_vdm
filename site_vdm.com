server {
	listen 443 ssl;
	server_name vdm.fr;
	
	access_log /var/log/nginx/site_vdm.log;
	error_log /var/log/nginx/site_vdm.error;
	
	root /var/vdm;
	
	ssl_certificate /etc/nginx/ssl/vdm.crt;
	ssl_certificate_key /etc/nginx/ssl/vdm.key;
	#location ~ /VDM(.*)/ {
	#	
	#	alias /var/vdm/$1.html;
#
#	}
}
