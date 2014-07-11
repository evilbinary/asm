;ϵͳ������ 11.0592 MHz
        ORG     0000H
        LJMP    START
        ORG     0040H
START:
        MOV     SP,#60H
        LCALL   STATUS0         ;��ʼ״̬(���Ǻ��)
CIRCLE: LCALL   STATUS1         ;�ϱ��̵�,�������
        LCALL   STATUS2         ;�ϱ��̵���ת�Ƶ�,�������
        LCALL   STATUS3         ;�ϱ����,�����̵�
        LCALL   STATUS4         ;�ϱ����,�����̵���ת�Ƶ�
        LJMP    CIRCLE
STATUS0:                        ;�ϱ����,�������
        MOV     DPTR,#8300H
        MOV     A,#0FH
        MOVX    @DPTR,A
        MOV     R2,#10          ;��ʱ1��
        LCALL   DELAY
        RET
STATUS1:                        ;�ϱ��̵�,�������
        MOV     DPTR,#08300H
        MOV     A,#96H          ;�ϱ��̵�,�������
        MOVX    @DPTR,A
        MOV     R2,#200         ;��ʱ20��
        LCALL   DELAY
        RET
STATUS2:                        ;�ϱ��̵���ת�Ƶ�,�������
        MOV     DPTR,#8300H
        MOV     R3,#03H         ;�̵���3��
FLASH:  MOV     A,#9FH
        MOVX    @DPTR,A
        MOV     R2,#03H
        LCALL   DELAY
        MOV     A,#96H
        MOVX    @DPTR,A
        MOV     R2,#03H
        LCALL   DELAY
        DJNZ    R3,FLASH
        MOV     A,#06H          ;�ϱ��Ƶ�,�������
        MOVX    @DPTR,A
        MOV     R2,#10          ;��ʱ1��
        LCALL   DELAY
        RET
STATUS3:                        ;�ϱ����,�����̵�
        MOV     DPTR,#8300H
        MOV     A,#69H
        MOVX    @DPTR,A
        MOV     R2,#200         ;��ʱ20��
        LCALL   DELAY
        RET
STATUS4:                        ;�ϱ����,�����̵���ת�Ƶ�
        MOV     DPTR,#8300H
        MOV     R3,#03H         ;�̵���3��
FLASH1: MOV     A,#6FH
        MOVX    @DPTR,A
        MOV     R2,#03H
        LCALL   DELAY
        MOV     A,#69H
        MOVX    @DPTR,A
        MOV     R2,#03H
        LCALL   DELAY
        DJNZ    R3,FLASH1
        MOV     A,#09H         ;�ϱ����,�����Ƶ�
        MOVX    @DPTR,A
        MOV     R2,#10          ;��ʱ1��
        LCALL   DELAY
	NOP
        RET
DELAY:                          ;��ʱ�ӳ���
        PUSH    2
        PUSH    1
        PUSH    0
DELAY1: MOV     1,#00H
DELAY2: MOV     0,#0B2H
        DJNZ    0,$
        DJNZ    1,DELAY2        ;��ʱ 100 mS
        DJNZ    2,DELAY1
        POP     0
        POP     1
        POP     2
        RET
        END
