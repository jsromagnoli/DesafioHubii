# Define a imagem base oficial do Python 3.11 na versão slim
FROM python:3.11-slim

# Define /app como diretório de trabalho dentro do container            
WORKDIR /app           

# Copia e instala as dependências antes do código
COPY requirements.txt .  
RUN pip install --no-cache-dir -r requirements.txt

# Copia todo o código do projeto para dentro do container
COPY . .   
 # Cria um usuário sem privilégios e troca para ele                         
RUN useradd -m appuser             
USER appuser

# Documenta que o container usa a porta 8080
EXPOSE 8080                         
# comando executado quando o container iniciar
CMD ["python", "app.py"]            