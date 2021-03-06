# Dockerized ccminer - tpruvot's fork
CUDA 9 branch with GTX 1080, GTX 1070, GTX 1060, et cetera (Compute Capability 6.1) support.

## Requirements
- [Docker 17.05+](https://www.docker.com/community-edition#/download)
- [Docker Engine Utility for NVIDIA GPUs](https://github.com/NVIDIA/nvidia-docker)

## Building
```
docker build -t ccminer-tpruvot:2.2.5-cuda-9 .
```

## Examples
### Vivo coin with bulwarkpool.com mining pool
#### Launch container
```
docker run \
    -itd \
    --init \
    --runtime=nvidia \
    --restart on-failure \
    --name vivo_bulwarkpool_miner \
    ccminer-tpruvot:2.2.5-cuda-9 \
    -a neoscrypt \
    -o stratum+tcp://us.bulwarkpool.com:4233 \
    -u VIVO_ADDRESS
```

#### Stop container
```
docker stop vivo_bulwarkpool_miner
```

#### Start existing container
```
docker start vivo_bulwarkpool_miner
```

### Trezarcoin with pool.trezarcoin.com mining pool
### Requires registration
#### Launch container
```
docker run \
    -itd \
    --init \
    --runtime=nvidia \
    --restart on-failure \
    --name tzc_trezarcoin_miner \
    ccminer-tpruvot:2.2.5-cuda-9 \
    -a neoscrypt \
    -o stratum+tcp://pool.trezarcoin.com:5566 \
    -u POOL_USERNAME.WORKER_NAME
```

#### Stop container
```
docker stop tzc_trezarcoin_miner
```

#### Start existing container
```
docker start tzc_trezarcoin_miner
```

### LBRY Credits with suprnova.cc mining pool
### Requires registration
#### Launch container
```
docker run \
    -itd \
    --init \
    --runtime=nvidia \
    --restart on-failure \
    --name lbc_suprnova_miner \
    ccminer-tpruvot:2.2.5-cuda-9 \
    -a lbry \
    -o stratum+tcp://lbry.suprnova.cc:6256 \
    -u POOL_USERNAME.WORKER_NAME
```

#### Stop container
```
docker stop lbc_suprnova_miner
```

#### Start existing container
```
docker start lbc_suprnova_miner
```

### GoByte with gobyte.network mining pool
### Requires registration
#### Launch container
```
docker run \
    -itd \
    --init \
    --runtime=nvidia \
    --restart on-failure \
    --name gbx_gobyte_miner \
    ccminer-tpruvot:2.2.5-cuda-9 \
    -a neoscrypt \
    -o stratum+tcp://us1.gobyte.network:4233 \
    -u GBX_ACCOUNT
```

#### Stop container
```
docker stop gbx_gobyte_miner
```

#### Start existing container
```
docker start gbx_gobyte_miner
```

## Donations
If you find this useful, feel free to toss some coin my way.

ETH: 0x75F4363b09166FDf8702F41502E90D21A3F2Afb9
ZEN: znY2eiUwdx9Pj4EzRkktZqRWHfEfX7o9gkW
FTC: 6nDBmQE65gy7BbcUYbYPttc9EYA7eNKN3g
ZCL: t1cSvJsEBWCipA4CY9K7oi9sKRQgb3EG76T
VIVO: VVmjio2zqGgfnvmkEU9bZcxXmFpNswusig
TZC: Tn6K9mw6bKc8R447CrpeEMazFcve8vEg1a
LBC: bXp34GVRLnQgTTid9x6nMorHYjq1GzFwz7
GBX: GTeMA2kehXf2E7DqPGEGVSsb1gQWxpg5Lx
BTC: 196h6xSrcjEPMf7jRQZbNBQcAB3twDMHE6
