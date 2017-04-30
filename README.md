# Yay, BTC!

### Why is it called YAYBTC?

💡 🤔

Because I couldn't think of a better name...

### Purpose

YAYBTC was planned and built in my spare time in a single month (April 2017) as part of the #launch project (https://medium.com/all-systems-go). The concept of #launch is to plan, build and launch a project in a calendar month.

### Disclaimer

**To all randos that come across this and decide to try it out**: This application is a big experiment and the algorithm that determines a buy or sell is not very sophisticated. Use at your own risk. I am not responsible for lost or stolen Bitcoins or anything bad that happens to you as a result of your interactions with this site.

### Application

This platform allows a user to run the code (I recommend a $7 Heroku hobby instance, so you can get a free SSL cert with it), connect a Coinbase account, and toggle the auto buy/sell feature.  If auto buy/sell is enabled, it will execute trades (using the Coinbase API) based on the output of an algorithm.


### Running

Set the following environment variables to run this application:

```
BASIC_NAME
BASIC_PASSWORD
COINBASE_API_KEY
COINBASE_API_SECRET
```

`BASIC_NAME` and `BASIC_PASSWORD` will be the credentials that you use to log into the site (via HTTP Basic Auth). This will create a user for you and link your coinbase account, assuming `COINBASE_API_KEY` and `COINBASE_API_SECRET` are set. At that point, the interface will show that you have not enabled Auto Buy/Sell. When you are ready to begin trading, just click the link named `Enable auto buy/sell`, and the banner will turn green. Voila! YAYBTC will start executing trades for you.

### Coinbase

You'll need to sign up for a Coinbase account and generate an API key and secret. This usually takes 24 to 48 hours to be activated, so plan accordingly!

### Notes

* https://developers.coinbase.com/api/v2
* http://docs.winkdex.com/
* https://www.reddit.com/dev/api/
