# @file
# @desc  Starts up our boot node
FROM ubuntu-geth
WORKDIR /app
COPY data /app/data
COPY boot/keystore /app/boot/keystore
COPY boot.sh /app/
EXPOSE 3000/tcp 3000/udp
EXPOSE 8000/tcp
CMD ./boot.sh
