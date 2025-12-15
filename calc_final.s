.global main
.extern printf
.extern scanf

.section .data
    menu_txt:      .string "\n--- CALCULADORA ARM64 ---\n1. Soma (+)\n2. Subtracao (-)\n3. Multiplicacao (*)\n4. Divisao (/)\nEscolha: "
    msg_num1:      .string "Primeiro numero: "
    msg_num2:      .string "Segundo numero: "
    
    msg_res:       .string "Resultado: %d\n"
    msg_res_div:   .string "Quociente: %d, Resto: %d\n"
    
    msg_err_zero:  .string "Erro: Divisao por zero!\n"
    msg_err_opt:   .string "\n[ERRO] Opcao invalida! Escolha entre 1 e 4.\n"
    
    msg_cont:      .string "\nDigite 1 para reiniciar ou 0 para sair: "
    fmt_int:       .string "%d"

.section .text
main:
    // Setup do Stack Frame (32 bytes)
    stp x29, x30, [sp, -32]! 
    mov x29, sp

inicio:
    // Menu
    ldr x0, =menu_txt
    bl printf

    // Ler opcao
    ldr x0, =fmt_int
    add x1, sp, 16       // Opcao em [sp+16]
    bl scanf

    // Validacao da opcao (1 a 4)
    ldr w0, [sp, 16]
    cmp w0, 1
    b.lt erro_opcao
    cmp w0, 4
    b.gt erro_opcao

    // Ler primeiro numero
    ldr x0, =msg_num1
    bl printf
    ldr x0, =fmt_int
    add x1, sp, 20       // Num1 em [sp+20]
    bl scanf

    // Ler segundo numero
    ldr x0, =msg_num2
    bl printf
    ldr x0, =fmt_int
    add x1, sp, 24       // Num2 em [sp+24]
    bl scanf

    // Carregar valores para registradores
    ldr w0, [sp, 16]     // Opcao
    ldr w1, [sp, 20]     // Num1
    ldr w2, [sp, 24]     // Num2

    // Selecao de operacao
    cmp w0, 1
    b.eq calc_soma
    cmp w0, 2
    b.eq calc_sub
    cmp w0, 3
    b.eq calc_mul
    cmp w0, 4
    b.eq calc_div

calc_soma:
    add w1, w1, w2
    b imprimir

calc_sub:
    sub w1, w1, w2
    b imprimir

calc_mul:
    mul w1, w1, w2
    b imprimir

calc_div:
    cbz w2, erro_zero      // Verifica divisao por zero
    sdiv w3, w1, w2        // Quociente
    msub w4, w3, w2, w1    // Resto: w4 = w1 - (w3 * w2)
    
    // Imprimir divisao com resto
    ldr x0, =msg_res_div
    mov w1, w3
    mov w2, w4
    bl printf
    b perguntar_fim

imprimir:
    ldr x0, =msg_res
    bl printf
    b perguntar_fim

erro_zero:
    ldr x0, =msg_err_zero
    bl printf
    b perguntar_fim

erro_opcao:
    ldr x0, =msg_err_opt
    bl printf
    b perguntar_fim

perguntar_fim:
    ldr x0, =msg_cont
    bl printf

    ldr x0, =fmt_int
    add x1, sp, 16       // Reutiliza slot da opcao
    bl scanf

    ldr w0, [sp, 16]
    cmp w0, 1
    b.eq inicio          // Reinicia se for 1

    // Encerra o programa
    mov w0, 0
    ldp x29, x30, [sp], 32
    ret
