## 📱 Tech Master Flutter

Este é um aplicativo mobile desenvolvido em Flutter que consome uma API RESTful para realizar operações de cadastro de usuários. A API utilizada está disponível no repositório Backend_Cadastro.
🔗 API Backend
O backend, responsável pelas funcionalidades do sistema, foi desenvolvido em Node.js e está disponível em:

## 👉 Backend_Cadastro
Funcionalidades disponíveis na API:

Criar usuários
Listar usuários
Atualizar dados
Deletar usuários

## 🚀 Funcionalidades do App

Cadastro de novos usuários
Listagem de usuários cadastrados (exclusivo para perfil Administrador)
Edição e exclusão de usuários existentes (exclusivo para perfil Administrador)
Interface intuitiva e responsiva
Comunicação via requisições HTTP com a API

## 🛠️ Tecnologias Utilizadas
Frontend (Flutter):

Flutter SDK
Dart
HTTP
InternetAddress
Shared Preferences
Provider

Backend:

Spring
MySQL (hospedado na nuvem)

## ⚙️ Como Rodar o Projeto
Pré-requisitos

Flutter SDK instalado
Emulador Android/iOS ou dispositivo físico
API em funcionamento (siga as instruções no repositório da API) ou utilize a API em produção: https://backend-cadastro-prod.onrender.com/swagger-ui/index.html#/

Passos

Clone o projeto:
git clone https://github.com/seu-usuario/flutter-cadastro-app.git
cd flutter-cadastro-app


Instale as dependências:
flutter pub get


Configure a URL da API:No arquivo auth_service.dart, atualize a URL base da API com o IP e porta corretos.
const String baseUrl = 'http://<SEU_IP_LOCAL>:3000'; // ou use a API em produção: https://backend-cadastro-prod.onrender.com


Rode o aplicativo:
flutter run



## 🖼️ Screenshots



## 🤝 Contribuição
Contribuições são bem-vindas! Siga os passos abaixo:
1.ernas2. Crie uma branch para sua funcionalidade:
git checkout -b feature/nova-funcionalidade


Commit suas mudanças:git commit -m "Adiciona nova funcionalidade"


Faça o push para o repositório remoto:git push origin feature/nova-funcionalidade


Abra um Pull Request.

## 📧 Contato
Desenvolvido por Arthur Paraibano. Para dúvidas ou sugestões, abra uma issue ou entre em contato pelo GitHub.
