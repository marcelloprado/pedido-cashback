def processar_pedido(pedido):
    
    print("\n==================== NOVO PEDIDO ====================")
    print(f"Nome: {pedido.nome}")
    print(f"CPF: {pedido.cpf}")
    print(f"Email: {pedido.email}")
    print(f"Produto: {pedido.produto}")
    print(f"Valor: {pedido.valor}")
    print(f"Quantidade: {pedido.quantidade}")
    print(f"Tipo: {pedido.tipo}")
    print("======================================================\n")