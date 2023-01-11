FROM postgres:15
RUN apt update -y \
    && apt install apt-transport-https curl python3-pip libssl-dev jq -y \
    && apt -y autoremove \
    && rm -rf /var/lib/apt/lists/*
RUN pip install boto boto3 awscli --no-cache-dir
