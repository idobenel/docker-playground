FROM node:20 AS builder

WORKDIR /app

COPY package*.json ./

RUN npm install

COPY . .


FROM node:20-slim

RUN apt-get update && \
    apt-get install -y \
    ca-certificates \
    bash \
    vim \
    procps \
    curl && \
    rm -rf /var/lib/apt/lists/*


RUN groupadd -g 1500 user && \
    useradd -m -u 1500 -g 1500 user


WORKDIR /home/user/app

COPY --from=builder /app /home/user/app

RUN chown -R user:user /home/user/app

USER user

EXPOSE 8080

CMD ["bash", "/home/user/app/start.sh"]

