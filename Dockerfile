# syntax=docker/dockerfile:1.3-labs

FROM quay.io/devfile/base-developer-image:ubi9-latest

ARG TARGETARCH

LABEL maintainer="Anes Hadrez"

LABEL com.redhat.component="devfile-universal-container" \
    name="devfile/universal-developer-image" \
    version="ubi9" \
    summary="devfile universal developer image" \
    description="Image with developer tools, languages SDK, and runtimes included." \
    io.k8s.display-name="devfile-developer-universal"

USER 0

# Copy Google Cloud SDK repo definition
COPY google-cloud-sdk.repo /etc/yum.repos.d/google-cloud-sdk.repo

# Install tools and  packages
RUN dnf install -y iputils bind-utils stow xz google-cloud-cli google-cloud-cli-gke-gcloud-auth-plugin && \
    dnf clean all

ENV PROFILE_EXT=/etc/profile.d/udi_environment.sh
RUN touch ${PROFILE_EXT} && chown 10001 ${PROFILE_EXT}


# Terraform
RUN <<EOF
set -euxf -o pipefail
TEMP_DIR="$(mktemp -d)" && cd "${TEMP_DIR}"
TF_VERSION="1.10.5"
TF_ARCH="linux_${TARGETARCH}"
TF_ZIP="terraform_${TF_VERSION}_${TF_ARCH}.zip"
curl -sSLO "https://releases.hashicorp.com/terraform/${TF_VERSION}/${TF_ZIP}"
curl -sSLO "https://releases.hashicorp.com/terraform/${TF_VERSION}/terraform_${TF_VERSION}_SHA256SUMS"
sha256sum --ignore-missing -c terraform_${TF_VERSION}_SHA256SUMS
unzip ${TF_ZIP}
install -m 755 terraform /usr/local/bin/
cd - && rm -rf "${TEMP_DIR}"
EOF

# add terraform vscode extension
COPY terraform.vsix /home/tooling/



RUN echo 'alias gcloud_login="gcloud auth login --no-launch-browser --update-adc"' >> /home/user/.bashrc

# Terrascan
RUN <<EOF
set -euxf -o pipefail
TEMP_DIR="$(mktemp -d)" && cd "${TEMP_DIR}"
TERRASCAN_VERSION="1.19.9"
TERRASCAN_ARCHIVE="terrascan_${TERRASCAN_VERSION}_Linux_x86_64.tar.gz"
curl -sSLO "https://github.com/tenable/terrascan/releases/download/v${TERRASCAN_VERSION}/${TERRASCAN_ARCHIVE}"
tar -xzf "${TERRASCAN_ARCHIVE}"
install -m 755 terrascan /usr/local/bin/
cd - && rm -rf "${TEMP_DIR}"
EOF

# Shellcheck
RUN <<EOF
set -euxf -o pipefail
TEMP_DIR="$(mktemp -d)" && cd "${TEMP_DIR}"
SHELL_CHECK_VERSION="0.8.0"
SHELL_CHECK_ARCH=$( [ "$TARGETARCH" = "arm64" ] && echo "aarch64" || echo "x86_64" )
SHELL_CHECK_TGZ="shellcheck-v${SHELL_CHECK_VERSION}.linux.${SHELL_CHECK_ARCH}.tar.xz"
curl -sSLO "https://github.com/koalaman/shellcheck/releases/download/v${SHELL_CHECK_VERSION}/${SHELL_CHECK_TGZ}"
tar -xJf "${SHELL_CHECK_TGZ}"
install -m 755 shellcheck-v${SHELL_CHECK_VERSION}/shellcheck /bin/shellcheck
cd - && rm -rf "${TEMP_DIR}"
EOF

# Google Cloud Bash completion
RUN echo "source /usr/lib64/google-cloud-sdk/completion.bash.inc" >> ~/.bashrc


# Container engine configuration
COPY --chown=0:0 containers.conf /etc/containers/containers.conf


# Set proper permissions to allow arbitrary users to write
RUN chgrp -R 0 /home && chmod -R g=u /etc/passwd /etc/group /home /etc/pki

# Final cleanup
RUN dnf clean all --enablerepo='*'

USER 10001
ENV HOME=/home/user
