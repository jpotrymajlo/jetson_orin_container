

set -e -x

echo "start container"

docker_uid=$(stat -c '%u' "/projects")
docker_gid=$(stat -c '%g' "/projects")

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
mkdir -p /run/sshd

sudo /usr/sbin/sshd

source /etc/profile
sudo -u "${DOCKER_USER}" vim-addon-manager install youcompleteme
sudo -u "${DOCKER_USER}" sed -i '/force_color_prompt/s/^#//' $HOME/.bashrc
sudo -u "${DOCKER_USER}" mkdir -p $HOME/bin
sudo -u "${DOCKER_USER}" mkdir -p $HOME/.local/bin
cd $HOME

exec runuser -u "${DOCKER_USER}" -- bash
#-c "$*"

#exec runuser -u "${DOCKER_USER}" -- bash -c "$*"

