# @file
# @desc  Starts up our boot node
FROM ubuntu-geth
WORKDIR /app
COPY data /app/data
COPY boot/keystore /app/boot/keystore
COPY boot.sh /app/
COPY boot.key /app/
EXPOSE 30303/tcp 30303/udp
EXPOSE 8000/tcp
CMD ./boot.sh
