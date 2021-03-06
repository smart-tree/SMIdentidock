FROM python:3.4

USER root

RUN groupadd -r uwsgi && useradd -r -g uwsgi uwsgi
RUN yum install -y curl
RUN curl "https://bootstrap.pypa.io/get-pip.py" -o "get-pip.py" && \
    python get-pip.py
RUN yum install -y python-devel && \
    yum install -y rh-python34-python-devel
RUN pip install Flask==0.10.1 uWSGI==2.0.8 requests==2.5.1 redis==2.10.3
WORKDIR /app
COPY app /app
COPY cmd.sh /

RUN chmod +x /cmd.sh

EXPOSE 9090 9191
USER uwsgi

CMD ["/cmd.sh"]
