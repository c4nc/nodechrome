ACCOUNT = c4nc
ARCH = alpine
IMAGE = nodechrome
SHELL = "/bin/sh"
SHELL_INT = $(SHELL) "-i"
TARGET = $(ACCOUNT)/$(IMAGE)
VERSION = $(shell cat VERSION)-$(ARCH)
LATEST = latest-$(ARCH)
TEST = test
SQUASH = squash
VCS_REF = $(shell git rev-parse --short HEAD)
BUILD_DATE=$(shell date -u +"%Y-%m-%dT%H:%M:%SZ")

default: build

build:
	docker build \
		-f "Dockerfile" \
		--compress \
		--build-arg VCS_REF=$(VCS_REF) \
  	--build-arg BUILD_DATE=$(BUILD_DATE) \
		--build-arg VERSION=$(VERSION) \
		-t $(TARGET):$(LATEST) .

build-full:
	@docker build \
		-f "Dockerfile" \
		--no-cache --rm \
		--compress \
		--build-arg VCS_REF=$(VCS_REF) \
  	--build-arg BUILD_DATE=$(BUILD_DATE) \
		--build-arg VERSION=$(VERSION) \
		-t $(TARGET):$(LATEST) .

build-squash:
	@docker build \
		-f "Dockerfile" \
		--no-cache --rm --squash \
		--compress \
		--build-arg VCS_REF=$(VCS_REF) \
  	--build-arg BUILD_DATE=$(BUILD_DATE) \
		--build-arg VERSION=$(VERSION)-$(SQUASH) \
		-t $(TARGET):$(VERSION)-$(SQUASH) .

#Run latest builded version
run: 
	docker run $(TARGET):$(LATEST)

run-it:
	docker run -it $(TARGET):$(LATEST) $(SHELL_INT)

run-test:
	docker build --rm --no-cache -f "Dockerfile" -t $(TARGET):$(TEST) .
	docker run $(TARGET):$(TEST)

build-tag: build-full tag

push-repo:
	git add . && git commit -m "Release: $(TARGET):$(VERSION)" && git push origin master

tag: 
	docker tag $(TARGET):$(LATEST) $(TARGET):$(VERSION)


