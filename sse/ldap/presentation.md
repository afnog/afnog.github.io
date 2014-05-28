class: center, middle, title

# LDAP and Kerberos

## How to run an LDAP server and Kerberos domain

.height_8em[[![Tree in Mist](https://farm8.staticflickr.com/7095/7230738190_3c6f7146e6_b.jpg)](https://www.flickr.com/photos/matthewpaulson/7230738190)]

### Chris Wilson, [Aptivate](http://www.aptivate.org/), AfNOG 2014

---

## Credits

Based on presentations by:

* [Brian Candler and NSRC](https://nsrc.org/workshops/2011/sanog17/wiki/Agenda) (SANOG 17)

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

* What is LDAP
* What is Kerberos
* Creating a Kerberos domain (KDC)
* Add clients to Kerberos domain
* Share user information using LDAP

---

## What is LDAP

* A generic directory service.
* Can store and retrieve any kind of information.
* Frequently used as database backends for other applications.
* Organises entries into a hierarchical *directory tree*.
* Trees can be very simple, or very complex, with many branch points.

---

## What is Kerberos

---

## Practicals

---
layout: true
## Build a KDC
---

### Before you Start

Choose a realm name:
* For example, `myname.afnog.guru`

---

### Install the Packages

```sh
sudo pkg install krb5
```

---

### Configure local Kerberos

Edit `/etc/krb5.conf` (using sudo) and add these lines:

```sh
[libdefaults]
default_realm = <your_realm>
dns_lookup_realm = true
dns_lookup_kdc = true

[realms]
<your_realm> = {
        kdc = pcXX.sse.ws.afnog.org
        admin_server = pcXX.sse.ws.afnog.org
}

[domain_realm]
pcXX.sse.ws.afnog.org = <your_realm>
```

### Enable the Service

Edit `/etc/rc.conf` (using sudo) and add the line:

```sh
sssd_enable="YES"
```

Edit `/etc/nsswitch.conf` (using sudo) and change the `group` and `passwd` lines to match these:

```sh
group: files sss
passwd: files sss
```

---

### Configure the Service (1)

Create the file `/usr/local/etc/sssd/sssd.conf` (using sudo):

```
[domain/<domain_name>]
cache_credentials = True
krb5_store_password_if_offline = True
ipa_domain = <domain_name>
id_provider = ipa
auth_provider = ipa
access_provider = ipa
ipa_hostname = pcXX.sse.ws.afnog.org
chpass_provider = ipa
ipa_server = _srv_ # use DNS SRV
```

---

### Configure the Service (2)

Continue adding to `/usr/local/etc/sssd/sssd.conf`:

```
ldap_tls_cacert = <ldap tls CA cert location>
enumerate = True #to enumerate users and groups

[sssd]
enumerate = True
services = nss, pam, sudo
config_file_version = 2
domains = <domain_name>

[nss]

[pam]

[sudo]
```

/usr/local/etc/sssd/sssd.conf


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
