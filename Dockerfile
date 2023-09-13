FROM ubuntu:20.04
USER root
RUN apt update && \
    apt install -y software-properties-common && \
    add-apt-repository ppa:deadsnakes/ppa && \
    apt install -y curl && \
    apt install -y sudo && \
    apt install unzip && \
    apt install -y python3.8 && \
    apt install -y python3.8-distutils && \
    curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py && \
    python3.8 get-pip.py && \
    curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && \
    unzip awscliv2.zip && \
    ./aws/install
RUN ["apt-get", "install", "-y", "vim"]
RUN apt-get install -y git
RUN apt-get install telnet -y 
COPY ./dbt-spark.tar.gz  .
#RUN git clone git@codebase.aps1aws.lumiq.int:Data_Engineering/dbt-spark.git
RUN tar -xvf dbt-spark.tar.gz
WORKDIR dbt-spark
COPY ./Dockerfile .
RUN pip install .
RUN  apt-get install sasl2-bin libsasl2-2 libsasl2-dev libsasl2-modules -y
#RUN pip install sasl==0.3
#RUN apt-get install cyrus-sasl-plain -y
RUN pip install agate==1.7.0
RUN pip install attrs==23.1.0
RUN pip install Babel==2.12.1
RUN pip install certifi==2023.5.7
RUN pip install cffi==1.15.1
RUN pip install charset-normalizer==3.1.0
RUN pip install click==8.1.3
RUN pip install colorama==0.4.6
RUN pip install dbt-core==1.5.0
RUN pip install dbt-extractor==0.4.1
RUN pip install dbt-spark==1.5.0
RUN pip install future==0.18.3
RUN pip install hologram==0.0.16
RUN pip install idna==3.4
RUN pip install importlib-resources==5.12.0
RUN pip install isodate==0.6.1
RUN pip install Jinja2==3.1.2
RUN pip install jsonschema==4.17.3
RUN pip install leather==0.3.4
RUN pip install Logbook==1.5.3
RUN pip install MarkupSafe==2.1.2
RUN pip install mashumaro==3.6
RUN pip install minimal-snowplow-tracker==0.0.2
RUN pip install msgpack==1.0.5
RUN pip install networkx==2.8.8
RUN pip install packaging==23.1
RUN pip install parsedatetime==2.4
RUN pip install pathspec==0.11.1
RUN pip install pip==20.0.2
RUN pip install pkgutil-resolve-name==1.3.10
RUN pip install protobuf==4.23.1
RUN pip install pure-sasl==0.6.2
RUN pip install pycparser==2.21
RUN pip install PyHive==0.6.5
RUN pip install pyrsistent==0.19.3
RUN pip install python-dateutil==2.8.2
RUN pip install python-slugify==8.0.1
RUN pip install pytimeparse==1.1.8
RUN pip install pytz==2023.3
RUN pip install PyYAML==6.0
RUN pip install requests==2.30.0
RUN pip install sasl==0.3
RUN pip install setuptools==44.0.0
RUN pip install six==1.16.0
RUN pip install sqlparams==5.1.0
RUN pip install sqlparse==0.4.3
RUN pip install text-unidecode==1.3
RUN pip install thrift==0.16.0
RUN pip install thrift-sasl==0.4.3
RUN pip install typing-extensions==4.5.0
RUN pip install urllib3==2.0.2
RUN pip install Werkzeug==2.3.4
RUN pip install wheel==0.40.0
RUN pip install zipp==3.15.0
#RUN pip install .
RUN mkdir /apps
#RUN cp requirements.txt /apps
WORKDIR /root
RUN mkdir ./.dbt
COPY ./profiles.yml ./.dbt/
## in requirements.txt , it contain the python packages we need to install in our container.
WORKDIR /apps
#RUN pip install --no-cache-dir -r /apps/requirements.txt 
COPY ./demo_poc.zip .
RUN unzip demo_poc.zip
WORKDIR /apps/demo_poc_2
CMD ["/usr/local/bin/dbt", "debug"]



