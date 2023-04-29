From ubuntu

EXPOSE 8080

ENV NEZHA_URI="host:port"
ENV NEZHA_SECRET='secret-key'

RUN apt update -y && apt install curl sudo wget unzip python3 -y

RUN echo 'root:123456' | chpasswd

RUN useradd -m cmcc -u 10086  && echo 'cmcc:123456' | chpasswd  && usermod -aG sudo cmcc \ 
    && echo 'cmcc ALL=(ALL) NOPASSWD:ALL' > /etc/sudoers.d/cmcc-nopasswd

RUN mkdir -p /app && chmod 777 /app

USER 10086
WORKDIR /app

COPY entrypoint.sh ./
RUN sudo chmod a+x entrypoint.sh 

RUN wget https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64 \
    && sudo chmod a+x cloudflared-linux-amd64

RUN wget https://github.com/naiba/nezha/releases/download/v0.14.11/nezha-agent_linux_amd64.zip \
    && unzip nezha-agent_linux_amd64.zip  && sudo chmod a+x nezha-agent
   

CMD [ "./entrypoint.sh"]
