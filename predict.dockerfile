# Base image
FROM python:3.9-slim

# install python
RUN apt update && \
    apt install --no-install-recommends -y build-essential gcc && \
    apt clean && rm -rf /var/lib/apt/lists/*

COPY requirements.txt requirements.txt
COPY setup.py setup.py
COPY src/ src/
COPY data/ data/
COPY models/ models/

WORKDIR /
# no cache for smaller image size
RUN pip install -r requirements.txt --no-cache-dir

# -u to redirect print statements
ENTRYPOINT ["python", "-u", "src/predict_model.py"]
