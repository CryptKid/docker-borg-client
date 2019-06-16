from ubuntu:rolling
#Install required packages
RUN apt update
RUN apt install borgbackup cron gettext-base openssh-client -y
RUN rm -rf /var/lib/apt/lists/*

#Set default vars
ENV ssh_hostname="0.0.0.0"
ENV ssh_user="backup"
ENV ssh_port="22"
ENV ssh_private_key=""
ENV ssh_server_host_key=""
ENV ssh_proxy_jump="" 
ENV borg_repo=""
ENV borg_path="/backups"
ENV borg_password=""
ENV borg_date_prefix="backup"
ENV cron_intervall="0 3 * * * "
#Create default backup path
RUN mkdir /backups
#Add folder
COPY borg-client /borg
#Make sure everything belongs to root
RUN chown root:root /borg -Rc
# Symlink everything into place
## ssh
RUN mkdir /root/.ssh/
RUN ln -s /borg/config/ssh/config /root/.ssh/config
RUN ln -s /borg/config/ssh/known_hosts /root/.ssh/known_hosts
## crontab
RUN ln -s /borg/config/crontab/tab /etc/cron.d/borg
ENTRYPOINT ["/borg/init.sh"]
