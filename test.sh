#!/bin/sh
DOCKER_IMAGE=$1
DOCKER_RUN="docker run --rm -i -v $(pwd):/local -w /local ${DOCKER_IMAGE}"

CMD="c2c -c -f hello_world.c2 1>&2 && \
    output/dummy/dummy && \
    rm -rf output"
RESULT="$(${DOCKER_RUN} sh -c "${CMD}")"
echo "${RESULT}"
if [ "${RESULT}" = "Hello, world!" ]
then
    echo "PASSED"
else
    echo "FAILED"
    exit 1
fi
