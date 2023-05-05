FROM python:2.7

WORKDIR /tmp
RUN apt-get update && apt-get install -y curl autoconf automake autopoint pkg-config libtool gcc make
RUN curl -LO "https://github.com/mchehab/zbar/archive/refs/tags/0.23.90.tar.gz" \
    && tar zxf 0.23.90.tar.gz \
    && (cd zbar-0.23.90 && autoreconf -vfi && ./configure && make && make install) \
    && rm -rf 0.23.90.tar.gz zbar-0.23.90 \
    && apt-get --purge remove -y curl autoconf automake autopoint pkg-config libtool gcc make \
    && apt-get clean \
    && rm -rf /var/lib/apt-get/lists/*

WORKDIR /usr/src/app
COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

CMD [ "python", "./main.py" ]