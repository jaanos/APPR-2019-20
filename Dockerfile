FROM jaanos/appr:base

USER root
COPY . ${HOME}
RUN chown -R ${NB_USER} ${HOME}
USER ${NB_USER}

RUN if [ -f install.R ]; then R --quiet -f install.R; fi
