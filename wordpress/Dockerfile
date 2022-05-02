FROM wordpress:php8.1

RUN apt update

COPY php.ini /usr/local/etc/php/php.ini
RUN apt-get update && \
  apt-get -y install git unzip libicu-dev libonig-dev && \
  pecl install xdebug && docker-php-ext-enable xdebug

# set up for puphpeteer
RUN  apt-get -y install curl git unzip

RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" &&\
  php -r "if (hash_file('sha384', 'composer-setup.php') === '906a84df04cea2aa72f40b5f787e49f22d4c2f19492ac310e8cba5b96ac8b64115ac402c8cd292b8a03482574915d1a8') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;" &&\
  php composer-setup.php &&\
  php -r "unlink('composer-setup.php');"

RUN mv composer.phar /usr/local/bin/composer
RUN docker-php-ext-install sockets

# imagecreatefromwebp()が使えるようにする
RUN apt-get update && \
  apt-get install -y zlib1g-dev libwebp-dev libpng-dev libjpeg-dev

RUN docker-php-ext-configure gd --with-webp && \
  docker-php-ext-install gd

RUN apt-get install -y libgtk-3.0 libgbm-dev libnss3 libatk-bridge2.0-0 libasound2
RUN apt install -y nodejs
RUN apt install -y npm

# puppeteer インストール
RUN apt-get update \
  && apt-get install -y wget gnupg \
  && wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - \
  && sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list' \
  && apt-get update \
  && apt-get install -y google-chrome-stable fonts-ipafont-gothic fonts-wqy-zenhei fonts-thai-tlwg fonts-kacst fonts-freefont-ttf libxss1 \
  --no-install-recommends \
  && rm -rf /var/lib/apt/lists/*
