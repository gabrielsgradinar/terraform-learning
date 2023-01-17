# Terraform

- Permite construir, gerenciar e destruir a infraestrutura em poucos minutos
- Umas das grandes vantagens é poder fazer o deploy em diferentes plataformas (clouds públicas e privadas)
- Arquivos de configuração com a extensão `.tf` e usa a liguagem declarativa `HCL`


## Resource

- Um objeto que o Terraform gerencia
    - pode ser um arquivo local ou uma maquina virtual no cloud ou outros serviços


## Providers

- Diferentes providers são distribuídos pela Hashi Corp e são publicamente disponibilizados no Terraform Registry ( `registry.terraform.io` )

- Official Providers
    - São mantidos pela prórpia Hash Corp (GCP, AWS, Azure)

- Verified Providers
    - Mantidos por empresas terceiras e parceiras da Hashi Corp (Heroku, DigitalOcean)

- Community Providers
    - Mantidos por contribuidos individuais da comunidade

- `terraform init` -> Faz o download e instala plug-ins para os providers usaram com as configurações


## Terraform State

- `terraform.tfstate`
    - Criado após o uso do `terraform  apply` pela primeira vez
    - É um arquivo JSON que mapeia a infraestrutura real criada com oque foi definico no arquivo de configuração
    - É usado como fonte da verdade quando executamos `plan` ou `apply`

## Commands

- `validate`
    - valida a sintax HCL do arquivo de configuração

- `fmt` (format)
    - formata o arquivo de configuração

- `show`
    - mostra o estado atual da infraestrutura

## Datasources

- Permitem que o terraform leia atributos de outros recursos que foram provisionados fora do seu controle.

