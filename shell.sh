#!/bin/bash
tag=$(git log -1 --pretty=format:%h)


docker build -t ngregistry.imanagelabs.dev/nodeapps:$tag .

docker push ngregistry.imanagelabs.dev/nodeapps:$tag
