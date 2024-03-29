FROM python:3.7-slim

WORKDIR /app

COPY api_yamdb/requirements.txt requirements.txt

COPY api_yamdb/ /app

RUN pip3 install -r requirements.txt

COPY . .

CMD ["gunicorn", "api_yamdb.wsgi:application", "--bind", "0:8000"] 
