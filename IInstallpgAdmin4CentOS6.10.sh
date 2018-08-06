#!/bin/bash
#
# Script: Instala pgAdmin4 no GNU/Linux CentOS 6.5/6.10
# Escrito por: Cesar Nunes
# Email: raynunes@gmail.com
# Data: 01/08/2018
#
clear
#
# Check root
if [ "`whoami`" != "root" ]; then
  echo "É necessário ser root para a instalação"
  echo ""
  echo "Atenção: Logue como usuário root e execute o script novamente"
  echo ""
  exit
fi
#
echo ""
echo "#####################################################################"
echo "#                                                                   #"
echo "#                      Seja Bem-Vindo!!!                            #"
echo "#                    Instalação do pgAdmin4                         #"
echo "#  Projeto IInstallpgAdmin4CentOS6.10 on GNU/Linux CentOS 6.5/6.10  #"
echo "#                                        Versão: 1.0.0              #"
echo "#                                                                   #"
echo "#####################################################################"
echo ""
sleep 2
# Variables
#
localInstalacaoScript="/usr/src/IInstallpgAdmin4CentOS6.10/"
#
localInstalacaoPython27="/usr/src/"
#
nomePacotePython="Python-2.7.10.tgz"
#
nomeDiretorioPython="Python-2.7.10"
#
nomeInstaladorPgAdmin4="pgadmin4-1.5-py2.py3-none-any.whl"
#
localInstalacaopgadmin4="/opt/pgadmin4/"
#
# 1. Copiando Python-2.7.10.tgz
cp Python-2.7.10.tgz $localInstalacaoPython27
#
# 2. Descompactando Python-2.7.10.tgz
tar xzf $localInstalacaoPython27${nomePacotePython}
#
# 3. Compilando
cd $localInstalacaoPython27${nomeDiretorioPython}
#
./configure
#
make altinstall
#
# 4. Checa a versão do Python
python2.7 -V
sleep 5
#
# 5. Instalando repositorio EPEL
yum install epel-release
#
# 6. Instalando pip
yum install python-pip -y
cd $localInstalacaoScript
python2.7 get-pip.py
#
# 7. Instalando virtualenv
pip2.7 install virtualenv
#
# 8. Criando diretório de instalação
mkdir -p /opt/pgadmin4/
#
cd $localInstalacaopgadmin4
#
virtualenv venv -p /usr/bin/python2.7
#
source ./venv/bin/activate
#
cd $localInstalacaoScript
#
cp pgadmin4-1.5-py2.py3-none-any.whl $localInstalacaopgadmin4
#
cd $localInstalacaopgadmin4
#
pip2.7 install $nomeInstaladorPgAdmin4
#
cp ./venv/lib/python2.7/site-packages/pgadmin4/config.py ./venv/lib/python2.7/site-packages/pgadmin4/config_local.py
#
echo "Instruções para Configuração do Arquivo config_local.py"
echo ""
echo "Local do Arquivo (config_local): ./venv/lib/python2.7/site-packages/pgadmin4/config_local.py"
echo ""
echo "Edite os seguintes parâmetros: "
echo ""
echo "SERVER_MODE = True | Altere para: False"
echo ""
echo "DEFAULT_SERVER = 'localhost' | Altere para: 0.0.0.0"
echo ""
echo "Em produção altere para a rede de acordo com a segurança"
echo ""
echo "Executando o pgadmin4 execute o comando abaixo:"
echo ""
echo "python2.7 ./venv/lib/python2.7/site-packages/pgadmin4/pgAdmin4.py"
#
# Atualizações
# 06/08/2018 - Homologado na Distribuição CentOS 6.5
