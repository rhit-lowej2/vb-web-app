ALL: build run

.PHONY: build
build:
	docker build -f Dockerfile -t vbapp .

.PHONY: run
run:
	docker run -it -p 5000:5000 \
	-v /mnt/wslg:/mnt/wslg \
	-v "$$XDG_RUNTIME_DIR/$$WAYLAND_DISPLAY:/tmp/$$WAYLAND_DISPLAY" \
	-e DISPLAY=$$DISPLAY \
	-e WAYLAND_DISPLAY=$$WAYLAND_DISPLAY \
	-e XDG_RUNTIME_DIR=/tmp \
	-e PULSE_SERVER=$$PULSE_SERVER \
	-e LIBGL_ALWAYS_SOFTWARE=true \
	vbapp
