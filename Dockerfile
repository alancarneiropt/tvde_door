# Dockerfile para TVDE Door - Site Estático
FROM nginx:alpine

# Copiar arquivos estáticos
COPY . /usr/share/nginx/html/

# Copiar configuração do nginx
COPY nginx.conf /etc/nginx/nginx.conf

# Expor porta 8006 (porta correta do Easy Panel)
EXPOSE 8006

# Comando para iniciar nginx
CMD ["nginx", "-g", "daemon off;"]
