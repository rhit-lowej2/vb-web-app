FROM ubuntu:24.04 AS builder
# NOTE:
# Docker is not a Node.js package manager.
# Please ensure it is already installed on your system.
# Follow official instructions at https://docs.docker.com/desktop/
# Docker images are provided officially at https://github.com/nodejs/docker-node/

RUN apt-get update && apt-get install -y \
    python3 \
    python3-venv \
    unixodbc

ENV VIRTUAL_ENV=/opt/venv
RUN python3 -m venv $VIRTUAL_ENV
ENV PATH="$VIRTUAL_ENV/bin:$PATH"

RUN pip install --upgrade pip && \
    pip install --upgrade flask pyodbc Flask-SQLAlchemy

WORKDIR /app
COPY . .

EXPOSE 5000
# # pulls the Node.js Docker image
# FROM node:20-alpine

# # verifies the right Node.js version is in the environment
# RUN node -v # should print `v20.18.0`

# # verifies the right npm version is in" the environment
# RUN npm -v # should print `10.8.2`

# COPY --from=builder /app /app

CMD [ "python", "run.py" ]
