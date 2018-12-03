
# c4nc/nodechrome

[![source:](https://images.microbadger.com/badges/commit/c4nc/nodechrome.svg)](https://microbadger.com/images/c4nc/nodechrome "See details at microbadger.com")[![version:](https://images.microbadger.com/badges/version/c4nc/nodechrome.svg)](https://microbadger.com/images/c4nc/nodechrome "See details at microbadger.com")[![img size:](https://images.microbadger.com/badges/image/c4nc/nodechrome.svg)](https://microbadger.com/images/c4nc/nodechrome "See details at microbadger.com")

Base repo for custom alpine docker container, with nodejs and chromium


## Usage

    make [...] to control the project workflow

### \[shell]$ make build -- Make local build (using cached layers)

	docker build \
		-f "Dockerfile" \
		--compress \
		--build-arg VCS_REF=$(VCS_REF) \
  	--build-arg BUILD_DATE=$(BUILD_DATE) \
		--build-arg VERSION=v$(VERSION) \
		-t $(TARGET):$(LATEST) .

  
### \[shell]$ make build-full -- Make local build from scratch

	@docker build \
		-f "Dockerfile" \
		--no-cache \
		--rm \
		--compress \
		--build-arg VCS_REF=$(VCS_REF) \
  	--build-arg BUILD_DATE=$(BUILD_DATE) \
		--build-arg VERSION=$(VERSION) \
		-t $(TARGET):$(LATEST) .

### \[shell]$ make build-squash

	@docker build \
		-f "Dockerfile" \
		--no-cache \
		--rm \
		--squash \
		--compress \
		--build-arg VCS_REF=$(VCS_REF) \
  	--build-arg BUILD_DATE=$(BUILD_DATE) \
		--build-arg VERSION=$(VERSION)-$(SQUASH) \
		-t $(TARGET):$(VERSION)-$(SQUASH) .

### \[shell]$ make build-run-d -- -- Make local build from scratch and run demonized prod container

### \[shell]$ make run -- run latest builded version

	docker run $(TARGET):$(LATEST)
		
### \[shell]$ make run-d -- run latest version demonized with prod conf (#TODO: add seccom policy and low lev sys users outside at the host level)
    docker run -d -p 3100:3100 --restart always --name $(IMAGE) $(TARGET):$(LATEST)

### \[shell]$ make run-it -- run latest version interactive
  
    docker run -it $(TARGET):$(LATEST) $(SHELL_INT)

### \[shell]$ make run-test -- build and run for test
    docker build --rm -f "Dockerfile" -t $(TARGET):$(TEST) .
	docker run --rm $(TARGET):$(TEST)

### \[shell]$ make build-tag -- Make local build from scratch and tag it with latest and version number from file VERSION

### \[shell]$ make get-log -- attach to latest container log
	docker logs -f $(IMAGE)

### \[shell]$ make push-repo -- !!!TO BE USED ON LOCAL DEV ENV!!! Add and commit all changes and push them to the origin master   

    git add . && git commit -m "Commit: $(VCS_REF) - Release: $(TARGET):$(VERSION)" && git push origin master

### \[shell]$ make tag -- tag latest image with its version

	docker tag $(TARGET):$(LATEST) $(TARGET):$(VERSION)