


echo "start container"


HOME=${DOCKER_HOME}


sudo sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin no/' /etc/ssh/sshd_config && \
sudo sed -i 's/#PubkeyAuthentication yes/PubkeyAuthentication no/' /etc/ssh/sshd_config && \
sudo sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config && \
sudo sed -i 's/UsePAM yes/UsePAM no/' /etc/ssh/sshd_config && \
echo "AllowUsers ${DOCKER_USER}" | sudo tee -a /etc/ssh/sshd_config


key_storage=${DOCKER_HOME}/.ssh/docker_keys
if [ ! -d ${key_storage} ]; then
    mkdir -p ${key_storage}
fi

if [ ! -f ${key_storage}/ed25519_host_key ]; then
    /usr/bin/ssh-keygen -t ed25519 -f ${key_storage}/ed25519_host_key
fi

sudo cp ${key_storage}/* /etc/ssh


sudo mkdir -p /run/sshd

sudo /usr/sbin/sshd

sudo runuser -u "${DOCKER_USER}" -- bash

