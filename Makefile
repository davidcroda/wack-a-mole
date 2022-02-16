.phone: build

build:
	docker build --platform linux/amd64 -t 192.168.50.3:32000/moles:latest .