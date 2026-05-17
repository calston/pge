FROM debian:trixie
RUN apt-get update && apt-get install -y wget dosbox-x

RUN wget -O "/usr/share/keyrings/xpra.asc" https://xpra.org/xpra.asc
RUN cd /etc/apt/sources.list.d/ && wget https://raw.githubusercontent.com/Xpra-org/xpra/master/packaging/repos/trixie/xpra-lts.sources

RUN apt-get update && apt-get install -y xpra


WORKDIR /dos
COPY dosbox.conf /dos/
COPY tp7/ /dos/tp7/
COPY src/ /dos/src/
COPY examples/ /dos/examples/
COPY build.bat /dos/

EXPOSE 14500

CMD ["xpra", "start", "--bind-tcp=0.0.0.0:14500", "--html=on", \
     "--start-child=dosbox-x -conf /dos/dosbox.conf", \
     "--exit-with-children=yes", "--daemon=no"]
