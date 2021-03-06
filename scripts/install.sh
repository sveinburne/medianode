#!/bin/bash
#Make path relative
cd "${BASH_SOURCE%/*}" || (echo "FAILURE: impossible de trouver le répertoire courant" ; exit 1)
if [[ $(id -u) -ne 0 ]]; then
    echo "FAILURE : Doit être éxécuté avec les privilèges super-utilisateur!" ; exit 1
fi
hash node 2>/dev/null || {
    echo "FAILURE : node doit être installé!" ; exit 1
}
hash npm 2>/dev/null || {
    echo "FAILURE : npm doit être installé!" ; exit 1
}
hash coffee 2>/dev/null || {
    echo "FAILURE : coffee-script doit être installé!" ; exit 1
}
hash redis-server 2>/dev/null || {
    echo "FAILURE : redis-server doit être installé!" ; exit 1
}
mkdir -p /etc/redis/
cp ../redis.conf /etc/redis/redis-media-node.conf
groupadd media-node &> /dev/null
echo "Création du groupe 'media-node'"
echo "Autorisation en lecture / écriture pour le groupe 'media-node'"
mkdir -p /var/lib/redis/
echo "/var/lib/redis/"
mkdir -p /var/log/redis/
echo "/var/log/redis/"
chown -R :media-node /var/lib/redis/
chown -R :media-node /var/log/redis/
echo "Mise à jour de npm..."
cd .. && npm update
echo "Configuration de media-node effectuée avec succès"
echo "IMPORTANT : pour pouvoir lancer media-node, vous devez ajouter votre utilisateur au groupe 'media-node'"
echo "ex : sudo usermod -a -G media-node nom_utilisateur"
