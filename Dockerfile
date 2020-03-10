FROM ruby:2.6.3

# このDockerfileのメタデータを記述
# MAINTAINERはdeprecateになった
LABEL maintainer="Tomohiro Hagino <marspeoplehg@gmail.com>"|

# install bundler.
RUN apt-get update && \
    apt-get install -y vim less postgresql-client && \
    apt-get install -y build-essential libpq-dev nodejs && \
    gem install bundler && \
    apt-get clean && \
    rm -r /var/lib/apt/lists/*

RUN mkdir /myapp
WORKDIR /myapp
COPY Gemfile /myapp/Gemfile
COPY Gemfile.lock /myapp/Gemfile.lock

# Bundlerの設定
# 失敗したネットワーク要求を再試行する回数。デフォルトは3
# bundlerが並行してインストールできるgemの数。デフォルトは1
RUN bundle config --global retry 5 \
  && bundle config --global jobs 4 \
  && bundle config --global path vendor/bundle

COPY launch.sh /usr/bin/
RUN chmod +x /usr/bin/launch.sh

# 文字コードの設定
# 日本語を受け付けるように設定(rails consoleで日本語を使うなど) => LANG=C.UTF-8
# 設定したロケールの値をC.UTF-8で上書きする => LC_ALL=C.UTF-8
# 文字コードのカテゴリをutf-8に設定 => LC_CTYPE="utf-8"
ENV LANG=C.UTF-8 \
    LC_ALL=C.UTF-8 \
    LC_CTYPE="utf-8"

# 使用するエディタ
ENV EDITOR vim

COPY . /myapp

# nginxでpuma.sockを配置するディレクトリを作成
RUN mkdir -p tmp/sockets
RUN mkdir -p tmp/public