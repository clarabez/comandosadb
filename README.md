
<div align="center">
<img src="/images/ADB_inicial.png">

<b>⭐️ 🌟 Se este tutorial te ajudou, não esquece de deixar uma estrelinha ⭐️ 🌟</b>
</div>

Este material é um guia básico para inicializar pessoas em testes para dispositivos móveis na plataforma Android, apresentando recursos super úteis e algumas dicas, como:
- Comandos ADB; 
- Modo _fastboot_;
- _bootloader_;
- Automação de algumas ações com shell script;
- Modo _recovery_;
- Modo _downloading_;
- O que é um chipset?

Aqui neste material **não** temos como objetivo falar de _frameworks_ de automação nem de desenvolvimento de aplicações para dispositivos móveis. Também não utilizo linguagens nativas como _Kotlin_ ou _Java_. Também não apresentamos conteúdo para a plataforma _iOS_, apenas para _Android_.

___

🗂 **Organização do material:** 🗂 

- Introdução
- O que são comandos ADB?
- Por que importam?
- Como instalar e configurar?
- Primeiros passos com comandos ADB
- Como utilizá-los em minhas atividades de rotina?
- Alguns dos meus comandos ADB favoritos
- KeyEvent - adicionando eventos
- Como posso automatizar estes comandos?
- Vamos _debugar_? Algumas maneiras de capturar e analisar _logs_;
- O que é o _fastboot_?
- O que é o _bootloader_?
- O que é o modo _recovery_?
- O que é o modo _downloading_?
- O que é um _chipset_?

___

# Introdução

Neste tutorial pretendo trazer um pouco do que são comandos ADB e mostrar como podemos tirar melhor proveito deles quando trabalhamos com mobile; mostrar que é possível realizar a automação de algumas atividades rotineiras de quem trabalha com mobile, como: adicionar uma conta de email de teste, inserir a senha da rede de teste, habilitar/desabilitar o modo avião, dentre outros.
Também pretendo falar um pouco de alguns modos que podemos acionar no nosso celular, como o modo `fastboot` (para dispositivos Motorola) e o modo `odin` (para dispositivos Samsung).

___

# O que são comandos ADB?

ADB é uma abreviação de: _Android Debug Bridge_. Através de comandos ADB podemos, de forma bastante rápida, estabelecer uma comunicação direta entre o terminal do nosso computador e nosso dispositivo Android, de forma muito prática, realizando ações como:
- Instalar/desinstalar aplicativos;
- Mudar configurações internas, como: tempo de desligar tela, bloqueio/desbloqueio de tela, etc.
- Habilitar/desabilitar funções de conexões, como: wifi, dados, BT, modo avião.
- Transferência/manipulação de arquivos;
- Reiniciar e desligar o dispositivo - não funciona para ligá-lo (mas isso pode ser resolvido através de frameworks);
- Capturar diversos tipos de logs das atividades do dispositivo.
- Consultar de forma rápida toda e qualquer informação de configuração do dispositivo.

Sobre a estrutura do ADB, ele é um programa cliente-servidor baseado em três componentes:

**Cliente:** é a partir de onde vamos usar os nosso comandos, ou seja, o computador que estamos usando para interagir com o dispositivo.

**Daemon:** responsável por executar os comandos enviados pelo cliente.

**Servidor:** responsável por gerenciar a comunicação entre as partes cliente e daemon.


📌 **Links importantes para esta seção:** 📌
[Mais sobre comandos ADB na página oficial do Android - em português](https://developer.android.com/studio/command-line/adb?hl=pt-br)

___

# Por que importam?

Trabalhar com comandos ADB pode nos poupar bastante tempo em fazer operações quaisquer no aparelho, uma vez que não precisamos interagir com ele visualmente, como, por exemplo, percorrer várias telas e dar vários cliques para adicionarmos uma conta google de testes. Para isto, é possível chamarmos via comando a opção de wifi, darmos um clique na rede desejada e em seguida chamar uma função via terminal que já tenha a senha da nossa rede de teste armazenada. Esta é uma maneira de automatizar atividades massantes da nossa rotina.
Outra razão de darmos importância aos comandos ADB é que esta é uma maneira oficial do Android de realizarmos contato direto com o dispositivo via terminal e de utilizarmos recursos válidos para a atividade de testes, como captura e análise de logs, identificação das informações do dispositivo (facilita descrição de cenários) e facilidade em controlar recursos do dispositivo em teste. Comandos ADB é um grande aliado quando se trabalha com mobile.

___

# Como instalar e configurar?

ADB é um recurso nativo do pacote **Android SDK Platform-tools**, essencial para quem quer desenvolver qualquer coisa para Android, seja aplicações ou atividades para testes. Para realizar o download apenas deste recurso, siga o [conteúdo desta página](https://developer.android.com/studio/releases/platform-tools) para baixar o material de acordo com o seu sistema operacional e, em seguida, um popup vai abrir para que você leia os termos, aceite, e inicie o download.
Caso você utilize o Android Studio, você pode baixar este recurso através do SDK manager, como orientado aqui na [página oficial do Android](https://developer.android.com/studio/intro/update#sdk-manager).
Independente de como você baixou o recurso, você deve adicionar o path (caminho) de onde o SDK está baixado na sua variável de ambiente. Aqui[INSERIR] temos uma seção explicando como configurar suas variáveis de ambiente.

📌 **Links importantes para esta seção:** 📌

[Página Oficial do Android](https://developer.android.com/studio/releases/platform-tools)

___

# Primeiros passos com comandos ADB

Depois de ter instalado e configurado o ADB em seu computador, agora abra um terminal e insira o seguinte comando:

```bash
adb devices
```

Observe que o serviço ADB vai ser iniciado, como na imagem a seguir:

<div align="center">
<img src="/images/adb_start.png">
</div>

O comando `adb devices` serve para listar os dispositivos Android que estão conectados em seu computador. Como não tenho nenhum dispositivo conectado no momento em que executei o comando, nada foi retornado, apenas o serviço ADB foi iniciado.
Caso você queira finalizar o serviço (eu nunca precisei fazer isto, ele não compete com nenhum outro serviço que uso em minhas atividades de rotina, mas pode ser que você precise em algum momento), é só utilizar o comando:

```bash
adb kill-server
```

___

# Como utilizá-los em minhas atividades de rotina?

Cada rotina vai ter diferentes atividades e finalidades de uso. A minha rotina, por exemplo, normalmente é iniciada por usar um celular que acabou de ser resetado. Portanto sempre tenho que definir idioma, percorrer as telas de configuração inicial, definir se quero configurar com ou sem wifi, etc. Normalmente deixo para adicionar wifi e email já na tela inicial do celular. Feito isto, eu finalmente me conecto na wifi (sempre uso a mesma) e adiciono alguma conta de email para testes. Aí sim inicio as atividades do teste em si, mas pra isso, sempre faço algumas atividades de forma repetitiva e igual:
- Completar o setup do celular;
- Na tela de início, conectar na wifi (sempre a mesma);
- Adiciono um email de teste;
- Definir o tempo de descanso da tela para o máximo possível.

Só aí já tenho 3 atividades que com facilidade consigo criar um script para me ajudar: adicionar a senha da minha wifi de teste, adicionar o email de teste que utilizo, definir o tempo máximo de tela ativa para que ela apague.

Pronto, estas atividades são relacionadas à minha rotina, que pode ser diferente da sua ou de algum outro colega meu. Mas independente da rotina de qualquer pessoa, se você trabalha com mobile e está sempre precisando manualmente fazer qualquer interação com sua tela, muito provavelmente tem um comando ADB que vai te ajudar a automatizar esta atividade. Assim você ganha um pouco mais de agilidade nas operações, fazendo as atividades com algumas linhas de comando. 

Mas como podemos gerar estes scripts? Os caminhos são muitos, também vai de gosto, mas eu acho bem prático criar funções no arquivo de inicialização do meu sistema operacional. Utilizo MAC, então meu arquivo de configuração inicial fica na raiz do meu sistema e chama-se `bash_profile`. No Linux (qualquer distribuição) o arquivo fica também na pasta raiz e chama-se `bash_rc`. Não remova nada que já exista por lá, pois estes arquivos recebem alguns caminhos para configuração de variáveis de ambiente do seu sistema operacional, portanto evite poluir muito por lá para evitar dores de cabeça :)
Criadas as funções no seu arquivo global, basta chamar as funções diretamente pelo seu terminal. Mais adiante vou mostrar alguns exemplos.

___

# Alguns dos meus comandos ADB favoritos

Existe uma infinidade de comandos ADB disponíveis. A depender da sua rotina de atividades, você utiliza mais alguns comandos que outros. Eu, por exemplo, gosto bastante de utilizar os que facilitam a configuração inicial de um celular, como por exemplo a conexão com wifi (sempre uso a mesma), a inserção da minha conta de teste, a habilitação/desabilitação do modo avião. Portanto, minha lista de rotinas pode ser bem diferente da lista de alguém que trabalha comigo, pois nossas rotinas são diferentes. Dito isto, segue aqui uma lista de comandos que não podem faltar no meu arquivo /.bash_profile:

1. Desbloqueio de Tela:

```bash
adb shell input keyevent 66
```

2. Bloqueio de Tela:

```bash
adb shell input keyevent 26
```

3. Senha de wifi padrão:

```bash
adb shell input text "SenhaDaSuaWifi"
```

4. Entrar com texto:

```bash
adb shell input text "SeuTextoAqui"
```

5. Habilitar modo avião:

```bash
adb shell settings put global airplane_mode_on 1
```

6. Desabilitar modo avião:

```bash
adb shell settings put global airplane_mode_on 0
```

7. Definir o tempo máximo (30 minutos) de descanso de tela:

```bash
adb shell settings put system screen_off_timeout 60000
```

8 - Reiniciar o aparelho:

```bash
adb reboot
```

9 - Obter todas as informações de propriedades do aparelho:

```bash
adb shell getprop
```

10 - Tirar um print da tela do aparelho:

```bash
adb shell screencap /sdcard/NomeDoPrint.png
```
O print vai ficar armazenado dentro do dispositivo, no pasta `sdcard`.

11 - Iniciar a gravação da tela (fica gravando até 2 minutos ou até vc matar o processo - ctrl c):

```bash
adb shell screenrecord /sdcard/NomeDoVideo.mp4
```

O vídeo vai ficar armazenado dentro do dispositivo, no pasta `sdcard`.

12 - Pegar conteúdo (foto, música, vídeo, etc) do dispositivo:

```bash
adb pull /sdcard/NomeDoPrint.png
```

13 - Transferir conteúdo (foto, música, vídeo, etc) para o dispositivo:

```bash
adb push /CaminhoDaPasta/NomeDoPrint.png
```

14 - Instalar um apk (pacote de um aplicativo) no dispositivo:

```bash
adb install -r NomeDoApk.apk
```

O uso de `-r` indica que, caso já existe um aplicativo com este nome, o comando irá substituir o já existente (vem de _replace_).

15 - Desinstalar um aplicativo:

```bash
adb uninstall com.nome.do.pacote
```

16 - Listar todos os pacotes de todas as aplicações do seu dispositivo:

```bash
adb shell pm list package
```

17 - Checar o caminho até o pacote desejado:

```bash
adb shell pm path com.nome.do.pacote
```

___

# KeyEvent - adicionando eventos

Um outro recurso muito legal que podemos utilizar através do ADB é o uso dos _KeyEvents_ (ou _KeyCodes_), que são funcionalidades que processam algumas ações de teclado físico/lógico (um número, letra, pressionar o botão de ligar/desligar, etc) ou habilitam/desabilitam uma funcionalidade específica do dispositivo (finalizar uma chamada, por exemplo) - tudo isso sem necessidade de interação direta com a tela do celular.
A seguinte estrutura é utilizada para o envio de um _KeyEvent_:

```bash
adb shell input [text|keyevent]
```

Ou seja, podemos passar tanto o valor inteiro (o código) ou uma string equivalente ao código. Para valor inteiro:

```bash
adb shell input keyevent <event_code>
```

Para passar string:

```bash
adb shell input text <string>
```

Lista de alguns eventos super úteis:

Pressionar Enter:

```bash
adb shell input keyevent 66
```

Simular clique na seta pra cima:

```bash
adb shell input keyevent 19
```

Simular clique na seta pra baixo:

```bash
adb shell input keyevent 20
```

Simular clique na seta para lado esquerdo:

```bash
adb shell input keyevent 21
```

Simular clique na seta para lado direito:

```bash
adb shell input keyevent 22
```

Simular clique em posição X (200) e Y (500):

```bash
adb shell input tap 200 500
```

Simular gesto na tela em posição X (500), Y (1600), Z (540), W (100):

```bash
adb shell input swipe 500 1600 540 100
```

Chamar a aplicação da câmera:

```bash
adb shell input keyevent 26
```

📌 **Links importantes para esta seção:** 📌

[Lista dos KeyEvents - Android](https://developer.android.com/reference/android/view/KeyEvent#KEYCODE_CAMERA)

___

# Como posso automatizar estes comandos?

Estes comandos são bem úteis pra gente realizar ações de forma mais rápida na nossa rotina, então algo que ajuda muito é configurar nosso arquivo de inicialização do sistema operacional implementando algumas funções destas ações. Também podemos utilizar estes recursos para criar alguma biblioteca em um ambiente de automação, afinal temos bibliotecas de comandos ADB para basicamente todas as linguagens :)

___

# Vamos _debugar_? Algumas maneiras de capturar e analisar _logs_:

Quem trabalha com testes tem que saber coletar logs e também analisá-los :) isso é essencial para entendimento do que você está realizando, como seu celular está se comportando (até pra entender se realmente é um bug ou se é uma interferência de ambiente), e para prover insumos para que o time de desenvolvimento possa analisar e identificar o que possivelmente está causando um bug no que está sendo testado. O Android oferece alguns recursos muitos legais para que você possa gerar logs. Vamos aprender um pouco sobre _bugreport_ e _logcat_.
Antes disso, vamos aprender como habilitar o modo _debugging_ em nosso dispositivo Android, através da opção de desenvolvimento. Para entender um pouco mais sobre os recursos disponíveis em modo de desenvolvimento do Android, [consulte esta página oficial da plataforma.](https://developer.android.com/studio/debug/dev-options)

Primeiro, vamos lá em Configurações (_Settings_):

<div align="center">
<img src="/images/menu.png">
</div>

Em seguida, vá até o final da tela e clique em Sobre (_About_):

<div align="center">
<img src="/images/menu_about.png">
</div>

Em seguida, vá até o final da página novamente e clique 7x seguidas no campo de **Número da versão** (_build number_):

<div align="center">
<img src="/images/menu_build_number.png">
</div>

Com isso, habilitamos as opções de desenvolvimento em nosso disposito :) a opção aparece em:

<div align="center">
<img src="/images/menu_system_advanced.png">
</div>

É só clicar nesta opção e observar que vários recursos que podem facilitar o uso do dispositivo aparecem. Vamos habilitar a opção de **Depuração USB** (_USB Debugging_):

<div align="center">
<img src="/images/menu_developer_opt.png">
</div>

Pronto, desta maneira a gente consegue estabelecer a comunicação USB entre nosso dispositivo e o nosso computador, e agora podemos capturar logs. Vamos voltar aos tipos de log para Android.

- **Logcat:** é uma ferramenta de análise via linha de comando, sendo possível visualizar todos os registros de mensagens do sistema. O _logcat_ vai exibindo tudo na tela e vai gerando conteúdo a partir do momento que você acionou o comando e não vai parar até que você finalize o processo (ctrl c).

Para gerar um _logcat_:

```bash
adb logcat
```

Para gerar um _logcat_ indicando o nome do arquivo desejado:

```bash
adb bugreport > NomeDoArquivo.txt
```

Para gerar um _logcat_ filtrando a expressão desejada:

```bash
adb bugreport | grep -i NomeDaExpressão
```

- **Bugreport:** através deste tipo de log é possível emitir um relatório contendo as informações do seu dispositivo e várias informações de diagnósticos para localização e entendimento de possíveis bugs. Com este recurso, o relatório vai gerar tudo que aconteceu em seu dispositivo até o momento que você acionou o comando. A geração dura poucos minutos e a operação é finalizada sozinha.

Para gerar um _bugreport_:

```bash
adb bugreport
```

Para gerar um _bugreport_ indicando o nome do arquivo desejado:

```bash
adb bugreport > NomeDoArquivo.txt
```

Com estas ferramentas (_logcat_ e _bugreport_) é possível analisar o que está acontecendo com o seu dispositivo em tempo de execução, facilitando a análise de bugs, cenários e comportamentos de serviços.

📌 **Links importantes para esta seção:** 📌
[Logcat - Android](https://developer.android.com/studio/command-line/logcat?hl=pt-br)
[Bugreport - Android](https://developer.android.com/studio/debug/bug-report)
[Configurar opções do desenvolvedor no dispositivo - Android](https://developer.android.com/studio/debug/dev-options)

___

# O que é o _fastboot_?

_Fastboot_ é um mecanismo de comunicação para quando seu aparelho está em _bootloader_ e conectado via USB em um computador - ou até na rede. É uma ferramenta que também vem junto do Android SDK, que falamos mais acima. Tudo o que você aplicar em modo fastboot, será aplicado antes da camada do sistema operacional, ou seja, é uma maneira de você fazer escritas diretamente no dispositivo, mesmo que ele não tenha nenhuma imagem do Android instalada.
Em modo _fastboot_, não é possível utilizar comandos ADB, pois cada um funciona em seu nível. Aqui segue alguns comandos _fastboot_ que considero bem úteis:

Listar dispositivos conectados em _fastboot_:

```bash
fastboot devices
```

Reiniciar um dispositivo que esteja em modo _fastboot_:

```bash
fastboot reboot
```

📌 **Links importantes para esta seção:** 📌
[Sobre fastboot - Página oficial do Android](https://android.googlesource.com/platform/system/core/+/master/fastboot/#fastboot)

___

# O que é _bootloader_?

É um software que possibilita a inicialização do sistema operacional de dispositivos como computadores, celulares e alguns outros equipamentos. É através do _bootloader_ que o sistema operacional é carregado.

<div align="center">
<img src="/images/bootloader_mode.png">
</div>

___

# O que é o modo _recovery_?

🚧 🚧 Atenção: 🚧 🚧 
Em modo _recovery_ é possível apagar partições do seu dispositivo, portanto tenha cuidado com as opções que você pode acionar aqui, tenha certeza antes de clicar em qualquer funcionalidade, pois você pode apagar tudo do seu celular.
O _recovery_ é um modo à parte do sistema operacional, funcionando em numa partição isolada, ou seja, é possível entrar em modo recovery mesmo que a imagem do seu sistema operacional esteja quebrada, ajudando bastante em situações que você precise reparar algo lógico do seu celular. Em resumo, podemos realizar as seguintes funções a partir do modo _recovery_:

- Reiniciar o dispositivo;
- Aplicar atualizar do sistema (é necessário o arquivo da atualização);
- Apagar todas as configurações e informações do celular;
- Backups e restaurações;
- Desligar o dispositivo.

Para acessar o modo recovery via comando:

```bash
adb reboot recovery
```

Também podemos acessar este modo utilizando a seguinte combinação dos botões físicos do dispositivo:

`Segurar os botões: Botão ligar + Baixar volume`

Esta é a carinha do modo _Recovery_:

<div align="center">
<img src="/images/recovery_mode.png">
</div>

___

# O que é o modo _downloading_?

Este é um modo para dispositivos Samsung onde, por exemplo, é possível utilizar a ferramenta [Odin](https://samsungodin.com/) para atualizar versões de _software_ do seu dispositivo. Os outros recursos do modo _download_ são bem similares aos explicados no modo _recovery_.

<div align="center">
<img src="/images/odin_mode.png">
</div>

📌 **Links importantes para esta seção:** 📌
[Bootloader - Visão Geral - Android](https://source.android.com/devices/bootloader)
[Samsung Odin - Download](https://samsungodin.com/)

___

# O que é um _chipset_?

Temos vários fabricantes produzindo aparelhos que utilizam o Android como plataforma: Motorola, Samsung, LG, Positivo, Xiaomi, dentre vários outros no mundo todo. O que conhecemos como fabricantes hoje estão mais para montadoras, pois compram os componentes de hardware para montar seus aparelhos inserindo suas tecnologias e customizações da plataforma Android.
Daí entra o `chipset`. De forma análoga, o `chipset` está para um celular como a placa mãe está para um computador. Ele é o responsável por controlar e gerenciar todos os componentes que formam o seu celular e que precisam de um hardware para isso: wifi, Bluetooth, NFC, sensores, áudio, etc. Temos várias opções de chipset no mercado, quanto mais robusto o chipset, mais caro o aparelho no mercado. Como fabricantes, temos: Qualcomm, Mediatek, Samsung, dentre outros. Se você estiver realizando atividades mais baixo nível, será necessário utilizar ferramentas específicas de cada chipset para realizar alguma atividade, como por exemplo, reescrever configurações de fábrica em um aparelho. Algumas dessas ferramentas você pode encontrar na página de cada um dos fabricantes, mas, a depender da sua necessidade, será necessário comprar uma licença para realizar ações mais específicas. Repetindo: isso é caso de quando estamos trabalhando num nível bem mais baixo.
