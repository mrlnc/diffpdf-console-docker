FROM ubuntu:18.04

# https://launchpad.net/ubuntu/+archive/primary/+sourcefiles/diffpdf/2.1.3-1.2/diffpdf_2.1.3.orig.tar.gz
COPY diffpdf-2.1.3 /root/diffpdf-2.1.3
# https://launchpad.net/ubuntu/+archive/primary/+sourcefiles/diffpdf/2.1.3-1.2/diffpdf_2.1.3-1.2.debian.tar.xz
COPY debian/patches/* /root/
# https://github.com/taurus-forever/diffpdf-console/commit/4552264b4a73101658cbc233246e5f5410c9bdd3
COPY 4552264b4a73101658cbc233246e5f5410c9bdd3.patch /root/

WORKDIR /root/diffpdf-2.1.3

# install build dependencies for diffpdf
RUN sed -Ei 's/^# deb-src /deb-src /' /etc/apt/sources.list
RUN apt update && apt install -y git && apt build-dep -y diffpdf

RUN patch < /root/02-buildflags.patch
RUN patch < /root/diffpdf-qt5.patch
RUN patch < /root/4552264b4a73101658cbc233246e5f5410c9bdd3.patch

ENV QT_SELECT 5
RUN lrelease diffpdf.pro
RUN qmake
RUN make
RUN make install

RUN apt install -y xvfb
COPY run.sh /root/
RUN chmod u+x /root/run.sh

ENTRYPOINT [ "/root/run.sh" ]