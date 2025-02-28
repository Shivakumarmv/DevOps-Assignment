FROM node:18-slim AS scraper

RUN apt-get update && apt-get install -y \
    chromium \
    fonts-liberation \
    libnss3 \
    libx11-xcb1 \
    libxcomposite1 \
    libxcursor1 \
    libxdamage1 \
    libxfixes3 \
    libxrandr2 \
    libxrender1 \
    libxss1 \
    libxtst6 \
    xdg-utils \
    && rm -rf /var/lib/apt/lists/*

ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=1
ENV PUPPETEER_EXECUTABLE_PATH="/usr/bin/chromium"

WORKDIR /app
COPY package*.json scraper.js ./

RUN npm install 

ARG SCRAPE_URL
ENV SCRAPE_URL=${SCRAPE_URL}

RUN node scraper.js && ls -lah /app


#stage-2 

FROM python:3.10-slim

WORKDIR /app


COPY --from=scraper /app/scraped_data.json ./scraped_data.json

COPY requirements.txt server.py ./


RUN pip install --no-cache-dir -r requirements.txt


EXPOSE 5000

CMD ["python"  ,"server.py"]
