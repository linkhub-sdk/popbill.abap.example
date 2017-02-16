*&---------------------------------------------------------------------*
*& Report  ZPB_EX_UPDATECONTACT
*&
*&---------------------------------------------------------------------*
*&팝빌 담당자 정보 수정 예제.
*&
*&---------------------------------------------------------------------*

REPORT  ZPB_EX_UPDATECONTACT.

DATA:
      lo_popbill_hometax TYPE REF TO ZPOPBILL_HT_TAXINVOICE.

CREATE OBJECT lo_popbill_hometax
  EXPORTING
    p_linkid    = 'TESTER'
    p_secretKey = 'SwWxqU+0TErBXy/9TVjIPEnI0VTUMMSQZtJf3Ed8q3I='.

lo_popbill_hometax->is_TEST = ABAP_TRUE.

DATA:
      lv_corpnum type string,
      lv_userid type string,
      lv_result TYPE ZPOPBILL=>S_POPBILL_RESULT,
      lv_contactinfo type ZPOPBILL=>S_PB_CONTACTINFO.

*회원 사업자번호
lv_corpnum = '1231212312'.
lv_userid = 'newid'.


*담당자 이메일주소
lv_contactinfo-email = 'new@test.com'.
*담당자 연락처
lv_contactinfo-tel = '07043042990'.
*담당자명
lv_contactinfo-personName = '김성준'.
*담당자 팩스번호
lv_contactInfo-fax = '07011112222'.
*담당자 휴대전화
LV_CONTACTINFO-hp = '01012341234'.



call method LO_POPBILL_HOMETAX->updateCONTACT
  EXPORTING
    p_corpnum = lv_corpnum
    p_contactinfo = lv_contactinfo
    p_userid = lv_userid
  IMPORTING
    p_result = lv_result.

write: /
      'RESULT Code',
      lv_result-code.
write: /
      'RERSULT Message',
      lv_result-message.
