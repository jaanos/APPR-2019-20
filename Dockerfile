FROM jaanos/appr:base

ENV PROJECT_DIR ${HOME}/APPR-2018-19
ENV PROJECT_FILE APPR-2018-19.Rproj

ENV RSTUDIO_PROJECT_DIR ${HOME}/.rstudio/project_settings

USER root
RUN mkdir -p ${PROJECT_DIR}
RUN mkdir -p ${RSTUDIO_PROJECT_DIR}
COPY . ${PROJECT_DIR}
RUN chown -R ${NB_USER} ${HOME}
RUN echo -n "${PROJECT_DIR}/${PROJECT_FILE}" > ${RSTUDIO_PROJECT_DIR}/last-project-path
USER ${NB_USER}

RUN if [ -f install.R ]; then R --quiet -f install.R; fi
