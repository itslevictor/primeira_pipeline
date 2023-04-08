#!/bin/bash
echo iniciando a verificacao
echo
#checkout
if [ -e  /usr/lib/systemd/system/react-app.service ];
then
# SE SATISFAZ ENTRA AQUI
rm -rf /usr/lib/systemd/system/react-app.service
mv /primeira_pipeline/react-app.service /usr/lib/systemd/system
rm -rf primeira_pipeline
else
echo
mkdir /app
# SE NAO SATISFAZ ENTRA AQUI
mv /primeira_pipeline/react-app.service /usr/lib/systemd/system
rm -rf primeira_pipeline
fi


if [ -d /usr/local/lib/node_modules ];
then
# SE SATISFAZ ENTRA AQUI
echo
else
echo
mkdir /app
# SE NAO SATISFAZ ENTRA AQUI
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.2/install.sh | bash

export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
yum install -y nodejs

fi

if [ -d repository/ ];
then
# SE SATISFAZ ENTRA AQUI
echo entrando no repositorio e removendo a pasta a força
echo
cd /repository
rm -rf react-app
else
echo criada a pasta repository
echo
mkdir /repository
# SE NAO SATISFAZ ENTRA AQUI
fi

if [ -d app/ ];
then
echo
# SE SATISFAZ ENTRA AQUI
else
echo criada a pasta app
echo
mkdir /app
# SE NAO SATISFAZ ENTRA AQUI
fi

echo iniciando o conteudo do sh
echo

echo baixando e instalando pasta
echo
git clone https://github.com/kelvin-alef/react-app.git

echo compilando
echo

npm run build
	
#deplyando
echo iniciando deploy
echo

#parando o react para evitar erros e removendo o antigo da pasta app
systemctl stop react-app
rm -rf /app/react-app

#movendo a build do repositorio para pasta app
mv /repository/react-app/build /app/react-app

#encerra aqui o shell

