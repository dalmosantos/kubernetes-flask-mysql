FROM python:3.9-slim

RUN apt-get clean \
    && apt-get -y update \
    && apt-get install -y build-essential curl nginx libpq-dev --no-install-recommends 

WORKDIR /app

COPY requirements.txt /app/requirements.txt

RUN pip3 install -r requirements.txt --src /usr/local/src \
    #Clean
    && apt-get clean autoclean \
    && apt-get autoremove -y \
    && rm -rf /tmp/* \
           /var/lib/{apt,dpkg,cache,log} \
           /var/lib/apt/lists/* \
           /var/tmp/* \
           /var/log/*log \
           /usr/share/doc/*

COPY . .

EXPOSE 5000
CMD [ "python", "flaskapi.py" ]
