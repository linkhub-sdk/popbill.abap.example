*&---------------------------------------------------------------------*
*& Report  ZPB_EX_CB_SENDEMAIL
*&
*&---------------------------------------------------------------------*
*&
*& 현금영수증 발행안내 메일 재전송.
*&
*&---------------------------------------------------------------------*

REPORT  ZPB_EX_CB_SENDEMAIL.

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
      lv_email type string,
      lv_result TYPE ZPOPBILL=>S_POPBILL_RESULT.

* 회원 사업자번호
lv_corpnum = '6798700433'.
* 전송할 현금영수증 관리번호.
lv_mgtkey = '20190819-002'.
* 수신할 이메일 주소
lv_email = 'pallet027@gmail.com'.

CALL METHOD lo_popbill_cashbill->SendEmail
  EXPORTING
    p_corpNum  = lv_corpnum
    p_mgtkey = lv_mgtkey
    p_receiver_email = lv_email
  IMPORTING
    p_result   = lv_result.

write: /
      'RESULT Code',
      lv_result-code.
write: /
      'RESULT Message',
      lv_result-message.