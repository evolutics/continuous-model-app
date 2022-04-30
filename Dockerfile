FROM python:3-alpine

WORKDIR /usr/src/app

COPY requirements.txt .
RUN pip install --no-cache-dir --requirement requirements.txt

COPY main.py .

ENV FLASK_APP=main
CMD [ "flask", "run", "--host", "0.0.0.0", "--port", "8080" ]
