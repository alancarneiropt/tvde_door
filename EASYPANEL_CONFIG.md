# 🔧 CONFIGURAÇÃO EASY PANEL - TVDE DOOR

## 📋 Configurações de Porta

### **Porta Principal: 8006**
- ✅ Dockerfile configurado para EXPOSE 8006
- ✅ nginx.conf configurado para listen 8006
- ✅ Easy Panel mapeia automaticamente para 8006

### **Configurações do Easy Panel:**

#### 1. **Variáveis de Ambiente**
```bash
PORT=8006
GUNICORN_BIND=0.0.0.0:8006
GUNICORN_WORKERS=1
GUNICORN_TIMEOUT=60
```

#### 2. **Configurações de Rede**
- **Porta Externa**: 8006
- **Porta Interna**: 8006
- **Protocolo**: HTTP/HTTPS
- **Domínio**: tvdedoor.fixdados.store

#### 3. **Configurações de SSL**
- ✅ HTTPS habilitado
- ✅ Certificado automático
- ✅ Redirecionamento HTTP → HTTPS

## 🐳 Configurações Docker

### **Dockerfile Principal (nginx)**
```dockerfile
FROM nginx:alpine
EXPOSE 8006
CMD ["nginx", "-g", "daemon off;"]
```

### **Dockerfile Alternativo (Gunicorn)**
```dockerfile
FROM python:3.11-alpine
EXPOSE 8006
CMD ["gunicorn", "--bind", "0.0.0.0:8006", ...]
```

## 🔧 Configurações nginx

### **nginx.conf**
```nginx
server {
    listen 8006;
    server_name localhost;
    root /usr/share/nginx/html;
    index index.html;
    # ... outras configurações
}
```

## 🚀 Deploy Automático

### **Easy Panel faz automaticamente:**
1. ✅ Build da imagem Docker
2. ✅ Mapeamento de porta 8006
3. ✅ Configuração de SSL
4. ✅ Configuração de DNS
5. ✅ Inicialização do container

### **URLs de Acesso:**
- **HTTP**: http://tvdedoor.fixdados.store:8006
- **HTTPS**: https://tvdedoor.fixdados.store:8006
- **Monitor**: https://tvdedoor.fixdados.store:8006/monitor.html
- **Teste**: https://tvdedoor.fixdados.store:8006/test.html

## 🔍 Verificações Pós-Deploy

### **1. Status do Container**
```bash
docker ps | grep tvde_door
# Deve mostrar porta 8006 mapeada
```

### **2. Teste de Conectividade**
```bash
curl -I http://localhost:8006
# Deve retornar HTTP 200
```

### **3. Teste de SSL**
```bash
curl -I https://tvdedoor.fixdados.store:8006
# Deve retornar HTTP 200 com SSL
```

## 🛠️ Troubleshooting

### **Problema: Porta não acessível**
- ✅ Verificar se container está rodando
- ✅ Verificar mapeamento de porta no Easy Panel
- ✅ Verificar firewall do servidor

### **Problema: SSL não funciona**
- ✅ Verificar certificado SSL
- ✅ Verificar configuração HTTPS
- ✅ Verificar DNS do DuckDNS

### **Problema: Site não carrega**
- ✅ Verificar logs do container
- ✅ Verificar configuração nginx
- ✅ Verificar arquivos estáticos

---
✅ **Configuração completa para porta 8006!**
