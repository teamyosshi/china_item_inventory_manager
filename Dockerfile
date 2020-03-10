FROM ruby:2.6.3

# このDockerfileのメタデータを記述
# MAINTAINERはdeprecateになった
LABEL maintainer="Tomohiro Hagino <marspeoplehg@gmail.com>"|

# yarnと必要なパッケージのインストール
RUN curl -sL https://deb.nodesource.com/setup_10.x | bash - \
  && curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
  && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
  && curl -sS https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - \
  && echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" | tee /etc/apt/sources.list.d/google-chrome.list \
  && apt-key update \
  && apt-get update -qq \
  && apt-get install --no-install-recommends -y build-essential postgresql-client nodejs yarn google-chrome-stable less yarn vim fonts-noto-cjk libreoffice graphviz \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

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