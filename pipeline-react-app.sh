sudo su-

#mostrando o conteudo do repositorio
ls -lhtr /repository/

vim pipeline-react-app.sh
#Iniciando o shell
	#!/bin/bash
	echo iniciando a verificacao
	echo
	if [ -d repository/ ];
then
echo 1
# SE SATISFAZ ENTRA AQUI
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

#checkout
echo entrando no repositorio e removendo a pasta a força
echo
cd /repository
rm -rf react-app

echo baixando e instalando pasta
echo
git clone https://github.com/kelvin-alef/react-app.git
npm install

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
