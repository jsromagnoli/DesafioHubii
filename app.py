import os                           # importa o modulo nativo do python ( interação com SO)
from flask import Flask, jsonify    # Importa o Flask (o framework web) e o jsonify (função que converte um dicionário Python em resposta JSON)
from dotenv import load_dotenv      #Importa a função que lê o arquivo .env e carrega as variáveis

load_dotenv()  # carrega o .env automaticamente

app = Flask(__name__)               #Lê o arquivo .env e carrega APP_ENV=development

@app.route("/health")               #diz ao Flask: "quando alguém acessar /health, execute a função abaixo"
def health():                       #Define a função que será executada quando o endpoint for chamado
    return jsonify({
        "status": "ok",
        "version": "1.0.0",
        "environment": os.getenv("APP_ENV", "development")
    }), 200

if __name__ == "__main__":          # só executa se você rodar o arquivo diretamente (python app.py), e não quando importado por outro arquivo
    app.run(host="0.0.0.0", port=8080) #aceita conexões de qualquer endereço (essencial para Docker)
