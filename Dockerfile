# Nastavitvena datoteka za Binder
FROM jaanos/appr:extended

ENV PROJECT_DIR ${HOME}/APPR-2018-19
ENV PROJECT_FILE ${PROJECT_DIR}/APPR-2018-19.Rproj
ENV PROJECT_INSTALL ${PROJECT_DIR}/install.R
ENV PROJECT_GITCONFIG ${PROJECT_DIR}/gitconfig

ENV RSTUDIO_PROJECTS_SETTINGS ${HOME}/.rstudio/projects_settings

USER root
RUN mkdir -p ${PROJECT_DIR}
RUN mkdir -p ${RSTUDIO_PROJECTS_SETTINGS}
COPY . ${PROJECT_DIR}
RUN echo -n "${PROJECT_FILE}" > ${RSTUDIO_PROJECTS_SETTINGS}/last-project-path
RUN chown -R ${NB_USER} ${HOME}
USER ${NB_USER}

RUN if [ -f ${PROJECT_INSTALL} ]; then R --quiet -f ${PROJECT_INSTALL}; fi
RUN if [ -f ${PROJECT_GITCONFIG} ]; then cp ${PROJECT_GITCONFIG} ${HOME}/.gitconfig; fi
