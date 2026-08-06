from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from schemas import Pedido
from services import processar_pedido


app = FastAPI(
    title= "Pedido Cashback API",
    version="1.0.0"
)

#^ Permite que o frontend acesse a API (Faça a requisição)
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"], #TODO: DEPOIS RESTRINGIR PARA O DOMÍNIO DO FRONTEND
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

@app.get("/")
def home():
    return {
        "status": "online",
        "mensagem": "API de pedidos de cashback está online!"
    }
    
@app.post("/pedido")
def criar_pedido(pedido: Pedido):
    
    return processar_pedido(pedido)
    
    
    