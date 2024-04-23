all: build

prepare:
	docker build -t rpmbuild:latest -f docker/Dockerfile --no-cache=true .
enter:
	docker run -ti --rm --name=rpmbuild -v $$PWD/src:/home/rpm/src -v $$PWD/out:/home/rpm/out --env-file ./.env rpmbuild bash
build:
	docker run -ti --rm --name=rpmbuild -v $$PWD/src:/home/rpm/src -v $$PWD/out:/home/rpm/out --env-file ./.env rpmbuild /build.sh
upload:
	docker tag rpmbuild:latest nulldevil/rpmbuild:latest
	docker push nulldevil/rpmbuild:latest
