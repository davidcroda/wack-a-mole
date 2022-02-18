.phone: build

build:
	docker build --platform linux/amd64 -t registry.daveroda.com/moles:latest .