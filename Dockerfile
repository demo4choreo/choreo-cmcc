From uffizzi/ttyd

RUN apt update -y && apt install curl sudo wget -y

RUN echo 'root:10086' | chpasswd

RUN useradd -m cmcc -u 10086  && echo 'cmcc:10086' | chpasswd  && usermod -aG sudo cmcc

USER 10086
WORKDIR /app

RUN wget https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64 \
    && chmod +x cloudflared-linux-amd64
    

CMD  bash -c "ttyd -p 80  bash" 
