FROM ruby:2.7.0-alpine

RUN apk update && apk add \
    bash supervisor git nodejs \
    openssl-dev postgresql-dev libpq postgresql-client sqlite-dev \
    libxml2-dev libxslt-dev build-base ruby-dev libc-dev linux-headers tzdata

RUN apk update && apk add --no-cache bash \
        alsa-lib \
        at-spi2-atk \
        atk \
        cairo \
        cups-libs \
        dbus-libs \
        eudev-libs \
        expat \
        flac \
        gdk-pixbuf \
        glib \
        libgcc \
        libjpeg-turbo \
        libpng \
        libwebp \
        libx11 \
        libxcomposite \
        libxdamage \
        libxext \
        libxfixes \
        tzdata \
        libexif \
        udev \
        xvfb \
        zlib-dev \
        chromium \
        chromium-chromedriver

WORKDIR /app
ADD . .

RUN gem install bundler
RUN bundle install