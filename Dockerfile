FROM alpine:latest

RUN apk add --no-cache --virtual .build-deps ca-certificates curl unzip

# ADD install.sh /install.sh

# RUN chmod +x /install.sh

# CMD /install.sh

# RUN apk del .build-deps
