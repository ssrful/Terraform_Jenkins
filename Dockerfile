FROM python:3
WORKDIR /usr/src/app
COPY . /usr/src/app
RUN apt-get -y update 
RUN pip install -r requirements.txt
EXPOSE 9090
CMD ["python", "web.py"]