FROM image-registry.openshift-image-registry.svc:5000/openshift/php:7.4-ubi8
LABEL "io.openshift.s2i.build.source-location"="." \
      "io.openshift.s2i.build.image"="image-registry.openshift-image-registry.svc:5000/openshift/php:7.4-ubi8"

USER root
# Copying in override assemble/run scripts
COPY .s2i/bin /tmp/scripts
# Copying in source code
COPY . /tmp/src
# Change file ownership to the assemble user. Builder image must support chown command.
RUN chown -R 1001:0 /tmp/scripts /tmp/src
USER 1001
RUN /tmp/scripts/assemble
# Run script sourced from builder image based on user input or image metadata.
# If this file does not exist in the image, the build will fail.
CMD /usr/libexec/s2i/run
