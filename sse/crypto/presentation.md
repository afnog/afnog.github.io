class: center, middle

# Cryptography and Security

## How to keep your data safe (a bit)

### Chris Wilson, [Aptivate](http://www.aptivate.org/), AfNOG 2014

---

## Credits

Based on presentations by:

* [Marcus Adomey](http://www.afnog.org/afnog_chix2011/Thursday/MA/CryptographySlides.odp) (AfChix, Malawi, 2011)
* [NSRC](https://nsrc.org/workshops/2013/nsrc-tenet-tut/raw-attachment/wiki/AgendaTrack2) (NSRC-TENET Workshop, South Africa, 2013)

You can access this presentation at: http://afnog.github.io/sse/crypto/presentation

Download or edit this presentation [on GitHub](https://github.com/afnog/sse/crypto/presentation.md).

---

## What we can talk about

* What is security?
* How secure are you?
* Attack vectors
* 

---

## What do you care about?

What do you want to prevent? Consider the *threat*:

* Is your data valuable to someone else?
* Are your systems valuable to someone else?
* What prevents them from doing that?
  * Make a list of defensive measures

???

* Is your data valuable to someone else?
  * Sell it?
  * Blackmail?
  * Steal money or resources?
  * Embarrass somebody important?
  * Threaten to or actually cause downtime?
* Are your systems valuable to someone else?
  * CPU time?
  * Disk space?
  * Network bandwidth?
  * IP addresses?
  * Access to other systems?
* What prevents them from doing that? - brainstorm

---

## How secure are you?

How would you crack the defensive measures that we just listed?

---

## Absolute security

> The only truly secure system is one that is powered off, cast in a block of concrete and sealed in a lead-lined room with armed guards - and even then I have my doubts. - [Gene Spafford](http://spaf.cerias.purdue.edu/quotes.html)

Security is **impossible** if:

* some users have additional rights (privileges)
* you cannot distinguish people using only laws of physics
* you cannot make it physically impossible to violate policy

---

## Living with insecurity

* **Can't** be completely secure
* **Can** make individual attacks more expensive.
* Beware the side effects (systems harder to use)
* Increase transparency (more eyes on attackers)

---

## Reducing specific risks

* Use encrypted communications
* Use multi-factor authentication
* Verify authenticity of messages
* Reduce risks (don't keep sensitive data)

---

## Goals of system security

Why do you lock your doors?

* Confidentiality
* Integrity
* Authentication
  * Access Control
  * Verification
  * Non-repudiation
* Availability

---

## How do we use cryptography?

* ssh/scp/sftp
* SSL/TLS/https
* pops/imaps/smtps
- VPNs
* dnssec
* wep/wpa
- digital signatures (software)
- certificates and pki
- DRM
- disk encryption

---

## Applied Cryptography

<img src="https://www.schneier.com/images/cover-applied-200h.gif">
<img src="https://www.schneier.com/images/bruce-blog3.jpg">

Written by Bruce Schneier. This is, perhaps, the best book around if you
want to understand how all this works.

---

## FIN

Any questions?
