class: center, middle

# Exim and Internet Mail

## Chris Wilson, [Aptivate](http://www.aptivate.org/), AfNOG 2013

Download or edit this presentation [on GitHub](https://github.com/afnog/sse/exim/presentation.md).

---

# Agenda

1. How email works
2. Setting up a mail server
3. Customising your server

---

# How email works

![How Internet Email Works](how-internet-email-works.svg)

---

# What is Exim?

* Listens on port 25 (smtp)
* Accepts mail
* Queues mail
* Delivers it somewhere
	* Using SMTP, LMTP, LDA, mbox or maildir
* No POP, IMAP, calendars, to-do lists, Crackberry!

---

# Who uses Exim?

![Public SMTP Server survey results](public-smtp-servers.svg)

???

About 23% of the servers polled by the [Open Email Survey](http://www.openemailsurvey.org/smtp.html).
2nd most popular SMTP server after Postfix.

## Why use Exim?

* Flexible (lots of features)
* Reasonably secure
* Reasonably scalable
* Good debugging options
* Sane (but complex) configuration syntax
