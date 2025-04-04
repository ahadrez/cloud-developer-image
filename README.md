# Cloud Developer Images

This is a universal developer container image based on Red Hat's base developer UBI9, designed to provide a rich set of tools for cloud-native development. It includes common developer utilities, Google Cloud CLI tools, Terraform, Terrascan, ShellCheck, and more — all set up for immediate use in DevSpaces or similar environments.


Containers images with tools for developers 👨‍💻👩‍💻

## Developer Base Image

Run the following command to test it with Docker:

```bash
$ docker run -ti --rm \
       quay.io/upstream/cloud-developer-image:ubi9-latest \
       bash
```
### Included Development Tools

| Tool                | ubi9 based image                    |
|---------------------|-------------------------------------|
| `terraform`         |`terraform`                          |
| `gcloud`            |`gcloud`                             |
| `terrascan`         |`terrascan`                          |
| `shellcheck`        |`shellcheck`                         |
| `bash`              |`bash`                               |
| `bat`               |`<gh releases>`                      |
| `buildah`           |`buildah`                            |
| `curl`              |`curl`                               |
| `ps`                |`ps`                                 |
| `diff`              |`diffutils`                          |
| `emacs`             |`NOT AVAILABLE (fedora only)`        |
| `fish`              |`NOT AVAILABLE (fedora only)`        |
| `gh`                |`<gh releases>`                      |
| `git`               |`git`                                |
| `git-lfs`           |`git-lfs`                            |
| `ip`                |`iproute`                            |
| `jq`                |`jq`                                 |
| `htop`              |`NOT AVAILABLE (fedora only)`        |
| `kubedock`          |`<gh releases>`                      |
| `less`              |`less`                               |
| `lsof`              |`lsof`                               |
| `man`               |`man`                                |
| `nano`              |`nano`                               |
| `netcat`            |`NOT AVAILABLE`                      |
| `netstat`           |`net-tools`                          |
| `openssh-client`    |`openssh-clients`                    |
| `podman`            |`podman`                             |
| `7z`                |`p7zip-plugins`                      |
| `ripgrep`           |`<gh releases>`                      |
| `rsync`             |`rsync`                              |
| `scp`               |`openssh-clients`                    |
| `screen`            |`NOT AVAILABLE`                      |
| `sed`               |`sed`                                |
| `shasum`            |`perl-Digest-SHA`                    |
| `socat`             |`socat`                              |
| `sudo`              |`sudo`                               |
| `ss`                |`NOT AVAILABLE`                      |
| `ssl-cert`          |`NOT AVAILABLE`                      |
| `stow`              |`stow`                               |
| `tail`              |`<built in>`                         |
| `tar`               |`tar`                                |
| `time`              |`time`                               |
| `tldr`              |`NOT AVAILABLE (fedora only)`        |
| `tmux`              |`NOT AVAILABLE (fedora only)`        |
| `vim`               |`vim`                                |
| `wget`              |`wget`                               |
| `zip`               |`zip`                                |
| `zsh`               |`NOT AVAILABLE (fedora only)`        |
| **TOTAL SIZE**      | **1.96GB**         |
