#Iniciando o shell
#!/bin/bash
sudo su-
cd /
echo iniciando a verificacao
echo
#checkout
systemctl stop react-app
echo =---> entrando no repositorio e removendo a pasta a força <---=
rm -rf /usr/lib/systemd/system/react-app.service
rm -rf repository
rm -rf app
mkdir repository
mkdir app
mkdir app/react-app
mv primeira_pipeline/react-app.service usr/lib/systemd/system
#rm -rf primeira_pipeline

if [ -d /usr/local/lib/node_modules ];
then
# SE SATISFAZ ENTRA AQUI (
echo =—> Node ja instalado <—=
else
echo
# SE NAO SATISFAZ ENTRA AQUI  =—> Instalando o Node <—=
curl -sL https://rpm.nodesource.com/setup_16.x | sudo bash -
yum install -y nodejs
fi
echo baixando e instalando pasta
echo
cd repository
git clone https://github.com/kelvin-alef/react-app.git
cd react-app
npm install -y
sudo yum install -y xsel

echo compilando
echo

npm run build	
#deployando
echo iniciando deploy
echo

#movendo a build do repositorio para pasta app
mv /repository/react-app/build/* /app/react-app

systemctl start react-app
systemctl status react-app
#encerra aqui o shell
