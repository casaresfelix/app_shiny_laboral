# Dockerfile para app Shiny en Render

# Usa imagen base de Shiny con R
FROM rocker/shiny:latest

# Instala los paquetes que necesitas (agrega los tuyos si usas más)
RUN R -e "install.packages(c('shiny', 'dplyr', 'memisc'))"

# Copia todo el contenido del directorio actual al servidor
COPY . /srv/shiny-server/

# Cambia los permisos para que el usuario shiny tenga acceso
RUN chown -R shiny:shiny /srv/shiny-server

# Expone el puerto usado por Shiny
EXPOSE 3838

# Comando para arrancar shiny-server
CMD ["/usr/bin/shiny-server"]
