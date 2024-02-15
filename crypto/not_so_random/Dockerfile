FROM python:3.9
WORKDIR /app

RUN useradd -m chall
RUN apt update
RUN apt install -y socat

COPY 2024.py .

RUN chmod +r 2024.py

EXPOSE 1337

USER chall

ENTRYPOINT socat tcp-l:1337,fork,reuseaddr exec:"python 2024.py"
