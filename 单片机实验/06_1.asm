;系统晶振是 11.0592 MHz
        ORG     0000H
        LJMP    START
        ORG     0040H
START:
        MOV     SP,#60H
        LCALL   STATUS0         ;初始状态(都是红灯)
CIRCLE: LCALL   STATUS1         ;南北绿灯,东西红灯
        LCALL   STATUS2         ;南北绿灯闪转黄灯,东西红灯
        LCALL   STATUS3         ;南北红灯,东西绿灯
        LCALL   STATUS4         ;南北红灯,东西绿灯闪转黄灯
        LJMP    CIRCLE
STATUS0:                        ;南北红灯,东西红灯
        MOV     DPTR,#8300H
        MOV     A,#0FH
        MOVX    @DPTR,A
        MOV     R2,#10          ;延时1秒
        LCALL   DELAY
        RET
STATUS1:                        ;南北绿灯,东西红灯
        MOV     DPTR,#08300H
        MOV     A,#96H          ;南北绿灯,东西红灯
        MOVX    @DPTR,A
        MOV     R2,#200         ;延时20秒
        LCALL   DELAY
        RET
STATUS2:                        ;南北绿灯闪转黄灯,东西红灯
        MOV     DPTR,#8300H
        MOV     R3,#03H         ;绿灯闪3次
FLASH:  MOV     A,#9FH
        MOVX    @DPTR,A
        MOV     R2,#03H
        LCALL   DELAY
        MOV     A,#96H
        MOVX    @DPTR,A
        MOV     R2,#03H
        LCALL   DELAY
        DJNZ    R3,FLASH
        MOV     A,#06H          ;南北黄灯,东西红灯
        MOVX    @DPTR,A
        MOV     R2,#10          ;延时1秒
        LCALL   DELAY
        RET
STATUS3:                        ;南北红灯,东西绿灯
        MOV     DPTR,#8300H
        MOV     A,#69H
        MOVX    @DPTR,A
        MOV     R2,#200         ;延时20秒
        LCALL   DELAY
        RET
STATUS4:                        ;南北红灯,东西绿灯闪转黄灯
        MOV     DPTR,#8300H
        MOV     R3,#03H         ;绿灯闪3次
FLASH1: MOV     A,#6FH
        MOVX    @DPTR,A
        MOV     R2,#03H
        LCALL   DELAY
        MOV     A,#69H
        MOVX    @DPTR,A
        MOV     R2,#03H
        LCALL   DELAY
        DJNZ    R3,FLASH1
        MOV     A,#09H         ;南北红灯,东西黄灯
        MOVX    @DPTR,A
        MOV     R2,#10          ;延时1秒
        LCALL   DELAY
	NOP
        RET
DELAY:                          ;延时子程序
        PUSH    2
        PUSH    1
        PUSH    0
DELAY1: MOV     1,#00H
DELAY2: MOV     0,#0B2H
        DJNZ    0,$
        DJNZ    1,DELAY2        ;延时 100 mS
        DJNZ    2,DELAY1
        POP     0
        POP     1
        POP     2
        RET
        END
