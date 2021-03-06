#!/bin/bash
# reads current bootnode URL
IMGNAME="ethereum/client-go:alltools-stable"
DATA_ROOT=${DATA_ROOT:-$(pwd)}
#ENODE_LINE=$(docker logs ethereum-bootnode 2>&1 | grep enode | head -n 1)
# replaces localhost by container IP
MYIP=$(docker exec ethereum-bootnode ifconfig eth0 | awk '/inet addr/{print substr($2,6)}')
#ENODE_LINE=$(echo $ENODE_LINE | sed "s/127\.0\.0\.1/$MYIP/g" | sed "s/\[\:\:\]/$MYIP/g")
#echo "enode:${ENODE_LINE#*enode:}"
ENODEKEY=$(docker run --rm -v $DATA_ROOT/.bootnode:/opt/bootnode $IMGNAME bootnode --nodekey /opt/bootnode/boot.key -writeaddress)
echo "enode://$ENODEKEY@$MYIP:30301"
