# 🚀 DEPLOY TVDE DOOR - FIXDADOS SOLUTIONS

## 📋 Informações do Deploy
- **Domínio**: tvdedoor.fixdados.store
- **Porta**: 8006
- **Servidor**: Easy Panel + DuckDNS
- **Tipo**: Site estático (HTML/CSS/JS)

## 📁 Estrutura de Arquivos para Upload

```
/
├── index.html              # Página principal
├── index-pwa.html         # Versão PWA (opcional)
├── manifest.json          # Manifest PWA
├── sw.js                  # Service Worker
├── favicon.ico            # Ícone do site
├── ads.json              # Configurações de anúncios
├── .htaccess             # Configurações do servidor
└── Imagem/               # Pasta com imagens
    ├── empresa_estetica.png
    ├── academia.png
    └── img1.png
```

## 🔧 Configurações no Easy Panel

### 1. Criar Site
- **Nome**: TVDE Door
- **Domínio**: tvdedoor.fixdados.store
- **Porta**: 8006
- **Tipo**: Site estático

### 2. Configurações de SSL
- ✅ Habilitar HTTPS (obrigatório para PWA)
- ✅ Certificado SSL automático

### 3. Configurações de Cache
- ✅ Habilitar cache estático
- ✅ Cache de imagens: 1 mês
- ✅ Cache de CSS/JS: 1 semana
- ✅ Cache de HTML: 1 hora

## 📤 Passos para Deploy

### 1. Upload dos Arquivos
```bash
# Via FTP/SFTP ou interface web do Easy Panel
# Upload todos os arquivos para a pasta raiz do site
```

### 2. Verificar Permissões
```bash
# Garantir que os arquivos tenham permissões corretas
chmod 644 *.html *.json *.js *.ico
chmod 755 Imagem/
chmod 644 Imagem/*
```

### 3. Testar Funcionamento
- [ ] Acessar: https://tvdedoor.fixdados.store:8006
- [ ] Verificar se carrega sem erros
- [ ] Testar PWA (instalar no dispositivo)
- [ ] Verificar se as imagens carregam
- [ ] Testar loop de anúncios

## 🔍 Verificações Pós-Deploy

### 1. Console do Navegador
- Abrir DevTools (F12)
- Verificar se não há erros no console
- Verificar se Service Worker está ativo

### 2. Teste PWA
- Verificar se aparece opção "Instalar app"
- Testar funcionamento offline
- Verificar se cache está funcionando

### 3. Teste de Performance
- Verificar velocidade de carregamento
- Testar em diferentes dispositivos
- Verificar responsividade

## 🐛 Troubleshooting

### Problema: Site não carrega
- ✅ Verificar se porta 8006 está aberta
- ✅ Verificar configuração DNS do DuckDNS
- ✅ Verificar certificado SSL

### Problema: PWA não funciona
- ✅ Verificar se HTTPS está ativo
- ✅ Verificar se manifest.json está acessível
- ✅ Verificar se sw.js está na raiz

### Problema: Imagens não carregam
- ✅ Verificar caminhos das imagens
- ✅ Verificar permissões da pasta Imagem/
- ✅ Verificar se arquivos existem

## 📱 Teste em Dispositivos

### Desktop
- Chrome/Edge/Firefox
- Teste fullscreen (F11)
- Teste controles (play/pause/mute)

### Mobile
- Android Chrome
- iOS Safari
- Teste orientação landscape
- Teste instalação PWA

## 🔄 Atualizações Futuras

### Para atualizar o site:
1. Fazer alterações localmente
2. Commit no Git Desktop
3. Upload dos arquivos modificados
4. Service Worker atualizará automaticamente

### Para adicionar novas imagens:
1. Adicionar na pasta Imagem/
2. Atualizar index.html
3. Atualizar sw.js (cache)
4. Upload dos arquivos

## 📞 Suporte
- **Desenvolvedor**: Fixdados Solutions
- **Domínio**: tvdedoor.fixdados.store
- **Versão**: v1.0

---
✅ **Deploy preparado e pronto para produção!**
