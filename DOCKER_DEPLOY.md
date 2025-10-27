# 🐳 DEPLOY DOCKER - TVDE DOOR

## 📋 Arquivos Docker Criados

### 1. Dockerfile
- Base: nginx:alpine (leve e eficiente)
- Porta: 8000 (Easy Panel mapeia para 8006)
- Serve arquivos estáticos via nginx

### 2. nginx.conf
- Configuração otimizada para site estático
- Compressão gzip habilitada
- Cache configurado para diferentes tipos de arquivo
- Headers de segurança
- Suporte completo a PWA

### 3. .dockerignore
- Otimiza build excluindo arquivos desnecessários
- Reduz tamanho da imagem Docker

## 🚀 Como Funciona o Deploy

1. **Easy Panel** baixa o código do GitHub
2. **Docker** executa o build usando o Dockerfile
3. **nginx** serve os arquivos estáticos na porta 8000
4. **Easy Panel** mapeia porta 8000 → 8006
5. **HTTPS** é gerenciado automaticamente pelo Easy Panel

## ✅ Vantagens desta Configuração

- ✅ **Performance**: nginx é mais rápido que Apache
- ✅ **Cache**: Configuração otimizada de cache
- ✅ **Compressão**: gzip automático
- ✅ **Segurança**: Headers de segurança configurados
- ✅ **PWA**: Suporte completo a Progressive Web App
- ✅ **Escalabilidade**: Fácil de escalar horizontalmente

## 🔧 Configurações Automáticas

O Easy Panel já configurou automaticamente:
- **Porta**: 8006 (mapeada internamente para 8000)
- **Domínio**: tvdedoor.fixdados.store
- **HTTPS**: Certificado SSL automático
- **Variáveis de ambiente**: Todas configuradas

## 📱 Teste Pós-Deploy

Após o deploy, teste:
1. **URL**: https://tvdedoor.fixdados.store:8006
2. **PWA**: Instalar no dispositivo
3. **Performance**: Verificar velocidade
4. **Cache**: Testar funcionamento offline

---
✅ **Deploy Docker configurado e pronto!**
