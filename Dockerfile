FROM python:3.7-alpine
WORKDIR /usr/src/app
ENV Flask-App web.py
ENV Flask-App_Host 0.0.0.0
COPY . .
RUN apt-get -y update 
RUN pip install -r requirements.txt
EXPOSE 9090
CMD ["python", "web.py"]