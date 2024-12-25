ALL: build-db build-app run-all

.PHONY: build-app
build-app:
	docker build -f Dockerfile -t vbapp .
	
# .PHONY: run-app
run-app:
	docker run --rm -p 5000:5000 \
	-v /mnt/wslg:/mnt/wslg \
	-v "$$XDG_RUNTIME_DIR/$$WAYLAND_DISPLAY:/tmp/$$WAYLAND_DISPLAY" \
	-e DISPLAY=$$DISPLAY \
	-e WAYLAND_DISPLAY=$$WAYLAND_DISPLAY \
	-e XDG_RUNTIME_DIR=/tmp \
	-e PULSE_SERVER=$$PULSE_SERVER \
	-e LIBGL_ALWAYS_SOFTWARE=true \
	vbapp

.PHONY: build-db
build-db:
	docker build -f db.Dockerfile -t db .

# .PHONY: run-db
run-db:
	docker run --rm -p 5000:5000 \
	-v /mnt/wslg:/mnt/wslg \
	-v "$$XDG_RUNTIME_DIR/$$WAYLAND_DISPLAY:/tmp/$$WAYLAND_DISPLAY" \
	-e DISPLAY=$$DISPLAY \
	-e WAYLAND_DISPLAY=$$WAYLAND_DISPLAY \
	-e XDG_RUNTIME_DIR=/tmp \
	-e PULSE_SERVER=$$PULSE_SERVER \
	-e LIBGL_ALWAYS_SOFTWARE=true \
	db

run-all:
	docker-compose up