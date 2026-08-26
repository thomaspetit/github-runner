FROM myoung34/github-runner:2.337.0

RUN apt-get update \
    && \
    apt-get -y install \
    wget \
    python3 \
    python3-pip \
    unzip \
    make \
    sshpass \
    && \
    rm -rf /var/lib/apt/lists/*

RUN pip install ansible yamllint docker==6.1.3 docker-compose jmespath

RUN ansible-galaxy collection install cloud.terraform community.docker:3.13.4

RUN wget -O- https://apt.releases.hashicorp.com/gpg | gpg --dearmor | sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg &&\
    echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list &&\
    apt-get update &&\
    apt-get -y install terraform
