# Minimal image with podman + oc + tooling
FROM registry.access.redhat.com/ubi9:latest

RUN dnf install -y \
      podman \
      git \
      python3 \
      python3-pip \
      gettext \
      curl \
      tar \
      jq \
    && dnf clean all

# Install oc + kubectl from official OpenShift client tools
RUN curl -L "https://mirror.openshift.com/pub/openshift-v4/x86_64/clients/ocp/latest/openshift-client-linux.tar.gz" \
      -o /tmp/oc.tar.gz \
 && tar -C /usr/local/bin -xzf /tmp/oc.tar.gz oc kubectl \
 && chmod +x /usr/local/bin/oc /usr/local/bin/kubectl \
 && rm -f /tmp/oc.tar.gz

# Default workdir where you'll mount your honse farm repo
WORKDIR /opt/honsefarm

# Just drop into a shell by default
ENTRYPOINT ["/bin/bash"]
