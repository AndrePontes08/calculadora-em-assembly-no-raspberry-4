# 🧮 Calculadora em Assembly ARM64 (AArch64)

> Projeto desenvolvido para a disciplina de Sistemas Embarcados.

Este repositório contém uma calculadora interativa de linha de comando desenvolvida inteiramente em **Assembly (ARMv8-A)**, executada nativamente em um **Raspberry Pi 4**.

O projeto demonstra conceitos fundamentais de baixo nível, como manipulação direta de registradores, gerenciamento de pilha (Stack Frame), desvios condicionais e integração com a biblioteca padrão C (`libc`).

## 🚀 Funcionalidades

- **Operações Básicas:** Soma, Subtração e Multiplicação.
- **Divisão Euclidiana:** Exibe tanto o **Quociente** quanto o **Resto** da divisão inteira.
- **Interface Interativa:** Menu de seleção e loop de execução (reiniciar ou sair).
- **Validação de Entrada:** Proteção contra opções inválidas no menu.
- **Tratamento de Erros:** Detecção e aviso de divisão por zero.

## 🛠️ Tecnologias e Arquitetura

* **Linguagem:** Assembly AArch64 (ARM 64-bit).
* **Plataforma de Teste:** Raspberry Pi 4 Model B.
* **Sistema Operacional:** Raspberry Pi OS (Linux/Debian based).
* **Compilador/Linker:** GCC (GNU Compiler Collection) via `as` e `ld`.
* **Bibliotecas:** Integração com `printf` e `scanf` da glibc para I/O.

## ⚙️ Como Executar

### Pré-requisitos
Você precisa de um ambiente Linux rodando em processador ARM de 64 bits (como Raspberry Pi 3, 4, 5 ou Jetson Nano) com o `gcc` instalado.

### Compilação
Utilize o GCC para montar e linkar o arquivo. A flag `-no-pie` é utilizada para desabilitar o *Position Independent Executable*, simplificando o endereçamento para fins didáticos.

```bash
gcc -no-pie calc_final.s -o calc
ou
gcc -no-pie calc_final.s -o calc_final
./calc_final
