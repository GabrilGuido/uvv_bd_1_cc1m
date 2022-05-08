# Respostas PSET1

## 1)

- Sistema de controle de versão são usados por programadores com o intúito de armazenar e controlar seus projetos e códigos, tendo sua importancia por poder realizar atualizações e ver antigas versões dos códigos.

## 2)

- A diferença entre o Git e o GitHub, é que o GitHub é o site que armazena os códigos fontes enviados pelo software Git, que os envia por meio de comandos pela linha de comando

## 3)

- O significado de um sistema distribuido de controle de versoes é que ele possui varios repositorios autonomos e independentes para cada desenvolvedor. Sendo recomendo para equipes de varios desenvolvedores, por ter a capacidade de cada area de trabalho ter seu proprio servidor, fazendo com que as operacoes sejam feitas direto da propria maquina e podendo comunicar-se entre si.

## 4)

- Um dos erros presentes no projeto entre as tabelas funcionario e departamento, é a falta de uma relacao entre os atributos numero_departamento, que na tabela funcionario é uma foreign key e na tabela departamento é uma primary key. Outro erro é no autorelacionamento da tabela funcionario, onde um funcionário podia ter varios supervisores.

## 5)

- Há sim relacionamento N:N, na tabela trabalha_em, pois um funcionário pode trabalhar em vários projetos e o projeto pode ter vários funcionários.

## 6)

- Para impor tal regra no projeto, basta ir na relação e mudar a Cardinality da FKtable: departamento para "Zero or One". Já no banco de dados foi necessário criar uma chave alternativa na tabela departamentos.

## 7)

- O relacionamento entre as tabelas está simbolizado por uma linha pontilhada por se tratar de uma relação não identificada, que ocorre quando o atributo de chave primária da tabela principal não é a chave primária da outra tabela.

## 8)

- O único tipo de relacionamento onde se é armazenados dados é o relacionamento N:N, que para existir é necessário que haja uma tabela intermediária, que armazena dados, entre a relação de outras duas tabelas.

## 9)

- O auto-relacionamento presente na tabela funcionario pode sim existir, mas no projeto está de uma forma errada, pois está como um relacionamento 1:N e não como N:1, para que o funcionário possa ter apenas um gerente e o gerente possa ser de vários funcionários.

## 10)

- A diferença entre eles, é que o usuário é quem irá usar o banco de dados (seja para consulta, inserção ou criação), já o esquema é onde será armazenado todos os objetos criados a partir do projeto lógico e o banco de dados é o rezultado do conjuntos desse objetos.

## 11)

- O esquema é importante pois ele organiza de forma lógica o banco de dados, como se fosse diferentes arquivos em uma pasta.

## 12)

- Se não for definido um esquema específico para onde irão os objetos do banco de dados, todos eles serão gravados no esquema 'Public', que é ruim, pois caso seja inserido outras tabelas, dados e relacionamentos sobre outras coisas, tudo irá se misturar.

## 13)

- Algumas melhorias que poderiam ser feitas no projeto, são o concerto dos erros na sua estrutura e relacionamentos que causam alguns loopings de erros ao inserir os dados nas tabelas.

## 14)

- As vantagens que o PostgresSQL possui, está na capacidade que ele tem de configuração e restrição na construção do banco de dados, como na hora de criar uma database e usuário, mas ao mesmo tempo tendo isso como uma desvantagem, por deixar seu uso mais difícil. Já o MySQL tem como ponto positivo ter uma fácil usabilidade, mas isso gera a desvantagem de não possuir tantas funcionalidades que o PostgresSQl tem.

## 15)

- Creio que meu desempenho durante o PSet foi bom, pois corri atrás de muitas informações lendo, pesquisando, vendo vídeos e dei meu máximo para o resolver por conta própria.
