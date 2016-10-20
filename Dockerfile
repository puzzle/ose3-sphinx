FROM openshift/base-centos7

# ABOUT
# This image is based on a S2I image but used in standard 'docker build'
# fashion. This is done by triggering $STI_SCRIPTS_PATH/assemble while
# building.

USER root

LABEL io.k8s.description="Sphinx container with openshift centos 7 base" \
      io.k8s.display-name="Sphinx" \
      io.openshift.expose-services="9312:sphinx" \
      io.openshift.tags="sphinx"

# SLOW STUFF
# Slow operations, kept at top of the Dockerfile so they're cached for most changes.

# Install epel first
RUN yum update -y && \
    INSTALL_PKGS="epel-release" && \
    yum install -y --setopt=tsflags=nodocs $INSTALL_PKGS && \
    yum clean all -y

# Install Sphinx searchd
RUN yum update -y && \
    INSTALL_PKGS="sphinx" && \
    yum install -y --setopt=tsflags=nodocs $INSTALL_PKGS && \
    yum clean all -y

USER 1001

# ENTRYPOINT

CMD searchd
