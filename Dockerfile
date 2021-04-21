FROM alvrme/alpine-android-base:latest-jdk8

RUN apk update 
RUN apk upgrade --update-cache --available

RUN apk add openssl unzip bison imagemagick gcc g++ curl wget bash make

RUN apk add ruby>2.6.6 
RUN apk add ruby-bundler ruby-dev
RUN gem install digest-crc 
RUN gem install unf_ext
COPY Gemfile /
RUN bundle install

COPY packages.txt /
RUN mkdir -p /root/.android \
 && touch /root/.android/repositories.cfg \
 && sdkmanager --sdk_root=${ANDROID_SDK_ROOT} --update \
 && sdkmanager --package_file=/sdk/packages.txt

RUN rm -rf /var/cache/apk/*
