#!/bin/bash
# 🔧 SCRIPT DE TESTE AUTOMATIZADO - TVDE DOOR

echo "🚀 INICIANDO TESTES AUTOMATIZADOS..."
echo "=================================="

# Configurações
DOMAIN="tvdedoor.fixdados.store"
PORT="8006"
BASE_URL="https://${DOMAIN}:${PORT}"

# Cores para output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Função para testar URL
test_url() {
    local url=$1
    local name=$2
    
    echo -n "Testando $name... "
    
    if curl -s -o /dev/null -w "%{http_code}" "$url" | grep -q "200"; then
        echo -e "${GREEN}✅ OK${NC}"
        return 0
    else
        echo -e "${RED}❌ FALHOU${NC}"
        return 1
    fi
}

# Função para testar conteúdo
test_content() {
    local url=$1
    local content=$2
    local name=$3
    
    echo -n "Verificando $name... "
    
    if curl -s "$url" | grep -q "$content"; then
        echo -e "${GREEN}✅ OK${NC}"
        return 0
    else
        echo -e "${RED}❌ FALHOU${NC}"
        return 1
    fi
}

echo "🌐 Testando conectividade básica..."
echo "-----------------------------------"

# Teste 1: Site principal
test_url "$BASE_URL/" "Site Principal"

# Teste 2: Página de teste
test_url "$BASE_URL/test.html" "Página de Teste"

# Teste 3: Monitor
test_url "$BASE_URL/monitor.html" "Monitor de Sistema"

# Teste 4: Manifest
test_url "$BASE_URL/manifest.json" "Manifest PWA"

# Teste 5: Service Worker
test_url "$BASE_URL/sw.js" "Service Worker"

echo ""
echo "📁 Testando arquivos estáticos..."
echo "--------------------------------"

# Teste 6: Imagens
test_url "$BASE_URL/Imagem/empresa_estetica.png" "Imagem Empresa Estética"
test_url "$BASE_URL/Imagem/academia.png" "Imagem Academia"
test_url "$BASE_URL/Imagem/img1.png" "Imagem Informativa"

echo ""
echo "🔍 Testando conteúdo..."
echo "----------------------"

# Teste 7: Conteúdo HTML
test_content "$BASE_URL/" "TVDE Door" "Título da Página"
test_content "$BASE_URL/test.html" "TESTE DE DEBUG" "Página de Teste"

echo ""
echo "📊 Testando performance..."
echo "-------------------------"

# Teste 8: Tempo de resposta
echo -n "Medindo tempo de resposta... "
response_time=$(curl -s -o /dev/null -w "%{time_total}" "$BASE_URL/")
echo -e "${GREEN}${response_time}s${NC}"

# Teste 9: Tamanho da página
echo -n "Verificando tamanho da página... "
page_size=$(curl -s -o /dev/null -w "%{size_download}" "$BASE_URL/")
echo -e "${GREEN}${page_size} bytes${NC}"

echo ""
echo "🔧 Testando funcionalidades..."
echo "-----------------------------"

# Teste 10: HTTPS
echo -n "Verificando HTTPS... "
if curl -s -I "$BASE_URL/" | grep -q "HTTP/2 200"; then
    echo -e "${GREEN}✅ HTTPS OK${NC}"
else
    echo -e "${YELLOW}⚠️ HTTPS pode ter problemas${NC}"
fi

# Teste 11: Headers de segurança
echo -n "Verificando headers de segurança... "
if curl -s -I "$BASE_URL/" | grep -q "X-Frame-Options"; then
    echo -e "${GREEN}✅ Headers OK${NC}"
else
    echo -e "${YELLOW}⚠️ Headers podem estar faltando${NC}"
fi

echo ""
echo "📱 Testando PWA..."
echo "-----------------"

# Teste 12: Manifest válido
echo -n "Verificando manifest JSON... "
if curl -s "$BASE_URL/manifest.json" | jq . > /dev/null 2>&1; then
    echo -e "${GREEN}✅ JSON Válido${NC}"
else
    echo -e "${RED}❌ JSON Inválido${NC}"
fi

echo ""
echo "🎯 RESUMO DOS TESTES"
echo "==================="

# Contar sucessos e falhas
total_tests=12
passed_tests=0

# Executar todos os testes novamente para contar
for test in {1..12}; do
    case $test in
        1) test_url "$BASE_URL/" "Site Principal" && ((passed_tests++)) ;;
        2) test_url "$BASE_URL/test.html" "Página de Teste" && ((passed_tests++)) ;;
        3) test_url "$BASE_URL/monitor.html" "Monitor" && ((passed_tests++)) ;;
        4) test_url "$BASE_URL/manifest.json" "Manifest" && ((passed_tests++)) ;;
        5) test_url "$BASE_URL/sw.js" "Service Worker" && ((passed_tests++)) ;;
        6) test_url "$BASE_URL/Imagem/empresa_estetica.png" "Img1" && ((passed_tests++)) ;;
        7) test_url "$BASE_URL/Imagem/academia.png" "Img2" && ((passed_tests++)) ;;
        8) test_url "$BASE_URL/Imagem/img1.png" "Img3" && ((passed_tests++)) ;;
        9) test_content "$BASE_URL/" "TVDE Door" "Título" && ((passed_tests++)) ;;
        10) test_content "$BASE_URL/test.html" "TESTE" "Teste" && ((passed_tests++)) ;;
        11) curl -s -o /dev/null -w "%{time_total}" "$BASE_URL/" > /dev/null && ((passed_tests++)) ;;
        12) curl -s "$BASE_URL/manifest.json" | jq . > /dev/null 2>&1 && ((passed_tests++)) ;;
    esac
done

echo ""
echo "📊 RESULTADO FINAL:"
echo "=================="
echo -e "Testes executados: ${YELLOW}$total_tests${NC}"
echo -e "Testes aprovados: ${GREEN}$passed_tests${NC}"
echo -e "Testes falharam: ${RED}$((total_tests - passed_tests))${NC}"

if [ $passed_tests -eq $total_tests ]; then
    echo -e "\n${GREEN}🎉 TODOS OS TESTES PASSARAM! Sistema funcionando perfeitamente.${NC}"
    exit 0
elif [ $passed_tests -gt $((total_tests / 2)) ]; then
    echo -e "\n${YELLOW}⚠️ MAIORIA DOS TESTES PASSOU. Verificar falhas.${NC}"
    exit 1
else
    echo -e "\n${RED}❌ MUITOS TESTES FALHARAM. Sistema com problemas.${NC}"
    exit 2
fi
