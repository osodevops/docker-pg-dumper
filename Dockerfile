FROM postgres:11
RUN apt-get update -y && \
    apt-get install apt-transport-https curl python-dev python-setuptools gcc make libssl-dev jq -y && \
    easy_install pip \
    && apt-get -y autoremove \
    && rm -rf /var/lib/apt/lists/*
RUN pip install boto boto3 awscli --no-cache-dir