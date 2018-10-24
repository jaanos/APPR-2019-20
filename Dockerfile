FROM jaanos/appr:base

# Copy repo into ${HOME}, make user owns $HOME
USER root
COPY . ${HOME}
RUN chown -R ${NB_USER} ${HOME}
USER ${NB_USER}
