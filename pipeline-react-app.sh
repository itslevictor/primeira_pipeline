#!/bin/bash
echo iniciando a verificacao
echo
systemctl stop react-app
#checkout
if [ -e  /usr/lib/systemd/system/react-app.service ];
then
echo
# SE SATISFAZ ENTRA AQUI - remove e move limpando o git
rm -rf /usr/lib/systemd/system/react-app.service
mv /primeira_pipeline/react-app.service /usr/lib/systemd/system
rm -rf primeira_pipeline
else
echo
# SE NAO SATISFAZ ENTRA AQUI
mv /primeira_pipeline/react-app.service /usr/lib/systemd/system
rm -rf primeira_pipeline
fi


if [ -d /usr/local/lib/node_modules ];
then
echo
# SE SATISFAZ ENTRA AQUI
else
echo
# SE NAO SATISFAZ ENTRA AQUI
curl -sL https://rpm.nodesource.com/setup_16.x | sudo bash -
yum install -y nodejs
fi

if [ -d repository/ ];
then
echo
# SE SATISFAZ ENTRA AQUI
echo entrando no repositorio e removendo a pasta a força
rm -rf repository
mkdir repository
echo
else
echo criada a pasta repository
echo
# SE NAO SATISFAZ ENTRA AQUI
mkdir /repository
fi

if [ -d app/ ];
then
# SE SATISFAZ ENTRA AQUI
rm -rf app
mkdir app
echo Criada a pasta app
echo
else
# SE NAO SATISFAZ ENTRA AQUI
echo criada a pasta app
echo
mkdir app
fi
echo iniciando o conteudo do .sh
echo

echo baixando e instalando pasta
echo
cd repository
git clone https://github.com/kelvin-alef/react-app.git
cd react-app
npm install
sudo apt install xsel 

echo compilando
echo

npm run build
	
#deployando
echo iniciando deploy
echo

#parando o react para evitar erros e removendo o antigo da pasta app
systemctl stop react-app
rm -rf /app/react-app

#movendo a build do repositorio para pasta app
mv /repository/react-app/build /app/react-app
systemctl start react-app
systemctl status react-app

#encerra aqui o shell
