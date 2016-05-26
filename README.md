# NAME 

- ssl4curl

# SYNOPSIS

- Download and setup Mozilla certificates for curl SSL/TLS
- a.k.a fixes error bellow

    curl: (60) SSL certificate problem: unable to get local issuer certificate
    More details here: http://curl.haxx.se/docs/sslcerts.html

    curl performs SSL certificate verification by default, using a "bundle"
    of Certificate Authority (CA) public keys (CA certs). If the default
    bundle file isn't adequate, you can specify an alternate file
    using the --cacert option.
    If this HTTPS server uses a certificate signed by a CA represented in
    the bundle, the certificate verification probably failed due to a
    problem with the certificate (it might be expired, or the name might
    not match the domain name in the URL).
    If you'd like to turn off curl's verification of the certificate, use
    the -k (or --insecure) option.

# INSTALLATION

```bash
#clone repository
git clone https://github.com/z448/ssl4curl
#initialize from command line as root or use sudo
sudo ssl4curl -i
```

# USAGE

```bash
#add to ~/.bashrc to check/download and setup certificates on start of every session
export `ssl4curl -p`
#execute on command line to check/download certificates and list export string. You can add output string into your ~/.bashrc in which case certificate setup will be skiped on start of session.
`ssl4curl`
#print this doc
`ssl4curl -h`
```
