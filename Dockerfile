FROM python:3.11-slim

WORKDIR /app

# Atualiza pacotes do sistema operacional (corrige vulnerabilidades do libc6)
RUN apt-get update && apt-get upgrade -y && rm -rf /var/lib/apt/lists/*

# Atualiza pip, setuptools e wheel (corrige vulnerabilidades HIGH)
RUN pip install --upgrade pip setuptools wheel

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

RUN useradd -m appuser
USER appuser

EXPOSE 8080

CMD ["python", "app.py"]
