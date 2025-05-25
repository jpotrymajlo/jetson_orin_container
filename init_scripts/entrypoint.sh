

#set -e -x

echo "start container"
echo $DOCKER_HOME 
echo $DOCKER_USER

docker_uid=$(stat -c '%u' "/projects")
echo $docker_uid
docker_gid=$(stat -c '%g' "/projects")
echo $docker_gid

groupadd --gid "${docker_gid}" devs
useradd --uid "${docker_uid}" --gid "${docker_gid}" --groups sudo -m -d "${DOCKER_HOME}" "${DOCKER_USER}"
usermod --shell /bin/bash ${DOCKER_USER}
echo "${DOCKER_USER}     ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
HOME=${DOCKER_HOME}

source /etc/profile
sudo -u "${DOCKER_USER}" vim-addon-manager install youcompleteme
sudo -u "${DOCKER_USER}" sed -i '/force_color_prompt/s/^#//' $HOME/.bashrc
sudo -u "${DOCKER_USER}" mkdir -p $HOME/bin
sudo -u "${DOCKER_USER}" mkdir -p $HOME/.local/bin
cd $HOME

exec runuser -u "${DOCKER_USER}" -- bash
#-c "$*"

#exec runuser -u "${DOCKER_USER}" -- bash -c "$*"

