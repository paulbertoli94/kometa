FROM kometateam/kometa

# Installa gettext-base per disporre di envsubst
RUN apt-get update && apt-get install -y gettext-base && rm -rf /var/lib/apt/lists/*

COPY requirements.txt requirements.txt
RUN pip3 install --no-cache-dir --upgrade --requirement /requirements.txt

COPY trigger.py trigger.py
COPY config.yml.tpl config.yml.tpl
COPY start.sh start.sh
RUN chmod +x start.sh

#start /kometa route
ENTRYPOINT ["bash", "start.sh"]
