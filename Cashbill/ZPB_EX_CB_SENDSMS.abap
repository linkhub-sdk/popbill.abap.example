*&---------------------------------------------------------------------*
*& Report  ZPB_EX_CB_SENDSMS
*&
*&---------------------------------------------------------------------*
*&
*& 현금영수증 발행안내 문자 재전송. ( 별도 과금 )
*&
*&---------------------------------------------------------------------*

REPORT  ZPB_EX_CB_SENDSMS.

DATA: lo_popbill_cashbill TYPE REF TO ZPOPBILL_CASHBILL.

CREATE OBJECT lo_popbill_cashbill
  EXPORTING
    p_linkid    = 'TESTER'
    p_secretKey = 'SwWxqU+0TErBXy/9TVjIPEnI0VTUMMSQZtJf3Ed8q3I='.

* 테스트베드 연결 여부.
lo_popbill_cashbill->is_TEST = ABAP_TRUE.

DATA:
      lv_corpnum type String,
      lv_mgtkey type String,
      lv_sender type string,
      lv_receiver_hp type string,
      lv_contents type string,
      lv_result TYPE ZPOPBILL=>S_POPBILL_RESULT.

* 회원 사업자번호
lv_corpnum = '6798700433'.
* 전송할 현금영수증 관리번호.
lv_mgtkey = '20190819-002'.
* 발신자 번호
lv_sender = '070-4304-2990'.
* 수신할 휴대폰 번호
lv_receiver_hp = '010-4168-0206'.
* 문자발신 내용. 90byte(영문 90자, 한글 45자)
lv_contents = '현금영수증이 발행되었습니다.'.

CALL METHOD lo_popbill_cashbill->SendSMS
  EXPORTING
    p_corpNum  = lv_corpnum
    p_mgtkey = lv_mgtkey
    p_sender = lv_sender
    p_receiver_hp = lv_receiver_hp
    p_contents = lv_contents
  IMPORTING
    p_result   = lv_result.

write: /
      'RESULT Code',
      lv_result-code.
write: /
      'RESULT Message',
      lv_result-message.