const puppeteer = require('puppeteer');
const fs = require('fs');

(async () => {
    const url = process.env.SCRAPE_URL || 'https://example.com';
    const browser = await puppeteer.launch({
        args: ['--no-sandbox', '--disable-setuid-sandbox'],
        headless: true
    });
    const page = await browser.newPage();
    await page.goto(url, { waitUntil: 'domcontentloaded' });
    
    const data = await page.evaluate(() => {
        return {
            title: document.title,
            heading: document.querySelector('h1') ? document.querySelector('h1').innerText : 'No H1 found',
            url: window.location.href, 
            bodyText: document.body.innerText.trim()
        };
    });
    
    fs.writeFileSync('scraped_data.json', JSON.stringify(data, null, 2));
    await browser.close();
})();
