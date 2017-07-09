# README

## Development tips
1. Use `rails server webrick` in development because Puma is too slow.
2. Active `ngrok` using `./ngrok http 3000`
- Copy the link that is generated and add it to the [test app](https://developers.facebook.com/apps/1898773100338407/webhooks/).
3. Change the testing URLs located in the EventResponder class and the PageAdditionService. You'll also need to add the domain as whitelisted on any page that you are testing in dev.

Tester credentials:
- uname: `qlemrugols_1499489641@tfbnw.net`  
- password: `tester`

## Page tips
1. Get started needs to be setup for the page.
2. The page must be published for m.me links to actually work.
