FROM python:3.11-slim as python-runtime

RUN python --version && pip --version
RUN echo "deb http://ftp.debian.org/debian buster-backports main " >> /etc/apt/sources.list.d/backports.list \
    && apt-get update && apt-get install -y ca-certificates curl gnupg apt-utils build-essential \
    && apt-key adv --no-tty --keyserver keyserver.ubuntu.com --recv-keys ABF5BD827BD9BF62 > /dev/null \
    && curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key --keyring /usr/share/keyrings/cloud.google.gpg add - \
    && echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] http://packages.cloud.google.com/apt cloud-sdk main " >> /etc/apt/sources.list \
    && apt-get update \
	  && apt-get install -y -t buster-backports openssl libssl-dev python3-dev libev-dev \
	  && apt-get install -y gcc google-cloud-sdk ca-certificates gettext-base jq \
    && rm -rf /root/.cache/  \
	  && rm -rf /var/lib/apt/lists/*

COPY requirements.txt requirements.txt
RUN pip install -r requirements.txt  && rm -rf /root/.cache/ && rm -rf requirements.txt
