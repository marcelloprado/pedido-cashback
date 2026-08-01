const quantidade = document.getElementById("quantidade");
const textoQuantidade = document.getElementById("valorQuantidade");

const atualizarTextoQuantidade = () => {
    const valor = Number(quantidade.value) || 1;
    textoQuantidade.textContent = `${valor} unidade${valor > 1 ? "s" : ""}`;
};

atualizarTextoQuantidade();
quantidade.addEventListener("input", atualizarTextoQuantidade);

document
    .getElementById("pedidoForm")
    .addEventListener("submit", async function (e) {
        e.preventDefault();

        const produtoSelecionado = document.querySelector(
            'input[name="produto"]:checked'
        );

        if (!produtoSelecionado) {
            alert("Selecione um produto antes de enviar.");
            return;
        }

        const dados = {
            nome: document.getElementById("nome").value.trim(),
            cpf: document.getElementById("cpf").value.trim(),
            email: document.getElementById("email").value.trim(),
            produto: produtoSelecionado.value,
            valor: Number(produtoSelecionado.dataset.valor),
            quantidade: Number(quantidade.value) || 1,

            tipo: "compras",
        };

        console.log("Produto selecionado:", produtoSelecionado.value);
        console.log("Data valor:", produtoSelecionado.dataset.valor);

        console.log(dados);

       // Defina a URL do seu webhook do n8n
       const WEBHOOK_URL = "COLOQUE_AQUI_SUA_URL_DO_WEBHOOK";

        try {
            const resposta = await fetch(WEBHOOK_URL, {
                method: "POST",
                headers: {
                    "Content-Type": "application/json",
                },
                body: JSON.stringify(dados),
            });

            const retorno = await resposta.text();
            alert("Pedido enviado!");
            console.log(retorno);
        } catch (erro) {
            console.error(erro);
            alert("Erro ao enviar.");
        }
    });
