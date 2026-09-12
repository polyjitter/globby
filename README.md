# globby &nbsp; [![bluebuild build badge](https://github.com/polyjitter/globby/actions/workflows/build.yml/badge.svg)](https://github.com/polyjitter/globby/actions/workflows/build.yml)

**Globby** is a custom [ucore](https://projectucore.org/) image which automatically builds in [k3s](https://k3s.io/) with a [Headlamp](https://headlamp.dev/) dashboard for running home Kubernetes clusters. 

It is named Globby because I am bad at naming things. It is stupidly work in progress! 

A lot of the initial work for this is inspired by [guiso](https://github.com/esteganobvio/guiso). 

## Roadmap

- [ ] Basic functionality
- [ ] Better integration with ucore features?
- [ ] Automatic worker joining over PXE
- [ ] (Very far away) Site to auto-generate installation files.

## Agent Configuration

Agent joining is handled via environmental variables in `/etc/rancher/k3s/k3s.env`. You can set this through your Butane file as follows (which can also be seen in `sub.butane` in the `examples` directory):

```butane
variant: fcos
version: 1.6.0

storage:
  files:
    - path: /etc/rancher/k3s/k3s.env
      mode: 0600
      contents:
        inline: |
          K3S_URL=https://YOUR_SERVER_IP_HERE:6443
          K3S_TOKEN=YOUR_NODE_TOKEN_HERE
```

## Installation

> [!WARNING]  
> [This is an experimental feature](https://www.fedoraproject.org/wiki/Changes/OstreeNativeContainerStable), try at your own discretion.

### Auto Rebase

You can auto-rebase with Butane; an example is provided in the `examples` directory.

### Manual Rebase

To rebase an existing atomic Fedora installation to the latest build:

- First rebase to the unsigned image, to get the proper signing keys and policies installed:
  ```sh
  # Or any variant
  rpm-ostree rebase ostree-unverified-registry:ghcr.io/polyjitter/globby-main:latest
  ```
- Reboot to complete the rebase:
  ```sh
  systemctl reboot
  ```
- Then rebase to the signed image, like so:
  ```sh
  # Or any variant
  rpm-ostree rebase ostree-image-signed:docker://ghcr.io/polyjitter/globby-main:latest
  ```
- Reboot again to complete the installation
  ```sh
  systemctl reboot
  ```

The `latest` tag will automatically point to the latest build. That build will still always use the Fedora version specified in `recipe.yml`, so you won't get accidentally updated to the next major version.

## ISO

If build on Fedora Atomic, you can generate an offline ISO with the instructions available [here](https://blue-build.org/how-to/generate-iso/#_top). These ISOs cannot unfortunately be distributed on GitHub for free due to large sizes, so for public projects something else has to be used for hosting.

## Verification

These images are signed with [Sigstore](https://www.sigstore.dev/)'s [cosign](https://github.com/sigstore/cosign). You can verify the signature by downloading the `cosign.pub` file from this repo and running the following command:

```bash
cosign verify --key cosign.pub ghcr.io/polyjitter/globby
```
