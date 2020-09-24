	ORG 00H
	SJMP BASLA
	ORG 0BH; Kesme Vektörü Adresi
KESME:    LJMP KESMEFONK ;KESME GELDIGINDE KESMEFONK GIT

	ORG 30H
BASLA:  MOV IE,#82H  ;EA ve ET0 i aktif ediyorum adresi. 1000 0010
		MOV TMOD,#01H ; zamanlayici modu timer0'in 1'i yani 65536 ya kadar
		
		Button_Kontrol: ;button kontrolü
		MOV A,#00H; Akü Sifirliyorum
		MOV TH0,#HIGH(-50000); 50 ms gecikmeye ayarliyorum
		MOV TL0,#LOW(-50000);50 ms gecikmeye ayarliyorum
		MOV R4,#00h
		CLR TR0 ; Buton kapali zamanlayi kapat;
		JB p1.0, Button_Kontrol ; buton 1 se yani kapaliysa butonkontrole git. 0'sa yani aktifse devam et
		SETB TR0; zamanlalyiciyi aç
		
		
		ACIK: ;PORTLARIN ACILACAGI DURUM
		JNZ KAPAT ;Eger A = 0 degil ise adrese dallan
		JB p1.0, Button_Kontrol
		
	CLR P0.0
	CLR P2.7
	CLR P2.5
	
	CALL P_SIFIRLA
	
	CLR P0.1
	CLR P2.7
	CLR P2.6
	CLR P2.1
	
	CALL P_SIFIRLA
	
	CLR P0.2
	CLR P2.0
	CLR P2.3
	CLR P2.4
	CLR P2.5
	CLR P2.6
	CLR P2.7
	
	CALL P_SIFIRLA
	
	CLR P0.3
	CLR P2.0
	CLR P2.1
	CLR P2.2
	CLR P2.5
	CLR P2.7
	 
	CALL P_SIFIRLA
		
		CJNE R4, #20, ACIK
		CALL Bir_Saniye
		SJMP KAPAT
		
		
		KAPAT:;PORTLARIN KAPANACAGI DURUM
		JZ ACIK;Eger A = 0 ise adrese dallan
		JB p1.0, Button_Kontrol
		
			CALL P_SIFIRLA
		
		
		CJNE R4, #20, KAPAT
		CALL Bir_Saniye
		SJMP ACIK

KESMEFONK:	
		INC R4

		MOV TH0,#HIGH(-50000)
		MOV TL0,#LOW(-50000)
		RETI
		
Bir_Saniye:
		CPL A
		MOV R4,#00h
		RET
		
	P_SIFIRLA:;tum portlar kapatýlýyor
	SETB P0.0
	SETB P0.1
	SETB P0.2
	SETB P0.3
	SETB P2.0
	SETB P2.1
	SETB P2.2
	SETB P2.3
	SETB P2.4	
	SETB P2.5
	SETB P2.6
	SETB P2.7
	RET

	END