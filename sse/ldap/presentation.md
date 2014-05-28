class: center, middle, title

# LDAP Directory Services

## How to run an LDAP server and domain

.height_8em[[![Tree in Mist](https://farm8.staticflickr.com/7095/7230738190_3c6f7146e6_b.jpg)](https://www.flickr.com/photos/matthewpaulson/7230738190)]

### Chris Wilson, [Aptivate](http://www.aptivate.org/), AfNOG 2014

---

## Credits

Based on presentations by:

* [FreeIPA Guide](http://docs.fedoraproject.org/en-US/Fedora/15/html/FreeIPA_Guide/index.html)
* [Seth Lyons](https://forums.freebsd.org/viewtopic.php?f=39&t=46526)

You can access this presentation at: http://afnog.github.io/sse/ldap/presentation
([edit](https://github.com/afnog/sse/ldap/presentation.md))

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

## What is FreeIPA?

* Domain controller for Linux and Unix machines.
* Used on controlling servers and enrolled client machines.
* Provides centralized structure for Linux/Unix environments.
* Centralizes identity management and identity policies.
* Uses native Linux (UNIX) applications and protocols.

---
layout: true
## Control Levels
---

### Low Control

* Central user, password, and policy stores.
* IT staff maintain the identities on one machine (the FreeIPA server).
* Users and policies are uniformly applied to all machines.
* Set different access levels for laptops and remote users.

---

### Medium Control

* Replaces traditional fragmented management tools:
  * NIS domain for machines;
  * LDAP directory for users;
  * Kerberos for authentication.
* Reduces administrative overhead by integrating these services seamlessly.
* Provides a single and simplified tool set.

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

---

### Enable PAM Integration

Edit `/etc/pam.d/system` (using sudo), find the line that says:

```sh
auth            required        pam_unix.so
```

And add the following line before it:

```sh
auth            sufficient      /usr/local/lib/pam_sss.so
```

---
layout: false

## FIN

Any questions?
