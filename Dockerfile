FROM jaanos/appr:base

ENV PROJECT_DIR ${HOME}/APPR-2018-19
ENV PROJECT_FILE ${PROJECT_DIR}/APPR-2018-19.Rproj

ENV RSTUDIO_PROJECT_SETTINGS ${HOME}/.rstudio/projects_settings

USER root
RUN mkdir -p ${PROJECT_DIR}
RUN mkdir -p ${RSTUDIO_PROJECT_SETTINGS}
COPY . ${PROJECT_DIR}
RUN echo -n "${PROJECT_FILE}" > ${RSTUDIO_PROJECT_SETTINGS}/last-project-path
RUN chown -R ${NB_USER} ${HOME}
USER ${NB_USER}

RUN if [ -f install.R ]; then R --quiet -f install.R; fi
