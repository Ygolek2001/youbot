docker images
docker rmi -f $(docker images -f "dangling=true" -q)
docker images
