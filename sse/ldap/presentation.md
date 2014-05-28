class: center, middle, title

# LDAP Directory Services

## How to run an LDAP server and domain

.height_8em[[![Tree in Mist](https://farm8.staticflickr.com/7095/7230738190_3c6f7146e6_b.jpg)](https://www.flickr.com/photos/matthewpaulson/7230738190)]

### Chris Wilson, [Aptivate](http://www.aptivate.org/), AfNOG 2014

---

## Credits

Based on presentations by:

* [Marcus Adomey](http://www.afnog.org/afnog_chix2011/Thursday/MA/CryptographySlides.odp) (AfChix, Malawi, 2011)
* [NSRC](https://nsrc.org/workshops/2013/nsrc-tenet-tut/raw-attachment/wiki/AgendaTrack2) (NSRC-TENET Workshop, South Africa, 2013)

You can access this presentation at: http://afnog.github.io/sse/crypto/presentation

Download or edit this presentation [on GitHub](https://github.com/afnog/sse/crypto/presentation.md).

---

## Conventions

Commands to enter are shown like this:

```sh
openssl smime -encrypt -binary -aes-256-cbc -in message3.txt -out message3.txt.enc yourpartner.crt.pem
openssl smime -decrypt -binary -in encrypted.zip.enc -out decrypted.zip -inkey private.key -passin pass:your_password
```

Please note:

* Long command lines are wrapped for readability.
* Each &#9656; triangle marks the start of a single command.

---

## What we can talk about

* What is an LDAP directory
* How to use an LDAP directory
* What is FreeIPA
* Practical exercises

---

## Practicals

---
layout: true
## Installing FreeIPA
---

### Install the Packages

```sh
sudo pkg install sssd
```

---

### System Configuration

Edit `/etc/rc.conf` (using sudo) and add the line:

```sh
sssd_enable="YES"
```

Copy the sample configuration for `sssd`:

```sh
sudo cp /usr/local/etc/sssd/sssd.conf{.sample,}
```

Edit `/etc/pam.d/system` (using sudo), find the line that says:

```sh
auth            required        pam_unix.so
```

And add the following line before it:

```sh
auth            sufficient      /usr/local/lib/pam_sss.so
```

---
### 

layout: false

## FIN

Any questions?
