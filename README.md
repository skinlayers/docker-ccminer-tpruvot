# Dockerized ccminer
tpruvot fork
CUDA 9 branch with GTX 1080, GTX 1070, GTX 1060, et cetera (Compute Capability 6.1) support.

## Requirements
- [Docker 17.05+](https://www.docker.com/community-edition#/download)
- [Docker Engine Utility for NVIDIA GPUs](https://github.com/NVIDIA/nvidia-docker)

## Building
```
docker build -t ccminer-tpruvot:2.2.3-cuda-9 .
```

## Examples
### Vivo coin with bulwarkpool.com mining pool
#### Launch container
```
docker run \
    -itd \
    --init \
    --runtime=nvidia \
    --name vivo_bulwarkpool_miner \
    ccminer-tpruvot:2.2.3-cuda-9 \
    -a neoscrypt \
    -o stratum+tcp://us.bulwarkpool.com:4233 \
    -u VIVO_ACCOUNT_ADDRESS
```

#### Stop container
```
docker stop vivo_bulwarkpool_miner
```

#### Start existing container
```
docker stop vivo_bulwarkpool_miner
```
