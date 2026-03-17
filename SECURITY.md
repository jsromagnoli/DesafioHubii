 Segurança do Projeto

 Gerenciamento de Segredos em Produção

Em produção, segredos nunca devem ser armazenados em arquivos ou código-fonte.
As abordagens recomendadas são:

Kubernetes Secrets: armazenar credenciais como objetos Secret no cluster, injetados como variáveis de ambiente nos containers
AWS Secrets Manager ou HashiCorp Vault: solução dedicada para gerenciar, rotacionar e auditar segredos automaticamente
External Secrets Operator: integra o Kubernetes com cofres externos, sincronizando segredos sem expô-los no repositório

Como Evitar Exposição de Credenciais

Nunca commitar arquivos .env com valores reais no repositório
Sempre adicionar .env ao .gitignore
Utilizar .env.example com valores fictícios como referência
Configurar ferramentas como GitGuardian ou git-secrets para bloquear commits com credenciais acidentais
Em pipelines CI/CD, usar GitHub Actions Secrets para armazenar tokens e chaves de acesso

Segurança da Imagem Docker

Usar imagem base oficial e mínima python:3.11-slim
Nunca rodar o container como usuário root usar USER appuser
Manter pacotes do sistema atualizados com apt-get upgrade`
Atualizar pip, setuptools e wheel para versões sem CVEs conhecidos
Executar scan de vulnerabilidades com Trivy a cada build no pipeline
Em produção, considerar imagens distroless para reduzir superfície de ataque

Boas Práticas de Acesso em Ambientes Cloud

Aplicar o princípio do menor privilégio: cada serviço deve ter apenas as permissões estritamente necessárias
Nunca usar credenciais de root ou administrador em workloads
Usar IAM Roles com credenciais temporárias em vez de access keys permanentes
Habilitar MFA para todos os usuários com acesso ao console AWS
Ativar CloudTrail para auditoria de todas as ações na conta
Revisar e rotacionar credenciais periodicamente