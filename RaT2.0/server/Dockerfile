FROM alpine:3.5
RUN apk update
RUN apk add --upgrade py2-pip
RUN pip install --upgrade pip
COPY requirements.txt /usr/src/app/
RUN pip install --no-cache-dir -r /usr/src/app/requirements.txt
COPY app.py /usr/src/app/
COPY templates/index.html /usr/src/app/templates/
EXPOSE 80
CMD ["python", "/usr/src/app/app.py"]