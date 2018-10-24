FROM rocker/binder:3.5.1

# Copy repo into ${HOME}, make user owns $HOME
USER root
COPY . ${HOME}
RUN chown -R ${NB_USER} ${HOME}
USER ${NB_USER}
