FROM nodeshift/ubi8-s2i-web-app

RUN yum update -y && \
    yum install -y python-pip python-dev curl vim

# We copy just the requirements.txt first to leverage Docker cache
COPY ./requirements.txt /app/requirements.txt
WORKDIR /app
RUN pip install -r requirements.txt
COPY . /app

ENV BUCKET_NAME "$BUCKET_NAME"
ENV ENDPOINT_URL "$ENDPOINT_URL"
ENV AWS_ACCESS_KEY_ID "$AWS_ACCESS_KEY_ID"
ENV AWS_SECRET_ACCESS_KEY "$AWS_SECRET_ACCESS_KEY"

EXPOSE 80
#EXPOSE 8081

ENTRYPOINT [ "python" ]
CMD [ "app.py" ]

