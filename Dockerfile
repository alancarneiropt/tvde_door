# Dockerfile para TVDE Door - Site Estático
FROM nginx:alpine

# Copiar arquivos estáticos
COPY . /usr/share/nginx/html/

# Copiar configuração do nginx
COPY nginx.conf /etc/nginx/nginx.conf

# Expor porta 8000 (Easy Panel mapeia para 8006)
EXPOSE 8000

# Comando para iniciar nginx
CMD ["nginx", "-g", "daemon off;"]
