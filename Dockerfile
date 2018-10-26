FROM jaanos/appr:base

ENV PROJECT_DIR ${HOME}/APPR-2018-19
ENV PROJECT_FILE APPR-2018-19.Rproj

USER root
RUN mkdir -p ${PROJECT_DIR}
COPY . ${PROJECT_DIR}
RUN chown -R ${NB_USER} ${HOME}
RUN echo "rstudioapi::openProject('${PROJECT_DIR}/${PROJECT_FILE}')" > ${HOME}/.Rprofile
USER ${NB_USER}

RUN if [ -f install.R ]; then R --quiet -f install.R; fi
