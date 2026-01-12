📌 Auto Commit por Evento – Monitoramento de Scripts
🎯 Objetivo

Este projeto demonstra uma automação que realiza commit e push automaticamente no GitHub sempre que um novo arquivo .script é criado na pasta Scripts.

O processo não depende de ação manual do usuário e utiliza autenticação SSH, permitindo execução contínua e silenciosa.

🧠 Como a solução funciona (visão geral)

Um script PowerShell monitora a pasta Scripts

Quando um novo arquivo .script é criado, o evento é capturado

O Git executa automaticamente:

git add

git commit

git push

O Agendador de Tarefas do Windows é usado apenas para iniciar o monitor automaticamente

⚠️ O commit não é por horário, e sim por evento de criação de arquivo.

📁 Estrutura do Projeto
C:\qa-auto-commit-evento\
├── Scripts\
│   └── exemplo.script
├── watcher.ps1
├── README.md
└── .git\

🔐 Pré-requisitos

Antes de utilizar a automação, é obrigatório:

Git instalado

Repositório GitHub configurado

Autenticação via SSH (HTTPS não é suportado)

PowerShell habilitado

Verifique o SSH com:

ssh -T git@github.com

🔗 Configuração do Repositório Git

Dentro da pasta do projeto:

git init
git branch -M main
git remote add origin git@github.com:SEU-USUARIO/qa-auto-commit-evento.git
git push -u origin main


Confirme:

git remote -v

⚙️ Script de Monitoramento (watcher.ps1)

O arquivo watcher.ps1 é responsável por monitorar a pasta Scripts e executar o commit automático quando um novo arquivo surgir.

O script utiliza FileSystemWatcher, recurso nativo do Windows.

▶️ Execução Manual (teste inicial)

Abra o PowerShell

Execute:

Set-ExecutionPolicy -Scope CurrentUser RemoteSigned


Inicie o monitor:

cd C:\qa-auto-commit-evento
.\watcher.ps1


⚠️ O PowerShell precisa permanecer aberto para o monitor funcionar.

⏰ Execução Automática (Agendador de Tarefas)

Para evitar execução manual, configure o Agendador de Tarefas do Windows.

Configuração recomendada:

Programa/script:

powershell.exe


Argumentos:

-ExecutionPolicy Bypass -File "C:\qa-auto-commit-evento\watcher.ps1"


Iniciar em:

C:\qa-auto-commit-evento


Trigger sugerido:

At log on ou

At startup

✅ Como testar a automação

Inicie o watcher (manual ou via agendador)

Vá até:

C:\qa-auto-commit-evento\Scripts


Crie um arquivo:

novo-script.script


Salve o arquivo

Resultado esperado:

Commit automático criado

Push enviado ao GitHub

Arquivo visível no repositório

⚠️ Observações Importantes

Apenas novos arquivos disparam o commit

Alterações em arquivos existentes não disparam o evento

O watcher deve estar ativo (PowerShell ou Agendador)

Em ambientes produtivos, este modelo pode ser convertido em serviço do Windows

📊 Comparação com a versão por horário
Versão	Disparo do Commit	Tecnologia
Horário	Agendador	Batch (.bat)
Evento	Criação de arquivo	PowerShell
✅ Conclusão

Este projeto demonstra uma automação baseada em evento, ideal para cenários onde scripts precisam ser versionados imediatamente após criação, garantindo rastreabilidade, histórico confiável e zero dependência de ações humanas.