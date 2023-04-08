#!/bin/bash
echo iniciando a verificacao
echo
#checkout
if [ -e  /usr/lib/systemd/system/react-app.service ];
then
echo 1
# SE SATISFAZ ENTRA AQUI
rm -rf primeira_pipeline
else
echo
mkdir /app
# SE NAO SATISFAZ ENTRA AQUI
mv /primeira_pipeline/pipeline-react-app.sh /usr/lib/systemd/system
rm -rf primeira_pipeline
fi


if [ -d /usr/local/lib/node_modules ];
then
echo 1
# SE SATISFAZ ENTRA AQUI
else
echo

mkdir /app
# SE NAO SATISFAZ ENTRA AQUI
curl -sL https://rpm.nodesource.com/setup_16.x | sudo bash -
sudo yum install -y nodejs
sudo npm install -g n
sudo n latest

fi

if [ -d repository/ ];
then
echo 1
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
echo 1
# SE SATISFAZ ENTRA AQUI
else
echo criada a pasta app
echo

mkdir /app
# SE NAO SATISFAZ ENTRA AQUI
fi
echo iniciando o conteudo do .sh
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

