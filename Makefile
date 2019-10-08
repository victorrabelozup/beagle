REGISTRY = ${DOCKER_REGISTRY}
RELEASE = ${RELEASE_VERSION}
BINARY_NAME=darwin-beagle-framework

# Docker
DOCKERCMD=docker
DOCKERBUILD=${DOCKERCMD} build
DOCKERPUSH=${DOCKERCMD} push
DOCKERTAG=${DOCKERCMD} tag

# Commons
HOST=127.0.0.1

build:
	@echo ${REGISTRY}
	@echo ${RELEASE}
	$(DOCKERBUILD) -t "${REGISTRY}/${BINARY_NAME}:${RELEASE}" .
	$(DOCKERTAG) "${REGISTRY}/${BINARY_NAME}:${RELEASE}" "${REGISTRY}/${BINARY_NAME}:latest"
publish:
	${DOCKERPUSH} "${REGISTRY}/${BINARY_NAME}:${RELEASE}"
	${DOCKERPUSH} "${REGISTRY}/${BINARY_NAME}:latest"
test:
	@echo "don't have time for test right now"