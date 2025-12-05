FROM python:3.12.12-alpine3.23

WORKDIR /app

COPY . /app 

RUN pip install --no-cache-dir -r .requirements.txt

EXPOSE 5000

CMD ["python", "app.py"]


