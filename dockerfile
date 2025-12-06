FROM python:3.12.12-alpine3.23

RUN apk update -y
RUN apk add curl nano

WORKDIR /app

COPY . /app 

RUN pip install --no-cache-dir -r requirements.txt

EXPOSE 5000

CMD ["python", "run.py"]


