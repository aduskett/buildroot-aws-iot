CLEAN_AFTER_BUILD ?= false
ENV_FILES ?= env.json
EXIT_AFTER_BUILD ?= false
NO_BUILD ?= false
VERBOSE ?= false
target ?= greengrass

.PHONY: build
build:
	docker-compose build

.PHONY: down
down:
	docker-compose down

.PHONY: menuconfig
menuconfig:
	/bin/bash -c 'if [ -z $(docker container ps -aqf "name=aws-iot-buildroot-build") ]; then make upd; fi;'
	docker exec -it aws-iot-buildroot-build /bin/bash -c 'cd ~/buildroot/adam/output/${target} && make menuconfig'

.PHONY: kill
kill:
	docker-compose kill

.PHONY: shell
shell:
	/bin/bash -c 'if [ -z $(docker container ps -aqf "name=aws-iot-buildroot-build") ]; then make NO_BUILD=true EXIT_AFTER_BUILD=false upd; fi;'
	docker exec -it aws-iot-buildroot-build /bin/bash

.PHONY: up
up:
	VERBOSE=${VERBOSE} ENV_FILES=${ENV_FILES} EXIT_AFTER_BUILD=${EXIT_AFTER_BUILD} NO_BUILD=${NO_BUILD} CLEAN_AFTER_BUILD=${CLEAN_AFTER_BUILD} docker-compose up --abort-on-container-exit

.PHONY: upd
upd:
	VERBOSE=${VERBOSE} ENV_FILES=${ENV_FILES} EXIT_AFTER_BUILD=${EXIT_AFTER_BUILD} NO_BUILD=${NO_BUILD} CLEAN_AFTER_BUILD=${CLEAN_AFTER_BUILD} docker-compose up -d
