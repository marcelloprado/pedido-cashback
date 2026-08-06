from pydantic import BaseModel


class Pedido(BaseModel):
    nome: str
    cpf: str
    email: str
    produto: str
    valor: float
    quantidade: int
    tipo: str
    
