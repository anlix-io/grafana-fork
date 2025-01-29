FROM grafana/grafana:11.5.0

USER root

# Copia os arquivos locais para dentro do container
COPY img/logo.svg /usr/share/grafana/public/img/logo.svg
COPY img/favicon.png /usr/share/grafana/public/img/favicon.png
COPY img/login_dark.svg /usr/share/grafana/public/img/login_dark.svg

# Verifica se os arquivos foram copiados corretamente
RUN ls -l /usr/share/grafana/public/img/

# Renomeia os arquivos para garantir a substituição
RUN mv -f /usr/share/grafana/public/img/logo.svg /usr/share/grafana/public/img/grafana_icon.svg
RUN mv -f /usr/share/grafana/public/img/favicon.png /usr/share/grafana/public/img/fav32.png
RUN mv -f /usr/share/grafana/public/img/login_dark.svg /usr/share/grafana/public/img/g8_login_dark.svg

RUN find /usr/share/grafana/public/build/ -name *.js \
## Update Title
    -exec sed -i 's|AppTitle="Grafana"|AppTitle="Anlix"|g' {} \;

RUN find /usr/share/grafana/public/build/ -name *.js \
## Update Login Title
    -exec sed -i 's|LoginTitle="Welcome to Grafana"|LoginTitle=""|g' {} \;

# Retorna ao usuário original do Grafana
USER 472
