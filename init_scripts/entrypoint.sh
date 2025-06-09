

#set -e -x

echo "start container"

docker_uid=$(stat -c '%u' "${DOCKER_HOME}/projects")
docker_gid=$(stat -c '%g' "${DOCKER_HOME}/projects")

groupadd --gid "${docker_gid}" devs
useradd --uid "${docker_uid}" --gid "${docker_gid}" --groups sudo -m -d "${DOCKER_HOME}" "${DOCKER_USER}"
usermod --shell /bin/bash ${DOCKER_USER}
echo "${DOCKER_USER}:nvidia" | chpasswd
echo "${DOCKER_USER}     ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
HOME=${DOCKER_HOME}

sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin no/' /etc/ssh/sshd_config && \
sed -i 's/#PubkeyAuthentication yes/PubkeyAuthentication no/' /etc/ssh/sshd_config && \
sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config && \
sed -i 's/UsePAM yes/UsePAM no/' /etc/ssh/sshd_config && \
echo "AllowUsers ${DOCKER_USER}" >> /etc/ssh/sshd_config

#start sshd

key_storage=${DOCKER_HOME}/.ssh/docker_keys
if [ ! -d ${key_storage} ]; then
    mkdir -p ${key_storage}
fi

if [ ! -f ${key_storage}/ed25519_host_key ]; then
    /usr/bin/ssh-keygen -t ed25519 -f ${key_storage}/ed25519_host_key
fi

cp ${key_storage}/* /etc/ssh


mkdir -p /run/sshd

sudo /usr/sbin/sshd

source /etc/profile
cd $HOME
export PATH=$PATH:${DOCKER_HOME}/.local/bin
exec runuser -u "${DOCKER_USER}" -- bash

