all: build

help:
	@echo ""
	@echo "-- Help Menu"
	@echo ""
	@echo "   1. make build        - build the docker-salt-minion image"

build:
	@docker build --tag=arau/salt-minion:latest .

